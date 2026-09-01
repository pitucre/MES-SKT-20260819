using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldBomEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldBomEdit));
            Int32 bomId = Convert.ToInt32(Request.QueryString["ID"]);//从主页面中传递过来的Shift ID
            if (bomId > 0)
            {
                var entity = (new MoludBom()).GetInfo(bomId);
                if (entity != null)
                {
                    this.DataPage = entity;
                }
            }
        }

        [AjaxMethod]
        public int EditBom(MoludBomInfo entity, string dtlJson)
        {
            int bomId = -1;
            try
            {
                MoludBom bll = new MoludBom();
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                bomId = bll.Edit(entity, dtlJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return bomId;
        }

        [AjaxMethod]
        public List<MoludBomChildInfo> GetMouldBomChildInfo(int Id)
        {
            List<MoludBomChildInfo> list = null;
            try
            {
                MoludBom bll = new MoludBom();
                list = bll.GetMouldBomChildInfo(Id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 编辑状态下获得对应CertID的数据
        /// </summary>
        protected MoludBomInfo DataPage
        {
            set
            {
                this.txtBomName.Text = value.BomName;
                this.txtInternalDiameter.Text = value.InternalDiameter.ToString();
                this.txtExternalDiameter.Text = value.ExternalDiameter.ToString();
                this.txtAcreage.Text = value.Acreage.ToString("F3");
                this.txtMaxPressure.Text = value.MaxPressure.ToString();
                this.txtDescribe.Text = value.Describe;
                this.hdnMouldBomId.Value = value.MouldBomId.ToString();
            }
        }
    }
}