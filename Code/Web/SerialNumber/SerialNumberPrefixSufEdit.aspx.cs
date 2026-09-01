using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.SerialNumber.Model;
namespace SKT.LeanMES.Web.SerialNumber
{
    public partial class SerialNumberPrefixSufEdit : BasePage
    {
        SerialNumberPerfixSuf bll = new SerialNumberPerfixSuf();
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSerialNumber));
            if (!IsPostBack)
            {
                //绑定方法函数、存储过程
                BindFunc();

                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = bll.GetInfo(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }
                }
            }
        }

        private void BindFunc()
        {
            var list = bll.GetPrefixSufFunc();

            foreach (string item in list)
            {
                ddlRuleFunc.Items.Add(new ListItem(item, item));
            }
            ddlRuleFunc.Items.Insert(0, new ListItem("=请选择=", ""));
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private DictionaryInfo PageData
        {
            set
            {
                this.txtRuleName.Text = value.Value;
                this.txtDescription.Text = value.Description;
                this.ddlRuleFunc.SelectedValue = value.Code;
            }
        }
    }
}