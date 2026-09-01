using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.Account.Model;
using System.Linq;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldAbnormalView : BasePage
    {
         AjaxEsop aEsop = new AjaxEsop();
        string filePath = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldAbnormalView));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldAbnormalEdit));

            var bll = new MoludAbnormal();

            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);

                if (id > 0)
                {

                    var model= bll.GetInfo(id);
                    PageData = model;

               
                }
               
            }
        }


        [AjaxMethod]
        public int Edit(MoludAbnormalInfo entity)
        {
            

            try
            {
                entity.CreateBy = AccountController.GetCurrentUser().UserName;

                var bll = new MoludAbnormal();

                return bll.Edit(entity);
            }
            catch (Exception ex)
            {
                return -1;

            }
        }

        protected MoludAbnormalInfo PageData
        {
            set
            {

                SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
                this.lblBomName.Text = value.BomName;
                this.hdMouldBomId.Value = value.MouldBomId.ToString();


                this.lblEquimentName.Text = value.EquipmentName;
                this.hdnEquimentId.Value = value.EquipmentId.ToString();



                this.lblAnormalType.Text = value.AnormalTypeName;


                //this.lblResourceType.Text = value.ResTypeName;

                this.txtAbnormalReason.Text = value.AbnormalReason;
                this.txtAbnormalPhenomenon.Text = value.AbnormalPhenomenon;

                this.ckeIsLeak.Checked = value.IsLeak == 0 ? false : true;
                this.lblConclusion.Text = value.Conclusion;

                //处理处理人（可能多人）
                if (!string.IsNullOrEmpty(value.HandlePerson))
                {

                    this.lblHandlePerson.Text = GetCNameByUserNames(value.HandlePerson);
                }
                if (!string.IsNullOrEmpty(value.MangerPerson))
                {
                    MembershipInfo userInfo = user.GetInfo(value.MangerPerson);
                    this.lblMangerPerson.Text = (userInfo == null) ? "" : userInfo.EmployeeCName;
                }

                this.lblStarTime.Text = value.StartTime.ToString();
                this.lblEndTime.Text = value.EndTime.ToString();


                this.hdStatus.Value = value.Status.ToString();

                var rcca = "";
                if (value.Rcca != "")
                {
                    filePath = aEsop.LocalFileExists(value.Rcca, "UploadRCCA");
                    if (filePath != "")
                    {
                        rcca = filePath;
                    }
                    else
                    {
                        rcca = SKT.LeanMES.Web.WebHelper.WebRoot + "/ESOP/DownLoad.aspx?Action=UploadRCCA&fileName=" + value.Rcca;
                    }
                }
                var rccaFileName = rcca.Substring(rcca.LastIndexOf("/") + 1, rcca.Length - rcca.LastIndexOf("/") - 1);
                this.lblRCCAPath.Text = "<a href='" + rcca + "' target='_blank'>" + value.Rcca + "</a>";

                this.hdnRCCAFilePath.Value = rcca;
                this.txtRemark.Text = value.Remark;



                if (value.PicFile != "")
                {
                    filePath = aEsop.LocalFileExists(value.PicFile, "MouldAnormal");
                    if (filePath != "")
                    {
                        this.txtimg.ImageUrl = filePath;
                    }
                    else
                    {
                        this.txtimg.ImageUrl = SKT.LeanMES.Web.WebHelper.WebRoot + "/ESOP/DownLoad.aspx?Action=MouldAnormal&fileName=" + value.PicFile;
                    }
                }
                lbFileReady.Value = value.PicFile;
            }
        }

        /// <summary>
        /// 通过用户名获取中文名
        /// </summary>
        /// <param name="userNames">用户名长串（逗号拼接）</param>
        /// <returns></returns>
        private string GetCNameByUserNames(string userNames)
        {
            string userCNames = string.Empty;

            if (!string.IsNullOrEmpty(userNames))
            {
                SKT.Common.Account.BLL.Users user = new Common.Account.BLL.Users();
                var listUserName = new List<string>();
                var listUserCName = new List<string>();
                listUserName = userNames.Split(new char[] { ',' }).ToList();
                foreach (var item in listUserName)
                {
                    MembershipInfo userInfo = user.GetInfo(item);
                    listUserCName.Add((userInfo == null) ? "" : userInfo.EmployeeCName);
                }
                userCNames = string.Join(",", listUserCName);
            }
            return userCNames;
        }
    }
}