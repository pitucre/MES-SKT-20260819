using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    public partial class IQCConfirmList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "InspectionId";
            this.Master.DefaultSortExpression = "InspectionId desc"; //也可不赋值


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            string orderNo = txtOrderNo.Value;
            if(orderNo!=null)
            {
                string OrderType = hdOrderType.Value;
                if(OrderType=="")
                {
                    OrderType = "1";
                    hdOrderType.Value = OrderType;
                }
                if(OrderType == "1")
                {
                    searchSettings.AddCondition("送货单", orderNo);
                }
                else if (OrderType == "2")
                {
                    searchSettings.AddCondition("采购单", orderNo);
                }
                else if (OrderType == "3")
                {
                    searchSettings.AddCondition("IQC检验单", orderNo);
                }
                    
                
            }

            if (!String.IsNullOrEmpty(this.txtSOCode.Value.Trim()))
            {
                searchSettings.AddCondition("订单号", this.txtSOCode.Value.Trim());
            }

            searchSettings.AddCondition("供应商代码", txtVendorCode.Value);
            searchSettings.AddCondition("物料编号", ItemCode.Value);


            string statue = hfStatus.Value;
            string TimeStart = txtTimeStart.Text ;
            string TimeEnt = txtTimeEnd.Text;
            if (TimeEnt != "")
            {
                TimeEnt = Convert.ToDateTime(TimeEnt).AddDays(1).ToString();
            }
            if (statue == "")
            {
                statue = "-1";
            }

            string where = " ( -1=" + statue + " or Status=" + statue + ") ";

            if (TimeStart != "" && TimeEnt != "")
            {
                where += " and (  交接时间 BETWEEN '" + TimeStart + "' AND  '" + TimeEnt + "' )  ";
            }
            else if (TimeStart != "")
            {

                where += " and  交接时间 >= '" + TimeStart + "'";
            }
            else if (TimeEnt != "")
            {

                where += " and  交接时间 <= '" + TimeEnt + "'";
            }



  
            string CheckDateStart = txtCheckDateStart.Text;
            string CheckDateEnd = txtCheckDateEnd.Text;
            if (CheckDateEnd != "")
            {
                CheckDateEnd = Convert.ToDateTime(CheckDateEnd).AddDays(1).ToString();
            }
            if (CheckDateStart != "" && CheckDateEnd != "")
            {
                where += " and (  检验日期 BETWEEN '" + CheckDateStart + "' AND  '" + CheckDateEnd + "' )  ";
            }
            else if (CheckDateStart != "")
            {

                where += " and  检验日期 >= '" + CheckDateStart + "'";
            }
            else if (CheckDateEnd != "")
            {

                where += " and  检验日期 <= '" + CheckDateEnd + "'";
            }

            //检验结果
            string inspectionResult = this.selInspectionResult.Value;
            if (inspectionResult != "")
            {
                if (string.Equals(inspectionResult, "1"))
                {
                    //合格
                    searchSettings.AddCondition("InspectionResult", inspectionResult);
                }
                else
                {
                    //不合格
                    where += " AND InspectionResult IN (0,2) ";
                }
            }
            //处理结果
            string iqcResult = this.selIQCResult.Value;
            if (!string.IsNullOrEmpty(iqcResult))
            {
                searchSettings.AddCondition("ManageResult", iqcResult);
            }


            searchSettings.ExtensionCondition = where;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //设定视图、表名
            this.Master.TableOrView = "vwIQCConfirmList";
        }
    }
}