using AjaxPro;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxIPQC
    {
        [AjaxMethod]
        /// <summary>
        /// SMT上料核对GRN/料站验证
        /// </summary>
        /// <param name="FBillNo">排程工单</param>
        /// <param name="EquipmentId">机台Id</param>
        /// <param name="Position">料站</param>
        /// <param name="GRN">物料条码</param>
        /// <param name="IsCheckGRN">是否验证GRN 0:验证料站，1：验证GRN</param>
        /// <returns></returns>
        public LoadinglistInfo IPQCSMTCheck(string FBillNo, int EquipmentId, string Position, string GRN, int IsCheckGRN)
        {
            try
            {
                LoadingList bll = new LoadingList();
                return bll.IPQCSMTCheck(FBillNo, EquipmentId, Position, GRN, IsCheckGRN);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        //[AjaxMethod]
        ///// <summary>
        ///// AI、手插上料核对GRN验证
        ///// </summary>
        ///// <param name="PickListId">上料清单Id</param>
        ///// <param name="ProdOrderId">工单Id</param>
        ///// <param name="StationId">工序Id</param>
        ///// <param name="ResourceId">资源Id</param>
        ///// <param name="GRN">物料条码</param>
        ///// <param name="Position">料站</param>
        ///// <param name="CheckType">AI、 Hand</param>
        ///// <param name="IsCheckGRN">0:验证料站，1：验证GRN</param>
        ///// <returns></returns>
        //public LoadingMaterialCheckInfo IPQCHandCheck(int PickListId, int ProdOrderId, int StationId, int ResourceId, string GRN, string Position, string CheckType, int IsCheckGRN)
        //{
        //    try
        //    {
        //        LoadingList bll = new LoadingList();
        //        return bll.IPQCHandCheck(PickListId, ProdOrderId, StationId, ResourceId, GRN, Position, CheckType, IsCheckGRN);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new Exception(ex.Message);
        //    }
        //}
    }
}