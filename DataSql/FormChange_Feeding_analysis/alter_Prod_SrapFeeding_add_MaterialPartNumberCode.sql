/* Test: 172.16.5.179 PROD_TEST_MES
 * Add header column for selected 03xx raw material (multi-candidate choice).
 * Bak: bak_Prod_SrapFeeding_20260924150219.sql
 */
IF COL_LENGTH('dbo.Prod_SrapFeeding', 'MaterialPartNumberCode') IS NULL
BEGIN
    ALTER TABLE dbo.Prod_SrapFeeding
    ADD MaterialPartNumberCode VARCHAR(50) NULL;
    PRINT 'ADDED Prod_SrapFeeding.MaterialPartNumberCode';
END
ELSE
    PRINT 'ALREADY EXISTS Prod_SrapFeeding.MaterialPartNumberCode';
