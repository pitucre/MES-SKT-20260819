using SKT.LeanMES.SDK;
using Swashbuckle.Examples;
using Swashbuckle.Swagger.Annotations;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Web.Http;
using WebAPI.Code;
using WebAPI.Code.Attributes;
using WebAPI.Dao;
using WebAPI.Job;
using WebAPI.Models;
using WebAPI.Models.Enum;
using WebAPI.Models.MES;
using WebAPI.Models.RequestExample;
using WebAPI.Models.ResponseExample;
using WebAPI.Models.ScrapStorage;
using WebAPI.Utility;

namespace WebAPI.Controllers
{
    /// <summary>
    /// ERP同步
    /// </summary>
    //[CustomActionAttribute]
    public class ERPSyncController : BaseController
    {
        /// <summary>
        /// 同步部门信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns>JSON字符串</returns>
        [Route("SyncDepartment")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPSYSOrganizationInfo>), typeof(ReqExample<ERPSYSOrganizationInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncDepartment([FromBody] BasalSyncInfo<ERPSYSOrganizationInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Department);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步用户信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncUser")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPSYSMembershipInfo>), typeof(ReqExample<ERPSYSMembershipInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncUser([FromBody] BasalSyncInfo<ERPSYSMembershipInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.User);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步仓库信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncWarehouse")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPBasalWarehouseInfo>), typeof(ReqExample<ERPBasalWarehouseInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncWarehouse([FromBody] BasalSyncInfo<ERPBasalWarehouseInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Warehouse);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步库位信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncWarehouseLocation")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPBasalWarehouseLocationInfo>), typeof(ReqExample<ERPBasalWarehouseLocationInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncWarehouseLocation([FromBody] BasalSyncInfo<ERPBasalWarehouseLocationInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.WarehouseLocation);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步客户信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncCustomer")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPBasalCustomerInfo>), typeof(ReqExample<ERPBasalCustomerInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncCustomer([FromBody] BasalSyncInfo<ERPBasalCustomerInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Customer);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }


        /// <summary>
        /// 同步供应商信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncSupplier")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPBasalSupplierInfo>), typeof(ReqExample<ERPBasalSupplierInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncSupplier([FromBody] BasalSyncInfo<ERPBasalSupplierInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Supplier);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步物料分类信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncItemCategory")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPBasalItemCategoryInfo>), typeof(ReqExample<ERPBasalItemCategoryInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncItemCategory([FromBody] BasalSyncInfo<ERPBasalItemCategoryInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.ItemCategory);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步物料信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncItem")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPBasalItemInfo>), typeof(ReqExample<ERPBasalItemInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncItem([FromBody] BasalSyncInfo<ERPBasalItemInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Item);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步产品BOM信息（包括产品BOM明细信息）
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncItemBom")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPBasalItemBomInfo>), typeof(ReqExample<ERPBasalItemBomInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncItemBom([FromBody] BasalSyncInfo<ERPBasalItemBomInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.ItemBom);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步替代料信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncSubsItem")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPBasalSubsItemInfo>), typeof(ReqExample<ERPBasalSubsItemInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncSubsItem([FromBody] BasalSyncInfo<ERPBasalSubsItemInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.SubsItem);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步工单信息（包括工单BOM明细信息）
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncOrder")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPProdOrderInfo>), typeof(ReqExample<ERPProdOrderInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncOrder([FromBody] BasalSyncInfo<ERPProdOrderInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Order);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        ///// <summary>
        ///// 同步工单BOM信息
        ///// </summary>
        ///// <param name="entity"></param>
        ///// <returns></returns>
        //[Route("SyncOrderBom")]
        //  [SignAuth, LoginAuth, Param,HttpPost]
        //public APIResult SyncOrderBom([FromBody] BasalSyncInfo<ERPProdOrderBomInfo> entity)
        //{
        //      var msg = SyncERPData(entity, ApiEnum.OrderBom);
        //      return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        //}


        /// <summary>
        /// 同步采购单信息（包括采购单明细）
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncPoCode")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPERPPurOrderInfo>), typeof(ReqExample<ERPERPPurOrderInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncPoCode([FromBody] BasalSyncInfo<ERPERPPurOrderInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.PoCode);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步收货通知单（送货单）信息（包括送货单明细）
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncDeliver")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPProdDeliverInfo>), typeof(ReqExample<ERPProdDeliverInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncDeliver([FromBody] BasalSyncInfo<ERPProdDeliverInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Deliver);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }


        /// <summary>
        /// 同步领料单信息（包括领料单明细）
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncApply")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPProdApplyInfo>), typeof(ReqExample<ERPProdApplyInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncApply([FromBody] BasalSyncInfo<ERPProdApplyInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Apply);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步调拨单信息（包括调拨单明细）
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncTransfer")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPProdTransfersInfo>), typeof(ReqExample<ERPProdTransfersInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncTransfer([FromBody] BasalSyncInfo<ERPProdTransfersInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Transfer);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步销售出库单信息（包括销售出库单明细）
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncSalOrder")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPProdSalOrderInfo>), typeof(ReqExample<ERPProdSalOrderInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncSalOrder([FromBody] BasalSyncInfo<ERPProdSalOrderInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.SaleOrder);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步供应商退料单信息（仓库退供应商，包括退料明细）
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncReturnOrder")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPProdReturnToVendorInfo>), typeof(ReqExample<ERPProdReturnToVendorInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncReturnOrder([FromBody] BasalSyncInfo<ERPProdReturnToVendorInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.ReturnOrder);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步生产退料单信息（包括明细信息）
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncReturnToWarehouse")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPProdReturnToWarehouseInfo>), typeof(ReqExample<ERPProdReturnToWarehouseInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncReturnToWarehouse([FromBody] BasalSyncInfo<ERPProdReturnToWarehouseInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.ReturnToWarehouse);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步客退单信息（包括客退单明细）
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncSaleReturn")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPProdSaleReturnInfo>), typeof(ReqExample<ERPProdSaleReturnInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncSaleReturn([FromBody] BasalSyncInfo<ERPProdSaleReturnInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.SaleReturn);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步设备信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncEquipment")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPBasalEquipmentInfo>), typeof(ReqExample<ERPBasalEquipmentInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncEquipment([FromBody] BasalSyncInfo<ERPBasalEquipmentInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Equipment);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步工厂信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncFactory")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPBasalFactoryInfo>), typeof(ReqExample<ERPBasalFactoryInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncFactory([FromBody] BasalSyncInfo<ERPBasalFactoryInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Factory);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }


        /// <summary>
        /// 同步GRN信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns>JSON字符串</returns>
        [Route("SyncGRN")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPProdMaterialUnit>), typeof(ReqExample<ERPProdMaterialUnit>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncGRN([FromBody] BasalSyncInfo<ERPProdMaterialUnit> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.GRN);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 同步报废单信息（包括报废信息）
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncScrap")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPProdScrapInfo>), typeof(ReqExample<ERPProdScrapInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncScrap([FromBody] BasalSyncInfo<ERPProdScrapInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.Scrap);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 确认报废
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("ScrapConfirmation")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(ScrapStorageBaseInfo<ScrapNoInfo>), typeof(ReqExample<ScrapNoInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult ScrapConfirmation([FromBody] ScrapStorageBaseInfo<ScrapNoInfo> entity)
        {
            var msg = new ScrapStorage().ScrapStorageCallBack(entity);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG);
        }

        /// <summary>
        /// 查询报废单状态
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("GetScrapStatus")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(ScrapNoInfo), typeof(ReqExample<ScrapNoInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult GetScrapStatus([FromBody] ScrapNoInfo entity)
        {
            try
            {
                APIResult result=new APIResult();
                result.Basis = new BaseData();
                string msg = string.Empty;
                var data = new ScrapStorage().GetScrapStatus(entity);
                if (data != null && data.Count>0)
                {
                    //状态(0 - 待报废，1 - 报废中，2 - 报废完成，3 - 已提交（扫码完成）)
                   if (data[0].Statue == 0)
                    {
                        result.Basis.Message = "待报废";
                        result.Basis.State = 1;
                        result.Result = 0;
                    }
                    if (data[0].Statue == 1)
                    {
                        result.Basis.Message = "报废中";
                        result.Basis.State = 1;
                        result.Result = 1;
                    }
                    if (data[0].Statue == 2)
                    {
                        result.Basis.Message = "报废完成";
                        result.Basis.State = 1;
                        result.Result = 2;
                    }
                    if (data[0].Statue == 3)
                    {
                        result.Basis.Message = "已提交（扫码完成）";
                        result.Basis.State = 1;
                        result.Result = 3;
                    }
                    return APIResponse.APIResponseMsg(result);
                }

                return APIResponse.APIResponseMsg("未获取到数据！", ResultEnum.NG);

            }
            catch (Exception ex)
            {
                return APIResponse.APIResponseMsg(ex.Message, string.IsNullOrWhiteSpace(ex.Message) ? ResultEnum.OK : ResultEnum.NG);
            }
           
        }
        /// <summary>
        /// 移除同步配置表缓存
        /// </summary>
        /// <returns></returns>
        [Route("RemoveCache")]
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult RemoveCache()
        {

            WebAPI.Utility.CacheHelper.RemoveAllCache(ERPSyncDao.CacheKey);
            return APIResponse.APIResponseMsg(string.Empty);
        }

        /// <summary>
        /// 同步形态转换单信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [Route("SyncFormChange")]
        [SwaggerResponse(HttpStatusCode.OK, Type = typeof(APIResult))]//响应模型
        [SwaggerResponseExample(HttpStatusCode.OK, typeof(ResExample))] //响应示例
        [SwaggerRequestExample(typeof(BasalSyncInfo<ERPProdFormChangeInfo>), typeof(ReqExample<ERPProdFormChangeInfo>))]//请求模型，请求示例
        [SignAuth, LoginAuth, Param, HttpPost]
        public APIResult SyncFormChange([FromBody] BasalSyncInfo<ERPProdFormChangeInfo> entity)
        {
            var msg = SyncERPData(entity, ApiEnum.FormChange);
            return APIResponse.APIResponseMsg(msg, string.IsNullOrWhiteSpace(msg) ? ResultEnum.OK : ResultEnum.NG); ;
        }

       
    }
}
