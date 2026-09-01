using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Quality.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionLotMemberList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "InspectionLotMemberId";
            this.Master.DefaultSortExpression = "InspectionLotMemberId";
            string idStr = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "InspectionLotId = " + idStr;
            this.Master.SearchSettings = searchSettings;

            if (idStr != "-1")
            {
                var list = new InspectionLot().GetAll(0, -1, "", searchSettings);
                if (list != null && list.Count > 0)
                {
                    lblLotNo.InnerText = list[0].InspectionLotNo;
                    lblState.InnerText = list[0].State;
                    lblLotQty.InnerText = list[0].LotQty.ToString();
                    lblItemCode.InnerText = list[0].ItemCode;
                    lblResult.InnerText = list[0].Result;
                    lblCheckDateTime.InnerText = list[0].CreateDateTime.ToString("yyyy-MM-dd HH:mm:ss");
                }
            }
        }
    }
}