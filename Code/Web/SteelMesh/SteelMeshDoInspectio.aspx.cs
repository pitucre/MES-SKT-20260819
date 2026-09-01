using SKT.Common.Account.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SteelMesh
{
    public partial class SteelMeshDoInspectio : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSteelMeshInspection));
        }
        /// <summary>
        /// 通过用户名获取中文名
        /// </summary>
        /// <param name="userNames">用户名长串（逗号拼接）</param>
        /// <returns></returns>
        public string GetCNameByUserNames(string userNames)
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