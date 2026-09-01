using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Text;
using Microsoft.Office.Interop.Excel;
using SKT.LeanMES.ESOP.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Web.AppCode.Utility;
using SKT.Common.Model;
using System.Configuration;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using Newtonsoft.Json;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.SDP.Model;
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// Summary description for UploadHander
    /// </summary>
    public class UploadHander : IHttpHandler, IRequiresSessionState
    {
        int Sequence = 0;
        

        public void ProcessRequest(HttpContext context)
        {
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            var retentity = new UploadFileInfo() { Msg = string.Empty };

            context.Response.ContentType = "text/plain";
            context.Response.Charset = "utf-8";
            HttpPostedFile file = context.Request.Files["file"];
            if (file == null)
            {
                file = context.Request.Files["Filedata"];
            }

            if (file != null)
            {
                var fileName = "";
                fileName = file.FileName;
                var ext = fileName.Substring(fileName.LastIndexOf(".")).ToLower();
                if (!string.IsNullOrWhiteSpace(ext) && !FileValidator.AllowedExtensions.Contains(ext))
                {

                    retentity.Msg = "文件上传失败，文件类型【" + ext + "】不符合系统要求！";
                    retentity.Code = 1;
                    var retJson = JsonConvert.SerializeObject(retentity);
                    context.Response.Write(retJson);
                    return;
                }
            }

            //Add By Alen 2017-08-26 修改此文件，增加通用上传方法，原来此方法只针对ESOP的上传(上传到FTP)
            var actionName = context.Request.QueryString["Action"] == null
                ? context.Request["Action"]
                : context.Request.QueryString["Action"];
            if (!string.IsNullOrEmpty(actionName))
            {
                var savedPath = "";
                if (actionName == "FileUploadEquiment" || actionName == "MouldAnormal" || actionName == "EquipmentTemplateItemFile")
                {

                    savedPath = FileUploadEquiment(context, actionName);
                }
                else if (actionName == "ImportResultData")
                {
                    savedPath = ImportResultData(context);
                }
                else
                {
                    savedPath = FileUpload(context, actionName);
                }

                context.Response.Write(savedPath);
            }
            else
            {
                string ftpUrl = "";

                int ESOPID = Convert.ToInt32(context.Request["ESOPID"]);

                string userName = context.Request["userName"].ToString();
                string fileName = string.Format("{0}_{1}{2}", Path.GetFileNameWithoutExtension(file.FileName).Replace(" ", "_"), DateTime.Now.ToString("yyyyMMddHHmmss"), Path.GetExtension(file.FileName));  // 空格替换成下滑线
                //fileName = StringToPattern(fileName);
                int ESOPFileId = 0;
                string folder = "UploadFiles/ESOP";
                if (ESOPID <= 0)
                {
                    retentity.Msg = "文件上传失败，请先保存ESOP信息！";
                    var retJson = JsonConvert.SerializeObject(retentity);
                    context.Response.Write(retJson);
                    return;
                }

                if (file != null && ESOPID != 0)
                {

                    SKT.LeanMES.ESOP.BLL.FtpServerConfig ftpBll = new LeanMES.ESOP.BLL.FtpServerConfig();
                    SKT.LeanMES.ESOP.Model.FtpServerConfigInfo ftpEntity = ftpBll.GetInfo();
                    if (ftpEntity != null)
                    {
                        try
                        {
                            //if (fileName.Substring(fileName.LastIndexOf(".") + 1) == "pdf")
                            //{
                            //    //保存转码和不转码的文件
                            //    string fileNameEn = System.Web.HttpUtility.UrlEncode(fileName, System.Text.Encoding.GetEncoding("GB2312"));
                            //    UploadUtility.UploadFile(file.InputStream, fileName, ftpEntity.FtpStoreLocation, ftpEntity.FtpServerName, ftpEntity.UserName, ftpEntity.PWD);
                            //    ftpUrl = UploadUtility.UploadFile(file.InputStream, fileNameEn, ftpEntity.FtpStoreLocation, ftpEntity.FtpServerName, ftpEntity.UserName, ftpEntity.PWD);
                            //}
                            //else
                            //{
                            var ext = fileName.Substring(fileName.LastIndexOf(".") + 1).ToLower();

                            if (ext == "xls" || ext == "xlsx")
                            {

                                Stream fssStream = file.InputStream;

                                ftpUrl = ExcelToPdfAchieve(fssStream, fileName, ftpEntity, ext);

                            }
                            else
                            {

                                //验证是否存在文件夹 没有就新建
                                UploadUtility.CheckCreateFolder(ftpEntity.FtpServerName, folder.Split(new char[] { '/' })[0], ftpEntity.UserName,
                                    ftpEntity.PWD, folder);

                                ftpUrl = UploadUtility.UploadFile(file.InputStream, fileName,
                                    folder, ftpEntity.FtpServerName, ftpEntity.UserName,
                                    ftpEntity.PWD);

                            }


                        }
                        catch (Exception ex)
                        {
                            retentity.Msg = "文件上传失败`！\nException:" + ex.Message;
                            var retJson = JsonConvert.SerializeObject(retentity);
                            context.Response.Write(retJson);
                            return;
                        }
                    }

                    if (!string.IsNullOrWhiteSpace(ftpUrl) && ftpUrl != "failed")
                    {
                        fileName = Path.GetFileName(file.FileName);


                        var ext = fileName.Substring(fileName.LastIndexOf(".") + 1).ToLower();
                        if (ext == "xls" || ext == "xlsx")
                        {

                            fileName = fileName.Substring(0, fileName.LastIndexOf('.')) + ".pdf";
                        }

                        var newFlieName = fileName.Substring(0, fileName.LastIndexOf('.')) + ".pdf";
                        string fileSuffix = fileName.Substring(fileName.LastIndexOf(".") + 1);
                        string esopFileName = string.Format("{0}_{1}.{2}", Path.GetFileNameWithoutExtension(fileName), DateTime.Now.ToString("yyyyMMddHHmmss"), fileSuffix);
                        //string esopFileName = string.Format("{0}_{1}", fileName.Substring(fileName.LastIndexOf("\\") + 1), DateTime.Now.ToString("yyyyMMddHHmmss"));
                        string esopName =
                            esopFileName.Substring(0,
                                esopFileName
                                    .LastIndexOf(
                                        ".")); //fileName.Substring(fileName.LastIndexOf("\\") + 1, fileName.Length - fileSuffix.Length + 1);
                        try
                        {
                            ESOPFileInfo entity = new ESOPFileInfo();
                            SKT.LeanMES.ESOP.BLL.ESOPFile bll = new LeanMES.ESOP.BLL.ESOPFile();
                            entity.FileType = fileSuffix;
                            entity.ESOPID = ESOPID;
                            entity.EsopFileName = esopFileName;
                            entity.EsopFileUrl = ftpUrl;
                            entity.EsopFileId = -1;
                            entity.Sequence = Sequence;
                            entity.CreateBy = userName;
                            entity.ModifyBy = userName;
                            ESOPFileId = bll.Edit(entity);
                            Sequence++;

                        }
                        catch (Exception ex)
                        {
                            if (ex.Message == "RecordExists")
                            {
                                retentity.Msg = "文件上传失败！\nException:当前ESOP列表已存在 " + esopFileName + " 文件！";
                                var retJson = JsonConvert.SerializeObject(retentity);
                                context.Response.Write(retJson);
                                return;
                            }
                            else
                            {
                                retentity.Msg = ex.Message;
                                var retJson = JsonConvert.SerializeObject(retentity);
                                context.Response.Write(retJson);
                                return;
                            }
                        }

                        retentity.Result = 0;
                        retentity.Msg = "";
                        retentity.FileName = esopName;
                        retentity.FileType = fileSuffix;
                        retentity.FTPUrl = ftpUrl;
                        retentity.EsopFileName = esopFileName;
                        retentity.ESOPFileId = ESOPFileId;
                        var OKretJson = JsonConvert.SerializeObject(retentity);
                        context.Response.Write(OKretJson);
                    }
                    else
                    {
                        context.Response.Write("0");
                    }
                }
                else
                {
                    context.Response.Write("0");
                }
            }
        }

        /// <summary>
        /// 导入文件结果读取（临时文件, 可以不用将文件上传到FTP）
        /// </summary>
        /// <param name="context"></param>
        /// <returns></returns>
        public string ImportResultData(HttpContext context)
        {
            HttpPostedFile file = context.Request.Files["Filedata"];


            string folder = HttpContext.Current.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/TemporaryFile/");
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }

            string serverPath = folder + file.FileName;
            if (File.Exists(serverPath))
            {
                File.Delete(serverPath);
            }
            file.SaveAs(serverPath);

            System.Data.DataTable dt = new System.Data.DataTable();
            dt.Columns.Add("VendorCode");
            dt.Columns.Add("Grades");

            using (FileStream fsRead = System.IO.File.OpenRead(serverPath))
            {
                NPOI.SS.UserModel.IWorkbook wk = null;
                //获取后缀名
                string extension = serverPath.Substring(serverPath.LastIndexOf(".")).ToString().ToLower();
                //判断是否是excel文件
                if (extension == ".xlsx" || extension == ".xls")
                {
                    //判断excel的版本
                    if (extension == ".xlsx")
                    {
                        wk = new NPOI.XSSF.UserModel.XSSFWorkbook(fsRead);
                    }
                    else
                    {
                        wk = new NPOI.HSSF.UserModel.HSSFWorkbook(fsRead);
                    }

                    //获取第一个sheet
                    NPOI.SS.UserModel.ISheet sheet = wk.GetSheetAt(0);

                    //读取每行,从第二行起
                    for (int r = 1; r <= sheet.LastRowNum; r++)
                    {
                        System.Data.DataRow dr = dt.NewRow();
                        //获取当前行
                        NPOI.SS.UserModel.IRow row = sheet.GetRow(r);

                        if (row.Cells.Count > 0 && NPOIHelper.GetCellValue(row.Cells[0]) != "")
                        {
                            dr["VendorCode"] = NPOIHelper.GetCellValue(row.Cells[0]);
                            dr["Grades"] = NPOIHelper.GetCellValue(row.Cells[1]);
                        }
                        dt.Rows.Add(dr);
                    }
                }
            }
            JsonSerializerSettings setting = new JsonSerializerSettings()
            {
                ReferenceLoopHandling = ReferenceLoopHandling.Ignore
            };
            return JsonConvert.SerializeObject(dt, setting);
        }


        /// <summary>
        /// Excel转Pdf
        /// </summary>
        /// <param name="fssStream"></param>
        /// <param name="fileName"></param>
        /// <param name="ftpEntity"></param>
        /// <returns></returns>
        public string ExcelToPdfAchieve(Stream fssStream, string fileName, FtpServerConfigInfo ftpEntity, string ext)
        {

            string ftpUrl = null;
            try
            {

                byte[] infbytes = new byte[fssStream.Length];

                fssStream.Read(infbytes, 0, infbytes.Length);
                // 设置当前流的位置为流的开始 
                fssStream.Seek(0, SeekOrigin.Begin);

                if (ext == "xls")
                {
                    infbytes = SKT.LeanMES.Web.AppCode.Utility.ExcelToPdf.RenderToXls(infbytes);
                }
                else
                {
                    infbytes = SKT.LeanMES.Web.AppCode.Utility.ExcelToPdf.Render(infbytes);
                }

                string serverPath = HttpContext.Current.Server.MapPath(WebHelper.WebRoot + "/UploadFiles/ESOP/");
                if (!Directory.Exists(serverPath))
                {
                    Directory.CreateDirectory(serverPath);
                }
                string folder = "UploadFiles/ESOP";
                var newFlieName = fileName.Substring(0, fileName.LastIndexOf('.')) + ".pdf";
                FileStream fs1 = new FileStream(@serverPath + newFlieName, FileMode.Create,
                    FileAccess.Write);
                fs1.Write(infbytes, 0, infbytes.Length);
                fs1.Close();

                FileStream fs11 = new FileStream(@serverPath + newFlieName, FileMode.Open,
                    FileAccess.Read);

                //验证是否存在文件夹 没有就新建
                UploadUtility.CheckCreateFolder(ftpEntity.FtpServerName, folder.Split(new char[] { '/' })[0], ftpEntity.UserName,
                    ftpEntity.PWD, folder);

                ftpUrl = UploadUtility.UploadFile(fs11, newFlieName, folder,
                    ftpEntity.FtpServerName, ftpEntity.UserName, ftpEntity.PWD);

                if (ftpUrl != "" && ftpUrl != "failed")
                {
                    DeleteFile(@serverPath + newFlieName);
                    DeleteFile(@serverPath + fileName);
                }

                return ftpUrl;
            }
            catch (Exception ex)
            {
                return "";
            }

        }


        /// <summary>
        /// 删除服务器上的文件
        /// </summary>
        /// <param name="filePath"></param>
        /// <param name="fileName"></param>
        /// <returns></returns>
        public bool DeleteFile(string file)
        {
            try
            {
                if (File.Exists(file))
                {
                    File.Delete(file);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /**/
        /// <summary>  
        /// 把Excel文件转换成pdf文件  
        /// </summary>  
        /// <param name="sourcePath">需要转换的文件路径和文件名称</param>  
        /// <param name="targetPath">转换完成后的文件的路径和文件名名称</param>  
        /// <returns></returns>  
        public static bool ExcelToPdf(string sourcePath, string targetPath)
        {
            bool result = false;

            XlFixedFormatType xlTypePDF = XlFixedFormatType.xlTypePDF; //转换成pdf  
            object missing = Type.Missing;
            Microsoft.Office.Interop.Excel.Application applicationClass = null;
            Workbook workbook = null;
            try
            {
                applicationClass = new Microsoft.Office.Interop.Excel.Application();
                string inputfileName = sourcePath; //需要转格式的文件路径  
                string outputFileName = targetPath; //转换完成后PDF文件的路径和文件名名称  
                XlFixedFormatType xlFixedFormatType = xlTypePDF; //导出文件所使用的格式  
                XlFixedFormatQuality
                    xlFixedFormatQuality =
                        XlFixedFormatQuality.xlQualityMinimum; //1.xlQualityStandard:质量标准，2.xlQualityMinimum;最低质量  
                bool includeDocProperties = true; //如果设置为True，则忽略在发布时设置的任何打印区域。  
                bool openAfterPublish = false; //发布后不打开  
                workbook = applicationClass.Workbooks.Open(inputfileName, missing, missing, missing, missing, missing,
                    missing, missing, missing, missing, missing, missing, missing, missing, missing);
                if (workbook != null)
                {
                    workbook.ExportAsFixedFormat(xlFixedFormatType, outputFileName, xlFixedFormatQuality,
                        includeDocProperties, openAfterPublish, missing, missing, missing, missing);
                }

                result = true;
            }
            catch (Exception ex)
            {

                result = false;
            }
            finally
            {
                if (workbook != null)
                {
                    workbook.Close(true, missing, missing);
                    workbook = null;
                }

                if (applicationClass != null)
                {
                    applicationClass.Quit();
                    applicationClass = null;
                }
            }

            return result;
        }

        public bool IsReusable
        {
            get { return false; }
        }

        /// <summary>
        /// 替换特殊字符为空
        /// </summary>
        /// <param name="Str"></param>
        /// <returns></returns>
        public string StringToPattern(string Str)
        {
            if (Str == "")
                return "";

            string[] c = { "-", "_", "%", "$", "{", "[", "(", "*", "+", "?", "!", "#", "|", ")" };
            for (int i = 0; i < c.Length; i++)
            {
                Str = Str.Replace(c[i], "");
            }

            return Str;
        }

        /// <summary>
        /// 上传文件；wenshun，修改下根据传来的action到不同的目录
        /// </summary>
        /// <param name="context"></param>
        /// <param name="actionName"></param>
        /// <returns></returns>
        private string FileUpload(HttpContext context, string actionName)
        {
            var fileName = "";
            try
            {
                var savePath = "";
                HttpPostedFile file;
                if (string.Equals(actionName, "EquipmentFailure", StringComparison.CurrentCultureIgnoreCase) || string.Equals(actionName, "EquipmentMaintenance", StringComparison.CurrentCultureIgnoreCase) || string.Equals(actionName, "MouldMaintenanceLoad", StringComparison.CurrentCultureIgnoreCase))
                {
                    //设备保修上传文件
                    file = context.Request.Files["file"];
                }
                else
                {
                    file = context.Request.Files["Filedata"] ?? context.Request.Files["file"];
                }
                fileName = file.FileName;

                string inspectionId = context.Request["InspectionId"] == null ? "-1" : context.Request["InspectionId"];
                string inspectionOrderOATemplateDetailId = context.Request["InspectionOrderOATemplateDetailId"] == null ? "-1" : context.Request["InspectionOrderOATemplateDetailId"];
                string fileType = context.Request["fileType"] == null ? "-1" : context.Request["fileType"];

                // HttpPostedFile file = context.Request.Files["Filedata"];
                string userName = context.Request.QueryString["userName"] == null
                    ? context.Request["userName"]
                    : context.Request.QueryString["userName"];
                string folder = "OnlineService/AnormalRCCAFile";
                string datetimeStr = "_" + DateTime.Now.ToString("yyyyMMddHHmmss");
                fileName = string.Format("{0}{1}{2}", Path.GetFileNameWithoutExtension(file.FileName), datetimeStr, Path.GetExtension(file.FileName));
                switch (actionName)
                {
                    case "UploadRCCA":
                        folder = "OnlineService/AnormalRCCAFile";
                        break;
                    case "BurnSoft":  //烧录上传
                        folder = "OnlineService/BurnSoftware";
                        break;
                    case "InspectionFile":
                        folder = "UploadFiles/Inspection";
                        break;
                    case "UploadCustomerLogo":
                        try
                        {
                            Configuration config =
                                System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(HttpContext.Current
                                    .Request.ApplicationPath);
                            AppSettingsSection appseting = (AppSettingsSection)config.GetSection("appSettings");
                            //string isEncrypt = appseting.Settings["CustomerLogo"].Value;
                            var logoPath = WebHelper.WebRoot + "/OnlineService/CustomerLogo/" + fileName;
                            if (appseting.Settings["CustomerLogo"] == null)
                            {
                                config.AppSettings.Settings.Add("CustomerLogo", logoPath);
                            }
                            else
                            {
                                appseting.Settings["CustomerLogo"].Value = logoPath;
                            }

                            config.Save(ConfigurationSaveMode.Modified);
                        }
                        catch (Exception ex)
                        {
                            WebHelper.HandleException(ex);
                            throw ex;
                        }
                        folder = "OnlineService/CustomerLogo/";
                        break;
                    case "UpalodMedia":
                        folder = "OnlineService/CorpWeCat";
                        break;
                    case "ExperimentFile":
                        folder = "UploadFiles/ExperimentFile";
                        break;
                    case "ShippingReport":
                        folder = "UploadFiles/ShippingReport";
                        break;
                    case "TestReport":
                        folder = "UploadFiles/TestReport";
                        break;
                    case "CheckItemFileUpload":
                        folder = "UploadFiles/Inspection";
                        break;
                    case "SalOrder":
                        folder = "UploadFiles/SalOrder";
                        break;
                    case "EquipmentFailure":
                        folder = "UploadFiles/EquipmentFailure";
                        break;
                    case "EquipmentInspectionFile":
                        folder = "UploadFiles/EquipmentInspectionFile";
                        break;
                    case "EquipmentMaintenance":
                        folder = "/UploadFiles/EquipmentMaintenance/";
                        break;
                    case "MouldMaintenanceLoad": //模具保养图片
                        folder = "UploadFiles/MouldMaintenanceLoad";
                        break;
                    case "IPQC":
                        folder = "UploadFiles/IPQCInspection";
                        break;
                    case "FAIInspectionTemplate":
                        folder = "UploadFiles/FAIInspectionTemplate";
                        break;
                    default:
                        break;

                }

                //文件路径
                string urlPath = string.Empty;
                if (file != null)
                {
                    SKT.LeanMES.ESOP.BLL.FtpServerConfig ftpBll = new LeanMES.ESOP.BLL.FtpServerConfig();
                    SKT.LeanMES.ESOP.Model.FtpServerConfigInfo ftpEntity = ftpBll.GetInfo();
                    if (ftpEntity != null)
                    {

                        //验证是否存在文件夹 没有就新建
                        UploadUtility.CheckCreateFolder(ftpEntity.FtpServerName, folder.Split(new char[] { '/' })[0], ftpEntity.UserName,
                            ftpEntity.PWD, folder);

                        urlPath = UploadUtility.UploadFile(file.InputStream, fileName,
                            folder, ftpEntity.FtpServerName, ftpEntity.UserName,
                            ftpEntity.PWD);
                        if (actionName == "EquipmentFailure" || actionName == "EquipmentMaintenance" || actionName == "MouldMaintenanceLoad")
                        {
                            fileName = "{\"code\": 0 ,\"msg\": \"上传成功\" ,\"data\": {\"src\": \"" + urlPath + "\",\"FileName\": \"" + fileName + "\"} }";
                        }

                    }
                }

                switch (actionName)
                {
                    case "EquipmentInspectionFile":
                        if (!string.IsNullOrEmpty(inspectionId))
                        {
                            EquipmentInspectionInfo eiInfo = new EquipmentInspectionInfo();
                            eiInfo.InspectionId = Int32.Parse(inspectionId);
                            eiInfo.ModifyBy = context.Request["userName"];

                            new LeanMES.Equipment.BLL.EquipmentInspectionTemplateItem().UploadTemplateItemFile(eiInfo, Int32.Parse(inspectionOrderOATemplateDetailId), Int32.Parse(fileType), fileName, urlPath);
                            fileName = "{\"code\": 0 ,\"msg\": \"上传成功\" ,\"data\": {\"src\": \"" + urlPath + "\",\"FileName\": \"" + fileName + "\"} }";
                        }

                        break;
                    case "InspectionFile":
                        string InspectionNo = context.Request["InspectionNo"];
                        if (!string.IsNullOrEmpty(InspectionNo))
                        {
                            SKT.LeanMES.Material.BLL.MaterialIQC iqcBll = new LeanMES.Material.BLL.MaterialIQC();
                            SearchSettings setting = new SearchSettings();
                            setting.AddCondition("InspectionNo", InspectionNo);
                            List<Model.MaterialIQCInfo> model = iqcBll.GetAll(0, -1, "InspectionId", setting);
                            if (model.Count > 0)
                            {
                                SKT.LeanMES.ESOP.BLL.ESOPFile bll = new LeanMES.ESOP.BLL.ESOPFile();
                                bll.InsertFile("MaterialIQC", Path.GetExtension(file.FileName).Replace(".", ""),
                                    Path.GetFileName(file.FileName), fileName,
                                    urlPath, model[0].InspectionId,
                                    model[0].InspectionNo, userName);
                            }
                        }

                        break;
                    case "ExperimentFile":
                        SKT.LeanMES.ESOP.BLL.ESOPFile ESOPFileBll = new LeanMES.ESOP.BLL.ESOPFile();
                        ESOPFileBll.InsertFile("ExperimentFile", Path.GetExtension(file.FileName).Replace(".", ""),
                            file.FileName, fileName,
                            urlPath,
                            Convert.ToInt32(context.Request["applyID"]), context.Request["InspectionNo"], userName);

                        break;
                    case "ShippingReport":
                        string txtBuyNO = context.Request["txtBuyNO"];
                        if (!string.IsNullOrEmpty(txtBuyNO))
                        {
                            SKT.LeanMES.Material.BLL.PurOrder purOrderBll = new LeanMES.Material.BLL.PurOrder();
                            SearchSettings setting = new SearchSettings();
                            setting.ExtensionCondition = " PoCode='" + txtBuyNO + "'";
                            List<PurOrderInfo> model = purOrderBll.GetPurOrderList(0, -1, "PurOrderId", setting);

                            if (model.Count > 0)
                            {
                                SKT.LeanMES.ESOP.BLL.ESOPFile bll = new LeanMES.ESOP.BLL.ESOPFile();
                                bll.InsertFile("ShippingReport", Path.GetExtension(file.FileName).Replace(".", ""),
                                    Path.GetFileName(file.FileName), fileName,
                                    urlPath, model[0].PurOrderId,
                                    model[0].POCode, userName);
                            }
                        }

                        break;
                    case "TestReport":
                        string txtBuyNO2 = context.Request["txtBuyNO"];
                        if (!string.IsNullOrEmpty(txtBuyNO2))
                        {
                            SKT.LeanMES.Material.BLL.PurOrder purOrderBll2 = new LeanMES.Material.BLL.PurOrder();
                            SearchSettings setting = new SearchSettings();
                            setting.ExtensionCondition = " PoCode='" + txtBuyNO2 + "'";
                            List<PurOrderInfo> model = purOrderBll2.GetPurOrderList(0, -1, "PurOrderId", setting);

                            if (model.Count > 0)
                            {
                                SKT.LeanMES.ESOP.BLL.ESOPFile bll = new LeanMES.ESOP.BLL.ESOPFile();
                                bll.InsertFile("TestReport", Path.GetExtension(file.FileName).Replace(".", ""),
                                    file.FileName, fileName,
                                    urlPath, model[0].PurOrderId,
                                    model[0].POCode, userName);
                            }
                        }

                        break;
                    case "CheckItemFileUpload":
                        string id = context.Request["Id"];
                        if (!string.IsNullOrEmpty(id))
                        {
                            //修改结果表的文件地址字段
                            LeanMES.Material.BLL.MaterialIQC iqcBll = new LeanMES.Material.BLL.MaterialIQC();
                            iqcBll.UpdateInspectionItemFilePath(string.Format("{0}/{1}/", WebHelper.WebRoot, folder) + fileName, Convert.ToInt32(id));


                            SKT.LeanMES.ESOP.BLL.ESOPFile bll = new LeanMES.ESOP.BLL.ESOPFile();
                            bll.InsertFile("InspectionItemReport", Path.GetExtension(file.FileName).Replace(".", ""),
                                Path.GetFileName(file.FileName), fileName,
                                urlPath, Convert.ToDecimal(id), id,
                                userName);
                            fileName = "{\"code\": 0 ,\"msg\": \"上传成功\" ,\"data\": {\"src\": \"" + urlPath + "\",\"FileName\": \"" + fileName + "\"} }";

                        }

                        break;
                    case "SalOrder":

                        string salOrderID = context.Request["salOrderID"];

                        if (!string.IsNullOrEmpty(salOrderID))
                        {
                            SKT.LeanMES.Warehouse.BLL.WarehouseCpOutStock bll =
                                new SKT.LeanMES.Warehouse.BLL.WarehouseCpOutStock();
                            bll.CPOutStockUploadFile(Convert.ToInt32(salOrderID), file.FileName,
                                Path.GetExtension(file.FileName).Replace(".", ""), fileName,
                                urlPath, userName);
                        }

                        break;

                    case "MouldMaintenanceLoad":

                        string MouldMaintenanceId = context.Request["ID"];
                        if (!string.IsNullOrEmpty(MouldMaintenanceId) && MouldMaintenanceId != "-1")
                        {
                            MouldOperateRecord bll = new MouldOperateRecord();

                            bll.MouldMaintenanceUploadFile(Convert.ToInt32(MouldMaintenanceId), file.FileName, Path.GetExtension(file.FileName).Replace(".", ""), fileName, urlPath, userName);
                        }
                        break;
                    case "IPQC":
                        SKT.LeanMES.ESOP.BLL.ESOPFile blls = new LeanMES.ESOP.BLL.ESOPFile();
                        string FormCode = context.Request["OrderON"];
                        decimal ID = Convert.ToDecimal(context.Request["Id"]);
                        blls.InsertFile("InspectionIPQCFile", Path.GetExtension(file.FileName).Replace(".", ""), file.FileName, fileName, urlPath, ID, FormCode, userName);
                        fileName = "{\"code\":0,\"fileName\":\"" + fileName + "\"}";
                        break;
                    case "FAIInspectionTemplate":
                        SKT.LeanMES.ESOP.BLL.ESOPFile eSOP = new LeanMES.ESOP.BLL.ESOPFile();
                        decimal FAIID = Convert.ToDecimal(context.Request["InspectionTemplateId"]);
                        eSOP.InsertFile("FAIInspectionTemplate", Path.GetExtension(file.FileName).Replace(".", ""), file.FileName, fileName, urlPath, FAIID, "", userName);
                        fileName = "{\"code\":0,\"FileName\":\"" + file.FileName + "\",\"EsopFileName\":\"" + fileName + "\"}";
                        break;
                }

            }
            catch (Exception ex)
            {
                if (actionName == "EquipmentFailure" || actionName == "CheckItemFileUpload" || actionName == "EquipmentInspectionFile" || actionName == "EquipmentMaintenance" || actionName == "MouldMaintenanceLoad")
                {
                    fileName = "{\"code\": 1 ,\"msg\": \"上传失败" + ex.Message + "\" ,\"data\": {\"src\": \"\"} }";
                }
            }
            return fileName;
        }



        /// <summary>
        /// 上传设备文件 zhuxi add 20171017
        /// </summary>
        /// <param name="context"></param>
        /// <param name="actionName"></param>
        /// <returns></returns>
        private string FileUploadEquiment(HttpContext context, string actionName)
        {
            var savePath = "";
            HttpPostedFile file = context.Request.Files["file"];
            string fileName = string.Format("{0}{1}{2}", Path.GetFileNameWithoutExtension(file.FileName), "_" + DateTime.Now.ToString("yyyyMMddHHmmss"), Path.GetExtension(file.FileName));
            ;
            var dir = "";

            switch (actionName)
            {
                case "FileUploadEquiment":
                    dir = "UploadFiles/EQPicture";
                    break;
                case "MouldAnormal": //模具异常图片
                    dir = "UploadFiles/MouldAnormalPicture";
                    break;
                case "EquipmentTemplateItemFile": //点检模板图片
                    dir = "UploadFiles/ESOP";
                    break;

            }
            var json = "";
            try
            {
                if (file != null)
                {
                    SKT.LeanMES.ESOP.BLL.FtpServerConfig ftpBll = new LeanMES.ESOP.BLL.FtpServerConfig();
                    SKT.LeanMES.ESOP.Model.FtpServerConfigInfo ftpEntity = ftpBll.GetInfo();
                    if (ftpEntity != null)
                    {
                        try
                        {
                            //验证是否存在文件夹 没有就新建
                            UploadUtility.CheckCreateFolder(ftpEntity.FtpServerName, "UploadFiles", ftpEntity.UserName,
                                ftpEntity.PWD, dir);

                            savePath = UploadUtility.UploadFile(file.InputStream, fileName,
                                dir, ftpEntity.FtpServerName, ftpEntity.UserName,
                                ftpEntity.PWD);
                        }
                        catch (Exception ex)
                        {
                            json = "{\"code\": 1 ,\"msg\": \"上传失败\" ,\"data\": {\"src\": \"\"} }";
                        }
                    }
                }

                json = "{\"code\": 0 ,\"msg\": \"上传成功\" ,\"data\": {\"src\": \"" + savePath + "\",\"FileName\": \"" + fileName + "\"} }";

            }
            catch (Exception ex)
            {
                json = "{\"code\": 1 ,\"msg\": \"上传失败\" ,\"data\": {\"src\": \"\"} }";
            }



            return json;
        }



    }

    // <summary>
    /// 文件上传信息
    /// </summary>
    public class UploadFileInfo
    {
        /// <summary>
        /// 上传结果
        /// </summary>
        public int Result { get; set; }

        /// <summary>
        /// 消息
        /// </summary>
        public string Msg { get; set; }
        /// <summary>
        /// SN
        /// </summary>
        public string SN { get; set; }

        /// <summary>
        /// 原始文件名称
        /// </summary>
        public string FileName { get; set; }

        /// <summary>
        /// 文件类型
        /// </summary>
        public string FileType { get; set; }

        /// <summary>
        /// 服务器中的文件名
        /// </summary>
        public string ServerFileName { get; set; }

        /// <summary>
        /// 服务器中的文件路径
        /// </summary>
        public string ServerFilePath { get; set; }

        /// <summary>
        /// FTP地址
        /// </summary>
        public string FTPUrl { get; set; }

        /// <summary>
        /// ESOP文件名称
        /// </summary>
        public string EsopFileName { get; set; }

        /// <summary>
        /// ESOP文件ID
        /// </summary>
        public int ESOPFileId { get; set; }

        public int Code { get; set; }

    }
}