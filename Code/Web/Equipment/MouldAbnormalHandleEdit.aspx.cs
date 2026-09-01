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
    public partial class MouldAbnormalHandleEdit : BasePage
    {

        AjaxEsop aEsop = new AjaxEsop();
        string filePath = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldAbnormalEdit));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldAbnormalHandleEdit));
            

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

            var result = -1;
            try
            {
                entity.CreateBy = AccountController.GetCurrentUser().UserName;

                var bll = new MoludAbnormal();

                result =bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
            return result;
        }

        protected MoludAbnormalInfo PageData
        {
            set
            {
                this.hdMouldBomId.Value = value.MouldBomId.ToString();
                this.txtBomName.Text = value.BomName;

                this.hdnEquimentId.Value = value.EquipmentId.ToString();
                this.txtEquimentCode.Text = value.EquipmentName;

                this.hdAnormalTypeId.Value = value.AnormalTypeId.ToString();
                this.txtAnormalType.Text = value.AnormalTypeName;

                //this.hdResourceTypeId.Value = value.ResourceTypeId.ToString();
                //this.txtResourceType.Text = value.ResTypeName;

                this.txtAbnormalReason.Text = value.AbnormalReason;
                this.txtAbnormalPhenomenon.Text = value.AbnormalPhenomenon;

                this.ckeIsLeak.Checked = value.IsLeak == 0 ? false : true;
                this.txtConclusion.Text = value.Conclusion;

                //处理人（可能多个）
                this.lblHandlePerson.Text = GetCNameByUserNames(value.HandlePerson);
                this.hdHandlePerson.Value = value.HandlePerson;
                this.txtMangerPerson.Text = GetCNameByUserNames(value.MangerPerson);
                this.hdMangerPerson.Value = value.MangerPerson;

                this.txtStartTime.Text = value.StartTime.ToString();
                this.txtEndTime.Text = (value.EndTime.ToString("yyyy-MM-dd") == "1900-01-01" ? "" : value.EndTime.ToString());
                this.hdStatus.Value = value.Status.ToString();

                var rcca = value.Rcca;
                this.lblRCCAPath.Text = rcca.Substring(rcca.LastIndexOf("/") + 1, rcca.Length - rcca.LastIndexOf("/") - 1);
                this.hdnRCCAFilePath.Value = rcca;
                // this.txtRemark.Text = value.Remark;

             

                if (value.PicFile != "")
                {
                    filePath = aEsop.LocalFileExists(value.PicFile, "MouldAnormal");
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