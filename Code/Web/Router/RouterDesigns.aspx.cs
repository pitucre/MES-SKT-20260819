using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Router
{
    public partial class RouterDesigns : BasePage
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
                int i = 1;
                foreach (SKT.LeanMES.Station.Model.StationTypeInfo entity in list)
                {
                    string className = "p_b_c_item";
                    if (i % 2 == 0)
                    {
                        className = "p_b_c_item p_b_c_item_bg";
                    }
                    operationType += " <div title=\"" + entity.StationType + "\" stid =\"" + entity.StationTypeId + "\" class=\"" + className + "\" >" + entity.StationType + " </div>";
                    i++;
                }
            }
            return operationType;
        }

        protected String InitOperationStaiton()
        {
            string operationType = "";
            List<SKT.LeanMES.Station.Model.StationInfo> list = (new SKT.LeanMES.Station.BLL.Station()).GetAll(0, -1, "StationId", null);
            if (list.Count > 0)
            {
                //operationType += "<tr class=\"ListTableHeader\"><th scope=\"col\" style=\"width:40%; font-size:12px; text-align:center;\">" + Resources.lang.StationType + "</th></tr>";
                foreach (SKT.LeanMES.Station.Model.StationInfo entity in list)
                {
                    operationType += " <div title=\"" + entity.Station + "\" style=\"display: none\" stid= \"" + entity.StationTypeId + "\"  sid=\""+entity.StationId+ "\" ><img src=\"../Content/images/wf_node.png\" />" + entity.Station + " </div>";
                }
            }
            return operationType;
        }


        protected String InitOperationStaitonJson()
        {
            string operationType = "";
            List<SKT.LeanMES.Station.Model.StationInfo> list = (new SKT.LeanMES.Station.BLL.Station()).GetAll(0, -1, "StationId", null);
            if (list.Count > 0)
            {
                return JsonConvert.SerializeObject(list);
            }
            return "[]";
        }

    }
}