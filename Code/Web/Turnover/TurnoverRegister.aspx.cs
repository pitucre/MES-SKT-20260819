using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using SKT.LeanMES.Turnover.BLL;
using SKT.LeanMES.Turnover.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Turnover
{
    public partial class TurnoverRegister : BasePage
    {
        private int Id = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxTurnover));

            LoadTurnoverData();
        }


        private TurnoverGroupInfo PageData
        {
            set
            {
                lblTurnoverTypeName.Text = value.TurnoverTypeName;
                lblTurnoverGroupName.Text = value.TurnoverGroupName;
                lblItemName.Text = value.ItemName;
                lblMaxStowQty.Text = value.MaxQty.ToString();
                lblMinStowQty.Text = value.MinQty.ToString();
                lblValidTurnoverQty.Text = value.ValidTurnoverQty.ToString();
                lblItemCode.Text = value.ItemCode;
            }
        }


        /// <summary>
        /// 导入文件，获取内容。
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void bt_fileupTurnover_Click(object sender, EventArgs e)
        {
            if (SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(AccountController.GetCurrentUser().UserId, 20170104))
            {
                if (fileupTurnover.HasFile)
                {
                    Stream stream = fileupTurnover.FileContent;
                    Byte[] bytes = new Byte[(Int32)stream.Length];
                    stream.Read(bytes, 0, bytes.Length);
                    string fileContents = Encoding.Default.GetString(bytes, 0, bytes.Length);
                    fileContents = Regex.Replace(fileContents, "\\s", "");

                    if (TurnoverImportCheck(fileContents, fileupTurnover.FileName))
                    {
                        /*捕捉数据库内抛出的重复条码*/
                        try
                        {
                            new TurnoverData().ImportTurnoverNumber(fileContents, Convert.ToInt32(Request.QueryString["ID"]), AccountController.GetCurrentUser().UserName, 1);
                            LoadTurnoverData();
                            WebHelper.ShowMessage(Resources.Messages.ImportSuccess);
                        }
                        catch (Exception ex)
                        {
                            WebHelper.ShowMessage(ex.Message + Resources.Messages.RecordExists);
                        }
                    }
                    else
                    {
                        WebHelper.ShowMessage(Resources.Messages.TurnoverNumberImportFail);
                    }
                }
                else
                {
                    WebHelper.ShowMessage(Resources.Messages.PleaseSelectFile);
                }
            }
            else
            {
                WebHelper.ShowMessage(Resources.Messages.NotWarranttedToOperater);
            }
        }


        /// <summary>
        /// 根据文件路径和文件内容检查是否合法
        /// </summary>
        /// <param name="fileContents">文件内容</param>
        /// <param name="fileurl">文件路径</param>
        /// <returns>是否合法</returns>
        private bool TurnoverImportCheck(string fileContents, string fileurl)
        {
            //文件路径的后缀是否是txt格式  不是txt则返回false
            if (!Regex.IsMatch(fileurl, @"[.]txt+?\b"))
            {
                return false;
            }

            //是否存在非字母和非数字的条码号，或者条码号长度超出50。 存在则条码为非法字符
            if (Regex.IsMatch(fileContents, @"[^A-Za-z0-9_,-]|[A-Za-z0-9_-]{51,}[,]{1}|[A-Za-z0-9_-]{51,}"))
            {
                return false;
            }

            return true;
        }

        /// <summary>
        /// 加载周转工具编码
        /// </summary>
        private void LoadTurnoverData() {
            string IdStr = Request.QueryString["ID"];
            Id = Convert.ToInt32(IdStr);
            if (Id > 0)
            {
                PageData = new TurnoverGroup().GetInfo(Id);
            }

            List<TurnoverDataInfo> list = (new TurnoverData()).GetTurnoverNumberList(Id);
            string shtml = "";
            string rowClassName = "ListTableOddRow";
            if (list.Count == 0)
            {
                shtml += "<tr class='ListTableEmptyDataRow'><td colspan='2'>该周转工具还没有任何条码</td></tr>";
            }
            else
            {
                for (int i = 0, j = list.Count; i < j; i++)
                {
                    if (i % 2 == 0)
                    {
                        rowClassName = "ListTableEvenRow";
                    }
                    else
                    {
                        rowClassName = "ListTableOddRow";
                    }
                    shtml += "<tr class='" + rowClassName + "'><td>" + list[i].TurnoverNumber + "</td><td>" + list[i].TurnoverStatusDesc + "</td></tr>";
                }
            }
            this.llTurnoverSNList.Text = shtml;
        }
    }
}