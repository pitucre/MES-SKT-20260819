using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;


namespace SKT.LeanMES.Web.Kanban
{
    public partial class KanbanContainerEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));
            string path = Server.MapPath("../Content/Kanban/LayoutIcron/");
            hfIcronsName.Value = new PubItems.BLL.PubItems().GetFilesNameByPath(path);

            //初始页面信息
            if (!IsPostBack)
            {
                int containerId = Convert.ToInt32(Request.QueryString["ID"]);

                if (containerId != -1)
                {
                    SKT.LeanMES.Kanban.Model.MasterInfo model = new LeanMES.Kanban.BLL.Master().GetContInfo(containerId);
                    if (model != null)
                    {
                        hfContTypeID.Value = model.ContainerTypeId.ToString();
                        hfEditOptinJS.Value = model.EditOption;
                        txtContType.Text = model.LayoutType;
                        txtContName.Text = model.ContainerName;
                        txtRemark.Text = model.Remark;

                        selTypeL.SelectedIndex = model.TitleLType + 1;
                        selTypeM.SelectedIndex = model.TitleMType + 1;
                        selTypeR.SelectedIndex = model.TitleRType + 1;
                        txtTitleLeft.Value = model.TitleLValue;
                        txtTitleRight.Value = model.TitleRValue;
                        txtTitleMid.Value = model.TitleMValue;
                        txtTitleLAttr.Value = model.TitleLCss;
                        txtTitleMAttr.Value = model.TitleMCss;
                        txtTitleRAttr.Value = model.TitleRCss;
                    }

                }
            }
        }
    }
}