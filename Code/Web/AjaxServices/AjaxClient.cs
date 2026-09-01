using System;
using System.Collections.Generic;
using System.Web;
using AjaxPro;
using System.Text;
using SKT.LeanMES.Process;
using SKT.LeanMES.ProdUnit.Model;
using SKT.LeanMES.Container.Model;
using SKT.LeanMES.Container.BLL;
using SKT.LeanMES.PackPrint.BLL;
using SKT.LeanMES.PackPrint.Model;
using SKT.LeanMES.Product.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxClient
    {
        /// <summary>
        /// 执行业务
        /// </summary>
        /// <param name="routerId"></param>
        /// <param name="operationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string OutputExecuteActivity(Int32 routerId, Int32 operationId)
        {
            StringBuilder sb = new StringBuilder();
            List<SKT.LeanMES.Router.Model.ActivityInfo> list = (new SKT.LeanMES.Router.BLL.Activity()).GetActivityCode(routerId, operationId);
            if (list.Count > 0)
            {
                for (int i = 0; i < list.Count; i++)
                {
                    sb.Append(list[i].AC_FunctionCode);
                }
            }
            return sb.ToString();
        }

        /// <summary>
        /// 根据路由id和工序找到对应Activity
        /// </summary>
        /// <param name="routerId"></param>
        /// <param name="operationId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string OutputActivityFunction(Int32 routerId, Int32 operationId)
        {
            Dictionary<string, List<string>> dict = new Dictionary<string, List<string>>();
            List<string> listValue = null;

            List<SKT.LeanMES.Router.Model.ActivityInfo> list = (new SKT.LeanMES.Router.BLL.Activity()).GetActivityFunction(routerId, operationId);
            if (list.Count > 0)
            {
                for (int i = 0; i < list.Count; i++)
                {
                    if (dict.ContainsKey(list[i].AC_FunctionName))
                    {
                        ((List<string>)dict[list[i].AC_FunctionName]).Add(list[i].AC_Param_Value);
                    }
                    else
                    {
                        listValue = new List<string>();
                        listValue.Add(list[i].AC_Param_Value);
                        dict.Add(list[i].AC_FunctionName, listValue);
                    }
                }
            }
            StringBuilder sb = new StringBuilder();
            foreach (string key in dict.Keys)
            {
                listValue = dict[key];
                sb.Append(key + "(");
                for (int i = 0; i < listValue.Count; i++)
                {
                    sb.Append("'" + listValue[i] + "'");
                    if (i != listValue.Count - 1)
                    {
                        sb.Append(", ");
                    }
                }
                sb.Append(");");
            }
            return sb.ToString();
        }

        /// <summary>
        /// 获取资源
        /// </summary>
        /// <param name="resClass"></param>
        /// <param name="resKey"></param>
        /// <returns></returns>
        [AjaxMethod]
        public String GetResourceString(string resClass, string resKey)
        {
            string str = "";

            HttpCookie cookie = HttpContext.Current.Request.Cookies["lang"];
            string lang = cookie == null ? "zh-cn" : cookie.Value;
            Object resource = HttpContext.GetGlobalResourceObject(resClass, resKey, new System.Globalization.CultureInfo(lang));
            if (resource != null)
            {
                str = resource.ToString();
            }
            return str;
        }

        /// <summary>
        /// 某用户是否有某权限
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="popedom">权限</param>
        /// <returns></returns>
        [AjaxMethod]
        public Boolean IsPermission(int userId, int popedom)
        {
            return SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(userId, popedom);
        }

        /// <summary>
        /// 获取所有的Operation Type
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<SKT.LeanMES.Station.Model.StationInfo> GetOperationTypeByUser(string username, int id, bool isGetOperationType)
        {
            List<SKT.LeanMES.Station.Model.StationInfo> list = null;
            try
            {
                list = (new SKT.LeanMES.Station.BLL.StationType()).GetOperationTypeByUser(username, id, isGetOperationType);
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
        public List<SKT.LeanMES.Resource.Model.ResourceInfo> GetResourcesByOprId(int oprId, string username)
        {
            List<SKT.LeanMES.Resource.Model.ResourceInfo> list = null;
            try
            {
                list = (new SKT.LeanMES.Resource.BLL.Resource()).GetResourcesByOprId(oprId, username);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取工位模板
        /// </summary>
        /// <param name="opeTypeId">工位类型ID</param>
        /// <param name="opeId">工位ID</param>
        /// <returns>如果工位没有绑定模板则返回工位类型绑定的模板</returns>
        [AjaxMethod]
        public string GetTmplContentByOpeTypeId(int opeTypeId, int opeId)
        {
            string s = "";
            try
            {
                s = new SKT.LeanMES.Station.BLL.Template().GetTmplContentByOpeTypeId(opeTypeId, opeId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return s;
        }

        /// <summary>
        /// 获取服务器时间
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string getDBDateTime()
        {
            string dbTime = "";
            try
            {
                dbTime = (new Process.ProcessValidation()).getDBDateTime().ToString();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return dbTime;
        }

        /// <summary>
        /// 产品序列号的流程验证
        /// </summary>
        /// <param name="strSN">产品序列号</param>
        /// <param name="opeID">操作工位</param>
        /// <param name="userID">操作用户ID</param>
        /// <param name="ResID">资源ID</param>
        /// <returns></returns>
        [AjaxMethod]
        public int SNProcessValidation(string strSN, int opeID, int userID, int ResID)
        {
            int intResult = 0;
            try
            {
                intResult = (new ProcessValidation()).SNProcessValidate(strSN, opeID, userID, ResID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return intResult;
        }
        #region 仅限于彩盒包装工位验证
        /// <summary>
        /// 产品序列号的流程验证
        /// </summary>
        /// <param name="strSN">产品序列号</param>
        /// <param name="opeID">操作工位</param>
        /// <param name="userID">操作用户ID</param>
        /// <param name="ResID">资源ID</param>
        /// <returns></returns>
        [AjaxMethod]
        public int SNColorPackValidate(string strSN, int opeID, int userID, int ResID)
        {
            int intResult = 0;
            try
            {
                intResult = (new ProcessValidation()).SNColorPackValidate(strSN, opeID, userID, ResID);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return intResult;
        }
        #endregion
        /// <summary>
        /// 获取产品序列号信息
        /// </summary>
        /// <param name="strSN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ProdUnitInfo GetUnitInfo(string strSN)
        {
            ProdUnitInfo entity = null;
            try
            {
                entity = (new ProdUnit.BLL.ProdUnit()).GetProdUnitInfo(strSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 扫描序列号操作完成
        /// </summary>
        /// <param name="unitID"></param>
        /// <param name="opeID"></param>
        /// <param name="isPass"></param>
        /// <param name="lineID"></param>
        /// <param name="userID"></param>
        /// <param name="resID"></param>
        /// <param name="enterTime"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void UnitComplete(Int64 unitID, int opeID, bool isPass, int lineID, int userID, int resID, string enterTime)
        {
            try
            {
                (new ProcessValidation()).UnitComplete(unitID, opeID, isPass, lineID, userID, resID, Convert.ToDateTime(enterTime));
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /*获得数据库服务器时间*/
        [AjaxMethod]
        public string getServerDateTime()
        {
            try
            {
                return DateTime.Now.ToString();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }
        /// <summary>
        /// 执行彩盒包装存储过程返回包装信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="carTon"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ColorBoxPackingInfo> GetColorPackingInfo(String grn, String carTon, String userName, Int32 itemId)
        {
            List<ColorBoxPackingInfo> list = null;
            try
            {
                list = (new ColorBoxPacking()).GetColorPackingInfo(grn, carTon, userName, itemId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 关闭和打开包装箱
        /// </summary>
        /// <param name="carTon"></param>
        /// <param name="userName"></param>
        /// <param name="flag"></param>
        [AjaxMethod]
        public void DoColoseOrOpenColorPack(String carTon, String userName, Int32 flag)
        {
            try
            {
                (new ColorBoxPacking()).DoColoseOrOpenColorPack(carTon, userName, flag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 获取彩盒内已包装的物料列表
        /// </summary>
        /// <param name="cartonsn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ColorBoxPackingInfo> GetPackedItemList(string cartonsn)
        {
            List<ColorBoxPackingInfo> list = null;
            try
            {
                list = (new ColorBoxPacking()).GetPackedItemList(cartonsn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 从彩盒包装箱内移除GRN
        /// </summary>
        /// <param name="cartonsn"></param>
        /// <param name="grnsn"></param>
        [AjaxMethod]
        public void RemoveGRN(string cartonsn, string grnsn, string allUnitId)
        {
            try
            {
                (new ColorBoxPacking()).RemoveGRN(cartonsn, grnsn, AccountController.GetCurrentUser().UserName, allUnitId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public ProdUnitInfo GetUnitInfoByResId(int resId, string sn)
        {
            ProdUnitInfo model = null;
            try
            {
                model = (new ProdUnit.BLL.ProdUnit()).GetUnitInfoByResId(resId, sn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;
        }


        /// <summary>
        /// 保存维修记录 如果有组件变更保存组装信息，以及部件变更记录。
        /// zhibin.chen 2015-09-09
        /// </summary>
        /// <param name="SerialNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void SynthesisRepairPartsChange(int unitId, int opeId, int resId, int userId, string data, int bomId, string assyDataChangeRecords)
        {
            try
            {
                System.Data.SqlClient.SqlParameter[] parms = new System.Data.SqlClient.SqlParameter[]{
                    new System.Data.SqlClient.SqlParameter("@unitid",System.Data.SqlDbType.Int),
                    new System.Data.SqlClient.SqlParameter("@opeid",System.Data.SqlDbType.Int),
                    new System.Data.SqlClient.SqlParameter("@resid",System.Data.SqlDbType.Int),
                    new System.Data.SqlClient.SqlParameter("@userid",System.Data.SqlDbType.Int),
                    new System.Data.SqlClient.SqlParameter("@data",System.Data.SqlDbType.NVarChar,2000),
                    new System.Data.SqlClient.SqlParameter("@BOMID",System.Data.SqlDbType.Int),
                    new System.Data.SqlClient.SqlParameter("@AssyDataChangeRecords",System.Data.SqlDbType.Xml)

                };

                parms[0].Value = unitId;
                parms[1].Value = opeId;
                parms[2].Value = resId;
                parms[3].Value = userId;
                parms[4].Value = data;
                parms[5].Value = bomId;
                parms[6].Value = assyDataChangeRecords;


                SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, "uspSynthesisRepairPartsChange", parms);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// add zhibin.chen 2015-11-25  当提示工位错误的时候，获取下一个工位展示给用户参考。
        /// </summary>
        /// <param name="sn"></param>
        /// <returns>下一工位的组合体</returns>
        [AjaxMethod]
        public string GetNextOperation(string sn)
        {
            string nextOperation = "";
            try
            {
                nextOperation = (new SKT.LeanMES.Manufacture.BLL.InfoCenter()).GetFlowPathInfo(sn).NextOperation;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return nextOperation;
        }

        /// <summary>
        /// 扫条码过捆包装工位（取得下一个扫的部件名称）
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ShipmentListConfigInfo> GetProdBalePackingGetInfo(string ItemSN)
        {
            List<ShipmentListConfigInfo> list = null;
            try
            {
                list = (new ShipmentListConfig()).GetProdBalePackingGetInfo(ItemSN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 扫条码过捆包装工位（扫描部件取得新的部件SN）
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ShipmentListConfigInfo> GetProdBalePackingScanBom(string ItemSN, string BomSn, int num)
        {
            List<ShipmentListConfigInfo> list = null;
            try
            {
                list = (new ShipmentListConfig()).GetProdBalePackingScanBom(ItemSN, BomSn, num);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        /// <summary>
        /// 扫条码过捆包装工位（扫描部件取得新的部件SN）
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void EditProdBalePackingScanBom(int ProductItemId, int ProductUID, string userName, string partBarCodes)
        {
            try
            {
                (new ShipmentListConfig()).EditProdBalePackingScanBom(ProductItemId, ProductUID, userName, partBarCodes);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(userName, ex, true);
            }
        }
        /// <summary>
        /// 保存SN和MAC地址的关系
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="sn"></param>
        /// <param name="address"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public string SaveSNAndMac(int itemId, string sn, string address, string userName)
        {
            string result = "";
            try
            {
                result = (new ShipmentListConfig()).SaveSNAndMac(itemId, sn, address, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(userName, ex, true);
            }
            return result;
        }
        /// <summary>
        /// 保存SN和MAC地址的关系
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="sn"></param>
        /// <param name="address"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public int CheckSNAndMac(string sn, string address)
        {
            int num = 0;
            try
            {
                num = (new ShipmentListConfig()).CheckSNAndMac(sn, address);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }
            return num;
        }

        /// <summary>
        /// 获取手动叫料数量信息
        /// </summary>
        [AjaxMethod]
        public string GetMenCallDetailInfo(int orderId, int stationId, int itemId)
        {
            var strResult = "";
            try
            {
                strResult = (new OrderBom()).GetMenCallDetailInfo(orderId, stationId, itemId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }
            return strResult;
        }

        /// <summary>
        /// 新增手动叫料
        /// </summary>
        [AjaxMethod]
        public void AddMenCall(int orderId, int itemId, int stationId, int resId,
            int callNum, string rdate, string curUser)
        {
            try
            {
                var bll = new OrderBom();
                bll.SaveMenCall(orderId, itemId, stationId, resId, callNum, rdate, curUser);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }

        }

        /// <summary>
        /// 删除手动叫料
        /// </summary>
        [AjaxMethod]
        public void CancelMenCall(string idStr)
        {
            try
            {

            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }

        }

        [AjaxMethod]
        public string CheckUserSessionOut()
        {
            string msg = "";
            try
            {
                WebHelper.CheckSession();
            }
            catch (Exception ex)
            {
                msg = "timeout";
               // WebHelper.HandleException("", ex, true);
            }
            return msg;
        }


        /// <summary>
        /// 写入用户操作日志
        /// </summary>
        /// <param name="LogType">日志类型</param>
        /// <param name="StationId">工位ID</param>
        /// <param name="ResourceId">资源ID</param>
        /// <param name="OederNo">工单号</param>
        /// <param name="UserName">用户名</param>
        /// <param name="LogContent">日志内容</param>
        [AjaxMethod]
        public void SaveUserUILog(string LogType, int StationId, int ResourceId, string OederNo, string LogContent)
        {
            try
            {
                System.Data.SqlClient.SqlParameter[] parms = new System.Data.SqlClient.SqlParameter[]{
                    new System.Data.SqlClient.SqlParameter("@LogType",System.Data.SqlDbType.VarChar,20),
                    new System.Data.SqlClient.SqlParameter("@StationId",System.Data.SqlDbType.Int),
                    new System.Data.SqlClient.SqlParameter("@ResourceId",System.Data.SqlDbType.Int),
                    new System.Data.SqlClient.SqlParameter("@OederNo",System.Data.SqlDbType.VarChar,100),
                    new System.Data.SqlClient.SqlParameter("@UserName",System.Data.SqlDbType.VarChar,20),
                    new System.Data.SqlClient.SqlParameter("@LogContent",System.Data.SqlDbType.VarChar,2000)

                };
                parms[0].Value = LogType;
                parms[1].Value = StationId;
                parms[2].Value = ResourceId;
                parms[3].Value = OederNo;
                parms[4].Value = AccountController.GetCurrentUser().UserName;
                parms[5].Value = LogContent;
                SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, "uspSaveUserUILog", parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

    }
}