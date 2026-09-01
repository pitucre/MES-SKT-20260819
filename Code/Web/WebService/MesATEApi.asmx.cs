using SKT.LeanMES.ProductionCollection.WebService;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using SKT.LeanMES.Web.AppCode.Utility;
using SKT.LeanMES.ESOP.Model;
using SKT.LeanMES.ESOP.BLL;
using SKT.LeanMES.SDP.BLL;
using SKT.Common.Account.BLL;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.WebService
{
    /// <summary>
    /// MesATEApi 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://mesateapi.com/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class MesATEApi : System.Web.Services.WebService
    {
        ATEWebService ateWs = new ATEWebService();

        #region  ATE相关数据检查

        /// <summary>
        /// 检测员工工号信息
        /// </summary>
        /// <param name="empNo"></param>
        /// <returns></returns>       
        [WebMethod(Description = @"
         [功能]：检测员工工号信息<br/>
        [参数]：empNo-工号<br/>
        [返回]：字符串，成功返回'OK;' 失败返回'NG;NG原因' <br/> 
        ")]
        public string CheckEmployeeNo(string empNo)
        {
            string msg = "";

            try
            {
                msg = ateWs.CheckEmployeeNo(empNo);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg;
        }

        /// <summary>
        /// 检查SN信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        [WebMethod(Description = @"
        [功能]：检查序列号信息<br/>
        [参数]：sn-序列号<br/>
        [返回]：字符串，成功返回'OK;' 失败返回'NG;NG原因' <br/>
        ")]
        public string CheckSN(string sn)
        {
            string msg = "";

            try
            {
                msg = ateWs.CheckSerialNumber(sn);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg;
        }

        /// <summary>
        /// 检测工号和序列号信息
        /// </summary>
        /// <param name="empNo"></param>
        /// <param name="sn"></param>
        /// <returns></returns>
        [WebMethod(Description = @"
        [功能]：检测工号和序列号信息<br/>
        [参数]：empNo-工号,sn-序列号<br/>
        [返回]：字符串，成功返回'OK;' 失败返回'NG;NG原因' <br/>
        ")]
        public string CheckEmployeeNoSN(string empNo, string sn)
        {
            string msg = "";

            try
            {
                msg = ateWs.CheckEmployeeNo_SN(empNo, sn);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg;
        }

        /// <summary>
        /// 检测工号和序列号和资源/设备
        /// </summary>
        /// <param name="empNo"></param>
        /// <param name="sn"></param>
        /// <param name="resource"></param>
        /// <returns></returns>
        [WebMethod(Description = @"
        [功能]：检测工号和序列号和资源/设备<br/>
        [参数]：empNo-工号,sn-序列号,resource-资源/设备<br/>
        [返回]：字符串，成功返回'OK;' 失败返回'NG;NG原因' <br/>
        ")]
        public string CheckEmployeeNoSNRes(string empNo, string sn, string resource)
        {
            string msg = "";

            try
            {
                msg = ateWs.CheckEmployeeNo_SN_Res(empNo, sn, resource);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg;
        }

        /// <summary>
        /// 检测工号和序列号和资源、工序
        /// </summary>
        /// <param name="empNo"></param>
        /// <param name="sn"></param>
        /// <param name="resource"></param>
        /// <param name="station"></param>
        /// <returns></returns>
        [WebMethod(Description = @"
        [功能]：检测工号和序列号和资源、工序<br/>
        [参数]：empNo-工号,sn-序列号,resource-资源/设备,station-工序<br/>
        [返回]：字符串，成功返回'OK;' 失败返回'NG;NG原因' <br/>
        ")]
        public string CheckEmployeeNoSNResStation(string empNo, string sn, string resource, string station)
        {
            string msg = "";

            try
            {
                msg = ateWs.CheckEmployeeNo_SN_Res_Station(empNo, sn, resource, station);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg;
        }

        #endregion

        #region ATE测试文件上传

        [WebMethod(Description = @"
        [功能]：测试系统上传文件到MES服务器<br/>
        [参数]：empNo-工号,sn-序列号,resource-资源/设备,station-工序,fileBytes-文件的字节数组(byte[]), folderName-要存放的文件夹名(如aaa,也可aaa\bbb),fileName-文件名(如aaa.txt)<br/>
        [返回]：是否成功结果信息 <br/>
        ")]
        public string UploadFileToMES(string empNo, string sn, string resource, string station, byte[] fileBytes, string folderName, string fileName)
        {
            string result = "OK;文件上传成功！";
            if (!FileValidator.ValidatePathParameter(folderName))
            {
                throw new Exception("存放文件路径非法!");
            }
            string folderPath = Server.MapPath(WebHelper.UploadFileRoot + folderName);
            string filePath = Server.MapPath(WebHelper.UploadFileRoot + folderName + "/" + fileName);

            string fileInfo = WebHelper.UploadFileRoot + folderName + "/" + fileName;

            if (!FileValidator.ValidateFile(fileName, fileBytes, out var msg))
            {
                throw new Exception(msg);
            }

            if (fileName.IndexOf(".") == -1)
            {
                result = "NG;无效的文件名！";
            }
            else
            {
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                try
                {
                    FileStream fs = new FileStream(@filePath, FileMode.Create, FileAccess.Write);
                    fs.Write(fileBytes, 0, fileBytes.Length);
                    fs.Close();
                    ateWs.CollectATEFileInfo(empNo, sn, resource, station, fileInfo);
                }
                catch (Exception ex)
                {
                    result = "NG;" + ex.Message;
                }
            }
            return result;
        }

        [WebMethod(Description = @"
        [功能]：测试系统上传文件到指定FTP服务器<br/>
        [参数]：empNo-工号,sn-序列号,resource-资源/设备,station-工序,fileBytes-文件的字节数组(byte[]), fileName-文件名(如aaa.txt)<br/>
        [返回]：是否成功结果信息  <br/>
        ")]
        public string UploadFileToFTP(string empNo, string sn, string resource, string station, byte[] fileBytes, string fileName)
        {
            string result = "OK;文件上传成功！";
            string ftpServerDir = "";
            string ftpServerIP = "";
            string ftpUserID = "";
            string ftpPassword = "";
            Stream stream = new MemoryStream(fileBytes);

            FtpServerConfigInfo model = (new FtpServerConfig()).GetInfo();
            ftpServerIP = model.FtpServerName;
            ftpUserID = model.UserName;
            ftpPassword = model.PWD;
            ftpServerDir = "ATE";

            bool folderExist = UploadUtility.DirectoryExist(ftpServerDir, ftpServerIP, ftpUserID, ftpPassword);
            if (!folderExist)
            {
                UploadUtility.MakeDir(ftpServerDir, ftpServerIP, ftpUserID, ftpPassword);
            }
            try
            {
                var ftpUrl = UploadUtility.UploadFile(stream, fileName, ftpServerDir, ftpServerIP, ftpUserID, ftpPassword);
                ateWs.CollectATEFileInfo(empNo, sn, resource, station, ftpUrl);
            }
            catch (Exception ex)
            {
                result = "NG;" + ex.Message;
            }

            return result;
        }

        #endregion

        #region ATE数据保存

        /// <summary>
        /// 检查ATE数据信息，保存测试数据
        /// </summary>
        /// <param name="empNo"></param>
        /// <param name="sn"></param>
        /// <param name="resource"></param>
        /// <param name="station"></param>
        /// <param name="ateData"></param>
        /// <returns></returns>
        [WebMethod(Description = @"
        [功能]：检查ATE数据信息，保存测试数据<br/>
        [参数]：empNo-工号,sn-序列号,resource-资源/设备,station-工序,ateData-测试数据（格式：Test1:2.5#Test2:2.8）<br/>
        [返回]：字符串，成功返回'OK;' 失败返回'NG;NG原因' <br/>
        ")]
        public string CollectATEData(string empNo, string sn, string resource, string station, string ateData)
        {
            string msg = "";

            try
            {
                msg = ateWs.CollectATEData(empNo, sn, resource, station, ateData);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg;
        }

        /// <summary>
        /// 检查ATE数据信息，采集不良记录 并过站
        /// </summary>
        /// <param name="empNo"></param>
        /// <param name="sn"></param>
        /// <param name="resource"></param>
        /// <param name="station"></param>
        /// <param name="ateNcData"></param>
        /// <returns></returns>
        [WebMethod(Description = @"
        [功能]：检查ATE数据信息，采集不良记录 并过站<br/>
        [参数]：empNo-工号,sn-序列号,resource-资源/设备,station-工序,ateNcData-测试结果（格式：OK; 或 NG;NC0A1#NC0A2）<br/>
        [返回]：字符串，成功返回'OK;' 失败返回'NG;NG原因' <br/>
        ")]
        public string CollectATESN(string empNo, string sn, string resource, string station, string ateNcData)
        {
            string msg = "";
            bool isPass = false;
            string result = "";
            try
            {
                if (ateNcData.IndexOf(";") > 0)
                {
                    result = ateNcData.Split(';')[0];
                    if (result == "OK")
                    {
                        isPass = true;
                        ateNcData = "";
                        msg = ateWs.CollectATESN(empNo, sn, resource, station, ateNcData, isPass);
                    }
                    else if (result == "NG")
                    {
                        isPass = false;
                        if (ateNcData.Split(';').Length > 1)
                        {
                            ateNcData = ateNcData.Split(';')[1];
                            msg = ateWs.CollectATESN(empNo, sn, resource, station, ateNcData, isPass);
                        }
                        else
                        {
                            msg = "NG;未找到测试的不良信息！";
                        }
                    }
                    else
                    {
                        msg = "NG;无效的操作标识[非OK;或NG;]！";
                    }

                }
                else
                {
                    msg = "NG;无效的操作标识[非OK;或NG;]！";
                }
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }

            return msg;
        }

        #endregion

        #region ATE自定义功能

        [WebMethod(Description = @"
        方法一（01）<br/>
            &nbsp;&nbsp;[功能]：序号检查<br/>
            &nbsp;&nbsp;[传入参数]：01;工号;序号;工序名称;资源名称;设备编码;工治具编码;<br/>
            &nbsp;&nbsp;[格式]:01;EMP001;SN001;Station001;Res001;MACHINE01;Fixture001;<br/>
            &nbsp;&nbsp;[备注]:工号、序号、工序名称、资源名称不能为空;设备编码为机器编码、工治具为工具编码,可以为空; <br/>
            &nbsp;&nbsp;[补充]:SN可以为主工单条码，也可以是组装的MAC地址,如果是MAC，则找到主SN进行检查。 <br/>
            &nbsp;&nbsp;[返回]：OK;NG;  NG原因; <br/>
        方法二（04）<br/>
            &nbsp;&nbsp;[功能]：测试结果上传（有就传，否则 可以不用）<br/>
            &nbsp;&nbsp;[传入参数]：04;工号;序号;工序名称;资源名称;设备编码;工治具编码; 测试开始时间;检测项1:结果值1,检测项2:结果值2;<br/>
            &nbsp;&nbsp;[格式]:04;EMP001;SN001;Station001;Res001;MachineNo;Fixture001;20181002131019;Test1:99,Test2:38,测试次数:2;<br/>
            &nbsp;&nbsp;[备注]:测试值传出检测项1：结果值1（每个测试项之间用,英文逗号隔开，测试项和测试值之间用英文冒号：）<br/>
            &nbsp;&nbsp;[补充]: 每次最多可以传7个测试项，超过则重新组一个04来传。依此类推补充：SN可以为主工单条码，也可以是组装的MAC地址,如果是MAC，则找到主SN进行检查。           
            &nbsp;&nbsp;[返回]：OK;NG;  NG原因; <br/>
         方法三（05）<br/>
            &nbsp;&nbsp;[功能]：序号过站<br/>
            &nbsp;&nbsp;[传入参数]：<br/>
            &nbsp;&nbsp;&nbsp;&nbsp;05;EMP001;SN001;Station001;Res001;MACHINE01;Fixture001;OK;<br/>
            &nbsp;&nbsp;&nbsp;&nbsp;05;EMP001;SN001;Station001;Res001;MACHINE01;Fixture001;NG;无法开机;<br/>
            &nbsp;&nbsp;[格式]:05;工号;序号;工序名称;资源名称;设备编码;工治具编码;测试结果;不良现象;<br/>
            &nbsp;&nbsp;[备注]:工号、序号、工序、资源名称不能为空;设备编码、工治具编码可以为空，没有时请填写为空，测试结果为必须填写 不良时，不良现象，必须有，只能一个（可挑最重要的传）<br/>
            &nbsp;&nbsp;<span style='color:red'>[注意]：SN属于拼板时，拼板所有子板SN都调用完05接口才会过站</span> <br/>
            &nbsp;&nbsp;[补充]:SN可以为主工单条码，也可以是组装的MAC地址,如果是MAC，则找到主SN进行检查。<br/>           
            &nbsp;&nbsp;[返回]：OK;NG;  NG原因; <br/>
        方法四（101）<br/>
            &nbsp;&nbsp;[功能]：绑定MAC过站<br/>
            &nbsp;&nbsp;[传入参数]：101;工号;序号;工序名称;资源名称;设备编码;工治具编码;MAC地址;<br/>
            &nbsp;&nbsp;[格式]:101;EMP001;SN001;Station001;Res001;MACHINE01;Fixture001;MAC001;<br/>
            &nbsp;&nbsp;[备注]:工号、序号、工序、资源名称不能为空;设备编码、工治具编码可以为空；MAC必须填写，写MAC完成后传输，未完成不要传输。MAC检查其16进制，以及唯一性，<br/>
            &nbsp;&nbsp; &nbsp;&nbsp; 有没有和其它序号绑定过对应工序在mes中采用离线条码绑定UI,设定部件类型为‘Offline_MAC’，MAC校验掩码；<br/>
            &nbsp;&nbsp;[补充]:二次写MAC，如下一工序再传101,SN及新MAC地址，则将替换MAC001为新的MAC地址。<br/>           
            &nbsp;&nbsp;[返回]：OK;NG;  NG原因; <br/>
        方法五(060) <br/>
         &nbsp;&nbsp;[功能]:批量序号过站（生成QC批次）<br/>
         &nbsp;&nbsp;[传入参数]:<br/>
         &nbsp;&nbsp;060;EMPO01;SNO01,SNO02,SN003;Res001;MACHINEO1;Fixture001;OK;<br/>

         &nbsp;&nbsp;[格式]:060;工号;序号;工序名称;资源名称;设备编码;工治具编码;测试结果;<br/>
         &nbsp;&nbsp;[备注]:工号、序号1，序号2(存在批量序号过站)、工序、资源名称不能为空;设备编码、工治具编码可以为空，没有时请填写为空，测试结果为必须填写NG时，NG现象，必须有，只能一个(可挑最重要的传)<br/>
         &nbsp;&nbsp;[补充]:批量序号过站存在生成QC批次号，需做成可配置按维护的过站数量系统自动生成QC批次号检验。<br/>
         &nbsp;&nbsp;[返回]:OK;NG; NG现象;
        ")]
        public string ATECommandCode(string commandString)
        {
            string msg = "";

            try
            {
                msg = ateWs.ATECommandCode(commandString);
            }
            catch (Exception ex)
            {
                msg = ex.Message;      
            }

            return msg;
        }

        #endregion



        /// <summary>
        /// 验证用户名
        /// </summary>
        /// <returns></returns>
        [WebMethod(Description = @"
        [功能]：验证用户名<br/>
        [参数]：UserName-用户名,Password-密码<br/>
        [返回]：字符串，成功返回'OK;' 失败返回'NG;NG原因' <br/>
        ")]
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

        private string SetReturnValue(bool bResult, string errorMsg)
        {
            return string.Format("<ReturnData><RtnString>{0}</RtnString><ErrMsg>{1}</ErrMsg></ReturnData>", bResult ? "1" : "0", errorMsg);
        }

       

        [WebMethod]

        public string WS_EOL_DATA_UPLOAD(string M_MACHINE_NO,
                                    string M_WORKSTATION_SN,
                                    string M_EMP_NO,
                                    string M_MO,
                                    string M_OPERATION,
                                    string M_SATGE,
                                    string M_TEST_MODE,
                                    string M_PRODUCT_SN,
                                    string M_CELL_SN,
                                    string M_QTY,
                                    string M_NG_QTY,
                                    string M_RESULT,
                                    string M_ERROR,
                                    string M_ERROR_QTY,
                                    string M_ERROR_POINT,
                                    string M_ITEMVALUE,
                                    string M_VOLTAGE,
                                    string Param1, string Param2)
        {
            return "";
        }

    }
}
