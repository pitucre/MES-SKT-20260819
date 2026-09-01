using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Molding.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.Client
{
    public partial class MaterialMoldingCollection : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMolding));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxPrint));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxSerialNumber));
            string position = SKT.LeanMES.Web.WebHelper.WebRoot.TrimEnd(new char[] { '/' });
            txtWebPath.Text = "http://" + HttpContext.Current.Request.Url.Authority.TrimEnd(new char[] { '/' });//http://+ip:端口+/+应用程序地址
            //加载FTP信息
            SKT.LeanMES.ESOP.BLL.FtpServerConfig ftpBll = new LeanMES.ESOP.BLL.FtpServerConfig();
            SKT.LeanMES.ESOP.Model.FtpServerConfigInfo ftpEntity = ftpBll.GetInfo();
            if (ftpEntity != null)
            {
                hdnFtpIP.Value = DESCryptoHelper.Encrypt(ftpEntity.FtpServerName, DESCryptoHelper.DefaultKey);
                hdnFtpUser.Value = DESCryptoHelper.Encrypt(ftpEntity.UserName, DESCryptoHelper.DefaultKey);
                hdnFtpPwd.Value = DESCryptoHelper.Encrypt(ftpEntity.PWD, DESCryptoHelper.DefaultKey);
            }
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"] == "downLoad")
                {
                    //DownloadSoft();改用ActiveX插件进行文件的更新
                }
                else
                {
                    BindGroup();
                }
            }
            else
            {
                BindGroup();
            }
        }
        protected void BindGroup()
        {
            SKT.LeanMES.ProductionShift.BLL.ProductionShift bll = new LeanMES.ProductionShift.BLL.ProductionShift();
            this.txtGroup.DataSource = bll.GetAll(0, -1, "", null);
            this.txtGroup.DataTextField = "ShiftName";
            this.txtGroup.DataValueField = "ShiftId";
            this.txtGroup.DataBind();
            this.txtGroup.Items.Insert(0, (new ListItem("请选择", "-1")));         
        }

        public void DownloadSoft()
        {
            int moldingMemberId = Convert.ToInt32(Request.Form["hidMoldingMemberId"]);
            //插入下载记录
            LeanMES.Molding.BLL.MaterialMolding bll = new Molding.BLL.MaterialMolding();
            bll.AddBurnSoftDownLoad(moldingMemberId, AccountController.GetCurrentUser().UserName);

            MaterialMoldingMemberInfo info = new MaterialMoldingMemberInfo();
            try
            {
                info = bll.GetMember(moldingMemberId, -1);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            string fileName = info.Filename;//客户端保存的文件名
            string filePath = Server.MapPath("../") + info.SoftPath.Replace("/", "\\"); //路径

            //以字符流的形式下载文件
            FileStream fs = new FileStream(filePath, FileMode.Open);
            byte[] bytes = new byte[(int)fs.Length];
            fs.Read(bytes, 0, bytes.Length);
            fs.Close();
            Response.ContentType = "application/octet-stream";
            //通知浏览器下载文件而不是打开
            Response.AddHeader("Content-Disposition", "attachment;  filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
            Response.BinaryWrite(bytes);
            Response.Flush();
            Response.End();

        }
    }
}