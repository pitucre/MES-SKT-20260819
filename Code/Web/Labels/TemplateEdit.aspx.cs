using System;
using SKT.LeanMES.Labels.BLL;
using SKT.LeanMES.Labels.Model;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace SKT.LeanMES.Web.Labels
{
    public partial class TemplateEdit : BasePage
    {
        private string numbertype = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxLabels));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["TempId"];
                //绑定下拉框
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    PrintTemplateInfo info = new PrintTemplate().GetEnityByTempId(Convert.ToInt32(idString));
                    if (Request.QueryString["Action"] == "Copy")
                    {
                        info.TempId = -1;
                        info.TempName += "-复制";
                    }
                    this.PageData = info;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PrintTemplateInfo PageData
        {
            set
            {
                this.txtTempId.Value = value.TempId.ToString();
                this.txtTempSet.Value = value.TempSet;
                this.txtPanelHeight.Text = (Math.Round(value.PanelHeight * 35.27) / 100).ToString();
                this.txtPanelWidth.Text = (Math.Round(value.PanelWidth * 35.27) / 100).ToString();
                this.txtTempName.Text = value.TempName;
            }
        }
        /// <summary>
        /// 下拉框绑定
        /// </summary>
        /// <param name="Value">查询字段值</param>
        /// <param name="DDList">下拉框</param>
        private void Bind(string Value, DropDownList DDList)
        {

            SKT.LeanMES.SerialNumber.BLL.Dictionary dictionary = new LeanMES.SerialNumber.BLL.Dictionary();
            List<SKT.LeanMES.SerialNumber.Model.DictionaryInfo> dInfos = dictionary.GetListInfo(Value);
            DDList.DataSource = dInfos;
            DDList.DataTextField = "Value";
            DDList.DataValueField = "Value";
            DDList.DataBind();
        }

        /// <summary>
        /// 下拉框绑定
        /// </summary>
        /// <param name="Value">查询字段值</param>
        /// <param name="DDList">下拉框</param>
        private void Bind_ValueID(string Value, DropDownList DDList)
        {

            SKT.LeanMES.SerialNumber.BLL.Dictionary dictionary = new LeanMES.SerialNumber.BLL.Dictionary();
            List<SKT.LeanMES.SerialNumber.Model.DictionaryInfo> dInfos = dictionary.GetListInfo(Value);
            DDList.DataSource = dInfos;
            DDList.DataTextField = "Value";
            DDList.DataValueField = "DictionaryDataId";

            if (dInfos.Count > 1)
            {
                DDList.SelectedIndex = 1;
            }

            DDList.DataBind();
        }
    }
}