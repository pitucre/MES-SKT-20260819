using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Product.Model;

using AjaxPro;
using System.Data;
using SKT.LeanMES.Router.Model;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;
using SKT.LeanMES.ProdUnit.BLL;
using SKT.LeanMES.ProdUnit.Model;
using System.Reflection;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxProduct
    {
        /// <summary>
        /// 新增/编辑保持产品分组
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void ItemGroupEdit(ItemGroupInfo entity)
        {
            try
            {
                ItemGroup bll = new ItemGroup();
                if (entity.ItemGroupId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 编辑产品
        /// </summary>
        /// <param name="model"></param>
        /// <param name="certificationList"></param>
        /// <param name="printDocList"></param>
        [AjaxMethod]
        public void ItemEdit(ItemInfo entity, String certificationList, String printDocList)
        {
            try
            {
                Item bll = new Item();
                bll.Edit(entity, certificationList, printDocList);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 编辑组件
        /// </summary>
        /// <param name="model"></param>
        [AjaxMethod]
        public void ComponentEdit(BomComponentInfo entity)
        {
            try
            {
                BomComponent bll = new BomComponent();
                if (entity.BomComponentId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                (new SKT.LeanMES.Product.BLL.BomComponent()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 新增/编辑保存
        /// </summary>
        [AjaxMethod]
        public Int32 BomEdit(BomInfo entity)
        {
            int bomid = -1;
            try
            {
                Bom bll = new Bom();
                if (entity.BomId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bomid = bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return bomid;
        }


        /// <summary>
        /// 新增/编辑保存 物料检验参数
        /// </summary>
        [AjaxMethod]
        public void ItemIQCParamEdit(ItemIQCParamInfo entity)
        {
            try
            {
                ItemIQCParam bll = new ItemIQCParam();

                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                entity.Remark = "";

                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 根据路由Id获得路由的各个站点
        /// </summary>
        [AjaxMethod]
        public RouterInfo GetLayout(int routerId)
        {
            try
            {
                SKT.LeanMES.Router.BLL.Router bll = new LeanMES.Router.BLL.Router();
                SKT.LeanMES.Router.Model.RouterInfo model = new RouterInfo();
                model = bll.GetLayout(routerId);
                return model;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 获取物料IQC检验参数列表
        /// </summary>
        /// <param name="Id">ItemId 物料Id</param>
        /// <returns>该物料已配置的IQC参数列表</returns>
        [AjaxMethod]
        public List<ItemIQCParamInfo> GetItemIQCParamList(Int32 ItemId)
        {
            List<ItemIQCParamInfo> list = new ItemIQCParam().GetItemIQCParamList(ItemId);
            return list;
        }
        /// <summary>
        /// 新增编辑产品参数
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void StationParamEdit(StationParamInfo entity)
        {
            try
            {
                StationParam bll = new StationParam();
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
        /// 获取参数列表
        /// </summary>
        /// <param name="Id">id</param>
        /// <returns>已配置的产品参数列表</returns>
        [AjaxMethod]
        public List<StationParamInfo> GetStationParamList(Int32 ItemId, Int32 StationId)
        {
            List<StationParamInfo> list;
            if (StationId == -1)
            {
                list = new StationParam().GetStationParamList(ItemId);
            }
            else
            {
                list = new StationParam().GetStationParamListByStationId(ItemId, StationId);
            }
            return list;
        }

        /// <summary>
        /// 编辑产品
        /// </summary>
        /// <param name="model"></param>
        /// <param name="certificationList"></param>
        /// <param name="printDocList"></param>
        [AjaxMethod]
        public ItemInfo GetItemByItem(int ItemId)
        {
            ItemInfo i = new ItemInfo();
            try
            {
                Item bll = new Item();
                i = bll.GetInfo(ItemId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return i;
        }
        /// <summary>
        /// 这个产品Bom是否已存在的新增的ItemId
        /// </summary>
        /// <param name="model"></param>
        [AjaxMethod]
        public bool IsComponentExists(int BomId, int ItemId)
        {
            bool flag = false;
            try
            {
                flag=(new SKT.LeanMES.Product.BLL.BomComponent()).IsComponentExists(BomId, ItemId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return flag;
        }

        #region 产品BOM模块
        /// <summary>
        /// 新增/编辑保存
        /// </summary>
        [AjaxMethod]
        public Int32 ItemBomEdit(ItemBomInfo entity)
        {
            int bomId = -1;
            try
            {
                ItemBom bll = new ItemBom();
                if (entity.ItemBomId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bomId = bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return bomId;
        }

        /// <summary>
        /// 新增/编辑保存
        /// </summary>
        [AjaxMethod]
        public Int32 ItemBomChildEdit(ItemBomChildInfo entity)
        {
            int bomId = -1;
            try
            {
                ItemBomChild bll = new ItemBomChild();
                if (entity.ItemBomChildId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bomId = bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return bomId;
        }

        /// <summary>
        /// Bom导入
        /// </summary>
        [AjaxMethod]
        public Int32 ItemBomImport(ItemBomInfo entity)
        {
            int bomId = -1;
            try
            {
                ItemBom bll = new ItemBom();
                if (entity.ItemBomId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bomId = bll.Import(entity);
            }
            catch (Exception ex)
            {
                if (ex.Message == "DBAccessError")
                {                     
                    throw new Exception("请导入正确的产品BOM清单！");
                }
                else
                {
                    WebHelper.HandleException(ex);
                }
               
            }

            return bomId;
        }

        /// <summary>
        /// 获取产品结构信息
        /// </summary>
        /// <param name="itemCode"></param>
        /// <param name="ver"></param>
        /// <param name="itemBomId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ItemBomInfo> GetBomStructInfo(string itemCode, string ver, int itemBomId)
        {
            List<ItemBomInfo> list = new List<ItemBomInfo>();
            try
            {
                ItemBom bll = new ItemBom();
                list = bll.GetBomStructInfo(itemCode,ver,itemBomId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 获取产品信息
        /// </summary>
        /// <param name="itemBomId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ItemBomInfo GetItemByBomID(int itemBomId)
        {
            ItemBomInfo entity = new ItemBomInfo();
            try
            {
                ItemBom bll = new ItemBom();
                entity = bll.GetItemByBomID(itemBomId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 从MES中间表同步单个产品信息
        /// </summary>
        /// <param name="itemBomId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void SynchroItemBom(string itemCode)
        {          
            try
            {
                ItemBom bll = new ItemBom();
                 bll.SynchroItemBom(itemCode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion

        #region 产品类别模块

        /// <summary>
        /// 获取类别树信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<ItemCategoryInfo> GetCategoryTree()
        {
            List<ItemCategoryInfo> list = new List<ItemCategoryInfo>();
            try
            {
                ItemCategory bll = new ItemCategory();
                list = bll.GetCategoryTree();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public List<ItemCategoryInfo> GetItemCategory(int parentId)
        {
            List<ItemCategoryInfo> list = new List<ItemCategoryInfo>();
            try
            {
                ItemCategory bll = new ItemCategory();
                list = bll.GetItemCategory(parentId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 新增、编辑产品类别信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public Int32 CategoryEdit(ItemCategoryInfo entity)
        {
            int categoryId = -1;
            try
            {
                ItemCategory bll = new ItemCategory();
                if (entity.ItemCategoryId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                categoryId = bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return categoryId;
        }
        #endregion

        #region 工序与物料关系模块

        /// <summary>
        /// 工序与物料关系编辑
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
       

        [AjaxMethod]
        public Int32 AddMatStation(int stationId,string itemIds)
        {
            int categoryId = -1;
            try
            {
                Item itemBll = new Item();
                StationMateriel bll = new StationMateriel();
                var entity = new StationMaterielInfo();
                var itemIdArr = itemIds.Split(',');
                if (itemIdArr.Length > 0)
                {
                    for (int i = 0; i < itemIdArr.Length; i++)
                    {
                        var itemEntity = itemBll.GetInfo(Convert.ToInt32(itemIdArr[i]));
                        if (itemEntity != null)
                        {
                            entity.StationMatId = -1;
                            entity.OrganizationCode = "";
                            entity.ItemCode = itemEntity.ItemCode;
                            entity.StationId = stationId;
                            entity.State = 1;
                            entity.CreateBy = AccountController.GetCurrentUser().UserName;
                            entity.ModifyBy = "";

                            categoryId = bll.Edit(entity);
                        }
                    }
                }
                
               
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return categoryId;
        }

        [AjaxMethod]
        public void RemoveMatStation(string stationMatId)
        {
            try
            {
                StationMateriel bll = new StationMateriel();
                bll.Delete(stationMatId, AccountController.GetCurrentUser().UserName); 
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }           
        }        
     
        #endregion

        #region 工序与产品BOM物料关系模块

        /// <summary>
        /// 编辑工序与产品BOM物料关系
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Int32 StationInBomEdit(StationInBomInfo entity)
        {
            int stationInBomId = -1;
            try
            {
                StationInBom bll = new StationInBom();
                if (entity.StationInBomId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                stationInBomId = bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return stationInBomId;
        }

        #endregion

        #region 保存物料类型信息
        /// <summary>
        ///保存物料类型信息
        /// </summary>
        /// <param name="entity">实体类</param>
        [AjaxMethod]
        public void SaveItemTypeInfo(ItemInfo entity)
        {
            try
            {
                Item bll = new Item();
                bll.SaveItemTypeInfo(entity, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 删除物料类型信息
        /// <summary>
        /// 删除物料类型信息
        /// </summary>
        /// <param name="idStr"></param>
        [AjaxMethod]
        public void DeleteItemTypeInfo(string idStr)
        {
            try
            {
                Item bll = new Item();
                bll.DeleteItemTypeInfo(idStr, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion
        #region 确认叫料信息
        /// <summary>
        /// 确认叫料信息
        /// </summary>
        /// <param name="idStr"></param>
        [AjaxMethod]
        public void ConfirmCryMaterialInfo(String idStr)
        {
            try
            {
                Item bll = new Item();
                bll.ConfirmCryMaterialInfo(idStr, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 查询刷新时间
        /// <summary>
        /// 查询刷新时间
        /// </summary>
        /// <param name="mocode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public DictionaryInfo GetRefreshTime(string TimeType)
        {
            DictionaryInfo list = new DictionaryInfo();
            try
            {
                Dictionary ColorBll = new Dictionary();
                list = ColorBll.GetInfo(TimeType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region 保存刷新时间
        /// <summary>
        /// 保存刷新时间
        /// </summary>
        /// <param name="TimeType"></param>
        /// <param name="TimeVaule"></param>
        [AjaxMethod]
        public void SaveRefreshTime(string TimeType, string TimeVaule)
        {
            try
            {
                Dictionary bll = new Dictionary();
                bll.SaveRefreshTime(TimeType, TimeVaule);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 保存号码范围信息
        /// <summary>
        /// 保存号码范围信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void BarCodeScopeSetEdit(int ScopeId,string OrderNo,string CustomerOrder,int Qty, List<BarCodeScopeTable> NumberTypeList)
        {
            try
            {
                DataTable dt = ToDataTable(NumberTypeList);
                SKT.LeanMES.ProdUnit.BLL.BarCodeScope bll = new SKT.LeanMES.ProdUnit.BLL.BarCodeScope();
                bll.BarCodeScopeSetEdit(ScopeId, OrderNo, CustomerOrder, Qty, dt, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 根据工单号查询号码类型
        /// <summary>
        /// 根据工单号查询号码类型
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<BarCodeScopeInfo> QueryBarType(string OrderNo)
        {
            List<BarCodeScopeInfo> list = null;
            try
            {
                list = (new BarCodeScope()).QueryBarType(OrderNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region 保存包装对应关系
        /// <summary>
        /// 保存包装对应关系
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void PackRelationEdit(int ScopeId, string OrderNo, string CustomerOrder, int Qty, List<BarCodeScopeTable> NumberTypeList)
        {
            try
            {
                DataTable dt = ToDataTable(NumberTypeList);
                SKT.LeanMES.ProdUnit.BLL.BarCodeScope bll = new SKT.LeanMES.ProdUnit.BLL.BarCodeScope();
                bll.PackRelationEdit(ScopeId, OrderNo, CustomerOrder, Qty, dt, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 根据工单号查询号码类型
        /// <summary>
        /// 根据工单号查询号码类型
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<BarCodeScopeInfo> QueryPackRelation(string OrderNo)
        {
            List<BarCodeScopeInfo> list = null;
            try
            {
                list = (new BarCodeScope()).QueryPackRelation(OrderNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region 根据工单号查询条码列表
        /// <summary>
        /// 根据工单号查询号码类型
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<BarCodeScopeInfo> QueryPackBarCodeList(string OrderNo)
        {
            List<BarCodeScopeInfo> list = null;
            try
            {
                list = (new BarCodeScope()).QueryPackBarCodeList(OrderNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region 根据订单号查询该订单是否已经生成过条码
        /// <summary>
        /// 根据订单号查询该订单是否已经生成过条码
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public BarCodeScopeInfo GetCustomerOrderBarCode(string CustomerOrder,string OrderNo, string NumberType)
        {
            BarCodeScopeInfo list = null;
            try
            {
                list = (new BarCodeScope()).GetCustomerOrderBarCode(CustomerOrder, OrderNo, NumberType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region <T>转换成Table
        private DataTable ToDataTable<T>(List<T> items)
        {
            var tb = new DataTable(typeof(T).Name);

            PropertyInfo[] props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);

            foreach (PropertyInfo prop in props)
            {
                Type t = GetCoreType(prop.PropertyType);
                tb.Columns.Add(prop.Name, t);
            }

            foreach (T item in items)
            {
                var values = new object[props.Length];

                for (int i = 0; i < props.Length; i++)
                {
                    values[i] = props[i].GetValue(item, null);
                }

                tb.Rows.Add(values);
            }

            return tb;
        }

        public static Type GetCoreType(Type t)
        {
            if (t != null && IsNullable(t))
            {
                if (!t.IsValueType)
                {
                    return t;
                }
                else
                {
                    return Nullable.GetUnderlyingType(t);
                }
            }
            else
            {
                return t;
            }
        }

        public static bool IsNullable(Type t)
        {
            return !t.IsValueType || (t.IsGenericType && t.GetGenericTypeDefinition() == typeof(Nullable<>));
        }
        #endregion


        /// <summary>
        /// 判断物料清单表是否存在该产品
        /// </summary>
        [AjaxMethod]
        public int IsItemBomExists(int itemId)
        {
            int bomId = -1;
            try
            {
                ItemBom bll = new ItemBom();
                bomId = bll.IsItemBomExists(itemId);
            }
            catch 
            {
                return 1;
            }
            return bomId;
        }

        #region 判断是否有主条码进入生产
        /// <summary>
        /// 判断是否有主条码进入生产
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void IsBarCodeExists(string OrderNo)
        {
            try
            {
                SKT.LeanMES.ProdUnit.BLL.BarCodeScope bll = new SKT.LeanMES.ProdUnit.BLL.BarCodeScope();
                bll.IsBarCodeExists(OrderNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        /// <summary>
        /// 删除号码段
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void DeletePackRelation(BarCodeScopeInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                (new BarCodeScope()).DeletePackRelation(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 包装对应关系—编辑—验证是否允许删除条码规则
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void IsAllowDeletePackRelation(BarCodeScopeInfo entity)
        {
            try
            {
                (new BarCodeScope()).IsAllowDeletePackRelation(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        #region  料桶信息维护
        /// <summary>
        /// 编辑料桶信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditMaterialBucket(MaterialBucketInfo entity)
        {
            try
            {
                (new MaterialBucket()).Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 如果bucketId小于等于0 则根据materialBucketCode查询 
        /// </summary>
        /// <param name="bucketId"></param>
        /// <param name="materialBucketCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MaterialBucketRelationItemInfo> GetMaterialBucketRelationItemList(int bucketId,string materialBucketCode)
        {
            List<MaterialBucketRelationItemInfo> list=new List<MaterialBucketRelationItemInfo>();
            try
            {
                list = new MaterialBucket().GetMaterialBucketRelationItemList(bucketId, materialBucketCode);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }



        #endregion
    }
}