using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;
using System.Linq;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldChangeConfirm : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldChangeConfirm));
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(InspectionTemplateEdit));
   
            var bll = new MoludApply();

            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);

                if (id > 0)
                {

                    var model= bll.GetInfo(id);
                    PageData = model;

                    DateTime startTime = Convert.ToDateTime(model.CreateTime);
                    DateTime endTime = Convert.ToDateTime(model.ActualStartTime);
                    DateTime endTime2 = Convert.ToDateTime(model.ActualFinish);
                    TimeSpan ts = endTime - startTime;
                    this.txtPlanTime.Text = ts.Hours.ToString();
                    TimeSpan ts1 = endTime2 - endTime;
                    this.txtActualTimeLength.Text = ts1.Hours.ToString();
                }
               
            }
        }


        [AjaxMethod]
        public int Edit(int cid,int isHege,string remark,DateTime actualFinish)
        {
            MoludApplyInfo info=new MoludApplyInfo();
            string userName = AccountController.GetCurrentUser().EmployeeCName;
            try
            {
                info.Cid = cid;
                info.Isqualified = isHege;
                info.ChangeConfirmRemark = remark;
                info.ActualFinish = actualFinish;
                var bll = new MoludApply();

                return bll.EditConfimEdit(info, userName);
            }
            catch (Exception)
            {
                return -1;

            }
        }

        protected MoludApplyInfo PageData
        {
           
            set
            {
                this.lblChangeNo.Text = value.ApplyNo;
                this.txtApplyRemark.Text = value.ApplyRemark;
                this.txtChangeOverRemark.Text = value.ChangeOverRemark;
                this.txtCreateBy.Text = value.CreateBy;
                //换模人
                this.txtOperator.Text = GetCNameByUserNames(value.Operator);
                this.txtActualFinish.Text = DateTime.Now.Year+"-"+ DateTime.Now.Month+"-"+ DateTime.Now.Day+" "+ DateTime.Now.Hour+":"+ DateTime.Now.Minute+":"+ DateTime.Now.Second;
                this.hdActualStartTime.Value = value.ActualStartTime.ToString();
                this.hdCreateTime.Value = value.CreateTime.ToString();
                this.hdStatus.Value = value.Status.ToString();
                this.txtInitialPress.Text = value.InitialPress.ToString();
                this.txtCurrentPress.Text = value.CurrentPress.ToString();

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