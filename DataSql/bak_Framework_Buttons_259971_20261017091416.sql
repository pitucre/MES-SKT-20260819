-- 备份 Framework_Buttons #259971 (Page=CommonDefectiveProductLabel), 备份时间: 20261017091416
-- 本次修改: Text/Tooltip COM_Save -> COM_SavePrint, Handler Save() -> SavePrint()
-- 回滚脚本:
UPDATE Framework_Buttons SET Text='COM_Save', Tooltip='COM_Save', Handler='Save()', ModifyBy='dev', ModifyDateTime=GETDATE() WHERE ButtonsID=259971;
