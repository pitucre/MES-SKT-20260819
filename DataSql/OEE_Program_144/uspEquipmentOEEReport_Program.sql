USE [LeanMes];
GO
IF OBJECT_ID('dbo.uspEquipmentOEEReport_Program', 'P') IS NOT NULL DROP PROCEDURE [dbo].[uspEquipmentOEEReport_Program];
GO
CREATE PROCEDURE [dbo].[uspEquipmentOEEReport_Program] (
    @ExtFieldValue varchar(100),
    @EquipmentCode varchar(100),
    @WorkStartDate VARCHAR(20),
    @WorkEndDate VARCHAR(20),
    @Status varchar(100),
    @PageSize INT = -1,
    @PageIndex INT = -1,
    @TotalCount INT = -1 OUTPUT
) AS
/*  M03 设备OEE报表(新逻辑) 取数存储过程 —— 仅新增对象，不改动 uspEquipmentOEEReport。
    相对原 SP 的差异：
    1) 读取新视图 vwEquipmentOEE_Program(ΔShot 判产)。
    2) 修复日期过滤括号缺失问题：
         原: ... AND WorkDate>=s AND WorkDate<=e OR WorkDate='1900-01-01'
             (OR 未加括号，导致 1900-01-01 行绕过设备/状态过滤)
         新: ... AND ((WorkDate>=s AND WorkDate<=e) OR WorkDate='1900-01-01')
    3) 日期参数只取前 10 位(避免 "2026-09-20 10:00" 把当天行排除在外)。
    4) 状态=非生产中 时按 Status<>'生产中' 过滤(使页面下拉可选)。 */
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN
    DECLARE @Where NVARCHAR(2000) = ' 1 = 1 '
    DECLARE @TableOrViewName VARCHAR(4000)
    DECLARE @Fields VARCHAR(4000)
    DECLARE @EquipmentCodeBy VARCHAR(100) = 'WorkDate asc,EquipmentCode asc'
    DECLARE @SD VARCHAR(10) = LEFT(LTRIM(RTRIM(ISNULL(@WorkStartDate, ''))), 10)
    DECLARE @ED VARCHAR(10) = LEFT(LTRIM(RTRIM(ISNULL(@WorkEndDate, ''))), 10)

    IF ISNULL(@ExtFieldValue, '') <> ''
        SET @Where += ' and ExtFieldValue LIKE ''' + @ExtFieldValue + '%''';
    IF ISNULL(@EquipmentCode, '') <> ''
        SET @Where += ' and EquipmentCode LIKE ''' + @EquipmentCode + '%''';
    IF ISNULL(@Status, '') <> ''
    BEGIN
        IF @Status = '非生产中'
            SET @Where += ' and Status <> ''生产中''';
        ELSE
            SET @Where += ' and Status = ''' + @Status + '''';
    END

    IF @SD <> '' AND @ED <> ''
        SET @Where += ' AND ((WorkDate >= ''' + @SD + ''' AND WorkDate <= ''' + @ED + ''') OR WorkDate = ''1900-01-01'') ';
    ELSE IF @SD <> ''
        SET @Where += ' AND ((WorkDate >= ''' + @SD + ''') OR WorkDate = ''1900-01-01'') ';
    ELSE IF @ED <> ''
        SET @Where += ' AND ((WorkDate <= ''' + @ED + ''') OR WorkDate = ''1900-01-01'') ';
    ELSE
        SET @Where += ' AND WorkDate = ''' + CONVERT(VARCHAR(10), GETDATE(), 120) + '''';

    IF @PageSize = -1
    BEGIN
        SET @Fields = 'Case when WorkDate=''1900-01-01'' then ''' + ISNULL(@SD, '') + ''' else WorkDate end ''日期'',
            EquipmentCode ''设备编码'',
            ExtFieldValue ''机器编码'',
            OpenQty ''开合模次数'',
            tQty ''实际产品数'',
            OkQty ''良品数'',
            NgQty ''不良数'',
            Status ''状态'',
            CurrentStatusdManger ''管理状态'',
            TotalRuntime ''生产总时长'',
            TotalStopTime ''在线未生产时长'',
            TotalWaitTime ''离线总时长'',
            TimeRate ''设备生产稼动率'',
            OEE ''综合稼动率OEE'''
        SET @TableOrViewName = 'vwEquipmentOEE_Program'
    END
    ELSE
    BEGIN
        SET @Fields = 'Case when WorkDate=''1900-01-01'' then ''' + ISNULL(@SD, '') + ''' else WorkDate end ''日期'',
            ''<a href="javascript:void(0)" onclick="showPage(''''''+ExtFieldValue+'''''',''''''+CAST(WorkDate AS NVARCHAR(50))+'''''',1)" >''+EquipmentCode+''</a>'' ''设备编码'',
            ExtFieldValue ''外部编码'',
            OkQty ''良品数'',
            NgQty ''不良数'',
            Status ''状态'',
            TotalRuntime ''正常生产总时长'',
            TotalStopTime ''在线未生产时长'',
            TotalWaitTime ''停机总时长'',
            '' <a href="javascript:void(0)" onclick="showPage(''''''+EquipmentCode+'''''',''''''+CAST(WorkDate AS NVARCHAR(50))+'''''',0)" >''+CurrentStatusdManger+''</a>'' ''管理状态'',
            TimeRate ''设备生产稼动率'',
            OEE ''综合稼动率OEE'',
            tQty ''开合模数'',
            OpenQty ''开合数'''
        SET @TableOrViewName = 'vwEquipmentOEE_Program'
    END

    EXEC @TotalCount = dbo.uspCommonPage
        @TableOrViewName, '', @Fields, @Where, @EquipmentCodeBy, @PageIndex, @PageSize, 2
END
GO
