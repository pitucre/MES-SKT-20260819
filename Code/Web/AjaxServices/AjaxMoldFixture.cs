using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMoldFixture
    {

        [AjaxMethod]
        public void UpLine(string strJson)
        {
            try
            {
                var bll = new MoldFixture();
                bll.UpLine(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        [AjaxMethod]
        public void DownLine(string strJson)
        {
            try
            {
                var bll = new MoldFixture();
                bll.DownLine(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void MoldFixtureEdit(string strJson)
        {
            try
            {
                var bll = new MoldFixture();
                bll.MoldFixtureEdit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public string GetUpLineList(int prodOrderId, int lineId)
        {
            try
            {
                var bll = new MoldFixture();
                return  bll.GetUpLineList(prodOrderId, lineId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }

        [AjaxMethod]
        public string GetUpLineListByMoudle(int EquipmentMoudleId)
        {
            try
            {
                var bll = new MoldFixture();
                return bll.GetUpLineListByMoudle(EquipmentMoudleId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }

    }
}