using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;
using SKT.Common.Model;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.WebService.BLL;

namespace SKT.LeanMES.Web.WebService
{
    /// <summary>
    /// Summary description for BasalWebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class BasalWebService : System.Web.Services.WebService
    {
        /// <summary>
        /// 验证用户名
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string WS_UserValid(string UserName)
        {
            bool bResult; string errorMsg = "";
            SKT.LeanMES.WebService.BLL.BasalWebService bws = new SKT.LeanMES.WebService.BLL.BasalWebService();
            bws.UserVoid(UserName, out bResult, out errorMsg);
            return SetReturnValue(bResult, errorMsg);   
        }

        /// <summary>
        /// 验证用户名
        /// </summary>
        /// <returns></returns>
        [WebMethod]
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
            return SetReturnValue(loginMessage == "" ? true : false, loginMessage);
        }

        /// <summary>
        /// 条码验证接口
        /// </summary>
        /// <param name="Barcode">条码</param>
        /// <param name="StationName">工位号</param>
        /// <param name="RscName">资源名称</param>
        /// <param name="UserName">用户名称</param>
        /// <param name="IsMultiPlate">是否连板</param>
        /// <returns></returns>
        [WebMethod]
        public string WS_BcValid(string Barcode, string StationName, string RscName, string UserName, bool IsMultiPlate = false)
        {
            bool bResult; string errorMsg = "";
            SKT.LeanMES.WebService.BLL.BasalWebService bws = new SKT.LeanMES.WebService.BLL.BasalWebService();
            bws.UnitCompleteValid(Barcode, StationName, RscName, UserName, IsMultiPlate, out bResult, out errorMsg);
            return SetReturnValue(bResult, errorMsg);
        }

        /// <summary>
        /// 过站信息更新接口
        /// </summary>
        /// <param name="Barcode">条码</param>
        /// <param name="StationName">工位号</param>
        /// <param name="RscName">资源名称</param>
        /// <param name="IsMultiPlate">是否连板</param>
        /// <param name="JudgeRsl">测试结果</param>
        /// <param name="DefectCode">不良代码</param>
        /// <param name="ExtParameter">测试数据</param>
        /// <param name="UserName">用户名称</param>
        /// <returns></returns>
        [WebMethod]
        public string WS_UpdUnitRecord(string Barcode, string StationName, string RscName, bool IsMultiPlate ,bool JudgeRsl,
            string DefectCode,string ExtParameter, string UserName)
        {
            bool bResult; string errorMsg = "";
            SKT.LeanMES.WebService.BLL.BasalWebService bws = new SKT.LeanMES.WebService.BLL.BasalWebService();
            bws.WSBarcodeComplete(Barcode, StationName, RscName, IsMultiPlate, JudgeRsl, DefectCode, ExtParameter, UserName, out bResult, out errorMsg);
            return SetReturnValue(bResult, errorMsg);
        }

       
        private string SetReturnValue(bool bResult,string errorMsg)
        {
            return string.Format("<ReturnData><RtnString>{0}</RtnString><ErrMsg>{1}</ErrMsg></ReturnData>", bResult ? "1" : "0", errorMsg);
        }
    }
}
