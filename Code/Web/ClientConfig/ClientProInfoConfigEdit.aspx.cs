using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ClientConfig.BLL;
using SKT.LeanMES.ClientConfig.Model;
using SKT.Common.Framework.Model;
using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.SDP.Model;
using System.Collections;

namespace SKT.LeanMES.Web.ClientConfig
{
    public partial class ClientProInfoConfigEdit : BasePage
    {
        private string popedom;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClientConfig));

            if (!this.IsPostBack)
            {
                bindDropDownList();

                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    int id = Convert.ToInt32(idString);
                    this.PageData = (new ClientProInfoConfig()).GetInfo(id);
                }

                BindPreUIList();
                BindUIList();
            }
        }

        string[] infoTypes = new string[] { "", Resources.lang.ProductInformation, Resources.lang.ProductionCount };
        string[] displayStyles = new string[] { "", Resources.lang.NormalSpanStyle, Resources.lang.TextareaStyle };

        /// <summary>
        /// 绑定下拉框的值
        /// </summary>
        private void bindDropDownList()
        {
            for (int i = 1; i < 3; i++)
            {
                ListItem infotype = new ListItem(infoTypes[i], i.ToString());
                ddlInfoType.Items.Add(infotype);
                ListItem displaystyle = new ListItem(displayStyles[i], i.ToString());
                ddlDisplayStyle.Items.Add(displaystyle);
            }
        }

        protected void BindPreUIList()
        {
            SKT.Common.Framework.BLL.Page bll = new Common.Framework.BLL.Page();
            List<PageInfo> models = bll.GetPagesByModule("Product_CollectionTemplate", false);

            foreach (PageInfo item in models)
            {
                if (!popedom.Contains(item.Popedom.ToString()))
                {
                    var popedomName = HttpContext.GetGlobalResourceObject("Popedom", item.Name);
                    if (popedomName == null)
                    {
                        popedomName = item.Name;
                    }
                    PreUIList.Items.Add(new ListItem(popedomName.ToString(), item.Popedom.ToString()));
                }
            }

            //二次开发UI
            UIModel uiModel = new UIModel();
            var list = uiModel.GetAll();
            var popedomList = popedom.Split(',');
            //string popedomObj = "";
            foreach (UIModelInfo entity in list)
            {
                var popedomObj = from n in popedomList
                                 where n == entity.ModelId.ToString() 
                                 select n;
                            
                if (popedomObj.ToList().Count == 0)
                {
                    PreUIList.Items.Add(new ListItem(entity.ModelName, entity.ModelId.ToString()));
                }


            }
        }

        protected void BindUIList()
        {
            SKT.Common.Framework.BLL.Page bll = new Common.Framework.BLL.Page();
            List<PageInfo> models = bll.GetPagesByModule("Product_CollectionTemplate", false);
            foreach (PageInfo item in models)
            {
                if (popedom.Contains(item.Popedom.ToString()))
                {
                    UIList.Items.Add(new ListItem(HttpContext.GetGlobalResourceObject("Popedom", item.Name).ToString(), item.Popedom.ToString()));
                }
            }

            //二次开发UI
            UIModel uiModel = new UIModel();
            var list = uiModel.GetAll();
            var popedomList = popedom.Split(',');
            foreach (string popedoms in popedomList)
            {
                foreach (UIModelInfo entity in list)
                {
                    if (popedoms == (entity.ModelId.ToString()))
                    {
                        UIList.Items.Add(new ListItem(entity.ModelName, entity.ModelId.ToString()));
                        break;
                    }
                }

            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ClientProInfoConfigInfo PageData
        {
            set
            {
                this.txtInfoName.Text = value.InfoName;
                this.txtDbName.Text = value.DbName;
                this.cbxIsDisplay.Checked = value.IsDisplay;
                this.ddlInfoType.SelectedValue = value.InfoType.ToString();
                this.ddlDisplayStyle.SelectedValue = value.DisplayStyle.ToString();
                popedom = value.Popedom == null ? "" : value.Popedom;
                this.txtDisplayCSS.Text = value.DisplayCSS;
            }
        }
    }
}