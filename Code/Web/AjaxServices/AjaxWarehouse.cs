using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Warehouse.BLL;
using SKT.LeanMES.Warehouse.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// 仓库管理类
    /// </summary>
    public class AjaxWarehouse
    {
        [AjaxMethod]
        public void WarehouseEdit(SKT.LeanMES.Warehouse.Model.WarehouseInfo entity)
        {
            try
            {
                new SKT.LeanMES.Warehouse.BLL.Warehouse().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        //[AjaxMethod]
        //public SKT.MES.User.Model.DepartmentInfo GetUserDept(int userId)
        //{
        //    try
        //    {
        //        SKT.MES.User.Model.UsersInfo userInfo = new SKT.MES.User.BLL.Users().GetInfo(userId);
        //        return new SKT.MES.User.BLL.Department().GetInfo(userInfo.DepartmentID);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //        return null;
        //    }
        //}

        /// <summary>
        /// 仓库类型
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void WarehouseTypeEdit(SKT.LeanMES.Warehouse.Model.WarehouseTypeInfo entity)
        {
            try
            {
                WarehouseType wht = new WarehouseType();
                if (entity.WarehouseTypeId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                wht.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 储位货位类   
        /// </summary>
        [AjaxMethod]
        public void WarehouseLocationEdit(SKT.LeanMES.Warehouse.Model.WarehouseLocationInfo entity)
        {
            try
            {
                new SKT.LeanMES.Warehouse.BLL.WarehouseLocation().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取可选物料   
        /// </summary>
        [AjaxMethod]
        public List<WarehouseCheckOrderInfo> GetMaterialForCheck(int flag, int orderId, int whId, string searchSetting)
        {
            List<WarehouseCheckOrderInfo> list = new List<WarehouseCheckOrderInfo>();
            try
            {
                list = (new WarehouseCheckOrder()).GetMaterialForCheck(flag, orderId, whId, searchSetting);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// 编辑仓库盘点信息   
        /// </summary>
        [AjaxMethod]
        public void WarehouseCheckOrderEdit(string strJson)
        {
            try
            {
                new SKT.LeanMES.Material.BLL.WarehouseCheckOrder().Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取盘点单  
        /// </summary>
        [AjaxMethod]
        public string GenerateOrderSN()
        {
            try
            {
                return (new SKT.LeanMES.Material.BLL.WarehouseCheckOrder()).GenerateOrderSN();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }

        /// <summary>
        /// 创建快照  
        /// </summary>
        [AjaxMethod]
        public void getWarehouseCheckSnap(int orderId, string userName, string mList)
        {
            try
            {
                new SKT.LeanMES.Material.BLL.WarehouseCheckOrder().getWarehouseCheckSnap(orderId, userName, mList);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 添加选中的GRNS  
        /// </summary>
        [AjaxMethod]
        public void ChoosingCheckGrn(string grns, string userName, int orderId)
        {
            try
            {
                new SKT.LeanMES.Material.BLL.WarehouseCheckOrder().ChoosingCheckGrn(grns, 1, userName, orderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 删除选中的GRNS  
        /// </summary>
        [AjaxMethod]
        public void DeleteChoosingGrn(string grns, string userName, int orderId)
        {
            try
            {
                new SKT.LeanMES.Material.BLL.WarehouseCheckOrder().ChoosingCheckGrn(grns, 2, userName, -1);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 货位亮灯颜色设定
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void WarehouseLightColorEdit(SKT.LeanMES.Warehouse.Model.WarehouseLightColorInfo entity)
        {
            try
            {
                WarehouseLightColor wht = new WarehouseLightColor();
                if (entity.FunctionId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                wht.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 判断产品是否能放入当前库位
        /// </summary>
        /// <param name="grn">GRN条码</param>
        /// <param name="itemCode">产品编码</param>
        /// <param name="cBarCode">库位条码</param>
        /// <returns></returns>
        [AjaxMethod]
        public bool IsItemCanPlacedInWarehouseLocation(string grn, string itemCode, string cBarCode)
        {
            try
            {
                WarehouseLocation bll = new WarehouseLocation();
                return bll.IsItemCanPlacedInWarehouseLocation(grn, itemCode, cBarCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return true;
        }

        #region AVG地标码
        [AjaxMethod]
        public void AgvEdit(WarehouseAGVMarkInfo entity)
        {
            try
            {
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                new WarehouseAGVMark().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        [AjaxMethod]
        public List<WarehouseInfo> GetWarehouse(string WarseCode)
        {
            List<WarehouseInfo> WarehouseInfo = new List<WarehouseInfo>();
            try
            {
                SearchSettings searchSettings = new SearchSettings();
                if (!string.IsNullOrEmpty(WarseCode))
                {
                    searchSettings.ExtensionCondition = " CWhCode = '" + WarseCode + "' OR  CWhName  LIKE '%" + WarseCode + "%'";
                }
                WarehouseInfo = new SKT.LeanMES.Warehouse.BLL.Warehouse().GetAll(0, int.MaxValue, "", searchSettings);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return WarehouseInfo;
        }

        [AjaxMethod]
        public List<MaterialUnitInfo> GetWarseHouseQty(string CWhCode, string ItemCode, string cpn = "")
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CWhCode", SqlDbType.NVarChar){ Value = CWhCode},
                new SqlParameter("@ItemCode", SqlDbType.NVarChar){ Value = ItemCode},
                new SqlParameter("@CPN", SqlDbType.NVarChar){ Value = cpn}

            };
            return ComMethod.GetList<MaterialUnitInfo>("uspGetWarseHouseQty", parms);
        }


        /// <summary>
        /// 根据库位查询在库物料信息
        /// </summary>
        /// <param name="cBarCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialUnitInfo> GetMaterialByCbarCode(string cBarCode)
        {

            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                     new SqlParameter("@CbarCode", SqlDbType.NVarChar){ Value = cBarCode}
                  };
                return ComMethod.GetList<MaterialUnitInfo>("uspGetMaterialByCbarCode", parms);

            }

            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }
    }
}