using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Quality.BLL;
using System.Configuration;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionFQCList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxInspectionFQC));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "InspectionFQCId";
            this.Master.DefaultSortExpression = "InspectionFQCId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("", "");
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                SKT.LeanMES.Quality.BLL.InspectionFQC bll = new SKT.LeanMES.Quality.BLL.InspectionFQC();
                try
                {
                    if (this.hdnOperate.Value.ToLower() == "delete")
                    {
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    if (this.hdnOperate.Value.ToLower() == "pdffile")
                    {
                        string strXmlPath = CommonMethod.WebRoot + "Content\\XmlFile\\PDF\\" + "InspectionFQC.xml";
                        string strTargePath = ConfigurationManager.AppSettings["FilePath"].ToString() + "Temp\\";
                        string strFileName = bll.GetPdf(Convert.ToInt32(Request.Form["hdnIdString"]), strTargePath, strXmlPath, CommonMethod.WebRoot);
                        //导出文件
                        CommonMethod.exportFile(strFileName, strTargePath);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
                this.hdnOperate.Value = "";
            }
        }

    }
}