using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.MSD.Model;

namespace SKT.LeanMES.Web.MSD
{
    public partial class MsdConstantOut : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MsdBakeOut));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MsdConstantOut));
            if (!this.IsPostBack)
            {
   
            }
        }

        [AjaxMethod]
        public MsdEncapInfo GetInfo(string serialNumber)
        {
            try
            {
                return new SKT.LeanMES.MSD.BLL.MsdEncapsulation().GetEncapInfo(serialNumber);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);

            }
            return null;
        }
        


        /// <summary>
        /// 增加烘烤信息
        /// </summary>
        /// <param name="bakeXml"></param>
        [AjaxMethod]
        public void BatchOutThermostat(string bakeXml)
        {
            var userName = AccountController.GetCurrentUser().UserName;
            SqlParameter[] parms = new SqlParameter[]{
                            new SqlParameter("@BakeXml", SqlDbType.NVarChar),
                            new SqlParameter("@CreateUser",  SqlDbType.NVarChar,30)
                            };

            try
            {
               
                parms[0].Value = bakeXml;
                parms[1].Value = userName;

                SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, "Msd_Proc_ThermostatOut", parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}