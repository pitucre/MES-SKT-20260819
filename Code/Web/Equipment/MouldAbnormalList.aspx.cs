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
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldAbnormalList : BasePage
    {
        private int columnIndex_Status = -1;
        private int columnIndex_HandlePerson = -1;
        private int columnIndex_MangerPerson = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Status = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Status")) + 1;
            columnIndex_HandlePerson = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "HandlePerson")) + 1;
            columnIndex_MangerPerson = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "MangerPerson")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));

            //后台赋值只读，避免postback时控件值丢失的问题
            txtApplyName.Attributes.Add("Readonly", "True");
            txtHandlePerson.Attributes.Add("Readonly", "True");

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "id";
            this.Master.DefaultSortExpression = " id";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("EquipmentCode", Server.HtmlEncode(this.txtEquipmentCode.Text));
            searchSettings.AddCondition("EquipmentName", Server.HtmlEncode(this.txtEquipmentName.Text));

            //searchSettings.AddCondition("MouldCode", Server.HtmlEncode(this.txtMouldCode.Text));
            searchSettings.AddCondition("BomName", Server.HtmlEncode(this.txtMouldName.Text));
            if (drpStatus.SelectedValue != "-1")
            {
                searchSettings.AddCondition(" Status", drpStatus.SelectedValue);
            }
            searchSettings.AddCondition(" CreateBy", Server.HtmlEncode(this.hdApplyName.Value));
            searchSettings.AddCondition(" HandlePerson", Server.HtmlEncode(this.hdHandlePerson.Value));
            //searchSettings.AddCondition("ResTypeName", Server.HtmlEncode(this.txtResNamtType.Text));
            searchSettings.AddCondition("AnormalTypeName", Server.HtmlEncode(this.txtAnormalType.Text));
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        MoludAbnormal bll = new MoludAbnormal();
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
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_Status
                //10改为columnIndex_HandlePerson
                //11改为columnIndex_MangerPerson
                Int32 cellNum = 0;
                cellNum = Convert.ToInt32(e.Row.Cells[columnIndex_Status].Text);
                switch (cellNum)
                {
                    case 0:
                        e.Row.Cells[columnIndex_Status].Text = "待分配";
                        e.Row.Cells[columnIndex_Status].BackColor = System.Drawing.Color.Yellow;
                        break;
                    case 1:
                        e.Row.Cells[columnIndex_Status].Text = "待处理";
                        e.Row.Cells[columnIndex_Status].BackColor = System.Drawing.Color.Yellow;
                        break;
                    case 2:
                        e.Row.Cells[columnIndex_Status].Text = "待审核";
                        e.Row.Cells[columnIndex_Status].BackColor = System.Drawing.Color.Brown;
                        e.Row.Cells[columnIndex_Status].ForeColor = System.Drawing.Color.White;
                        break;
                    case 3:
                        e.Row.Cells[columnIndex_Status].Text = "已审核";
                        e.Row.Cells[columnIndex_Status].BackColor = System.Drawing.Color.Green;
                        e.Row.Cells[columnIndex_Status].ForeColor = System.Drawing.Color.White;
                        break;
                    default:
                        e.Row.Cells[columnIndex_Status].Text = "";
                        break;
                }

                //获取处理人(可能是多个人)
                string userNames = e.Row.Cells[columnIndex_HandlePerson].Text;
                if (!string.IsNullOrEmpty(userNames))
                {
                    e.Row.Cells[columnIndex_HandlePerson].Text = GetCNameByUserNames(userNames);
                }
                //获取负责人
                userNames = e.Row.Cells[columnIndex_MangerPerson].Text;
                if (!string.IsNullOrEmpty(userNames))
                {

                    e.Row.Cells[columnIndex_MangerPerson].Text = GetCNameByUserNames(userNames);
                }
            }
        }

        /// <summary>
        /// 通过用户名获取中文名
        /// </summary>
        /// <param name="userNames">用户名长串（逗号拼接）</param>
        /// <returns></returns>
        private string GetCNameByUserNames(string userNames)
        {
            string userCNames = string.Empty;

            if (!string.IsNullOrEmpty(userNames))
            {
                SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
                var listUserName = new List<string>();
                var listUserCName = new List<string>();
                listUserName = userNames.Split(new char[] { ',' }).ToList();
                foreach (var item in listUserName)
                {
                    MembershipInfo userInfo = user.GetInfo(item);
                    listUserCName.Add((userInfo == null) ? "" : userInfo.EmployeeCName);
                }
                userCNames = string.Join(",", listUserCName);
            }
            return userCNames;
        }
    }
}