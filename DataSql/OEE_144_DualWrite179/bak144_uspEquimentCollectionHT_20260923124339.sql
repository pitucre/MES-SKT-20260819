/*****************************
项目名称：山东亿辰
功能描叙：
创 建 人：xi.zhu
创建时间：2024-09-22
更新信息: 
测试调试：
*/
CREATE PROC uspEquimentCollectionHT
@Status VARCHAR(50) ,
@EquiCode VARCHAR(50),
@ActCntPrt VARCHAR(50)
AS
BEGIN 

   DECLARE @WordDateTime DATETIME=GETDATE();
   DECLARE @WorkDate DATE=@WordDateTime;
   --PartSts=生产状态、MachineID=机器号、ActCntPrt=生产数量计数器
   DECLARE @ParamterStr NVARCHAR(MAX)='@PartSts,@MachineID,@ActCntPrt';
   DECLARE @ParamterVal NVARCHAR(MAX)=@Status+','+@EquiCode+','+@ActCntPrt;

   	--获取当天上一次执行更新时间与状态
	DECLARE  @LastDateTime DATETIME,@LastStatus INT ,@TotalRuntime  INT=0 ,@TotalWait INT=0 ,@TotalStop int=0 ;
	SELECT @LastDateTime=LastUpdateTime,@LastStatus=CurrentStatus FROM Prod_EquipmentStatusCollectionCurrent  WHERE WorkDate=@WorkDate AND MachineCode=@EquiCode
	SET @Status=ISNULL(@Status,0)
	IF @LastDateTime IS NULL
	BEGIN 
	        IF @Status=0
			BEGIN 
				SET @TotalStop=DATEDIFF(ss,@WorkDate,@WordDateTime)
			END 
			ELSE IF @Status=2
			BEGIN 
				SET @TotalWait= DATEDIFF(ss,@WorkDate,@WordDateTime)
			END 
			ELSE  IF @Status IN(3,4)
			BEGIN 
				SET @TotalRuntime=DATEDIFF(ss,@WorkDate,@WordDateTime)
			END 

			INSERT dbo.Prod_EquipmentStatusCollectionCurrent
			(
			    WorkDate,
			    MachineCode,
			    MachineIP,
			    CurrentStatus,
			    TotalRuntime,
			    TotalWait,
			    TotalStop,
			    LastUpdateTime
			)
			VALUES
			(   @WorkDate, -- WorkDate - date
			    @EquiCode,        -- MachineCode - varchar(100)
			    '',        -- MachineIP - varchar(20)
			    @Status,         -- CurrentStatus - int
			    @TotalRuntime,         -- TotalRuntime - int
			    @TotalWait,         -- TotalWait - int
			    @TotalStop,         -- TotalStop - int
			    @WordDateTime  -- LastUpdateTime - datetime
			    )
	END 
	ELSE 
	BEGIN 

	     -- 上一状态是停机或者待机状态和当前状态是生产状态计算运行时间
	        IF @LastStatus IN (0,2) AND @Status IN(3,4)
			BEGIN 
				SET @TotalRuntime=DATEDIFF(ss,@LastDateTime,@WordDateTime)
			END 
			 -- 上一状态是生产状态和当前状态是停机算运行时间
			ELSE IF @LastStatus IN(3,4,0) AND @Status=2
			BEGIN 
				SET @TotalStop= DATEDIFF(ss,@LastDateTime,@WordDateTime)
			END 
			ELSE  IF @LastStatus IN(3,4,1) AND @Status IN(0)
			BEGIN 
				SET @TotalStop=DATEDIFF(ss,@LastDateTime,@WordDateTime)
			END 
			ELSE 
			BEGIN 
				IF @Status=0
				BEGIN 
					SET @TotalStop=DATEDIFF(ss,@LastDateTime,@WordDateTime)
				END 
				ELSE IF @Status=2
				BEGIN 
					SET @TotalWait= DATEDIFF(ss,@LastDateTime,@WordDateTime)
				END 
				ELSE  IF @Status IN(3,4)
				BEGIN 
					SET @TotalRuntime=DATEDIFF(ss,@LastDateTime,@WordDateTime)
				END 	
			END 
			UPDATE dbo.Prod_EquipmentStatusCollectionCurrent SET CurrentStatus=@Status,TotalRuntime=TotalRuntime+@TotalRuntime,
			TotalWait=TotalWait+@TotalWait,TotalStop=TotalStop+@TotalStop ,@LastDateTime=@WordDateTime
			WHERE WorkDate=@WorkDate AND MachineCode=@EquiCode
	END 

   INSERT dbo.Prod_EquipmentCollectionHistory
	(
	    ParamterStr,
	    ParamterVal,
		EquipmentCode
	)
	VALUES
	(   
	    @ParamterStr,       -- ParamterStr - varchar(2000)
	    @ParamterVal,       -- ParamterVal - varchar(2000)
	    @EquiCode
	)
END 
