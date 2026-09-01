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
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.MSD
{
    public partial class MsdConstantEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MsdConstantEdit));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MsdBakeOut));
            
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
        /// 添加到恒温箱
        /// </summary>
        /// <param name="bakeXml"></param>
        /// /// <param name="containerId"></param>
        [AjaxMethod]
        public void BatchAddThermostat(int containerId, string bakeXml)
        {
            var userName = AccountController.GetCurrentUser().UserName;
            SqlParameter[] parms = new SqlParameter[]{
                            new SqlParameter("@MsdContainerId", SqlDbType.Int,4),
                            new SqlParameter("@BakeXml", SqlDbType.NVarChar),
                            new SqlParameter("@CreateUser",  SqlDbType.NVarChar,30)
                            };

            try
            {
                parms[0].Value = containerId;
                parms[1].Value = bakeXml;
                parms[2].Value = userName;

                SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, "Msd_Proc_ThermostatIn", parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}