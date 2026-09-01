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
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class ReplaceMoldPersonEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(ReplaceMoldPersonEdit));
            var bll = new MoludApply();


            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);

                if (id > 0)
                {

                    PageData = bll.GetInfo(id);

                }
                
            }
        }
       
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MoludApplyInfo PageData
        {
            set
            {
                //处理中文名
                SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
                var listUserName = new List<string>();
                var listUserCName = new List<string>();
                listUserName = value.Operator.Split(new char[] { ',' }).ToList();
                foreach (var item in listUserName)
                {
                    MembershipInfo userInfo = user.GetInfo(item);
                    listUserCName.Add((userInfo == null) ? "" : userInfo.EmployeeCName);
                }
                this.txtOperator.Text = string.Join(",", listUserCName); 
                this.hdOperator.Value = value.Operator;
                this.hidSatatus.Value=value.Status.ToString();
            }
        }


        [AjaxMethod]
        public int EditOperator(int id,string operators)
        {
            var result = -1;
            try
            {
                
                var bll = new MoludApply();

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