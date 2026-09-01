using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Router
{
    public partial class RouterDesign :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxStation));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxRouter));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSDP));
        }
        protected String InitOperationType()
        {
            string operationType = "";
            List<SKT.LeanMES.Station.Model.StationTypeInfo> list = (new SKT.LeanMES.Station.BLL.StationType()).GetAll(0, -1, "StationTypeId", null);
            if (list.Count > 0)
            {
                //operationType += "<tr class=\"ListTableHeader\"><th scope=\"col\" style=\"width:40%; font-size:12px; text-align:center;\">" + Resources.lang.StationType + "</th></tr>";
                operationType += "<tr class=\"ListTableOddRow\" onclick=\"initOperation(0);\"><td><span style=\"float:left\">&#187;&nbsp;</span>开始结束</td></tr>";
                string css = "ListTableOddRow";
                foreach (SKT.LeanMES.Station.Model.StationTypeInfo entity in list)
                {
                    css = css == "ListTableOddRow" ? "ListTableHoverRow" : "ListTableOddRow";
                    operationType += "<tr class=\"" + css + "\" onclick=\"initOperation(" + entity.StationTypeId.ToString() + ");\"  style='border-left:none;'><td style='border-left:none;'><span style=\"float:left\">&#187;&nbsp;</span>" + entity.StationType + "</td></tr>";
                }
            }
            return operationType == "" ? "<tr class=\"ListTableHeader\"><th scope=\"col\" style=\"width:40%; font-size:12px; text-align:center;\">" + Resources.lang.StationType + "</th></tr><tr class=\"ListTableOddRow\"><td style=\"text-align:center\">" + Resources.lang.NoOperationType + "</td></tr>" : operationType;
        }
    }
}