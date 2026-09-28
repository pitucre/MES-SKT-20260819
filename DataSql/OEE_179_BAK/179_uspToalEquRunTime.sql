/*****************************
项目名称：山东亿辰
功能描叙：统计设备当前运行时间
创 建 人：xi.zhu
创建时间：2025-08-08
更新信息: 
测试调试：

*/
CREATE PROC [dbo].[uspToalEquRunTime]
@EquipmentCode VARCHAR(50)
AS
BEGIN 

     DECLARE @NowDateTime DATETIME=GETDATE();
     DECLARE @EquimentExtNo VARCHAR(100) = '',
            @WorkDate DATE = @NowDateTime;
		DECLARE @LastDateTime DATETIME,
            @LastStatus INT,
            @TotalRuntime int = 0,
            @TotalWait INT = 0,
            @TotalStop INT = 0,
            @RunTotalTime DECIMAL(18,2)=0,
            @CollectionTime DATETIME = @NowDateTime;

    --获取当天上一次的时间        
    SELECT @LastDateTime = LastUpdateTime,
           @LastStatus = CurrentStatus
    FROM Prod_EquipmentStatusData WITH (NOLOCK)
    WHERE WorkDate = @WorkDate
          AND MachineCode = @EquipmentCode;

    --如果当天设备状态为空 则获取之前上一次的状态
    IF  @LastStatus IS NULL 
	BEGIN 
		---获取设备最新的上一次的状态        
		SELECT @LastStatus = CurrentStatus
		FROM Prod_EquipmentStatusData WITH (NOLOCK)
		WHERE MachineCode = @EquipmentCode;
	END 

    SET @LastStatus = ISNULL(@LastStatus, 1); --默认生产中        
    IF @LastDateTime IS NULL
    BEGIN
        IF @LastStatus = 1
        BEGIN
            SET @TotalRuntime = DATEDIFF(ss, @WorkDate, @NowDateTime);
        END;
        ELSE
        BEGIN
            SET @TotalStop = DATEDIFF(ss, @WorkDate, @NowDateTime);
        END;

        INSERT dbo.Prod_EquipmentStatusData
        (
            WorkDate,
            MachineCode,
            CurrentStatus,
            TotalRuntime,
            TotalWait,
            TotalStop,
            LastUpdateTime
        )
        VALUES
        (   @WorkDate,      -- WorkDate - date        
            @EquipmentCode, -- MachineCode - varchar(100)        
            @LastStatus,    -- CurrentStatus - int        
            @TotalRuntime,  -- TotalRuntime - int        
            @TotalWait,     -- TotalWait - int        
            @TotalStop,     -- TotalStop - int        
            @NowDateTime       -- LastUpdateTime - datetime        
            );
        IF @@ERROR <> 0
        BEGIN
            RAISERROR('新增设备运行时间发生错误!', 1, 12);
            RETURN;
        END;
    END;
    ELSE
    BEGIN
        ---上一次状态生产         
        IF @LastStatus = 1
        BEGIN
            SET @TotalRuntime = DATEDIFF(ss, @LastDateTime, @CollectionTime);
        END;
        ELSE
        BEGIN
            SET @TotalStop = DATEDIFF(ss, @LastDateTime, @CollectionTime);
        END;

        UPDATE dbo.Prod_EquipmentStatusData
        SET TotalRuntime = TotalRuntime + @TotalRuntime,
            TotalWait = TotalWait + @TotalWait,
            TotalStop = TotalStop + @TotalStop,
            LastUpdateTime = @CollectionTime
        WHERE WorkDate = @WorkDate
              AND MachineCode = @EquipmentCode;
        IF @@ERROR <> 0
        BEGIN
            RAISERROR('更新设备运行时间发生错误!', 1, 12);
            RETURN;
        END;
    END;
	--当前小时
	DECLARE @Hours INT=DATEPART(HOUR, @NowDateTime);
	DECLARE @ATotalRuntime INT=0 ,@BTotalRuntime INT=0 ;
	
    IF NOT  EXISTS( SELECT  1 FROM  Prod_EquipmentStatusCollectionData  WHERE  MachineCode=@EquipmentCode  AND WorkDate=@WorkDate AND Status=@LastStatus)
	BEGIN 
			 IF @LastDateTime IS NULL 
			 BEGIN 
			 --如果当前时间
				 IF (@Hours>=0  AND @Hours<8)   
				 BEGIN 
						SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 00:00:00'
						SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);
				 END  
				 ELSE  IF (@Hours>=20 AND  @Hours<24)
				 BEGIN
					 SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 20:00:00'
					 SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);
				 END 
				 ELSE
				 BEGIN  
					 SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 08:00:00'
					 SET @BTotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);
				 END 
			 END 
			 ELSE  
			 BEGIN 
			     --上一次更新时间小时
			     DECLARE @HoursLast INT=DATEPART(HOUR, @LastDateTime);
				   --如果当前时间
				 IF (@Hours>=0  AND @Hours<8)    
				 BEGIN 
				        
						IF (@HoursLast >8 OR @HoursLast<24)
						BEGIN 
						   SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 00:00:00'
						   SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);
						END 
						ELSE 
						BEGIN 
							SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);
						END 
						
				 END  
				 ELSE  IF (@Hours>=20 AND  @Hours<24)  
				 BEGIN
				     IF  (@HoursLast >24 OR  @HoursLast<20)
					 BEGIN 
						SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 20:00:00'
					    SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);
					 END 
					 ELSE 
					 BEGIN 
					      SET @ATotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);
					 END 
					 
				 END 
				 ELSE IF (@Hours>=8 AND  @Hours<20)  
				 BEGIN  
					   IF  (@HoursLast >20 OR  @HoursLast<8)
					   BEGIN 
						  SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 08:00:00'
						 SET @BTotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);
					   END 
					   ELSE 
					   BEGIN 
						  SET @BTotalRuntime=DATEDIFF(ss, @LastDateTime, @NowDateTime);
					   END 
				 END 
				

			 END 



			INSERT dbo.Prod_EquipmentStatusCollectionData
			(
			    WorkDate,
			    MachineCode,
			    Status,
			    ATotalRuntime,
			    BTotalRuntime,
			    LastUpdateTime
			)
			VALUES
			(   @WorkDate, -- WorkDate - date
			    @EquipmentCode,        -- MachineCode - varchar(100)
			    @LastStatus,         -- Status - int
			    @ATotalRuntime,         -- ATotalRuntime - int
			    @BTotalRuntime,         -- BTotalRuntime - int
			    @NowDateTime  -- LastUpdateTime - datetime
			    )
			IF @@ERROR <> 0
			BEGIN
				RAISERROR('新增设备运行时间发生错误!', 1, 12);
				RETURN;
			END;
	END 
	ELSE 
	BEGIN 
			 IF (@Hours>=0  AND @Hours<8)
			 BEGIN 
				  SET @ATotalRuntime=CASE WHEN @TotalRuntime>0 THEN @TotalRuntime ELSE @TotalStop END ;
			 END  
			 ELSE IF  (@Hours>=20 AND  @Hours<24)
			 BEGIN 
			      ---如果上次更新时间小于晚班开始时间20点则配置成
			       IF (@LastDateTime<CONVERT(VARCHAR(10),GETDATE(),120)+' 20:00:00')
				   BEGIN 
						SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 20:00:00'
						SET @ATotalRuntime =DATEDIFF(ss, @LastDateTime, @CollectionTime);
				   END 
				   ELSE 
				   BEGIN 
			          SET @ATotalRuntime=CASE WHEN @TotalRuntime>0 THEN @TotalRuntime ELSE @TotalStop END ;
				   END 
			 END  
			 ELSE 
			 BEGIN 

			      --如果上一次的时间小时
			      IF  DATEPART(HOUR, @NowDateTime)<8
				  BEGIN 
						SET @LastDateTime=CONVERT(VARCHAR(10),GETDATE(),120)+' 08:00:00'
						SET @BTotalRuntime =DATEDIFF(ss, @LastDateTime, @CollectionTime);
				  END  
				  ELSE 
				  BEGIN 
			         SET @BTotalRuntime=CASE WHEN @TotalRuntime>0 THEN @TotalRuntime ELSE @TotalStop END ;
				  END 
			 END 
			 UPDATE Prod_EquipmentStatusCollectionData SET ATotalRuntime=ATotalRuntime+@ATotalRuntime ,BTotalRuntime=@BTotalRuntime+BTotalRuntime,LastUpdateTime=@CollectionTime WHERE  WorkDate=@WorkDate AND MachineCode=@EquipmentCode AND Status=@LastStatus
	END 
END 
