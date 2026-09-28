/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-05
 * Description: PDA形态转换-MES 移除条码。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspFromChangeMesDeleteBarCode]
(
    @FromChangeByMESDtId INT,
	@CreateBy NVARCHAR(50)
)
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON
BEGIN
	BEGIN TRY
		DECLARE @ErrNum INT	,@LogContent NVARCHAR(200)
		--开启事务
		BEGIN TRAN TranEdit;
		

		DECLARE @Staues INT = -1,@FromChangeByMESId INT = -1,@FromChangeByMESNo VARCHAR(50),@BarCode VARCHAR(50)

		SELECT @Staues = b.Staues,@FromChangeByMESId = b.FromChangeByMESId,@FromChangeByMESNo = b.FromChangeByMESNo,@BarCode = a.BarCode FROM dbo.Prod_FromChangeByMESDt a WITH(NOLOCK) 
		INNER JOIN dbo.Prod_FromChangeByMES b WITH(NOLOCK) ON a.FromChangeByMESId = b.FromChangeByMESId
		WHERE a.FromChangeByMESDtId = @FromChangeByMESDtId


		IF @Staues = -1
		BEGIN
		    RAISERROR('当前条码已删除，请重新扫描单号!',12,1)
		END

		IF @Staues = 1
		BEGIN
		    RAISERROR('当前已完成转换,无法删除!',12,1)
		END

		DELETE FROM dbo.Prod_FromChangeByMESDt WHERE FromChangeByMESDtId = @FromChangeByMESDtId

		/*明细都没有了，删除主表*/
		IF NOT EXISTS (SELECT 1 FROM dbo.Prod_FromChangeByMESDt WHERE FromChangeByMESId = @FromChangeByMESId)
		BEGIN
		    DELETE FROM dbo.Prod_FromChangeByMES WHERE FromChangeByMESId = @FromChangeByMESId
		END

		SET @LogContent='形态转换单据【'+@FromChangeByMESNo+'】移除了条码【'+@BarCode+'】';
		EXEC dbo.uspSaveOperationLog @UserName=@CreateBy,@LogType='删除',@ModuleName='PDA形态转换MES',@PageName='PDA形态转换MES',@OederNo=@FromChangeByMESNo,@LogContent=@LogContent
		IF @@ERROR <>0
		BEGIN
			RAISERROR('写入删除形态转换单据条码日志失败', 12, 1)
		END
	
		
		
		--提交事务
		COMMIT TRAN TranEdit;
		
	END TRY
	BEGIN CATCH
		--事务回滚
		IF @@TRANCOUNT > 0
    	BEGIN
			ROLLBACK TRAN TranEdit;  
		END;
		THROW
	END CATCH
END
SET NOCOUNT OFF

