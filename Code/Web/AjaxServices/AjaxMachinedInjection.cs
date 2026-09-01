using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Maintenance.Model;
using SKT.LeanMES.Maintenance.BLL;
using SKT.LeanMES.SDP.BLL;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.Account.Model;
using SKT.Common.Account.BLL;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMachinedInjection
    {
        [AjaxMethod]
        public string WS_UserPassValid(string UserName, string Password)
        {
            string loginMessage = "";

            UIModel uiBll = new UIModel();
            try
            {
                string jsonParams = "{\"UserName\": \"" + UserName + "\"}";
                List<UsersInfo> list = CommonHelper.BLL.ComMethod.GetList<UsersInfo>("SYS_Users_GetByName", jsonParams);
                if (list.Count == 0)
                {
                    loginMessage = "验证错误，" + Resources.Messages.InvalidUser;
                }
                else
                {
                    SqlParameter[] parms = new SqlParameter[]{
                        new SqlParameter("@UserId", SqlDbType.Int),
                        new SqlParameter("@Password", SqlDbType.VarChar,50)
                    };
                    parms[0].Value = list[0].UserId;
                    parms[1].Value = SKT.Common.Utility.EncryptHelper.Encrypt(Password);
                    DataTable dt = CommonHelper.BLL.ComMethod.GetDataTableList("SYS_Users_ValidatePassword", parms);
                    if (dt.Rows.Count <= 0)
                    {
                        loginMessage = "验证错误";
                    }
                    else
                    {
                        int loginResult = Convert.ToInt32(dt.Rows[0][0]);
                        switch (loginResult)
                        {
                            case -1:
                                loginMessage = "验证错误，" + Resources.Messages.InvalidUser;
                                break;
                            case 0:
                                Users user = new Users();
                                int failedPasswordCount = user.GetFailedPasswordCount(UserName);
                                //Sperkey.Zhong 2018-12-12 读取‘最大允许输错密码次数’全局参数配置
                                int maxErrorCount = -1;
                                GlobarParameter.Model.GlobarParameterInfo entity = new GlobarParameter.BLL.GlobarParameter().GetInfo("FailedPasswordCount");
                                if (entity != null)
                                {
                                    maxErrorCount = Convert.ToInt32(entity.ParaValue);
                                }
                                if (UserName.ToLower() == "admin" || maxErrorCount == -1)
                                {
                                    loginMessage = "验证错误，" + Resources.Messages.InvalidPassword;
                                }
                                else
                                {
                                    loginMessage = "验证错误，" + Resources.Messages.InvalidPassword + Resources.Common.Comma + String.Format(Resources.Messages.RemainChance, (maxErrorCount - failedPasswordCount).ToString());
                                }
                                break;
                            case 1:
                                loginMessage = "";
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                loginMessage = "登录失败，" + ex.Message;
            }
            return loginMessage;
        }

        [AjaxMethod]
        public DataTable GetMachineUser(string OrderID, string MachineID, string UserName)
        {
            DataTable dt = null;
            try
            {
                dt = (new Equipments()).GetMachineUser(OrderID, MachineID, AccountController.GetCurrentUser().UserId, UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dt;
        }

        /// <summary>
        /// 实际出模数查询产品列表最大包装数
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string GetItemMaxBoxQty(string OrderNo)
        {
            //update by weixia on 2018.4.16 
            string str = @"SELECT ISNULL(a.MaxBoxQty,0) MaxBoxQty FROM  dbo.Basal_Item a WITH(NOLOCK) INNER JOIN dbo.Prod_Order b WITH(NOLOCK) ON a.ItemID=b.ItemId WHERE b.OrderNO=@OrderNo ";
            SqlParameter[] parms = new SqlParameter[]
                {
                    new SqlParameter("@OrderNo", SqlDbType.NVarChar,200) { Value = OrderNo }
                };

            return ComMethod.GetBySql(str, parms);

        }
    }
}