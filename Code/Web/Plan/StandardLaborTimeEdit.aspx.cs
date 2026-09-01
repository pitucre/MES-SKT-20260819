using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Plan.BLL;
using SKT.LeanMES.Plan.Model;

namespace SKT.LeanMES.Web.Plan
{
    public partial class StandardLaborTimeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStandardLaborTime));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxProduct));
            BindTableName();
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new StandardLaborTime()).GetInfo(Convert.ToInt32(idString));
                }
            }
            
           
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private StandardLaborTimeInfo PageData
        {
            set
            {
                this.txtEquipmentLineName.Text = value.EquipmentLineName;
                this.hdnEquipmentLineId.Value = Convert.ToString(value.EquipmentLineId);
                this.hdnItemId.Value = Convert.ToString(value.ItemId);
                this.txtItemName.Text = value.ItemCode;
                this.ddlTableName.SelectedValue = value.TableName;
                this.txtStandardLaborTime.Text = Convert.ToString(value.StandardLaborTime);
                this.txtStandardCapacity.Text = Convert.ToString(value.StandardCapacity);
                this.txtRemark.Text = value.Remark;
                this.lblPanelQty.Text = value.PanelQty.ToString();
                this.txtBottleneckHours.Text = value.BottleneckHours.ToString();
                if (value.LaborTimeType == 1)
                {
                    radSMT.Checked = true;                   
                }
                else
                {
                    radNoSMT.Checked = true;                   
                }
                radSMT.Enabled = false;
                radNoSMT.Enabled = false;
            }
        }

        /// <summary>
        /// 绑定面别
        /// </summary>
        protected void BindTableName()
        {
            var list = new SKT.LeanMES.SMT.BLL.LoadingListTable().GetAll(0, -1, "", new Common.Model.SearchSettings());
            ddlTableName.DataSource = list;
            ddlTableName.DataTextField = "TableDesc";
            ddlTableName.DataValueField = "TableName";
            ddlTableName.DataBind();
            ddlTableName.Items.Insert(0, new ListItem("", Resources.lang.Choose));
        }
    }
}