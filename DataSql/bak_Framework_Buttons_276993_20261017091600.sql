-- 备份 Framework_Buttons #276993 (Page=CommonDefectiveProductLabel) 修改前状态，用于回滚
-- 库: [172.16.5.179].PROD_TEST_MES
-- 备份时间: 20261017091600
-- 本次修改: Text/Tooltip COM_Save -> COM_SavePrint, Handler Save() -> SavePrint()
-- 修改前: ButtonsID=276993, Text=COM_Save, Tooltip=COM_Save, Handler=Save(), Popedom=0, Flag=0

-- 回滚脚本:
-- UPDATE Framework_Buttons SET Text='COM_Save', Tooltip='COM_Save', Handler='Save()', ModifyBy='dev', ModifyDateTime=GETDATE() WHERE ButtonsID=276993;
