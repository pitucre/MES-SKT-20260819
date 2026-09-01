using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Controls
{
    /// <summary>
    /// 自定义服务器控件DropDownList的基类
    /// </summary>
    public abstract class DropDownListBase : System.Web.UI.WebControls.DropDownList
    {
        protected String selectedValue;

        protected override void OnPagePreLoad(object sender, EventArgs e)
        {
            base.OnPagePreLoad(sender, e);

            if (this.Page.IsPostBack)
            {
                if (this.Items.Count == 0)
                {
                    BindControl();
                }
                if (selectedValue != null)
                {
                    this.SelectedValue = selectedValue;
                }
            }
            else
            {
                BindControl();
            }
        }

        /// <summary>
        /// 绑定列表(重写此方法初始化列表项)。
        /// </summary>
        protected abstract void BindControl();

        /// <summary>
        /// 从列表中移除具有指定值的列表项，移除成功返回true，移除失败返回false。
        /// </summary>
        /// <param name="value">移除项的值。</param>
        /// <returns>移除成功返回true，移除失败返回false。</returns>
        public Boolean RemoveItem(String value)
        {
            foreach (ListItem item in this.Items)
            {
                if (item.Value.Equals(value))
                {
                    this.Items.Remove(item);
                    return true;
                }
            }
            return false;
        }

        #region Postback Handling

        protected override bool LoadPostData(string postDataKey, System.Collections.Specialized.NameValueCollection postCollection)
        {
            selectedValue = postCollection[postDataKey];
            return base.LoadPostData(postDataKey, postCollection);
        }

        protected override void RaisePostDataChangedEvent()
        {
            base.RaisePostDataChangedEvent();
        }

        #endregion
    }
}
