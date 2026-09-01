using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionTemplateEditValue : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxDictionaryData));

            hdnValue.Value = Request.QueryString["value"] == null ? "" : Request.QueryString["value"].ToString();

            SKT.LeanMES.DictionaryData.BLL.DictionaryData dd = new LeanMES.DictionaryData.BLL.DictionaryData();
            if (Request.QueryString["UnitName"] != null)
            {
                txtUnit1.Text = Request.QueryString["UnitName"].ToString();
                LeanMES.DictionaryData.Model.DictionaryDataInfo ddi = dd.GetInfo(txtUnit1.Text);
                if (ddi != null)
                {
                    hdnUnit1.Value = ddi.DictionaryDataID.ToString();
                }
            }

            if (Request.QueryString["OffsetUnitName"] != null&& Request.QueryString["OffsetUnitName"] != "undefined")
            {
                txtUnit2.Text =Request.QueryString["OffsetUnitName"].ToString();
                LeanMES.DictionaryData.Model.DictionaryDataInfo ddi2 = dd.GetInfo(txtUnit2.Text);
                if (ddi2 != null)
                {
                    hdnUnit2.Value = ddi2.DictionaryDataID.ToString();
                }
            }

            if (hdnUnit1.Value != "" && hdnUnit1.Value != "-1" && hdnUnit2.Value != "" && hdnUnit2.Value != "-1")
            {
                try
                {
                    AjaxServices.AjaxDictionaryData bll = new AjaxServices.AjaxDictionaryData();
                    LeanMES.DictionaryData.Model.UnitTransforInfo info = bll.GetUnitTransforByUnitIDAndTransforID(Convert.ToInt32(hdnUnit1.Value), Convert.ToInt32(hdnUnit2.Value));
                    if (info != null)
                    {
                        hdnTransfer.Value = info.TransforData.ToString();
                    }
                }
                catch (Exception ex)
                {

                }
            }
        }
    }
}