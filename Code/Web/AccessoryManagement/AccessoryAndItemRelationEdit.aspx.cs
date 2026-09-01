using SKT.LeanMES.Product.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.AccessoryManagement.BLL;
using SKT.LeanMES.AccessoryManagement.Model;

namespace SKT.LeanMES.Web.AccessoryManagement
{
    public partial class AccessoryAndItemRelationEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessoryItemRelation));
            var bomBLL = new SKT.LeanMES.AccessoryManagement.BLL.AccessoryItemRelation();
            int bomId = -1;
            string idStr = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
            string itemcode = Request.QueryString["itemcode"];
            string desc = Request.QueryString["desc"];
            int.TryParse(idStr, out bomId);
            if (Convert.ToInt32(this.hdnBomId.Value) != -1)
            {
                //新增组件时 特殊处理
                bomId = Convert.ToInt32(this.hdnBomId.Value);
            }

            if (bomId != -1)
            {
                this.txtItemCode.Text = itemcode;
                this.txtMachine.Text = desc;
                //复制产品BOM信息
                //if (IsCopy != "")
                //{
                //    if (this.hdnBomId.Value == "-1")
                //    {
                //        bomId = bomBLL.ItemBomCopy(bomId);
                //    }
                //}

                var entity = bomBLL.GetInfo(bomId);
                if (entity != null)
                {
                    this.txtItemCode.Text = entity.ItemCode;
                    this.txtMachine.Text = entity.MachineTypeId;
                }
            }

            this.hdnBomId.Value = bomId.ToString();
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "Id";
            //this.Master.DefaultSortExpression = "ItemLevel";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " Pid = " + this.hdnBomId.Value.ToString();
            this.Master.SearchSettings = searchSettings;

            if (this.IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        AccessoryItemRelationDtl bll = new AccessoryItemRelationDtl();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }
            }
        }
    }
}