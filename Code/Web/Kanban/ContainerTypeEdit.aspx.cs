using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Kanban
{
    public partial class ContainerTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxKanban));


            //add by zhi.li 容器类型列表显示
            if (!IsPostBack)
            {
                int containerTypeId = Convert.ToInt32(Request.QueryString["ID"]);
                if (containerTypeId != -1)
                {
                    SKT.LeanMES.Kanban.Model.MasterInfo model = new LeanMES.Kanban.BLL.Master().GetContainerTypeInfo(containerTypeId);
                    if (model != null)
                    {
                        txtConTypeName.Value = model.LayoutType;
                        txtRemark.Value = model.Remark;

                        int count = 0;
                        string keywords = "contUnit";
                        int index = 0;
                        while ((index = model.RawCode.IndexOf(keywords, index)) != -1)
                        {
                            count++;
                            //下次从这个词末的位置开始查找，所以要跳过本次该词的长度个字符位置继续查找
                            index = index + keywords.Length;
                        }
                        txtUnitNum.Value = count.ToString();
                        divConM.InnerHtml = model.RawCode;

                    }

                }
            }
        }
    }
}