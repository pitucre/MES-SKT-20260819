using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.ESOP.Model;
using SKT.Common.Model;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;
using SKT.LeanMES.ESOP.BLL;
using SKT.LeanMES.Station.Model;
using SKT.LeanMES.Station.BLL;
using SKT.LeanMES.Web.AppCode.Utility;
using System.IO;
namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEsop
    {
        /// <summary>
        /// 根据ESOP主键ID获取ESOP有关信息
        /// </summary>
        /// <param name="EsopID">ESOP主键ID</param>
        /// <returns>Esop表列表</returns>
        [AjaxMethod]
        public List<ESOPInfo> GetEsopByID(int EsopID)
        {
            SKT.LeanMES.ESOP.BLL.ESOP esop = new SKT.LeanMES.ESOP.BLL.ESOP();
            SearchSettings search = new SearchSettings();
            search.AddCondition("ESOPID", EsopID.ToString());
            return esop.GetAll(0, -1, "", search);
        }

        [AjaxMethod]
        public List<ItemInfo> GetItemByCode(string itemcode)
        {
            Item item = new Item();
            SearchSettings search = new SearchSettings();
            search.AddCondition("ItemCode", itemcode);
            return item.GetAll(0, -1, "", search);
        }

        /// <summary>
        /// 删除单个文件
        /// </summary>
        /// <param name="fileUrl"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void DeleteEsopFile(int esopfileId, string fileUrl)
        {

            SKT.LeanMES.ESOP.BLL.FtpServerConfig ftpBll = new LeanMES.ESOP.BLL.FtpServerConfig();
            SKT.LeanMES.ESOP.Model.FtpServerConfigInfo ftpEntity = ftpBll.GetInfo();
            ESOPFile filebll = new ESOPFile();

            try
            {
                filebll.Delete(esopfileId.ToString(), AccountController.GetCurrentUser().UserName);
                UploadUtility.DeleteFile(fileUrl, ftpEntity.UserName, ftpEntity.PWD);
            }
            catch
            {

            }


        }

        [AjaxMethod]
        public List<ItemInfo> GetSelectedItem(string itemIds)
        {
            List<ItemInfo> list = new List<ItemInfo>();
            Item itembll = null;
            string[] ids = itemIds.Split(',');
            for (int i = 0; i < itemIds.Length; i++)
            {
                ItemInfo info = itembll.GetInfo(Convert.ToInt32(ids[i]));
                list.Add(info);
            }
            return list;
        }

        /// <summary>
        /// 保存ESOP及file,item信息
        /// </summary>
        /// <param name="esopId"></param>
        /// <param name="esopName"></param>
        /// <param name="stationId"></param>
        /// <param name="eFileList"></param>
        /// <param name="eFileItemList"></param>
        [AjaxMethod]
        public void EsopFileSave(int esopId, string esopName, int stationId, List<ESOPFileInfo> eFileList, List<ESOPFileItemRelation> eFileItemList)
        {
            ESOPInfo info = new ESOPInfo();
            info.ESOPID = esopId;
            info.ESOPName = esopName;
            info.StationId = stationId;
            info.Remark = "";
            info.FileList = eFileList;
            info.FileItemList = eFileItemList;
            info.CreateBy = AccountController.GetCurrentUser().UserName;
            info.ModifyBy = "";
            SKT.LeanMES.ESOP.BLL.ESOP bll = new LeanMES.ESOP.BLL.ESOP();
            bll.Edit(info);
        }
        /// <summary>
        /// 编辑的时候加载文件列表
        /// </summary>
        /// <param name="esopId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ESOPFileInfo> GetESOPFiles(int esopId)
        {
            SKT.LeanMES.ESOP.BLL.ESOPFile bll = new LeanMES.ESOP.BLL.ESOPFile();
            SearchSettings searchs = new SearchSettings();
            searchs.ExtensionCondition = "ESOPID=" + esopId.ToString();
            return bll.GetAll(0, -1, "", searchs).OrderBy(it=>it.Sequence).ToList();
        }

        /// <summary>
        /// 编辑的时候加载已选的产品
        /// </summary>
        /// <param name="esopId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ItemInfo> GetESOPItems(int esopId)
        {
            Item bll = new Item();
            SearchSettings searchs = new SearchSettings();
            searchs.AddCondition("pef.ESOPID", esopId.ToString());
            return bll.GetESOPItems(searchs);
        }

        /// <summary>
        /// 删除整个ESOP
        /// </summary>
        /// <param name="esopId"></param>
        [AjaxMethod]
        public void DeleteESOP(int esopId)
        {
            SKT.LeanMES.ESOP.BLL.ESOP bll = new LeanMES.ESOP.BLL.ESOP();
            bll.Delete(esopId, AccountController.GetCurrentUser().UserName);
        }


        /// <summary>
        ///保存Esop主表信息及ESOP和产品Item关系
        /// </summary>
        /// <param name="stationId">工序ID</param>
        /// <param name="esopName">Esop名称</param>
        /// <param name="CutTime">切屏时间</param>
        /// <param name="ItemIDString">选中的产品ID</param>
        /// <param name="UserName">创建人</param>
        /// <returns></returns>
        [AjaxMethod]
        public int SaveEsopInItem(int esopId, int stationId, string esopName, int CutTime, string ItemIDString)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                SKT.LeanMES.ESOP.BLL.ESOP bll = new LeanMES.ESOP.BLL.ESOP();
                return bll.SaveEsopInItem(esopId, stationId, esopName, CutTime, ItemIDString, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return 0;
        }

        /// <summary>
        /// 保存esop上传文件
        /// </summary>
        /// <param name="entity">esop上传文件信息实体</param>
        [AjaxMethod]
        public void SaveEsopFile(ESOPFileInfo entity)
        {
            try
            {
                SKT.LeanMES.ESOP.BLL.ESOPFile bll = new LeanMES.ESOP.BLL.ESOPFile();
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 保存ESOP数据
        /// </summary>
        /// <param name="esopId">主键ID</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="esopName">ESOP名称</param>
        /// <param name="CutTime">切屏时间</param>
        [AjaxMethod]
        public int SaveEsop(int esopId, int stationId, string esopName, int CutTime)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                SKT.LeanMES.ESOP.BLL.ESOP bll = new LeanMES.ESOP.BLL.ESOP();
                return bll.SaveEsop(esopId, stationId, esopName, CutTime, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return -1;
        }

        /// <summary>
        /// 删除esop产品关系
        /// </summary>
        /// <param name="stationId">工序</param>
        /// <param name="esopName">esop名称</param>
        /// <param name="ItemIDString">产品ID</param>
        [AjaxMethod]
        public void RemoveEsopOutItem(int stationId, string esopName, string ItemIDString)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                SKT.LeanMES.ESOP.BLL.ESOP bll = new LeanMES.ESOP.BLL.ESOP();
                bll.RemoveEsopOutItem(stationId, esopName, ItemIDString, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 根据条件获取esop
        /// </summary>
        /// <param name="operationId">工序</param>
        /// <param name="resId">资源</param>
        /// <returns>esop文件信息列表</returns>
        [AjaxMethod]
        public List<ESOPFileInfo> GetEsopListByField(int operationId, int resId)
        {
            try
            {
                SKT.LeanMES.ESOP.BLL.ESOP esop = new SKT.LeanMES.ESOP.BLL.ESOP();

                return esop.GetEsopListByField(operationId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public void EsopFileSquenceEdit(int oldFileId, int newFileId, int oldSquence, int newSquence)
        {
            try
            {
                SKT.LeanMES.ESOP.BLL.ESOPFile esop = new SKT.LeanMES.ESOP.BLL.ESOPFile();
                SearchSettings search = new SearchSettings();
                esop.EsopFileSquenceEdit(oldFileId, newFileId, oldSquence, newSquence);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 缓存ESOP文件（PDF）
        /// </summary>
        /// <param name="fileName"></param>
        [AjaxMethod]
        public void GetFtpConfigInfo(string fileName)
        {
            try
            {
                SKT.LeanMES.Web.ESOP.DownLoad download = new ESOP.DownLoad();
                download.GetFtpConfigInfo(fileName, "/UploadFiles/ESOP");
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void GetFtpConfigInfoByFAI(string fileName)
        {
            try
            {
                SKT.LeanMES.Web.ESOP.DownLoad download = new ESOP.DownLoad();
                download.GetFtpConfigInfo(fileName, "/UploadFiles/FAIInspectionTemplate");
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 删除缓存ESOP文件（PDF）
        /// </summary>
        /// <param name="fileName"></param>
        [AjaxMethod]
        public void DeleteFtpFile(string fileName)
        {
            try
            {
                SKT.LeanMES.Web.ESOP.DownLoad download = new ESOP.DownLoad();
                download.DeleteCacheFile(fileName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取ESOP工序信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<StationInfo> GetESOPStationInfo()
        {
            List<StationInfo> list = null;
            try
            {
                list = (new StationType()).GetESOPStationInfo();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 根据Operation Id 取得资源
        /// </summary>
        /// <param name="oprId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SKT.LeanMES.Resource.Model.ResourceInfo> GetEsopResourceByOpeId(int oprId)
        {
            List<SKT.LeanMES.Resource.Model.ResourceInfo> list = null;
            try
            {
                list = (new SKT.LeanMES.Resource.BLL.Resource()).GetEsopResourceByOpeId(oprId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取MAC信息
        /// </summary>
        /// <param name="mac"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ESOPMacInfo GetMacInfo(string mac)
        {
            ESOPMacInfo entity = new ESOPMacInfo();
            try
            {
                SKT.LeanMES.ESOP.BLL.ESOPMac esop = new SKT.LeanMES.ESOP.BLL.ESOPMac();
                entity = esop.GetInfo(mac);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 编辑ESOP设备信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void ESOPMacEdit(ESOPMacInfo entity)
        {
            try
            {
                if (entity.ESOPMacId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                SKT.LeanMES.ESOP.BLL.ESOPMac bll = new LeanMES.ESOP.BLL.ESOPMac();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 编辑ESOP显示信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EsopLineEdit(ESOPLineInfo entity)
        {
            string userName = AccountController.GetCurrentUserInfo().UserName;
            try
            {
                if (entity.ESOPLineId == -1)
                {
                    entity.CreateBy = userName;
                    entity.CreateDate = DateTime.Now;

                    entity.ModifyBy = "";
                    entity.ModifyDate = Convert.ToDateTime("9999-12-31");
                }
                else
                {
                    entity.CreateBy = "";
                    entity.CreateDate = Convert.ToDateTime("9999-12-31");

                    entity.ModifyBy = userName;
                    entity.ModifyDate = DateTime.Now;
                }
                SKT.LeanMES.ESOP.BLL.ESOPLine bll = new LeanMES.ESOP.BLL.ESOPLine();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 设置默认ESOP工序
        /// </summary>
        /// <param name="mac"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void SetDefaultEsopStation(string mac, int stationId, int resId)
        {
            try
            {
                SKT.LeanMES.ESOP.BLL.ESOPMac bll = new LeanMES.ESOP.BLL.ESOPMac();
                bll.SetDefaultEsopStation(mac, stationId, resId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 验证文件是否存在,存在则返回文件物理路径
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="actionName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string LocalFileExists(string fileName, string actionName)
        {
           
            string filePath = string.Empty;
            string folder = string.Empty;
            if (!string.IsNullOrEmpty(fileName))
            {
                switch (actionName)
                {
                    case "UploadRCCA":
                        folder = "/OnlineService/AnormalRCCAFile";
                        break;
                    case "BurnSoft":
                        folder = "/OnlineService/BurnSoftware";
                        break;
                    case "InspectionFile":
                        folder = "/UploadFiles/Inspection";
                        break;
                    case "UploadCustomerLogo":
                        folder = "/OnlineService/CustomerLogo/";
                        break;
                    case "UpalodMedia":
                        folder = "/OnlineService/CorpWeCat";
                        break;
                    case "ExperimentFile":
                        folder = "/UploadFiles/ExperimentFile";
                        break;
                    case "ShippingReport":
                        folder = "/UploadFiles/ShippingReport";
                        break;
                    case "TestReport":
                        folder = "/UploadFiles/TestReport";
                        break;
                    case "CheckItemFileUpload":
                        folder = "/UploadFiles/ShippingReport";
                        break;
                    case "SalOrder":
                        folder = "/UploadFiles/SalOrder";
                        break;
                    case "FileUploadEquiment":
                        folder = "/UploadFiles/EQPicture";
                        break;
                    case "MouldAnormal":
                        folder = "/UploadFiles/MouldAnormalPicture";
                        break;
                    case "EquFile":
                        folder = "/UploadFiles/EQFile";
                        break;
                    case "EquipmentFailure":
                        folder = "/UploadFiles/EquipmentFailure";
                        break;
                    case "FAIInspectionTemplate":
                        folder = "UploadFiles/FAIInspectionTemplate";
                        break;
                    default:
                        folder = "/UploadFiles/ESOP";
                        break;

                }
                string serverPath = HttpContext.Current.Server.MapPath(WebHelper.WebRoot + folder + "/" + fileName);
                if (File.Exists(serverPath))
                {
                    filePath = WebHelper.WebRoot + folder + "/" + fileName;
                }
            }
            return filePath; ;
        }

    }
}