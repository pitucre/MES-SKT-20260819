using AjaxPro;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.ProductionCollection.Client;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices.Client
{
	public class AjaxFromChangeByMES
	{

        [AjaxMethod]
        public string GetFromChangeNo(string value)
        {
            try
            {
                return new FormChangeByMES().GetFromChangeNo(value);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public string GetFromChangeByNo(string FromChangeByMESNo)
        {
            try
            {
                return new FormChangeByMES().GetFromChangeByNo(FromChangeByMESNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public void FromChangeByMESDeleteBarCode(int FromChangeByMESDtId)
        {
            try
            {
                new FormChangeByMES().FromChangeByMESDeleteBarCode(FromChangeByMESDtId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public string FromChangeMesScanGenerate(string FromChangeByMESNo, string BarCode, string ConvertedMaterial, decimal ConvertedQty, int Flag)
        {
            try
            {
                return new FormChangeByMES().FromChangeMesScanGenerate(FromChangeByMESNo,BarCode, ConvertedMaterial, ConvertedQty, Flag, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 形态转换-扫描生成/确认（带界面模式 UiMode，供三个对比页面分别调用）
        /// UiMode：0=生产原版（不解析06候选、无06校验）
        ///         1=不良/料把（所有条码都解析06候选，=2026-09-26 行为）
        ///         2=综合（按条码 Remark='粉碎机上料生成' 自动分叉）
        /// </summary>
        [AjaxMethod]
        public string FromChangeMesScanGenerateEx(string FromChangeByMESNo, string BarCode, string ConvertedMaterial, decimal ConvertedQty, int Flag, int UiMode)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                        new SqlParameter("@FromChangeByMESNo", SqlDbType.VarChar) { Value=FromChangeByMESNo},
                        new SqlParameter("@BarCode", SqlDbType.VarChar) { Value=BarCode},
                        new SqlParameter("@ConvertedMaterial", SqlDbType.VarChar) { Value=ConvertedMaterial},
                        new SqlParameter("@ConvertedQty", SqlDbType.Decimal) { Value=ConvertedQty},
                        new SqlParameter("@Flag", SqlDbType.Int) { Value=Flag},
                        new SqlParameter("@CreateBy", SqlDbType.VarChar) { Value=AccountController.GetCurrentUser().UserName},
                        new SqlParameter("@UiMode", SqlDbType.TinyInt) { Value=UiMode}
                };
                return ComMethod.GetList("uspFromChangeMesScan", parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public string GetItemCode(string value)
        {
            try
            {
                return new FormChangeByMES().GetItem(value);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public string GetMaterialCandidates(string BarCode, string Prefix)
        {
            try
            {
                return new FormChangeByMES().GetMaterialCandidates(BarCode, Prefix);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public string SaveFormChangeMES(string strJson)
        {
            try
            {
                List<string> list = new FormChangeByMES().SaveFormChangeCheck(strJson);
                return string.Join(",", list);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }
    }
}