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

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentChildList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentChildId";
            this.Master.DefaultSortExpression = "EquipmentChildId";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition += " IsDelete=0  ";
            searchSettings.AddCondition(" EquipmentCode", Server.HtmlEncode(this.txtEquipmentCode.Text));
            searchSettings.AddCondition(" EquipmentName", Server.HtmlEncode(this.txtEquipmentName.Text));
            searchSettings.AddCondition(" EquipmentCodeChild", Server.HtmlEncode(this.txtEquipmentCodeChild.Text));
            searchSettings.AddCondition(" EquipmentNameChild", Server.HtmlEncode(this.txtEquipmentNameChild.Text));

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        EquipmentChild bll = new EquipmentChild();
                        bll.DeleteByID(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                    }
                }

                if (Request.Form["hdnOperate"].ToLower() == "scrap")
                {
                    try
                    {
                        SKT.LeanMES.SteelMesh.BLL.SteelMesh bll = new SKT.LeanMES.SteelMesh.BLL.SteelMesh();
                        bll.Scrap(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.ScrapSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }


        }

        /// <summary>
        /// 绑定数据
        /// </summary>
        /// <returns></returns>
        public System.Data.DataTable BindData(String code, String name, int status)
        {
            System.Data.DataTable tb = new System.Data.DataTable();
            SKT.LeanMES.Equipment.BLL.Equipments bll = new SKT.LeanMES.Equipment.BLL.Equipments();
            tb = bll.ImportToExcel(code, name, status);

            if (tb != null)
            {
                return tb;
            }
            else
            {
                return null;
            }
        }
    }
}