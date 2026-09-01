using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.DictionaryData.Model;
namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxDictionaryData
    {
        [AjaxMethod]
        public void DictionaryDataEdit(DictionaryDataInfo model, List<UnitTransforInfo> UnitTransforslst)
        {
            try
            {
                new SKT.LeanMES.DictionaryData.BLL.DictionaryData().Edit(model);
                SKT.LeanMES.DictionaryData.BLL.UnitTransfor transfor = new LeanMES.DictionaryData.BLL.UnitTransfor();
                if (UnitTransforslst != null)
                {
                    transfor.Delete(model.Value);//先删除换算内容，再新增
                    for (int i = 0; i < UnitTransforslst.Count(); i++)
                    {
                        UnitTransforslst[i].CreateBy = SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName;
                        UnitTransforslst[i].CreateDateTime = DateTime.Now;
                        UnitTransforslst[i].ModifyBy = SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName;
                        UnitTransforslst[i].ModifyDateTime = DateTime.Now;

                        transfor.Edit(UnitTransforslst[i]);
                    }
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public List<UnitTransforInfo> GetTransforByUnitID(int UnitID)
        {
            SKT.LeanMES.DictionaryData.BLL.UnitTransfor transfor = new LeanMES.DictionaryData.BLL.UnitTransfor();
            SKT.Common.Model.SearchSettings setting = new Common.Model.SearchSettings();
            setting.AddCondition("UnitID", UnitID.ToString());
            return transfor.GetAll(0, 10000, "", setting);
        }

        [AjaxMethod]
        public UnitTransforInfo GetUnitTransforByUnitIDAndTransforID(int UnitID, int TransforUnitID)
        {
            SKT.LeanMES.DictionaryData.BLL.UnitTransfor transfor = new LeanMES.DictionaryData.BLL.UnitTransfor();

            return transfor.GetUnitTransforInfo(UnitID, TransforUnitID);
        }

        [AjaxMethod]
        public UnitTransforInfo GetUnitTransforByUnitAndTransfor(string UnitName, string TransforUnitName)
        {
            int UnitID = -1; int TransforUnitID = -1;
            SKT.LeanMES.DictionaryData.BLL.DictionaryData transfor = new LeanMES.DictionaryData.BLL.DictionaryData();
            LeanMES.DictionaryData.Model.DictionaryDataInfo ddi = transfor.GetInfo(UnitName, "Unit");
            if (ddi != null)
            {
                UnitID = ddi.DictionaryDataID;
            }
            LeanMES.DictionaryData.Model.DictionaryDataInfo ddi2 = transfor.GetInfo(TransforUnitName, "Unit");
            if (ddi2 != null)
            {
                TransforUnitID = ddi2.DictionaryDataID;
            }

            if (UnitName == TransforUnitName)
            {
                return new UnitTransforInfo()
                {
                    UnitID = UnitID,
                    TransforUnitID = TransforUnitID,
                    TransforData = 1
                };
            }

            return (new LeanMES.DictionaryData.BLL.UnitTransfor()).GetUnitTransforInfo(UnitID, TransforUnitID);
        }

        [AjaxMethod]
        public Decimal Divider(decimal divider, decimal dividend)
        {
            return divider / dividend;
        }
    }
}