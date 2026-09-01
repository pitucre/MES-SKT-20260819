using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.AccessoryManagement.BLL;
using SKT.LeanMES.AccessoryManagement.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// 辅料管理
    /// </summary>
    public class AjaxAccessory
    {
        int a = 0;
        #region 辅料类别
        /// <summary>
        /// 辅料类型新增
        /// </summary>
        /// <param name="en"></param>
        [AjaxMethod]
        public void AccessoryTypeEdit(AccessoryTypeInfo en)
        {
            try
            {
                new AccessoryType().Edit(en);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="en"></param>
        [AjaxMethod]
        public void AccessoryTypeDtl(string id)
        {
            try
            {
                AccessoryType bll = new AccessoryType();
                bll.Delete(id, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        #endregion
        #region 辅料
        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Accessory 实体对象。</returns>
        [AjaxMethod]
        public AccessoryInfo GetInfo(int fieldValue)
        {
            AccessoryInfo entity = new AccessoryInfo();
            try
            {
                entity = new Accessory().GetInfo(fieldValue);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 获取辅料信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public AccessoryInfo GetAccessoryInfo(AccessoryInfo entity)
        {
            try
            {
                return new Accessory().GetAccessoryInfo(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 辅料新增
        /// </summary>
        /// <param name="en"></param>
        [AjaxMethod]
        public void AccessoryEdit(AccessoryInfo en)
        {
            try
            {
                new Accessory().Edit(en);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public string[] AccessoryPrintSerialNumber(AccessoryInfo entity, int SumQty, decimal MinQty)
        {
            try
            {
                return new Accessory().PrintSerialNumber(entity, SumQty, MinQty);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        /// <summary>
        /// 辅料操作
        /// </summary>
        /// <param name="SN"></param>
        /// <param name="TYPE">1 解冻 2发料 3 上料 4 退回</param>
        /// <param name="USERNAME"></param>
        [AjaxMethod]
        public void AccessoryOperation(string SN, int TYPE, string USERNAME)
        {
            try
            {
                new Accessory().AccessoryOperation(SN, TYPE, USERNAME);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        #endregion
        #region PDA辅料上料验证
        [AjaxMethod]
        public List<AccessoryInfo> GetPlanOrderList()
        {
            try
            {
                return new Accessory().GetPlanOrderList();
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<AccessoryInfo> GetLineList()
        {
            try
            {
                return new Accessory().GetLineList();
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        /// <summary>
        /// add by peter on 2020-2-3  线别模糊查询
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SKT.LeanMES.Station.Model.LineInfo> GetLineListBySearch(string line)
        {
            try
            {
                SearchSettings s = new SearchSettings();
                s.ExtensionCondition += " LineName like '%" + line + "%' ";
                return new SKT.LeanMES.Station.BLL.Line().GetAll(0, 20, "LineName  DESC", s);
            }
            catch (Exception)
            {
                throw;
            }
        }


        [AjaxMethod]
        public List<AccessoryInfo> GetStationList()
        {
            try
            {
                return new Accessory().GetStationList();
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        /// <summary>
        /// add by peter on 2020-2-3  工序模糊查询
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<SKT.LeanMES.Station.Model.StationInfo> GetStationListBySearch(string line)
        {
            try
            {
                SearchSettings s = new SearchSettings();
                s.ExtensionCondition += " Station like '%" + line + "%' ";
                return new SKT.LeanMES.Station.BLL.Station().GetAll(0, 20, "StationId  DESC", s);
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// 上料验证
        /// </summary>
        /// <param name="SN"></param>
        /// <param name="OrderNo"></param>
        /// <param name="LineId"></param>
        /// <param name="StatonId"></param>
        /// <param name="username"></param>
        /// <returns></returns>
        [AjaxMethod]      
        public void Check(string SN, string OrderNo, int LineId, int StatonId, string username)
        {
            try
            {
                new Accessory().Check(SN,OrderNo,LineId,StatonId,username);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<AccessoryInfo> PDASearch(string SN, string OrderNo)
        {
            try
            {
               return new Accessory().PDASearch(SN, OrderNo);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        #endregion

        #region 辅料用完管理 空瓶管理
        [AjaxMethod]
        public void Finish(string SN)
        {
            try
            {
                var username = AccountController.GetCurrentUser().UserName;
                new Accessory().Finish(SN, username);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        #endregion

        [AjaxMethod]
        public void AccListDtl(int id)
        {
            try
            {
                SKT.LeanMES.AccessoryManagement.BLL.AccessoryList bll = new SKT.LeanMES.AccessoryManagement.BLL.AccessoryList();
                bll.Delete(id.ToString(), AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {

                throw;
            }

        }

        /// <summary>
        /// 检验辅料GRN信息是否正确
        /// </summary>
        /// <param name="ItemStr"></param>
        /// <param name="grn"></param>
        /// <param name="flage"></param>
        /// <param name="grnStr"></param>
        /// <returns></returns>
        [AjaxMethod]
        public IList<AccessoryInfo> CheckGrnAccessoryPrepare(string grn)
        {
            try
            {
                return new Accessory().CheckGrnAccessoryPrepare(grn);
            }
            catch (Exception ex)
            {
                throw;
            }
        }


        /// <summary>
        /// 辅料（锡膏）解冻校验
        /// </summary>
        /// <param name="sn"></param>
        [AjaxMethod]
        public string AccessoryThawValidate(string sn)
        {
            try
            {
                return new Accessory().AccessoryThawValidate(sn);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        [AjaxMethod]
        public void AccessrySupplierMaterialRegister(string grn)
        {
            try
            {
                new Accessory().AccessrySupplierMaterialRegister(grn, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                throw;
            }
        }



        #region 辅料下线
        
        [AjaxMethod]
        public void AccessoryOffline(string SN)
        {
            try
            {
                var username = AccountController.GetCurrentUser().UserName;
                new Accessory().AccessoryOfflineDal(SN, username);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        #endregion

    }
}