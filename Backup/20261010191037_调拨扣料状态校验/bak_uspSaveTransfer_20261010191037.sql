	
-- =============================================  
-- Author:  zhi.li   
-- Create date: 2018/07/21  
-- Description: 保存调拨出库(PDA)  
/***UPDATE      DATE       DESC  
 Alma.Liu     20190731     修复PDA调拨出库，GRN还在原仓库  
 Sperkey.Zhong    2019-08-17     修复PDA调拨出库时，GRN操作历史记录写了两条记录BUG  
 Sperkey.Zhong    2019-08-20     插入Prod_TransfersStorage数据时，添加 AND D.TransfersId = @TransfersId 过滤条件  
 yz.xiong		2021-06-08		调拨出库需求：
									1.调拨单明细支持多仓库调拨
									2.调出出库后GRN状态为调拨中，增加调拨单和GRN的绑定关系，调拨入库时使用同一批GRN
									3.增加调拨单状态“出库完成”（0：待调拨 1：调拨中 2：调拨完成 3：出库完成），标识调拨出库完成时的状态
 yz.xiong	2021-09-15			增加参数@OpSource（操作来源，1:PC 2:PDA），用于操作日志区分PC和PDA的调拨出库
 yz.xiong			2021-10-15		    增加校验：校验调拨明细数量，GRN是否已调拨
										修改调拨明细的更新方式，避免同时操作一个单据引发数据问题
 yz.xiong   2022-04-13 19:20:00	 修复GRN调拨入库后无法重复调拨的BUG
									
**/  
-- =============================================  
CREATE  PROCEDURE [dbo].[uspSaveTransfer]    
    @TransfersId INT ,    
    @UserName NVARCHAR(50),    
    @TransferDtlMaterial NVARCHAR(MAX),
	@OpSource INT =1		--操作来源
  
AS
--20240202 Yang
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
   
    DECLARE @LogContent NVARCHAR(1000);
	DECLARE @FunctionName NVARCHAR(50);
	DECLARE @TransfersNo VARCHAR(50);  
 
	DECLARE @TransferDtl_Tb TABLE(TransfersDtlId bigint,ApplyQty decimal(18,6), FinishQty decimal(18,6));
   
 --0.解析json的表  
 DECLARE @Row INT;    
 DECLARE @TransferDtlMaterial_Tb TABLE(  
  TransfersId bigint ,  
  TransfersDtlId bigint,  
  GRN varchar(50),  
  [IsOnShelf] bit,  
  BalanceQty decimal(18,6),  
  ValidInWhouse varchar(50),  
  ValidOutWhouse varchar(50)  
 );  
     
 SELECT * INTO #Transfer_1 FROM dbo.parseJSON(@TransferDtlMaterial)  
  
 --0.1 解析调拨单明细物料对应  
 SELECT @Row = MAX(parent_ID)-1 FROM #Transfer_1    
 WHILE @Row > 0    
 BEGIN    
 INSERT INTO @TransferDtlMaterial_Tb    
 (    
  TransfersId,    
  TransfersDtlId,    
  GRN,  
  IsOnShelf,  
  BalanceQty,  
  ValidInWhouse,  
  ValidOutWhouse  
 )    
 VALUES    
 (      
  (SELECT StringValue FROM #Transfer_1 WHERE NAME='TransfersId' AND parent_ID = @Row),  
  (SELECT StringValue FROM #Transfer_1 WHERE NAME='TransfersDtlId' AND parent_ID = @Row),  
  (SELECT StringValue FROM #Transfer_1 WHERE NAME='GRN' AND parent_ID = @Row),  
  (SELECT StringValue FROM #Transfer_1 WHERE NAME='IsOnShelf' AND parent_ID = @Row),  
  (SELECT StringValue FROM #Transfer_1 WHERE NAME='BalanceQty' AND parent_ID = @Row),  
  (SELECT StringValue FROM #Transfer_1 WHERE NAME='ValidInWhouse' AND parent_ID = @Row),  
  (SELECT StringValue FROM #Transfer_1 WHERE NAME='ValidOutWhouse' AND parent_ID = @Row)  
 )  
 SET @Row = @Row -1;    
 END  
 --获取调拨信息  
 SELECT @TransfersNo = TransfersNo FROM Prod_Transfers WHERE  TransfersId = @TransfersId  
 --校验调拨单状态
	IF EXISTS(SELECT 1 FROM Prod_Transfers WHERE TransfersNo=@TransfersNo AND (Statue=3 OR Statue=2))
	BEGIN
		RAISERROR('该调拨单已经出库完成或调拨完成！',12,1)
		RETURN; 
	END
	--校验GRN是否已调拨入库
	DECLARE @GRN NVARCHAR(50)
	SELECT @GRN = TDL.GRN FROM Prod_TransfersDtlMaterial TDL
		INNER JOIN @TransferDtlMaterial_Tb T ON T.GRN = TDL.GRN
	WHERE TDL.TransfersId =@TransfersId
	IF @GRN IS NOT NULL
	BEGIN
		SET @LogContent = '存在已调拨出库的物料条码【'+ @GRN+ '】'
		RAISERROR(@LogContent, 12, 1);  
        RETURN; 
	END
	--调拨明细
	INSERT INTO @TransferDtl_Tb
	SELECT A.TransfersDtlId,
		TD.ApplyQty,
		SUM(MU.BalanceQty)
	FROM (
		SELECT TDL.TransfersDtlId,TDL.GRN,TDL.IsOnShelf FROM Prod_TransfersDtlMaterial TDL	
		WHERE TDL.TransfersId = @TransfersId 
			AND TDL.TransfersDtlId IN (SELECT TransfersDtlId FROM @TransferDtlMaterial_Tb)
			AND TDL.GRN NOT IN(SELECT GRN FROM @TransferDtlMaterial_Tb)
		UNION
		SELECT T.TransfersDtlId,T.GRN,1 FROM @TransferDtlMaterial_Tb T
	) A 
		INNER JOIN Prod_TransfersDtl TD ON TD.TransfersDtlId = A.TransfersDtlId
		INNER JOIN Prod_MaterialUnit MU ON A.GRN = MU.SerialNumber
	GROUP BY A.TransfersDtlId,TD.ApplyQty
 
	--校验数量  
	 IF EXISTS(
			SELECT 1 FROM   @TransferDtl_Tb AS A
			WHERE A.FinishQty>A.ApplyQty
	 )
	 BEGIN  
			RAISERROR('调拨明细的调拨数量不能大于申请数量',12,1);    
			RETURN;   
	 END  
     
    BEGIN TRAN;    
     
 --1.将调拨信息保存到表中    
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
            '',  
            A.cBarCode ,    
            @UserName ,    
            GETDATE()    
    FROM    Prod_MaterialUnit A  WITH ( NOLOCK )  
            INNER JOIN Basal_Item B WITH ( NOLOCK ) ON A.PartId = B.ItemID    
            INNER JOIN @TransferDtlMaterial_Tb C ON A.SerialNumber = C.GRN   
            INNER JOIN dbo.Prod_TransfersDtl D WITH ( NOLOCK ) ON D.TransfersDtlId = C.TransfersDtlId    
   INNER JOIN Prod_Transfers E WITH ( NOLOCK ) ON D.TransfersId = E.TransfersId  
 WHERE E.TransfersId = @TransfersId  
     
    SET @LogContent = '调拨单号【' + @TransfersNo + '】';    
	SET @FunctionName= (CASE @OpSource WHEN 1 THEN 'PC-调拨出库' WHEN 2 THEN 'PDA-调拨出库' END);
    EXEC uspSaveOperationLog @UserName, '调拨出库', '仓库管理',    
        @FunctionName, @TransfersNo, @LogContent;    
    IF @@ERROR <> 0    
        BEGIN     
            RAISERROR('插入日志失败!',12,1);    
            RETURN;     
        END;       
     
 --2更新GRN状态和库位条码    
    UPDATE  A    
    SET     A.Status = 20 ,    
   A.ModifyBy = @UserName ,    
            A.ModifyDateTime = GETDATE() ,    
            A.cBarCode = '' ,    
            A.WarehouseId = C.WarehouseId    
    FROM    Prod_MaterialUnit A  WITH ( NOLOCK )   
            INNER JOIN @TransferDtlMaterial_Tb B ON A.SerialNumber = B.GRN  
   INNER JOIN Basal_Warehouse C WITH ( NOLOCK ) ON C.CWhCode = B.ValidInWhouse  
  
         
 --3.插入物料历史记录表  
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
                    B.BalanceQty,    
                    '调拨' ,    
                    @UserName ,    
                    GETDATE() ,    
                    '调拨出库' ,    
                    @TransfersNo    
            FROM    @TransferDtlMaterial_Tb AS A    
                    INNER JOIN Prod_MaterialUnit AS B WITH ( NOLOCK ) ON A.GRN = B.SerialNumber;      
     
    IF @@error <> 0    
        BEGIN    
            RAISERROR('更新GRN状态失败!', 12, 1);    
            ROLLBACK TRANSACTION;     
            RETURN;    
        END;    
     
     
 --4.调拨明细：完成数量等于申请数量则Statue为3，否则则为1    
    UPDATE  A    
    SET     A.FinishQty = B.FinishQty,
            Statue = CASE WHEN B.FinishQty = B.ApplyQty THEN 3    
                          ELSE 1    
                     END    
    FROM Prod_TransfersDtl AS A  
    INNER JOIN @TransferDtl_Tb AS B ON A.TransfersDtlId = B.TransfersDtlId    
    WHERE   A.TransfersId = @TransfersId;     
     
    IF @@error <> 0    
        BEGIN    
            RAISERROR('更新调拨单失败!#1', 12, 1);    
            ROLLBACK TRANSACTION;     
            RETURN;    
        END;    
     
 --5.调拨主表：总数相等，更新主表状态为 完成    
    DECLARE @SumFinishQty DECIMAL;    
    DECLARE @SumQty DECIMAL;    
    SELECT  @SumFinishQty = SUM(FinishQty)    
    FROM    Prod_TransfersDtl    
    WHERE   TransfersId = @TransfersId;  ----调拨总数    
    SELECT  @SumQty = SUM(ApplyQty)    
    FROM    Prod_TransfersDtl    
    WHERE   TransfersId = @TransfersId;  ----申请总数    
    IF @SumFinishQty = @SumQty    
        BEGIN    
            UPDATE  Prod_Transfers    
            SET     Statue = 3    
            WHERE   TransfersId = @TransfersId;    
            IF @@error <> 0    
                BEGIN    
                    RAISERROR('更新调拨单失败!#2', 12, 1);    
                    ROLLBACK TRANSACTION;     
                    RETURN;    
                END;    
        END;    
    ELSE    
        BEGIN    
            UPDATE  Prod_Transfers    
            SET     Statue = 1    
            WHERE   TransfersId = @TransfersId;    
            IF @@error <> 0    
                BEGIN    
                    RAISERROR('更新调拨单失败!#2', 12, 1);    
                    ROLLBACK TRANSACTION;     
                    RETURN;    
                END;    
        END;     
        
   --6.新调拨物料的增加调拨明细物料对应关系  
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
        ROLLBACK TRANSACTION;     
        RETURN;    
    END;

  --删除临时GRN
  DELETE b FROM @TransferDtlMaterial_Tb a JOIN dbo.Prod_TransfersGrn b ON b.GRN = a.GRN

    COMMIT TRAN;

