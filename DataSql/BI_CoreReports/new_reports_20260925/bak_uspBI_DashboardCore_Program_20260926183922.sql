 
-
-- bak target=172.16.5.179/PROD_TEST_MES obj=uspBI_DashboardCore_Program ts=20260926183922

CREATE PROCEDURE [dbo].[uspBI_DashboardCore_Program]
(
    @Role       VARCHAR(20) = 'prod',
    @Days       INT = 7,
    @Date       VARCHAR(10) = '',
    @PageSi
