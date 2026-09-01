using System;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{
    public partial class AQLGetValue : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            btn_GetFnViValue.Text = Resources.lang.GetFnVi;
        }

        protected void btn_GetFnViValue_OnClick(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(this.txtInspectionValue.Text.Trim()))
            {
                try
                {
                    int i = 0;
                    if (int.TryParse(txtInspectionValue.Text.Trim(), out i))
                    {
                        var str = (new AQLSample()).AQLSampleSize(i);
                        lblFN.Text = str.Split(',')[0];
                        lblVI.Text = str.Split(',')[1];
                    }
                    else
                    {
                        WebHelper.ShowMessage("当前数值已超过最大检验值2147483647！");
                    }
                }
                catch (Exception ex)
                {
                    
                    WebHelper.HandleException("", ex, true);
                }
            }
            else
            {
                WebHelper.ShowMessage("请输入检验数量");
            }
        }
    }
}