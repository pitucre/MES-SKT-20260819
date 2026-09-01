using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.Material
{
	public partial class MaterialdoApplyView : BasePage
	{
        protected void Page_Load(object sender, EventArgs e)
		{
            Apply bll = new Apply();
			string ApplyId = Request.QueryString["id"].ToString();
			if(ApplyId !="" && ApplyId != "-1")
			{
				this.PageInfo = bll.GetInfo2(Convert.ToInt32(ApplyId));
			}

			ApplyDtl bll2 = new ApplyDtl();
			Common.Model.SearchSettings search = new Common.Model.SearchSettings();
			search.AddCondition("ApplyId", ApplyId);
			GridView1.DataSource = bll2.GetAll(0, -1, "", search);
			GridView1.DataBind();

			AjaxServices.AjaxMaterialApply kk = new AjaxServices.AjaxMaterialApply();
			GridView2.DataSource = kk.GetMaterialPrepareGRN(Convert.ToInt32(ApplyId));
			GridView2.DataBind();
		}

		public ApplyInfo PageInfo
		{
			set
			{
				lblApplyNO.Text = value.ApplyNo;
				lblApplyType.Text = value.ApplyType == 1 ? "工单领料" : (value.ApplyType == 2 ? "手工增加" : "其它领料");
				lblDepartName.Text = value.DepName;
				if (value.Statue == 0)
				{
					lblStatusName.Text = "待备料";
				}
				else if (value.Statue ==1)
				{
					lblStatusName.Text = "已备料";
				}
				else if (value.Statue ==2)
				{
					lblStatusName.Text = "已接收";
				}
				else if (value.Statue ==3)
				{
					lblStatusName.Text = "已退料";
				}
				else if (value.Statue ==4)
				{
					lblStatusName.Text = "备料中";
				}
				else if (value.Statue ==-1)
				{
					lblStatusName.Text = "已删除";
				}
				lblUseDate.Text = value.UseDateTime.ToString("yyyy-MM-dd");
				lblWareHouse.Text = value.WhName;
			}
		}

		protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			if (e.Row.RowType == DataControlRowType.DataRow)
			{
                //xiang.yan 2024-4-23 cells取值改为根据列名获取 页面列表字段逻辑对不上，菜单栏里无此页面，暂不更改
                e.Row.Cells[2].Text = (Convert.ToDecimal(e.Row.Cells[3].Text) - Convert.ToDecimal(e.Row.Cells[4].Text)).ToString();
				if (Convert.ToDecimal(e.Row.Cells[2].Text) != 0)
				{
					e.Row.Cells[2].ForeColor = System.Drawing.Color.Red;
				}
			}
		}

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[10].Text.Contains("9999-12-31"))
                    e.Row.Cells[10].Text = "";
            }
        }
    }
}