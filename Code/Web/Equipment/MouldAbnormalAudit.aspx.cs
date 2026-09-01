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
    public partial class MouldAbnormalAudit : BasePage
    {

        AjaxEsop ajaxEsop = new AjaxEsop();
        string filePath = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldAbnormalAudit));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldAbnormalEdit));

            var bll = new MoludAbnormal();

            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);

                if (id > 0)
                {

                    var model = bll.GetInfo(id);
                    PageData = model;


                }

            }
        }


        [AjaxMethod]
        public int Edit(int id, string remark)
        {


            try
            {
                var entity = new MoludAbnormalInfo();
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                entity.Id = id;
                entity.Remark = remark;
                var bll = new MoludAbnormal();

                return bll.Audit(entity);
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

                this.lblBomName.Text = value.BomName;
                this.hdnMouldBomId.Value = value.MouldBomId.ToString();

                this.lblEquimentName.Text = value.EquipmentName;
                this.hdnEquimentId.Value = value.EquipmentId.ToString();


                this.lblAnormalType.Text = value.AnormalTypeName;


                //this.lblResourceType.Text = value.ResTypeName;

                this.txtAbnormalReason.Text = value.AbnormalReason;
                this.txtAbnormalPhenomenon.Text = value.AbnormalPhenomenon;

                this.ckeIsLeak.Checked = value.IsLeak == 0 ? false : true;
                this.lblConclusion.Text = value.Conclusion;

                //处理人（可能多个）
                this.lblHandlePerson.Text = GetCNameByUserNames(value.HandlePerson);
                this.lblMangerPerson.Text = GetCNameByUserNames(value.MangerPerson);

                this.lblStarTime.Text = value.StartTime.ToString();
                this.lblEndTime.Text = value.EndTime.ToString();

                if (value.Rcca != "")
                {
                    filePath = ajaxEsop.LocalFileExists(value.Rcca, "UploadRCCA");
                    var rcca = "";
                    var rccaFileName = "";
                    if (filePath != "")
                    {
                        rcca = filePath;
                    }
                    else
                    {
                        rcca = SKT.LeanMES.Web.WebHelper.WebRoot + "/ESOP/DownLoad.aspx?Action=UploadRCCA&fileName=" + value.Rcca;
                    }
                    rccaFileName = rcca.Substring(rcca.LastIndexOf("/") + 1, rcca.Length - rcca.LastIndexOf("/") - 1);
                    this.lblRCCAPath.Text = "<a href='" + rcca + "' target='_blank'>" + value.Rcca + "</a>";
                    this.hdnRCCAFilePath.Value = rcca;
                }


                // this.txtRemark.Text = value.Remark;
                if (value.PicFile != "")
                {
                    filePath = ajaxEsop.LocalFileExists(value.PicFile, "MouldAnormal");
                    if (filePath != "")
                    {
                        this.image1.ImageUrl = filePath;
                    }
                    else
                    {
                        this.image1.ImageUrl = SKT.LeanMES.Web.WebHelper.WebRoot + "/ESOP/DownLoad.aspx?Action=MouldAnormal&fileName=" + value.PicFile;
                    }
                }
                lbFileReady.Text = value.PicFile;
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