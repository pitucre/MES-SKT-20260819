using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.SerialNumber.BLL;

namespace SKT.LeanMES.Web.Product
{
    public partial class ShopOrderPrintRecordView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String idString = Request.QueryString["ID"];
            PrintRecordInfo printRecordInfo = (new PrintRecord()).GetInfo(Convert.ToInt32(idString));

            string actionTypeStr = "";
            int actionType =Convert.ToInt32(printRecordInfo.ActionType);
            switch (actionType)
            {
                case 1:
                    actionTypeStr = "正常打印";
                    break;
                case 2:
                    actionTypeStr = "重打";
                    break;
                default:
                    actionTypeStr = "";
                    break;
            }

            string printTypeStr = "";
            /*switch (printRecordInfo.PrintType)
            {
                case -2:
                    printTypeStr = "工单条码";
                    break;
                case -3:
                    printTypeStr = "物料条码";
                    break;
                case -4:
                    printTypeStr = "包装条码";
                    break;
                case -5:
                    printTypeStr = "栈板条码";
                    break;
                case -16:
                    printTypeStr = "客户条码";//zhiman.yuan 2017-8-7 增加客户条码类型显示
                    break;
                default:
                    printTypeStr = "";
                    break;
            }*/

            this.lblActionType.Text = actionTypeStr;
            this.lblPrintType.Text = printRecordInfo.SerialNumberType;
            this.lblPrintKey.Text = printRecordInfo.PrintKey;
            this.lblStation.Text = printRecordInfo.Station;
            this.lblResource.Text = printRecordInfo.Resource;
            this.lblPrintUser.Text = printRecordInfo.PrintUser;
            this.lblPrintTime.Text = SKT.Common.Utility.TypeHelper.ToShortDateString(printRecordInfo.PrintTime);
        }
    }
}