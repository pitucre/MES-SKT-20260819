using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SKT.LeanMES.Labels.BLL;

namespace SKT.LeanMES.Web.Labels
{
    public partial class LabelAddDBField : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindModuleName();
                string tbName = this.ddlModuleName.SelectedValue.ToString();
                BindFieldName(tbName);
                 
            }
        }
        protected void ddlModuleName_SelectedIndexChanged(object sender, EventArgs e)
        {
            string tbName = this.ddlModuleName.SelectedValue.ToString();
            BindFieldName(tbName);
             
        }

        protected void BindFieldName(string tname)
        {
            SKT.LeanMES.Labels.BLL.LabelField lb = new LeanMES.Labels.BLL.LabelField();
            DataTable dt = lb.GetDBField(tname);
            this.ddlFieldName.Items.Clear();
            if (dt.Rows.Count > 0)
            {
                string[] arr = dt.Rows[0][0].ToString().Split(',');

                for (int i = 0; i < arr.Length; i++)
                {
                    this.ddlFieldName.Items.Add(new ListItem(arr[i].ToString(), arr[i].ToString()));
                }
            }else
                {
                    ddlFieldName.Items.Add(new ListItem("---字段---", ""));
                }

        }

        protected void BindModuleName()
        {
             LabelField bll = new  LabelField();
             DataTable dt = bll.GetDBTables();
             this.ddlModuleName.Items.Clear();
             this.ddlModuleName.DataSource = dt;
             this.ddlModuleName.DataValueField = "DBTableNameMaping";
             this.ddlModuleName.DataTextField = "DBTableNameMaping";
             this.ddlModuleName.DataBind();

             if(ddlModuleName.Items.Count == 0)
             {
                 ddlModuleName.Items.Add(new ListItem("---模块---", ""));
             }
        }

    }
}