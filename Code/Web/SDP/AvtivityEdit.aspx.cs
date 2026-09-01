using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Data;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.SDP.Model;
using SKT.LeanMES.Web.AppCode;
using SKT.LeanMES.Lookup.Model;
using SKT.LeanMES.SDP.BLL;

namespace SKT.LeanMES.Web.SDP
{
    public partial class AvtivityEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
            if (!IsPostBack)
            {
                string controlName = Request.QueryString["control"];
                string activity = Request.QueryString["activity"];
                lblControlName.Text = controlName;
                lblActivity.Text = activity;

                string controlType = controlName.Substring(controlName.IndexOf('(') + 1, controlName.Length - controlName.IndexOf('(') - 2);

                SKT.LeanMES.Lookup.BLL.Lookup lookupBll = new SKT.LeanMES.Lookup.BLL.Lookup();
                List<string> removeFunction = new List<string>();
                Dictionary<string, object> condition = new Dictionary<string, object>();
                condition.Add("Alpha1", controlType);
                List<LookupInfo> lookupFunction = lookupBll.GetLookupByCondition(LookupTableName.SYS_ControlSetting, condition);
                if (lookupFunction.Count > 0)
                {
                    if (!string.IsNullOrEmpty(lookupFunction[0].Alpha4))
                    {
                        removeFunction = lookupFunction[0].Alpha4.Split(new char[] { ',' }).ToList();
                    }

                    //绑定控件的方法                
                    List<LookupInfo> lookupInfos = lookupBll.GetLookupByCondition(LookupTableName.SYS_StepFunction);
                    foreach (LookupInfo lookup in lookupInfos)
                    {
                        if (removeFunction.Contains(lookup.Alpha1))
                        {
                            ddlFunction.Items.Add(new ListItem(lookup.Alpha2, lookup.Alpha1));
                        }
                    }

                    DynamicLoadData(ddlFunction.SelectedValue);

                }
            }
        }

        protected void ddlFunction_SelectedIndexChanged(object sender, EventArgs e)
        {
            DynamicLoadData(ddlFunction.SelectedValue);
        }

        private void DynamicLoadData(string handleType)
        {
            //删除原有的用户控件
            for (int i = 0; i < tbUserControl.Controls.Count; i++)
            {
                tbUserControl.Controls.RemoveAt(i);
            }
            hdnControlTypes.Value = "";

            DropDownList ddlDataSource;
            SKT.LeanMES.Lookup.BLL.Lookup lookup = new SKT.LeanMES.Lookup.BLL.Lookup();
            Dictionary<string, object> condition = new Dictionary<string, object>();
            condition.Add("Alpha1", handleType);
            List<LookupInfo> lookupInfos = lookup.GetLookupByCondition(LookupTableName.SYS_StepFunction, condition);
            if (lookupInfos.Count > 0)
            {
                tbUserControl.Controls.Add(base.LoadControl(lookupInfos[0].Alpha3));

                //设置数据源
                if (!string.IsNullOrEmpty(lookupInfos[0].Alpha4) && lookupInfos[0].Alpha4 == SKT.LeanMES.SDP.Model.DataSourceType.Logic.ToString())
                {
                    ddlDataSource = tbUserControl.Controls[0].FindControl("ddlDataSource") as DropDownList;
                    BindSource(ddlDataSource, SKT.LeanMES.SDP.Model.DataSourceType.Logic.ToString());
                }
                else if (!string.IsNullOrEmpty(lookupInfos[0].Alpha4))
                {
                    ddlDataSource = tbUserControl.Controls[0].FindControl("ddlDataSource") as DropDownList;
                    BindSource(ddlDataSource);
                }

                //保存控件的类别
                hdnControlTypes.Value = lookupInfos[0].Alpha5;
            }
            else
            {
                //如果没有设置，则采用公共的用户控件
                tbUserControl.Controls.Add(base.LoadControl("ControlFuntion/CommonControl.ascx"));
                ddlDataSource = tbUserControl.Controls[0].FindControl("ddlDataSource") as DropDownList;
                BindSource(ddlDataSource, SKT.LeanMES.SDP.Model.DataSourceType.Logic.ToString());
            }

        }

        private void BindSource(DropDownList ddlDataSource, string sourceType = null)
        {
            if (string.IsNullOrEmpty(sourceType))
            {
                sourceType = SKT.LeanMES.SDP.Model.DataSourceType.Table.ToString();
            }

            //数据源绑定
            string acid = Request.QueryString["acId"];
            DataTable dtRouteDetail = new Activity().GetRouteDetailByrdId(Convert.ToInt32(acid));
            if (dtRouteDetail.Rows.Count <= 0)
            {
                throw new Exception("{\"result\": \"False\", \"message\": \"路由节点ID不存在，请在数据库查询是否已删除\" }");
            }

            string where = string.Format(" A.StationId='{0}' AND A.RouteId='{1}' AND DataSourceType='{2}'", dtRouteDetail.Rows[0]["StationId"], dtRouteDetail.Rows[0]["R_ID"], sourceType);
            DataTable dt = new SKT.LeanMES.SDP.BLL.RouteDetailDataSource().GetAll(where);
            ddlDataSource.DataSource = dt;
            ddlDataSource.DataTextField = "RouteDetailDataSourceName";
            ddlDataSource.DataValueField = "RouteDetailDataSourceID";
            ddlDataSource.DataBind();

            ddlDataSource.Items.Insert(0, new ListItem("请选择", "-1"));
        }

        
    }
}