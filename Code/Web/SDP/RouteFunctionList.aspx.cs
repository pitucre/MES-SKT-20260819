using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ClientConfig.BLL;
using SKT.LeanMES.SDP.Model;

namespace SKT.LeanMES.Web.SDP
{
    public partial class RouteFunctionList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "RD_Id";
            this.Master.DefaultSortExpression = "R_Id DESC";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            string routerName = this.hdnRoute.Value.Trim();
            if (!string.IsNullOrEmpty(routerName) && routerName != "-1")
            {
                searchSettings.AddCondition("R_Name", routerName);
            }
            if (!string.IsNullOrEmpty(hdnStation.Value.Trim()) && hdnStation.Value.Trim() != "-1")
            {
                searchSettings.AddCondition("Station", hdnStation.Value.Trim());
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

        //PopedomInStation popedomInStation = new PopedomInStation();

        public List<UIModelInfo> UIModelInfos = null;
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //转换绑定情况
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (UIModelInfos == null)
                {
                    UIModelInfos = GetAllModel();
                }

                var length = e.Row.Cells.Count;
                Label lblModelInfo = e.Row.FindControl("lblModelInfo") as Label;
                SKT.LeanMES.SDP.Model.RouteDetail model = e.Row.DataItem as SKT.LeanMES.SDP.Model.RouteDetail;
                if (model != null && lblModelInfo != null)
                {
                    if (model.ModelId != null && model.ModelId > 0)
                    {
                        UIModelInfo uimodel = UIModelInfos.Where(kk => kk.ModelId.Equals(model.ModelId)).FirstOrDefault();
                        if (model.ModelId < 10000000)
                        {                            
                            if (uimodel != null)
                            {
                                lblModelInfo.Text = uimodel.ModelName + "<font style='color:yellowgreen'>(自定义)";
                            }
                            else
                            {
                                lblModelInfo.Text = "用户自定义模板";
                            }
                            //e.Row.Cells[length - 1].ForeColor = System.Drawing.Color.YellowGreen;
                        }
                        else
                        {
                            if (uimodel != null)
                            {
                                lblModelInfo.Text = uimodel.ModelName + "<font style='color:orange'>(系统)";
                            }
                            else
                            {
                                lblModelInfo.Text = "用户自定义模板";
                            }
                            //e.Row.Cells[length - 1].ForeColor = System.Drawing.Color.Orange;
                        }
                    }
                    else
                    {
                        lblModelInfo.Text = "未绑定模板";
                        e.Row.Cells[length - 1].ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }

        public List<UIModelInfo> GetAllModel()
        {
            SKT.LeanMES.SDP.BLL.UIModel model = new SKT.LeanMES.SDP.BLL.UIModel();
            List<UIModelInfo> tempmodelList = model.GetAll();
            tempmodelList.ForEach(k =>
            {
                k.Content = "自定义UI模型";
            });

            SKT.Common.Framework.BLL.Page bll = new Common.Framework.BLL.Page();
            List<SKT.Common.Framework.Model.PageInfo> models = bll.GetPagesByModule("Product_CollectionTemplate", false);
            try
            {
                foreach (SKT.Common.Framework.Model.PageInfo item in models)
                {
                    UIModelInfo uimodel = new UIModelInfo() { Content = "系统定义UI模型", ModelId = item.Popedom };
                    if (HttpContext.GetGlobalResourceObject("Popedom", item.Name) == null)
                    {
                        uimodel.ModelName = item.Name;
                    }
                    else
                    {
                        uimodel.ModelName = HttpContext.GetGlobalResourceObject("Popedom", item.Name).ToString();
                    }
                    tempmodelList.Insert(0, uimodel);
                }
            }
            catch (Exception ex) { return null; }

            return tempmodelList;
        }

    }
}