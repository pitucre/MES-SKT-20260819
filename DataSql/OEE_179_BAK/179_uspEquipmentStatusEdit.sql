
/*****************************        
项目名称：山东亿辰        
功能描叙：        
创 建 人：xi.zhu        
创建时间：2024-09-22        
更新信息:         
测试调试：        
*/      
CREATE PROC [dbo].[uspEquipmentStatusEdit]      
    @EquipmentCode VARCHAR(50),      
    @Status INT,      
    @UserName VARCHAR(20)      
AS      
BEGIN      
    DECLARE @InjectionStatus INT=-1;      
    DECLARE @NowDateTime DATETIME =GETDATE()    
    DECLARE @CollectionTime DATETIME = @NowDateTime;      
    DECLARE @CollectionDate DATE = @CollectionTime;      
  
    SELECT @InjectionStatus = ISNULL(InjectionStatus, -1)      
    FROM dbo.Basal_Equipment WITH (NOLOCK)      
    WHERE EquipmentCode = @EquipmentCode;      
    IF @InjectionStatus IS NULL      
    BEGIN      
        RAISERROR('设备编码不存在!', 1, 12);      
        RETURN;      
    END;      
      
  
    --获取当天上一次执行更新时间与状态        
    DECLARE @LastDateTime DATETIME,      
            @LastStatus INT,      
            @TotalRuntime INT = 0,      
            @TotalWait INT = 0,      
            @TotalStop INT = 0;      
    
    --获取当天上一次的时间        
    SELECT @LastDateTime = LastUpdateTime,      
           @LastStatus = CurrentStatus      
    FROM Prod_EquipmentStatusData WITH (NOLOCK)      
    WHERE WorkDate = @CollectionDate      
          AND MachineCode = @EquipmentCode;      
    
    IF @LastStatus IS NULL    
		 BEGIN   
			---获取设备最新的上一次的状态        
		  SELECT @LastStatus = CurrentStatus      
		  FROM Prod_EquipmentStatusData WITH (NOLOCK)      
		  WHERE MachineCode = @EquipmentCode;      
		  SET @LastStatus = ISNULL(@LastStatus, 1); --默认生产中      
  
		 END    
		IF @LastStatus = @Status  and @LastStatus is not null     
		BEGIN      
			RETURN;      
		END;    
   
  
   
      
    --生产状态切换的逻辑是：设备状态当前属于调试状态； --调试状态切换的逻辑是：设备状态当前属于停机/换模状态； --换模状态切换的逻辑是：设备状态当前属于停机状态； --停机状态的切换逻辑是：设备当前属于生产状态/调试状态        
    --DECLARE @ErrorMsg VARCHAR(500) = CASE      
    --                                     WHEN @Status = 1      
    --                                          AND @InjectionStatus != 3 THEN      
    --                                         '设备当前状态非调试状态！'      
    --                                     WHEN @Status = 3      
    --                                          AND @InjectionStatus NOT IN ( 3, 5 ) THEN      
    --                                         '设备当前状态非停机/换模状态！'      
    --                                     WHEN @Status = 2      
    --                                          AND @InjectionStatus != 5 THEN      
    --                                         '设备当前状态非停机状态！'      
    --                                     WHEN @Status = 5      
    --                                          AND @InjectionStatus NOT IN ( 1, 3 ) THEN      
    --                                         '设备当前状态非生产 / 调试状态！'      
    --                                     ELSE      
    --                                         ''      
    --                                 END;      
    --IF @ErrorMsg != ''      
    --BEGIN      
    --    RAISERROR(@ErrorMsg, 1, 12);      
    --    RETURN;      
    --END;      
      
     
      
      
    BEGIN TRAN;      
    
    UPDATE Basal_Equipment      
    SET InjectionStatus = @Status      
    WHERE EquipmentCode = @EquipmentCode;      
    IF @@ERROR <> 0      
    BEGIN      
        RAISERROR('变更设备状态发生错误!', 1, 12);   
        ROLLBACK TRAN;    
        RETURN;      
    END;      
      
	 EXEC  uspToalEquRunTime @EquipmentCode
	 IF  @@ERROR<>0
	 BEGIN  
	    RAISERROR('变更设备状态发生错误!', 1, 12);   
        ROLLBACK TRAN;    
        RETURN;  
	 END 

	 UPDATE dbo.Prod_EquipmentStatusData SET CurrentStatus=@Status   WHERE WorkDate=@CollectionDate AND MachineCode=@EquipmentCode;
			IF  @@ERROR<>0
				BEGIN
					  RAISERROR('更新设备运行时间发生错误!',1,12);
					  ROLLBACK TRAN;
		              RETURN;
                END 
  
 --   IF @LastDateTime IS NULL      
 --   BEGIN      
 --       IF @Status = 1  OR @LastStatus = 1      
 --       BEGIN      
 --           SET @TotalRuntime = DATEDIFF(ss, @CollectionDate, @CollectionTime);      
 --       END;      
 --       ELSE      
 --       BEGIN      
 --           SET @TotalStop = DATEDIFF(ss, @CollectionDate, @CollectionTime);      
 --       END;      
 --       INSERT dbo.Prod_EquipmentStatusData      
 --       (      
 --           WorkDate,      
 --           MachineCode,      
 --           CurrentStatus,      
 --           TotalRuntime,      
 --           TotalWait,      
 --           TotalStop,      
 --           LastUpdateTime      
 --       )      
 --       VALUES      
 --       (   @CollectionDate, -- WorkDate - date        
 --           @EquipmentCode,  -- MachineCode - varchar(100)        
 --           @Status,         -- CurrentStatus - int        
 --           @TotalRuntime,   -- TotalRuntime - int        
 --           @TotalWait,      -- TotalWait - int        
 --           @TotalStop,      -- TotalStop - int        
 --           @CollectionTime  -- LastUpdateTime - datetime        
 --           );      
 --       IF @@ERROR <> 0      
 --       BEGIN      
 --           RAISERROR('新增设备运行时间发生错误!', 1, 12);      
 --           ROLLBACK TRAN;      
 --           RETURN;      
 --       END;      
 --   END;      
 --  ELSE      
 --   BEGIN      
 --       ---上一次状态生产         
 --       IF @LastStatus = 1      
 --       BEGIN      
 --           SET @TotalRuntime = DATEDIFF(ss, @LastDateTime, @CollectionTime);      
 --       END;      
 --       ELSE      
 --       BEGIN      
 --           SET @TotalStop = DATEDIFF(ss, @LastDateTime, @CollectionTime);      
 --       END;      
 --       PRINT @TotalRuntime    
 --       UPDATE dbo.Prod_EquipmentStatusData      
 --       SET CurrentStatus = @Status,      
 --           TotalRuntime = TotalRuntime + @TotalRuntime,      
 --           TotalWait = TotalWait + @TotalWait,      
 --           TotalStop = TotalStop + @TotalStop,      
 --           LastUpdateTime = @CollectionTime      
 --       WHERE WorkDate = @CollectionDate      
 --             AND MachineCode = @EquipmentCode;      
 --       IF @@ERROR <> 0      
 --       BEGIN      
 --           RAISERROR('更新设备运行时间发生错误!', 1, 12);      
 --           ROLLBACK TRAN;      
 --           RETURN;      
 --       END;      
 --   END;      
    
 ----当前小时    
 --DECLARE @Hours INT=DATEPART(HOUR, @NowDateTime);    
 --DECLARE @ATotalRuntime INT=0 ,@BTotalRuntime INT=0 ;    
     
 --   IF NOT  EXISTS( SELECT  1 FROM  Prod_EquipmentStatusCollectionData  WHERE  MachineCode=@EquipmentCode  AND WorkDate=@CollectionDate AND Status=@LastStatus)    
 --BEGIN     
    
 --         IF (@Hours>0  AND @Hours<8) OR (@Hours>20 AND  @Hours<24)    
 --   BEGIN     
 --    SET @ATotalRuntime=DATEDIFF(ss,CASE WHEN @LastDateTime IS NULL  THEN  @CollectionDate ELSE @LastDateTime END , @NowDateTime);    
 --   END      
 --   ELSE     
 --   BEGIN     
 --      SET @BTotalRuntime=DATEDIFF(ss, CASE WHEN @LastDateTime IS NULL  THEN  @CollectionDate ELSE @LastDateTime END, @NowDateTime);    
 --   END     
    
 --  INSERT dbo.Prod_EquipmentStatusCollectionData    
 --  (    
 --      WorkDate,    
 --      MachineCode,    
 --      Status,    
 --      ATotalRuntime,    
 --      BTotalRuntime,    
 --      LastUpdateTime    
 --  )    
 --  VALUES    
 --  (   @CollectionDate, -- WorkDate - date    
 --      @EquipmentCode,        -- MachineCode - varchar(100)    
 --      @LastStatus,         -- Status - int    
 --      @ATotalRuntime,         -- ATotalRuntime - int    
 --      @BTotalRuntime,         -- BTotalRuntime - int    
 --      @NowDateTime  -- LastUpdateTime - datetime    
 --      )    
 --  IF @@ERROR <> 0    
 --  BEGIN    
 --   RAISERROR('新增设备运行时间发生错误!', 1, 12);    
 --    ROLLBACK TRAN;      
 --   RETURN;    
 --  END;    
 --END     
 --ELSE     
 --BEGIN     
 --   IF (@Hours>0  AND @Hours<8) OR (@Hours>20 AND  @Hours<24)    
 --   BEGIN     
 --    SET @ATotalRuntime=CASE WHEN @TotalRuntime>0 THEN @TotalRuntime ELSE @TotalStop END ;    
 --   END      
 --   ELSE     
 --   BEGIN     
 --      SET @BTotalRuntime=CASE WHEN @TotalRuntime>0 THEN @TotalRuntime ELSE @TotalStop END ;    
 --   END     
 --   UPDATE Prod_EquipmentStatusCollectionData SET ATotalRuntime=ATotalRuntime+@ATotalRuntime ,BTotalRuntime=@BTotalRuntime+BTotalRuntime WHERE  WorkDate=@CollectionDate AND MachineCode=@EquipmentCode AND Status=@LastStatus    
 --       IF @@ERROR <> 0    
 --   BEGIN    
 --   RAISERROR('更新设备运行时间发生错误!', 1, 12);    
 --    ROLLBACK TRAN;      
 --   RETURN;    
 --  END;    
     
 --END     
    
      
    COMMIT TRAN;      
      
    DECLARE @InjectionStatusStr NVARCHAR(30) =''     
 SELECT  @InjectionStatusStr=ISNULL(StatusDesc,'')  FROM  Basal_EquipmentStatus  WHERE  StatusId=@InjectionStatus     
    DECLARE @StatusStr NVARCHAR(30) =''    
   SELECT  @StatusStr=ISNULL(StatusDesc,'')  FROM  Basal_EquipmentStatus  WHERE  StatusId=@Status     
    
    DECLARE @LogContent VARCHAR(500) = '变更设备状态由【' + @InjectionStatusStr + '】变更【' + @StatusStr + '】';      
    EXEC uspSaveOperationLog @UserName,      
                             '修改',      
                             '注塑采集',      
                             '注塑采集',      
                             @EquipmentCode,      
                             @LogContent;      
      
END;      
    


SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
