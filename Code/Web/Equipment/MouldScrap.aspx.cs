using System;
using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.Equipment
{
public partial class MouldScrap : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldScrap));

        //if (!this.IsPostBack)
        //{
        //    String idString = Request.QueryString["ID"];

        //    if (idString != null && Convert.ToInt32(idString) > 0)
        //    {
        //        this.PageData = (new FaultType()).GetInfo(Convert.ToInt32(idString));
        //    }
        //}
    }

        /// <summary>
        /// 模具报废
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod] 
        public void MouldScrapEn(MouldScrapRecordInfo entity)
        {
            try
            {
                new Equipments().MouldScrap(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
  
  }
}