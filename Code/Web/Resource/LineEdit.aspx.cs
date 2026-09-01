using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.Controls;


namespace SKT.LeanMES.Web.Resource
{
    public partial class LineEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceResource));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipmentLineRelation));

            if (!IsPostBack)
            {
                string lineIdStr = Request.QueryString["ID"];
                int lineId = Convert.ToInt32(lineIdStr);
                BindResouceByLineId(1, lineId);
                if (Request.QueryString["Action"] == "Copy")
                {
                    BindResouceByLineId(2, -1);
                }
                else
                {
                    BindResouceByLineId(2, lineId);
                }

                if (lineId > -1)
                {
                    SKT.LeanMES.Resource.Model.LineInfo model = new LeanMES.Resource.BLL.Line().GetInfo(lineId);
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }

        protected void BindResouceByLineId(int flage, int lineId)
        {
            List<SKT.LeanMES.Resource.Model.ResourceInfo> resource = new SKT.LeanMES.Resource.BLL.Resource().GetResourceByLineId(flage, lineId);
            if (flage == 1)
            {
                BindListBox(resource, this.lbAvilableResource, "ResName", "ResourceId");
            }
            else if (flage == 2)
            {
                if (lineId != -1)
                {
                    BindListBox(resource, lbAssignResource, "ResName", "ResourceId");
                }
            }
        }
        protected void BindListBox(Object obj, ListBox listBox, string textField, string valueField)
        {
            listBox.DataSource = obj;
            listBox.DataTextField = textField;
            listBox.DataValueField = valueField;
            listBox.DataBind();
        }

        protected SKT.LeanMES.Resource.Model.LineInfo PageData
        {
            set
            {
                if (Request.QueryString["Action"] == "Copy")
                {
                    this.txtLineName.Text = Resources.Buttons.COM_Copy + " - " + value.LineName;
                }
                else
                {
                    this.txtLineName.Text = value.LineName;
                }
                this.txtLineCode.Text = value.LineCode;
                this.txtEquipmentLineType.Text = value.LineMachineRelation;
                this.txtEquipmentLineType.Enabled = false;
                this.txtDescription.Text = value.LineDescription;
                this.txtWorkShopName.Text = value.WorkShopName;
                this.txtWorkShopName.Enabled = false;
                this.hdnWorkShopName.Value = value.WorkShopId.ToString();

            }
        }
    }
}