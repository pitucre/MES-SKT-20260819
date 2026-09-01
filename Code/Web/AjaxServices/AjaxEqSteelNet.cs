
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxEqSteelNet
    {
        /// <summary>
        /// 获取工单
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<SteelNetInfo> GetOrderList()
        {
            try
            {
                return new SteelNet().GetOrderList();
            }
            catch (Exception)
            {

                throw;
            }
        }
        //update by weixia on 2019.3.14模糊查询
        [AjaxMethod]
        public List<SKT.LeanMES.Order.Model.ShopOrderInfo> GetOrderListBySearch(string order)
        {
            try
            {
                SearchSettings s = new SearchSettings();
                s.ExtensionCondition += " OrderNo like '%" + order + "%' ";
                return new SKT.LeanMES.Order.BLL.ShopOrder().GetAll(0, 20, "OrderNo  DESC", s);
            }
            catch (Exception)
            {

                throw;
            }
        }

        [AjaxMethod]
        public List<SKT.LeanMES.Order.Model.ShopOrderInfo> GetInjectMoudlLinePlanAll(string equCode,string order)
        {
            try
            {
                SearchSettings s = new SearchSettings();
                s.ExtensionCondition += "MachineNumber='"+equCode+"' and   OrderNo like '%" + order + "%' and Planned_Start_Time >='" + DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd") + "' AND Planned_Start_Time <'" + DateTime.Now.AddDays(2).ToString("yyyy-MM-dd") + "'";

                return new SKT.LeanMES.Order.BLL.ShopOrder().GetInjectMoudlLinePlanAll(0, 20, "OrderNo  DESC", s);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 获取线别
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<SteelNetInfo> GetLineList()
        {
            try
            {
                return new SteelNet().GetLineList();
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<SteelNetInfo> GetSideList()
        {
            try
            {
                return new SteelNet().GetSideList();
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<SteelNetInfo> GetOrderSteelList(int orderId,int lineId,string side)
        {
            try
            {
                return new SteelNet().GetOrderSteelList(orderId, lineId, side);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<SteelNetInfo> GetOrderSteelTempList(string EquipmentCode)
        {
            try
            {
                return new SteelNet().GetOrderSteelTempList(EquipmentCode);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<SteelNetInfo> GetOrderDownLineList(string ecode)
        {
            try
            {
                return new SteelNet().GetOrderDownLineList(ecode);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void SteelNetLineUP(string EqCode, int OrderId, int LineId, string Layout, string username)
        {
            try
            {
                new SteelNet().SteelNetLineUP(EqCode, OrderId, LineId, Layout, username);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void SteelNetLineUPNew(string EqCode, int OrderId, int LineId, string Layout, string username,int OperateType)
        {
            try
            {
                new SteelNet().SteelNetLineUPNew(EqCode, OrderId, LineId, Layout, username,OperateType);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void SteelNetLineDown(string EqCode, string username)
        {
            try
            {
                new SteelNet().SteelNetLineDown(EqCode, username);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void SteelNetLineDownNew(string EqCode, string username,int OperateType)
        {
            try
            {
                new SteelNet().SteelNetLineDownNew(EqCode, username,OperateType);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void SteelWash(string eqCode, string Tension, string CheckResult, string UserName, int type)
        {
            try
            {
                new SteelNet().SteelWash(eqCode, Tension, CheckResult, UserName, type);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void SteelWashNew(string eqCode, string Tension, string CheckResult, string UserName, int type)
        {
            try
            {
                new SteelNet().SteelWashNew(eqCode, Tension, CheckResult, UserName, type);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<SteelNetInfo> Search(string eqCode, string orderId)
        {
            try
            {
                return new SteelNet().Search(eqCode, orderId);
            }
            catch (Exception)
            {

                throw;
            }
        }

        [AjaxMethod]
        public List<EquipmentsInfo> SearchMachine(string eqCode)
        {
            try
            {
                SearchSettings s = new SearchSettings();
                if (!string.IsNullOrEmpty(eqCode))
                {
                    s.ExtensionCondition += " EquipmentTypeName = '注塑机' AND EquipmentName like '%" + eqCode + "%' ";
                }
                else
                {
                    s.ExtensionCondition += " EquipmentTypeName = '注塑机' ";
                }
                return new Equipments().GetAll(0, int.MaxValue, "EquipmentId  DESC", s);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}