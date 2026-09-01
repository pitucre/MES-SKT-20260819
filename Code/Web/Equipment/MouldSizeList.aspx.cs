using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;
using System.Data;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldSizeList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MsmId";
            this.Master.DefaultSortExpression = "MsmId";
            this.Master.DefaultSortDirection = SortDirection.Ascending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (txtMouldeCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("MouldeCode", "%" + this.txtMouldeCode.Text.Trim());
            }
            if (txtBomName.Text.Trim() != "")
            {
                searchSettings.AddCondition("BomName", "%" + this.txtBomName.Text.Trim());
            }
            if(txtComponentName.Text.Trim() != "")
            {
                searchSettings.AddCondition("ComponentName", "%" + this.txtComponentName.Text.Trim());
            }
                        
            string testItemVal = ddlTestItem.SelectedValue;
            string extensionCondition = "";
            if (testItemVal != "-1")
            {
                string minAvg = txtTestItemAvgMin.Text;
                string maxAvg = txtTestItemAvgMax.Text;

                if (minAvg != "" || maxAvg != "")
                {                
                     
                    if (testItemVal == "1")//测试项目1
                    {
                        if (minAvg != "" && maxAvg != "")
                        {
                            extensionCondition = "ExternalDiameterAvg BETWEEN " + minAvg + " AND " + maxAvg;
                        }
                        else if (minAvg != "" && maxAvg == "")
                        {
                            extensionCondition = "ExternalDiameterAvg >= " + minAvg;
                        }
                        else
                        {
                            extensionCondition = "ExternalDiameterAvg <= " + maxAvg;
                        }
                       
                       
                    }
                    else if (testItemVal == "2")//测试项目2
                    {
                        if (minAvg != "" && maxAvg != "")
                        {
                            extensionCondition = "InternalDiameterAvg BETWEEN " + minAvg + " AND " + maxAvg;
                        }
                        else if (minAvg != "" && maxAvg == "")
                        {
                            extensionCondition = "InternalDiameterAvg >= " + minAvg;
                        }
                        else
                        {
                            extensionCondition = "InternalDiameterAvg <= " + maxAvg;
                        }
                    }
                    else if (testItemVal == "3")//测试项目3
                    {
                        if (minAvg != "" && maxAvg != "")
                        {
                            extensionCondition = "TestItem3Avg BETWEEN " + minAvg + " AND " + maxAvg;
                        }
                        else if (minAvg != "" && maxAvg == "")
                        {
                            extensionCondition = "TestItem3Avg >= " + minAvg;
                        }
                        else
                        {
                            extensionCondition = "TestItem3Avg <= " + maxAvg;
                        }                        
                    }
                    searchSettings.ExtensionCondition = extensionCondition;
                    extensionCondition = "";
                }

            }

            var useCountMin = txtUseCountMin.Text.Trim();
            var useCountMax = txtUseCountMax.Text.Trim();

            if (useCountMin != "" || useCountMax != "")
            {
                if (useCountMin != "" && useCountMax != "")
                {
                    extensionCondition = "UseCount BETWEEN " + useCountMin + " AND " + useCountMax;
                }
                else if (useCountMin != "" && useCountMax == "")
                {
                    extensionCondition = "UseCount >= " + useCountMin;
                }
                else
                {
                    extensionCondition = "UseCount <= " + useCountMax;
                }

                searchSettings.ExtensionCondition = searchSettings.ExtensionCondition == "" ? extensionCondition : " AND " + extensionCondition;
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        MoludSizeManger bll = new MoludSizeManger();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }


            }


        }

        public string Judge(string rlt)
        {
            string result = "";

            switch (rlt)
            {
                case "1":
                    result = "合格";
                    break;
                case "2":
                    result = "不合格";
                    break;
                default:
                    result = "";
                    break;
            }
            return result;
        }


        //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        e.Row.Cells[12].Text = Convert.ToInt32(Convert.ToDecimal(e.Row.Cells[12].Text)).ToString();
        //        e.Row.Cells[9].Text = Convert.ToBoolean(e.Row.Cells[9].Text) ? "已停线" : "未停线";

        //        var anormalObject = this.GridView1.DataKeys[e.Row.RowIndex].Values["AnormalObject"].ToString();

        //        List<AnormalObject> list = JsonConvert.DeserializeObject<List<AnormalObject>>("[" + anormalObject + "]");

        //        e.Row.Cells[2].Text = list[0].anormalname;

        //    }
        //}
        //protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        //{

        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        Int32 cellNum = 0;
        //        cellNum = Convert.ToInt32(e.Row.Cells[6].Text);
        //        switch (cellNum)
        //        {
        //            case 0:
        //                e.Row.Cells[6].Text = "待处理";
        //                e.Row.Cells[6].BackColor = System.Drawing.Color.Yellow;
        //                break;
        //            case 1:
        //                e.Row.Cells[6].Text = "待审核";
        //                e.Row.Cells[6].BackColor = System.Drawing.Color.Brown;
        //                e.Row.Cells[6].ForeColor = System.Drawing.Color.White;
        //                break;
        //            case 2:
        //                e.Row.Cells[6].Text = "已审核";
        //                e.Row.Cells[6].BackColor = System.Drawing.Color.Green;
        //                e.Row.Cells[6].ForeColor = System.Drawing.Color.White;
        //                break;
        //            default:
        //                e.Row.Cells[6].Text = "";
        //                break;
        //        }



        //    }

        //}
    }
}