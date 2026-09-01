using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Services;
using AjaxPro;
using SKT.LeanMES.CommonDataSource.Model;
using SKT.LeanMES.CommonDataSource.BLL;
using SKT.LeanMES.Plan.Model;


namespace SKT.LeanMES.Web.Plan
{
    public partial class PreviewConfig : BasePage
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {

            AjaxPro.Utility.RegisterTypeForAjax(typeof(PreviewConfig));
            if (!IsPostBack)
            {
                SKT.LeanMES.Plan.BLL.PreviewConfig bll=new SKT.LeanMES.Plan.BLL.PreviewConfig();
                PreviewConfigInfo result= bll.GetInfo();
                

                this.ddlIsTsPlan.SelectedValue = result.IsLine.ToString();
                this.ddlIsEnable.SelectedValue = result.IsEnable.ToString();
                this.ddlIsCheckLoad.SelectedValue = result.IsCheckLoad.ToString();
                this.txtPlanTime.Text = result.PlanTime;
                this.txtDay.Text = result.PreviewDay.ToString();
                this.txtRemark.Text = result.Remark;

               

                #region 读取web.config
                //Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
                //AppSettingsSection appseting = (AppSettingsSection)config.GetSection("appSettings");
                //string previewConfig = appseting.Settings["PreviewConfig"].Value;

                //if (!string.IsNullOrEmpty(previewConfig))
                //{
                //    this.txtDay.Text = previewConfig.Split(';')[0];
                //    this.ddlIsTsPlan.SelectedValue = previewConfig.Split(';')[1];
                    
                //}
                
                #endregion
            }
           
        }

        /// <summary>
        /// 保存配置到config文件
        /// </summary>
        /// <param name="info"></param>
        [AjaxMethod]
        public void Save(PreviewConfigInfo info)
        {
            try
            {

                SKT.LeanMES.Plan.BLL.PreviewConfig bll = new SKT.LeanMES.Plan.BLL.PreviewConfig();
                bll.Edit(info);
                //string previewConfig = previewDay + ";"+isPlan;
                //Configuration config = System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
                //AppSettingsSection appseting = (AppSettingsSection)config.GetSection("appSettings");
                //appseting.Settings["PreviewConfig"].Value = previewConfig;
                //config.Save(ConfigurationSaveMode.Modified);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }
    }
}