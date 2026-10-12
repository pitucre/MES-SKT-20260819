-- ============================================================
-- 方案A：调拨入库时清理上料关系
-- 对象：uspSaveTransferIn
-- 日期：2026-10-10
-- 说明：在第3步更新 Status 之后，删除被调拨 GRN 在
--       Prod_PickListResourceRecords / Prod_InjectionLoadingMaterial /
--       Prod_MaterialStationMuMap / Prod_DIPLoadingMaterialCheck
--       中的上料关系，防止"仓库状态物料仍在扣料池"。
-- 备份：bak_uspSaveTransferIn_20261010191037.sql
-- ============================================================
ALTER PROCEDURE [dbo].[uspSaveTransferIn]  
    @TransfersId INT , 
	@TransfersNo NVARCHAR(50),
	@UserName VARCHAR(50),
    @TransferDtlMaterial NVARCHAR(MAX),
	@TransferInShelfGRN NVARCHAR(MAX)
	
AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
 
BEGIN
    DECLARE @CurrentTime DATETIME = GETDATE()	--当前时间
	DECLARE @Msg NVARCHAR(2000)
    DECLARE @LogContent NVARCHAR(1000)
	DECLARE @ConfigResult NVARCHAR(50) ='-1'
	DECLARE @UserId INT
	DECLARE @UserCName NVARCHAR(50)
	DECLARE @TempWriteERP TABLE(TransfersDtlId BIGINT,Qty DECIMAL(18,6))

	SELECT @UserCName = su.CName FROM dbo.SYS_Users su WITH (NOLOCK) WHERE su.UserName = @UserName
	IF @@ROWCOUNT <= 0
	BEGIN
		SET @Msg = '用户不存在';
		THROW 50000, @Msg, 1;
	END
	DECLARE @TransferDtl_Tb TABLE(TransfersId BIGINT,TransfersDtlId bigint,ApplyQty decimal(18,6), FinishQty decimal(18,6), OnPosQty decimal(18,6));
 
	SELECT @ConfigResult =ConfigResult FROM Prod_MaterialSysConfig WHERE ConfigTypeId=23
	
	--0.解析json的表
	DECLARE @Row INT;  
	DECLARE @TransferDtlMaterial_Tb TABLE(TransfersId bigint ,TransfersDtlId bigint,GRN varchar(50),[IsOnShelf] bit);
	DECLARE @TransferInShelfGRN_Tb TABLE(TransfersId BIGINT,TransfersDtlId bigint ,GRN varchar(50) ,CBarCode nvarchar(50),IsTransferOut bit);
   
	SELECT * INTO #Transfer_1 FROM dbo.parseJSON(@TransferDtlMaterial)
	SELECT * INTO #Transfer_2 FROM dbo.parseJSON(@TransferInShelfGRN)
	
	--0.1 解析调拨单明细物料对应
	SELECT @Row = MAX(parent_ID)-1 FROM #Transfer_1  
	WHILE @Row > 0  
	BEGIN  
	INSERT INTO @TransferDtlMaterial_Tb  
	(  
		TransfersId,  
		TransfersDtlId,  
		GRN,
		IsOnShelf
	)  
	VALUES  
	(    
		(SELECT StringValue FROM #Transfer_1 WHERE NAME='TransfersId' AND parent_ID = @Row),
		(SELECT StringValue FROM #Transfer_1 WHERE NAME='TransfersDtlId' AND parent_ID = @Row),
		(SELECT StringValue FROM #Transfer_1 WHERE NAME='GRN' AND parent_ID = @Row),
		(SELECT StringValue FROM #Transfer_1 WHERE NAME='IsOnShelf' AND parent_ID = @Row)
	)
	SET @Row = @Row -1;  
	END
	--0.2 解析GRN入库上架更新记录
	SELECT @Row = MAX(parent_ID)-1 FROM #Transfer_2  
	WHILE @Row > 0  
	BEGIN  
	INSERT INTO @TransferInShelfGRN_Tb  
	(  
		TransfersDtlId,
		GRN,  
		CBarCode,  
		IsTransferOut
	)  
	VALUES  
	(    
		(SELECT StringValue FROM #Transfer_2 WHERE NAME='TransfersDtlId' AND parent_ID = @Row),
		(SELECT StringValue FROM #Transfer_2 WHERE NAME='GRN' AND parent_ID = @Row),
		(SELECT StringValue FROM #Transfer_2 WHERE NAME='CBarCode' AND parent_ID = @Row),
		(SELECT StringValue FROM #Transfer_2 WHERE NAME='IsTransferOut' AND parent_ID = @Row)	--是否已调拨出库
	)
	SET @Row = @Row -1;  
	END
	--校验调拨单状态
	IF EXISTS(SELECT 1 FROM Prod_Transfers WHERE TransfersNo=@TransfersNo AND Statue=2)
	BEGIN
		RAISERROR('该调拨单已经调拨完成',12,1)
		RETURN; 
	END
	--校验GRN是否已调拨入库
	DECLARE @GRN NVARCHAR(50)
	SELECT @GRN = TDL.GRN FROM Prod_TransfersDtlMaterial TDL
		INNER JOIN @TransferInShelfGRN_Tb T ON T.GRN = TDL.GRN
	WHERE TDL.IsOnShelf =1 AND TDL.TransfersId =@TransfersId
	IF @GRN IS NOT NULL
	BEGIN
		SET @LogContent = '存在已调拨入库的物料条码【'+ @GRN+ '】'
		RAISERROR(@LogContent, 12, 1);  
        RETURN; 
	END
	--调拨明细
	INSERT INTO @TransferDtl_Tb(TransfersId,TransfersDtlId,ApplyQty, FinishQty,OnPosQty)
	SELECT 
		@TransfersId,
		A.TransfersDtlId,
		TD.ApplyQty,
		SUM(MU.BalanceQty),
		SUM(CASE WHEN A.IsOnShelf =1 THEN MU.BalanceQty ELSE 0 END)
	FROM (
		SELECT TDL.TransfersDtlId,TDL.GRN,TDL.IsOnShelf FROM Prod_TransfersDtlMaterial TDL	
		WHERE TDL.TransfersId = @TransfersId 
			AND TDL.TransfersDtlId IN (SELECT TransfersDtlId FROM @TransferInShelfGRN_Tb)
			AND TDL.GRN NOT IN(SELECT GRN FROM @TransferInShelfGRN_Tb)
		UNION
		SELECT T.TransfersDtlId,T.GRN,1 FROM @TransferInShelfGRN_Tb T
	) A 
		INNER JOIN Prod_TransfersDtl TD ON TD.TransfersDtlId = A.TransfersDtlId
		INNER JOIN Prod_MaterialUnit MU ON A.GRN = MU.SerialNumber
	GROUP BY A.TransfersDtlId,TD.ApplyQty
	--校验数量
	IF EXISTS(
		SELECT 1 FROM   @TransferDtl_Tb AS A
		WHERE A.FinishQty>A.ApplyQty OR A.OnPosQty> A.ApplyQty
	)
	BEGIN
		RAISERROR('调拨明细的入库数量或出库数量,不能大于申请数量', 12, 1);  
        RETURN;  
	END

	--扫描的GRN
	DECLARE @TempGRN TABLE(TransfersDtlId BIGINT,GRN VARCHAR(50),BalanceQty DECIMAL(18,6))	--,ItemCode VARCHAR(50)

	INSERT INTO @TempGRN(TransfersDtlId,GRN,BalanceQty)
	SELECT
		tmp.TransfersDtlId,pu.SerialNumber,pu.BalanceQty
	FROM @TransferInShelfGRN_Tb tmp
	INNER JOIN dbo.Prod_MaterialUnit pu WITH (NOLOCK) ON tmp.GRN = pu.SerialNumber
	WHERE pu.Flag = -1
	UNION ALL
	SELECT
		tmp.TransfersDtlId,pum.SerialNumber,pum.BalanceQty
	FROM @TransferInShelfGRN_Tb tmp
	INNER JOIN dbo.Prod_MaterialUnit puc WITH (NOLOCK) ON tmp.GRN = puc.SerialNumber
	INNER JOIN dbo.Prod_MaterialUnit pum WITH (NOLOCK) ON puc.MaterialUnitId = pum.PID
	WHERE puc.Flag > -1 AND pum.Flag = -1

	INSERT INTO @TempWriteERP(TransfersDtlId,Qty)
	SELECT 
		t.TransfersDtlId,ISNULL(SUM(t.BalanceQty),0) 
	FROM @TempGRN t 
	GROUP BY t.TransfersDtlId
	
 
	--开始捕捉异常
	BEGIN TRY
	--开始事务
	--BEGIN TRAN	--Xudong.zhu,2024-08-23,注释
	--1.调拨记录信息
    INSERT  INTO Prod_TransfersStorage  
		( TransfersId ,  
			TransfersDtlId ,  
			ErpCode ,  
			ItemCode ,  
			TransfersQty ,  
			SerialNumber ,  
			BarCodeIn ,  
			BarCodeOut ,  
			CreateBy ,  
			CreateDateTime  
		)  
    SELECT  @TransfersId ,  
            D.TransfersDtlId ,  
            '' ,  
            B.ItemCode ,  
            A.BalanceQty ,  
            A.SerialNumber ,  
            C.CBarCode ,  
            A.cBarCode ,  
            @UserName ,  
            GETDATE()  
    FROM    Prod_MaterialUnit A WITH ( NOLOCK ) 
            INNER JOIN Basal_Item B WITH ( NOLOCK ) ON A.PartId = B.ItemID  
            INNER JOIN @TransferInShelfGRN_Tb C ON A.SerialNumber = C.GRN  
            INNER JOIN dbo.Prod_TransfersDtl D WITH ( NOLOCK ) ON D.ItemCode = B.ItemCode  
    WHERE	D.TransfersId = @TransfersId AND C.IsTransferOut =0
	IF @@error <> 0  
    BEGIN  
        RAISERROR('插入调拨记录失败!', 12, 1);  
        --ROLLBACK TRANSACTION;   --Xudong.zhu,2024-08-23,注释
        RETURN;  
    END; 
	UPDATE A SET
			A.BarCodeIn = B.CBarCode
	FROM    Prod_TransfersStorage AS A WITH ( NOLOCK ) 
            INNER JOIN @TransferInShelfGRN_Tb B ON A.SerialNumber = B.GRN
    WHERE	A.TransfersId=@TransfersId AND B.IsTransferOut =1
	IF @@error <> 0  
    BEGIN  
        RAISERROR('更新调拨记录失败!', 12, 1);  
        --ROLLBACK TRANSACTION;   --Xudong.zhu,2024-08-23,注释
        RETURN;  
    END; 
	--2.调拨记录
    SET @LogContent = '调拨单号【' + @TransfersNo + '】';  
    EXEC uspSaveOperationLog @UserName, '调拨入库', '仓库管理',  
        'PDA-调拨入库', @TransfersNo, @LogContent;  
    IF @@ERROR <> 0  
        BEGIN   
            RAISERROR('插入日志失败!',12,1);  
			--ROLLBACK TRANSACTION;   --Xudong.zhu,2024-08-23,注释
            RETURN;   
        END;     
   
  
	--3.更新GRN状态和库位条码  
    UPDATE  A  
    SET     A.Status =CASE WHEN c.CProperty='W' THEN 2 ELSE 0 END  ,  
			A.ModifyBy = @UserName ,  
            A.ModifyDateTime = GETDATE() ,  
            A.cBarCode = B.cBarCode ,   
            A.WarehouseId = D.WarehouseId  
    FROM    Prod_MaterialUnit A  WITH ( NOLOCK )
            INNER JOIN @TransferInShelfGRN_Tb B ON A.SerialNumber = B.GRN
			LEFT JOIN Basal_WarehouseLocation C WITH ( NOLOCK ) ON B.cBarCode = C.cBarCode
			LEFT JOIN Basal_Warehouse D WITH ( NOLOCK ) ON D.WarehouseId = C.cWhId
	IF @@error <> 0  
    BEGIN  
        RAISERROR('更新GRN状态失败!', 12, 1);  
        --ROLLBACK TRANSACTION;   --Xudong.zhu,2024-08-23,注释
        RETURN;  
    END; 
       
	--3.1 【2026-10-10】调拨入库时清理上料关系，防止仓库状态物料仍在扣料池
	DELETE PR
	FROM dbo.Prod_PickListResourceRecords AS PR
	INNER JOIN dbo.Prod_MaterialUnit AS MU ON MU.MaterialUnitId = PR.MaterialUnitId
	INNER JOIN @TransferInShelfGRN_Tb AS T ON T.GRN = MU.SerialNumber;

	DELETE IL
	FROM dbo.Prod_InjectionLoadingMaterial AS IL
	INNER JOIN dbo.Prod_MaterialUnit AS MU ON MU.MaterialUnitId = IL.MaterialUnitId
	INNER JOIN @TransferInShelfGRN_Tb AS T ON T.GRN = MU.SerialNumber;

	DELETE MM
	FROM dbo.Prod_MaterialStationMuMap AS MM
	INNER JOIN dbo.Prod_MaterialUnit AS MU ON MU.MaterialUnitId = MM.MaterialUnitID
	INNER JOIN @TransferInShelfGRN_Tb AS T ON T.GRN = MU.SerialNumber;

	DELETE DC
	FROM dbo.Prod_DIPLoadingMaterialCheck AS DC
	INNER JOIN dbo.Prod_MaterialUnit AS MU ON MU.MaterialUnitId = DC.MaterialUnitId
	INNER JOIN @TransferInShelfGRN_Tb AS T ON T.GRN = MU.SerialNumber;
	--3.1 END

    --4.插入物料历史记录表  
    INSERT  INTO Prod_MaterialUnitHistory  
        ( MaterialUnitId ,  
            ActionType ,  
            Qty ,  
            Description ,  
            CreateBy ,  
            CreateDateTime ,  
            Remark ,  
            OperateOrder  
        )  
    SELECT  B.MaterialUnitId ,  
            13 ,  
            BalanceQty ,  
            'PDA调拨' ,  
            @UserName ,  
            GETDATE() ,  
            'PDA调拨入库' ,  
            @TransfersNo  
    FROM    @TransferInShelfGRN_Tb AS A  
            INNER JOIN Prod_MaterialUnit AS B WITH ( NOLOCK ) ON A.GRN = B.SerialNumber
	WHERE  A.IsTransferOut = 0
    IF @@error <> 0  
    BEGIN  
        RAISERROR('插入物料历史记录表!', 12, 1);  
        --ROLLBACK TRANSACTION;   --Xudong.zhu,2024-08-23,注释
        RETURN;  
    END;  
   
	--5.更新明细表状态：入库上架数量等于申请数量则Statue为2，否则则为1  
    UPDATE  A  
    SET     A.FinishQty = B.FinishQty,
			A.OnPosQty = B.OnPosQty ,
            A.Statue = CASE 
				WHEN  B.OnPosQty = B.ApplyQty THEN 2 
				WHEN  B.FinishQty = B.ApplyQty THEN 3
                ELSE 1  END  
    FROM    Prod_TransfersDtl AS A  WITH ( NOLOCK )
            INNER JOIN @TransferDtl_Tb AS B  ON A.TransfersDtlId = B.TransfersDtlId  
			INNER JOIN @TransferInShelfGRN_Tb C ON C.TransfersDtlId = B.TransfersDtlId
    WHERE   A.TransfersId = @TransfersId;   
   
    IF @@error <> 0  
        BEGIN  
            RAISERROR('更新调拨单失败!#1', 12, 1);  
            --ROLLBACK TRANSACTION;   --Xudong.zhu,2024-08-23,注释
            RETURN;  
        END;  
 
	--6.更新主表状态：总数相等，更新主表状态为 完成  
    DECLARE @SumOnPosQty DECIMAL;  
	DECLARE @SumFinishQty DECIMAL;  
    DECLARE @SumQty DECIMAL;  
	DECLARE @Statue INT; 
    SELECT  @SumOnPosQty = SUM(OnPosQty),
			@SumFinishQty = SUM(FinishQty),
			@SumQty = SUM(ApplyQty)
    FROM    Prod_TransfersDtl  
    WHERE   TransfersId = @TransfersId;
	--设置状态
    IF @SumOnPosQty = @SumQty
	BEGIN  
		SET  @Statue =2;
		--调拨结束时更新结束人和时间
		UPDATE  Prod_Transfers  
		SET     EndUser = (SELECT UserId FROM SYS_Users WHERE UserName=@UserName) ,
				EndDate = GETDATE()
		WHERE   TransfersId = @TransfersId;  
		IF @@error <> 0  
		BEGIN  
			RAISERROR('更新调拨单失败!#3', 12, 1);  
			--ROLLBACK TRANSACTION  --Xudong.zhu,2024-08-23,注释
			RETURN
		END 
    END  
    ELSE IF @SumFinishQty = @SumQty
    BEGIN  
        SET  @Statue =3
    END
	ELSE
	BEGIN
		SET  @Statue =1
	END
	--更新
	UPDATE  Prod_Transfers  
    SET     Statue = @Statue 
    WHERE   TransfersId = @TransfersId;  
    IF @@error <> 0  
    BEGIN  
        RAISERROR('更新调拨单失败!#2', 12, 1);  
        --ROLLBACK TRANSACTION;   --Xudong.zhu,2024-08-23,注释
        RETURN;  
    END;  
		
    --7.更新调拨明细物料对应表的已上架记录
	UPDATE A SET
		A.IsOnShelf = 1
	FROM Prod_TransfersDtlMaterial AS A
		INNER JOIN @TransferInShelfGRN_Tb B ON A.GRN = B.GRN
	WHERE A.TransfersId = @TransfersId
	IF @@error <> 0  
    BEGIN  
        RAISERROR('更新调拨明细物料对应关系失败!', 12, 1);  
        --ROLLBACK TRANSACTION;   --Xudong.zhu,2024-08-23,注释
        RETURN;  
    END; 
 
	--8.新调拨物料的增加调拨明细物料对应关系
	INSERT INTO Prod_TransfersDtlMaterial (
		TransfersId,
		TransfersDtlId,
		GRN,
		IsOnShelf
	)
	SELECT 
		TransfersId,
		TransfersDtlId,
		GRN,
		IsOnShelf
	FROM @TransferDtlMaterial_Tb
	IF @@error <> 0  
    BEGIN  
        RAISERROR('增加调拨明细物料对应关系失败!', 12, 1);  
        --ROLLBACK TRANSACTION;   --Xudong.zhu,2024-08-23,注释
        RETURN;  
    END;  
		/*--Xudong.zhu,2024-08-23,注释
		DECLARE @Guid VARCHAR(50) = REPLACE(NEWID(),'-','')
		--返回回写所需数据
		SELECT 
			--主表信息
			pt.TransfersNo AS MESDocNO,	--调拨单号
			CONVERT(VARCHAR(30),@CurrentTime,120) AS BusinessDate,	--业务时间
			@UserName AS UserCode ,--业务操作人编号
			@UserCName AS UserName ,--业务操作人名称
			'ZJDB01_SYS' AS DocType,
			@Guid AS SrcUniqueID,	--此次数据包唯一标识，下次不会重复执行
			--明细信息			
			ptd.ItemCode AS ItemCode,--料号必有
			i.ERPItemID AS ItemERPID,--料品ERPID，必有 	 	 	
			pt.InWhouse,			   --调入仓库编号，必有(U8明细行必须一致)   仓库编码
			'' AS InWhERPID,		   --调入仓库ERPID，必有(U8明细行必须一致)    空
			pt.OutWhouse,			   --调出仓库编号，必有(U8明细行必须一致)     仓库编码
			'' AS OutWhERPID,		   --调出仓库ERPID，必有(U8明细行必须一致)     空
			so.DepartNo AS InDepCode,   --调入部门编号，若启用了部门核算必有(U8明细行必须一致)  空42
			so.ERPDepID AS InDepERPID,  --调入部门ERPID，若启用了部门核算必有(U8明细行必须一致) 空42
			so.DepartNo AS OutDepCode,  --调出部门编号，若启用了部门核算必有(U8明细行必须一致)  空
			so.DepartNo AS OutDepERPID, --调出部门ERPID，若启用了部门核算必有(U8明细行必须一致)  空
			'' AS InLCCode,  -- 货位/仓位编码，若启用了货位管理必有，若系统间没有用ID建立关联，可不传  空
			'' AS InLCERPID, -- 货位/仓位编码，若启用了货位管理必有  空
			'' AS OutLCCode, --  空
			'' AS OutLCERPID,--  空
			'' AS ERPOrderNO,--销售单号（寄售调拨），直接调拨为空
			ptd.TransfersDtlId AS AutoSeq,--MES调拨单行号，必有
			tmp.Qty AS Qty,--数量 OnPosQty？？？
			i.Units AS Units, --入库单位编码，金蝶K3WISE必有，单位
			--'' AS DocType,--单据类型编码，必有  空
			'' AS LotCode,--批号，需要（U9如果启用的批号管理，则必传）空 
			'' AS Memo,--备注，非必有 
			pt.TransfersNo AS MOMDocNO	--MES单号，必有 调拨单号
		FROM dbo.Prod_Transfers  pt WITH (NOLOCK) 
		INNER JOIN dbo.Prod_TransfersDtl ptd WITH (NOLOCK) ON pt.TransfersId = ptd.TransfersId
		INNER JOIN @TempWriteERP tmp ON tmp.TransfersDtlId = ptd.TransfersDtlId
		INNER JOIN dbo.Basal_Item i WITH (NOLOCK) ON ptd.ItemCode=i.ItemCode
		LEFT JOIN dbo.SYS_Organization so WITH (NOLOCK) ON pt.DepCode = so.DepartNo
		WHERE pt.TransfersId = @TransfersId
		*/

		--Xudong.zhu,2024-08-23,新增
		SELECT  
			@UserName AS userId	--当前操作人，需要 
			--主表信息
			,@TransfersNo AS billCode	--调拨单号
			,CONVERT(VARCHAR(10),@CurrentTime,120) AS billDate	--入库日期
			,CASE WHEN pt.TransfersType=0 THEN '无单调拨'
				WHEN pt.TransfersType=1 THEN '委外调拨' 
				WHEN pt.TransfersType=2 THEN '超期不良调拨' 
				WHEN pt.TransfersType=3 THEN '' 
				ELSE '其他' END AS billKind		--单据类型 
			,@UserCName AS userCode	--制单人，需要
			,@UserCName AS ckUserCode	--审核人，需要
			,pt.Remark AS remark	--表头备注
		
			--明细数据
			,bi.ItemCode AS mtrlCode	--存货物料编码，必有 	
			,pt.TransfersNo AS sourceCode --调出单号 ，必有
			,ptd.TransNo AS sourceSeq  --调出行号,必有
			,tmp.Qty AS billQty	--数量，必有
			,'' AS batchNo	--批号
			,ptd.InWhouse AS stockInCode	--调入仓库编码
			,ptd.OutWhouse AS stockOutCode	--调出仓库编码
			,ptd.Remark AS lineRemark 	--行备注
		FROM dbo.Prod_Transfers  pt WITH (NOLOCK) 
		INNER JOIN dbo.Prod_TransfersDtl ptd WITH (NOLOCK) ON pt.TransfersId = ptd.TransfersId
		INNER JOIN @TempWriteERP tmp ON tmp.TransfersDtlId = ptd.TransfersDtlId
		INNER JOIN dbo.Basal_Item bi WITH (NOLOCK) ON ptd.ItemCode=bi.ItemCode 
		WHERE pt.TransfersId = @TransfersId

    --提交事务
	--COMMIT TRAN	--Xudong.zhu,2024-08-23,注释
	END TRY
	BEGIN CATCH
		--异常处理
		/*--Xudong.zhu,2024-08-23,注释
		IF @@TRANCOUNT > 0
		BEGIN
		    ROLLBACK TRAN
		END
		*/

		SET @Msg = ERROR_MESSAGE();
		THROW 50000, @Msg, 1;

	END CATCH
   
 END
