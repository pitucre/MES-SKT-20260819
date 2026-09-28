
/*****************************
项目名称：获取设备A B班制状态的运行时间
功能描叙：
创 建 人：xi.zhu
创建时间：2025-04-08
更新信息: 
测试调试：

*/
CREATE VIEW [dbo].[vWGetEquipmentShiftStatusTime]
as
	select  CONVERT(VARCHAR(10),WorkDate,120) WorkDate,MachineCode,'晚班' ShiftType
		,[dbo].[fn_GetDateZH] (sum(case when Status=1 then AtotalRunTime else 0 end)) '生产'
		,[dbo].[fn_GetDateZH] (sum(case when Status=2 then AtotalRunTime else 0 end)) '换模'
		,[dbo].[fn_GetDateZH] (sum(case when Status=3 then AtotalRunTime else 0 end)) '调试'
		,[dbo].[fn_GetDateZH] (sum(case when Status=4 then AtotalRunTime else 0 end)) '设备故障'
		,[dbo].[fn_GetDateZH] (sum(case when Status=5 then AtotalRunTime else 0 end)) '模具故障'
		,[dbo].[fn_GetDateZH] (sum(case when Status=6 then AtotalRunTime else 0 end)) '计划停机'
		,[dbo].[fn_GetDateZH] (sum(case when Status=7 then AtotalRunTime else 0 end)) '原材料缺料'
		,[dbo].[fn_GetDateZH] (sum(case when Status=8 then AtotalRunTime else 0 end)) '辅材缺料'
		,[dbo].[fn_GetDateZH] (sum(case when Status=9 then AtotalRunTime else 0 end)) '保养'
		,[dbo].[fn_GetDateZH] (sum(case when Status=10 then AtotalRunTime else 0 end)) '待换模'
		,[dbo].[fn_GetDateZH] (sum(case when Status=11 then AtotalRunTime else 0 end)) '试模'
	    ,[dbo].[fn_GetDateZH] (sum(case when Status=12 then AtotalRunTime else 0 end)) '人力不足'
		,[dbo].[fn_GetDateZH] (sum(case when Status=13 then AtotalRunTime else 0 end)) '烘料'
		,[dbo].[fn_GetDateZH] (sum(case when Status=14 then AtotalRunTime else 0 end)) '试料'
		,[dbo].[fn_GetDateZH] (sum(case when Status=15 then AtotalRunTime else 0 end)) '模具厂试模'

		--,[dbo].[fn_GetDateZH] (sum(case when Status=1 then BtotalRunTime else 0 end)) 'B生产'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=2 then BtotalRunTime else 0 end)) 'B换模'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=3 then BtotalRunTime else 0 end)) 'B调试'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=4 then BtotalRunTime else 0 end)) 'B设备故障'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=5 then BtotalRunTime else 0 end)) 'B模具故障'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=6 then BtotalRunTime else 0 end)) 'B计划停机'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=7 then BtotalRunTime else 0 end)) 'B原材料缺料'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=8 then BtotalRunTime else 0 end)) 'B辅材缺料'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=9 then BtotalRunTime else 0 end)) 'B保养'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=10 then BtotalRunTime else 0 end)) 'B待换模'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=11 then BtotalRunTime else 0 end)) 'B试模'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=12 then BtotalRunTime else 0 end)) 'B人力不足'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=13 then BtotalRunTime else 0 end)) 'B烘料'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=14 then BtotalRunTime else 0 end)) 'B试料'

		from Prod_EquipmentStatusCollectionData PES with(nolock)
		group by WorkDate,MachineCode
		UNION 
	   SELECT  CONVERT(VARCHAR(10),WorkDate,120) WorkDate,MachineCode,'白班' ShiftType
		--,[dbo].[fn_GetDateZH] (sum(case when Status=1 then AtotalRunTime else 0 end)) 'A生产'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=2 then AtotalRunTime else 0 end)) 'A换模'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=3 then AtotalRunTime else 0 end)) 'A调试'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=4 then AtotalRunTime else 0 end)) 'A设备故障'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=5 then AtotalRunTime else 0 end)) 'A模具故障'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=6 then AtotalRunTime else 0 end)) 'A计划停机'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=7 then AtotalRunTime else 0 end)) 'A原材料缺料'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=8 then AtotalRunTime else 0 end)) 'A辅材缺料'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=9 then AtotalRunTime else 0 end)) 'A保养'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=10 then AtotalRunTime else 0 end)) 'A待换模'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=11 then AtotalRunTime else 0 end)) 'A试模'
	 --   ,[dbo].[fn_GetDateZH] (sum(case when Status=12 then AtotalRunTime else 0 end)) 'A人力不足'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=13 then AtotalRunTime else 0 end)) 'A烘料'
		--,[dbo].[fn_GetDateZH] (sum(case when Status=14 then AtotalRunTime else 0 end)) 'A试料'

		,[dbo].[fn_GetDateZH] (sum(case when Status=1 then BtotalRunTime else 0 end)) '生产'
		,[dbo].[fn_GetDateZH] (sum(case when Status=2 then BtotalRunTime else 0 end)) '换模'
		,[dbo].[fn_GetDateZH] (sum(case when Status=3 then BtotalRunTime else 0 end)) '调试'
		,[dbo].[fn_GetDateZH] (sum(case when Status=4 then BtotalRunTime else 0 end)) '设备故障'
		,[dbo].[fn_GetDateZH] (sum(case when Status=5 then BtotalRunTime else 0 end)) '模具故障'
		,[dbo].[fn_GetDateZH] (sum(case when Status=6 then BtotalRunTime else 0 end)) '计划停机'
		,[dbo].[fn_GetDateZH] (sum(case when Status=7 then BtotalRunTime else 0 end)) '原材料缺料'
		,[dbo].[fn_GetDateZH] (sum(case when Status=8 then BtotalRunTime else 0 end)) '辅材缺料'
		,[dbo].[fn_GetDateZH] (sum(case when Status=9 then BtotalRunTime else 0 end)) '保养'
		,[dbo].[fn_GetDateZH] (sum(case when Status=10 then BtotalRunTime else 0 end)) '待换模'
		,[dbo].[fn_GetDateZH] (sum(case when Status=11 then BtotalRunTime else 0 end)) '试模'
		,[dbo].[fn_GetDateZH] (sum(case when Status=12 then BtotalRunTime else 0 end)) '人力不足'
		,[dbo].[fn_GetDateZH] (sum(case when Status=13 then BtotalRunTime else 0 end)) '烘料'
		,[dbo].[fn_GetDateZH] (sum(case when Status=14 then BtotalRunTime else 0 end)) '试料'
		,[dbo].[fn_GetDateZH] (sum(case when Status=15 then BtotalRunTime else 0 end)) '模具厂试模'
		from Prod_EquipmentStatusCollectionData PES with(nolock)
		group by WorkDate,MachineCode		
