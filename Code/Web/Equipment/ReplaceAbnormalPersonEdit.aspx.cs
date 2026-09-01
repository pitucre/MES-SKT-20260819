using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxPro;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class ReplaceAbnormalPersonEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(ReplaceAbnormalPersonEdit));
  
            if (!IsPostBack)
            {
               
            }
        }
       
       


        [AjaxMethod]
        public int EditOperator(int id,string operators)
        {
            var result = -1;
            try
            {
                
                var bll = new MoludAbnormal();

                result = bll.EditOperator(id,operators);
            }
            catch (Exception ex)
            {
                return -1;

            }
            return result;
        }
    }
}