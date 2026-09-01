using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldBomComponentEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldBomComponentEdit));
            int compId = Convert.ToInt32(Request.QueryString["ID"]);            
            if (compId > 0)
            { 
                var entity = (new MoludBom()).GetBomChildInfo(compId);
                if (entity != null)
                {
                    this.PageData = entity;
                }
            }
        }

        [AjaxMethod]
        public int EditBomChild(MoludBomChildInfo entity)
        {
            int bomId = -1;
            try
            {
                MoludBom bll = new MoludBom();
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                bomId = bll.EditBomChild(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return bomId;
        }

        private MoludBomChildInfo PageData
        {
            set
            {
                this.txtMouldTypeName.Text = value.EquipmentTypeName;
               // this.txtComponentCode.Text = value.ComponentCode;
                this.txtReplaceComponent.Text = value.ReplaceComponentName;
                this.hdnMouldTypeId.Value = value.MouldTypeId.ToString();
                this.txtDescribe.Text = value.Describe;               
               
            }
        }
    }
}