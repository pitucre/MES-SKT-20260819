/**
 * Author: Jian.Lan
 * Creaet Date: 2026-03-04
 * Description: PDA 碎料移除GRN。
 * Update							Time						Description
 *
 */
CREATE PROCEDURE [dbo].[uspSrapFeedingDeleteBarCode]
(
    @SrapFeedingDtId INT,
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
		

		DECLARE @Staues INT = -1,@SrapFeedingId INT = -1,@SrapFeedingNo VARCHAR(50),@BarCode VARCHAR(50)

		SELECT @Staues = b.Staues,@SrapFeedingId = b.SrapFeedingId,@SrapFeedingNo = b.SrapFeedingNo,@BarCode = a.BarCode FROM dbo.Prod_SrapFeedingDtl a WITH(NOLOCK) 
		INNER JOIN dbo.Prod_SrapFeeding b WITH(NOLOCK) ON a.SrapFeedingId = b.SrapFeedingId
		WHERE a.SrapFeedingDtId = @SrapFeedingDtId


		IF @Staues = -1
		BEGIN
		    RAISERROR('当前条码已删除，请重新扫描粉碎机!',12,1)
		END

		IF @Staues = 1
		BEGIN
		    RAISERROR('当前已完成碎料上料,无法删除!',12,1)
		END

		DELETE FROM dbo.Prod_SrapFeedingDtl WHERE SrapFeedingDtId = @SrapFeedingDtId

		/*明细都没有了，删除主表*/
		IF NOT EXISTS (SELECT 1 FROM dbo.Prod_SrapFeedingDtl WHERE SrapFeedingId = @SrapFeedingId)
		BEGIN
		    DELETE FROM dbo.Prod_SrapFeeding WHERE SrapFeedingId = @SrapFeedingId
		END

		SET @LogContent='碎料上料单据【'+@SrapFeedingNo+'】移除了条码【'+@BarCode+'】';
		EXEC dbo.uspSaveOperationLog @UserName=@CreateBy,@LogType='删除',@ModuleName='PDA粉碎机上料',@PageName='PDA粉碎机上料',@OederNo=@SrapFeedingNo,@LogContent=@LogContent
		IF @@ERROR <>0
		BEGIN
			RAISERROR('写入删除粉碎料条码日志失败', 12, 1)
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

