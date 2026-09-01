using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Equipment.Model;
using System.IO;
using SKT.Common.Model;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;

namespace SKT.LeanMES.Web.Product
{
    public partial class MaterialBucketItemRelationEdit : BasePage
    {
        AjaxEsop aEsop = new AjaxEsop();
        string filePath = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxProduct));
           
            if (!this.IsPostBack)
            {
                string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
                int Id;

                if (int.TryParse(IdStr, out Id) && Id > 0)
                {
                    txtMaterialBucketCode.Enabled = false;
                    MaterialBucket bll = new MaterialBucket();
                    MaterialBucketInfo model = null;
                    model = bll.GetInfo(IdStr);
                    if (model != null)
                    {
                        this.PageData = model;
                    }

                  
                }
               
            }

        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MaterialBucketInfo PageData
        {
            set
            {
                txtMaterialBucketCode.Text = value.MaterialBucketCode;
                this.txtRemark.Text = value.Remark;
               
               
            }
        }

      

    }
}