using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Lookup;

namespace SKT.LeanMES.Web.Router
{
    public partial class RouterActivity : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxRouter));

            if (!IsPostBack)
            {
                Dictionary<string, object> dic = new Dictionary<string, object>();
                dic.Add("Alpha1", Request.QueryString["RouterID"]);
                dic.Add("Alpha2", Request.QueryString["OperationID"]);
                Lookup.BLL.Lookup lookupBll = new Lookup.BLL.Lookup();
                List<Lookup.Model.LookupInfo> lookupInfo = lookupBll.GetLookupByCondition("SYS_RouteDetailSetting", dic);
                if (lookupInfo.Count > 0)
                {
                    //SMT开拉检查
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha4) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha4))
                    {
                        ddlOpenLine.SelectedValue = lookupInfo[0].Alpha4;
                    }

                    //SMT扣料
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha3) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha3))
                    {
                        ddlSMTDeduct.SelectedValue = lookupInfo[0].Alpha3;
                    }

                    //检查钢网
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha10) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha10))
                    {
                        ddlCheckSteel.SelectedValue = lookupInfo[0].Alpha10;
                    }

                    //检查刮刀
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha11) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha11))
                    {
                        ddlCheckKnife.SelectedValue = lookupInfo[0].Alpha11;
                    }

                    //解除拼板
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha12) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha12))
                    {
                        ddlSplitPanel.SelectedValue = lookupInfo[0].Alpha12;
                    }

                    //手插扣料
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha13) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha13))
                    {
                        ddlPickDeduct.SelectedValue = lookupInfo[0].Alpha13;
                    }

                    //投入站
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha14) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha14))
                    {
                        ddlInputStation.SelectedValue = lookupInfo[0].Alpha14;
                    }

                    //产出站
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha15) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha15))
                    {
                        ddlOutputStation.SelectedValue = lookupInfo[0].Alpha15;
                    }

                    //正面投入站
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha16) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha16))
                    {
                        ddlSMTAInputStation.SelectedValue = lookupInfo[0].Alpha16;
                    }

                    //正面产出站
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha17) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha17))
                    {
                        ddlSMTAOutputStation.SelectedValue = lookupInfo[0].Alpha17;
                    }

                    //背面投入站
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha18) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha18))
                    {
                        ddlSMTBInputStation.SelectedValue = lookupInfo[0].Alpha18;
                    }

                    //背面产出站
                    if (!string.IsNullOrEmpty(lookupInfo[0].Alpha19) && !string.IsNullOrWhiteSpace(lookupInfo[0].Alpha19))
                    {
                        ddlSMTBOutputStation.SelectedValue = lookupInfo[0].Alpha19;
                    }

                    //手插开拉验证
                    if (!string.IsNullOrEmpty(lookupInfo[0].AlphaM21) && !string.IsNullOrWhiteSpace(lookupInfo[0].AlphaM21))
                    {
                        ddlPickOpenLine.SelectedValue = lookupInfo[0].AlphaM21;
                    }
                    //是否需要打印
                    if (!string.IsNullOrEmpty(lookupInfo[0].AlphaM22) && !string.IsNullOrWhiteSpace(lookupInfo[0].AlphaM22))
                    {
                        ddlIfPrint.SelectedValue = lookupInfo[0].AlphaM22;
                    }
                    //手插扣料组编号
                    if (!string.IsNullOrEmpty(lookupInfo[0].AlphaM23) && !string.IsNullOrWhiteSpace(lookupInfo[0].AlphaM23))
                    {
                        ddlGroupCode.SelectedValue = lookupInfo[0].AlphaM23;
                    }
                    //OSP-双面焊接检查
                    if (!string.IsNullOrEmpty(lookupInfo[0].AlphaM24) && !string.IsNullOrWhiteSpace(lookupInfo[0].AlphaM24))
                    {
                        ddlOSPWeldCheck.SelectedValue = lookupInfo[0].AlphaM24;
                    }
                    //OSP-开封至波峰焊检查
                    if (!string.IsNullOrEmpty(lookupInfo[0].AlphaM25) && !string.IsNullOrWhiteSpace(lookupInfo[0].AlphaM25))
                    {
                        ddlOSPWaveSolderingCheck.SelectedValue = lookupInfo[0].AlphaM25;
                    }
                    //样机检查
                    if (!string.IsNullOrEmpty(lookupInfo[0].AlphaM26) && !string.IsNullOrWhiteSpace(lookupInfo[0].AlphaM26))
                    {
                        ddlSampleExame.SelectedValue = lookupInfo[0].AlphaM26;
                    }
                    //PQC送检单
                    if (!string.IsNullOrEmpty(lookupInfo[0].AlphaM27) && !string.IsNullOrWhiteSpace(lookupInfo[0].AlphaM27))
                    {
                        ddlPQC.SelectedValue = lookupInfo[0].AlphaM27;
                    }

                    //扣料面别
                    if (!string.IsNullOrEmpty(lookupInfo[0].AlphaM28) && !string.IsNullOrWhiteSpace(lookupInfo[0].AlphaM28))
                    {
                        this.ddlSMTDeductFace.SelectedValue = lookupInfo[0].AlphaM28;
                    }

                    //扣料面别
                    if (!string.IsNullOrEmpty(lookupInfo[0].AlphaM29) && !string.IsNullOrWhiteSpace(lookupInfo[0].AlphaM29))
                    {
                        this.ddlUpModel.SelectedValue = lookupInfo[0].AlphaM29;
                    }
                }
            }
        }
    }
}