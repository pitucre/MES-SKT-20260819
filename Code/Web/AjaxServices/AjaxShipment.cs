using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxShipment
    {
        [AjaxMethod]
        public int ShipmentEdit(SKT.LeanMES.Shipment.Model.ShipmentInfo entity)
        {
                if (null != entity)
                {
                    entity.Qty = Convert.ToDecimal(entity.QtyStr);
                    SKT.LeanMES.Shipment.BLL.Shipment bll = new SKT.LeanMES.Shipment.BLL.Shipment();
                    SKT.LeanMES.Shipment.Model.ShipmentInfo shipmentInfo = bll.GetInfo(entity.ShipmentId);
                    entity.ShipDate = Convert.ToDateTime(WebHelper.FormatToDate(entity.ShipDateStr));
                    entity.AuditDateTime = Convert.ToDateTime(WebHelper.FormatToDate(null));
                    entity.RejectDateTime = Convert.ToDateTime(WebHelper.FormatToDate(null));
                    entity.CreateDateTime = Convert.ToDateTime(WebHelper.FormatToDate(null));
                    entity.ModifyDateTime = Convert.ToDateTime(WebHelper.FormatToDate(null));
                    if (shipmentInfo == null)
                    {
                        entity.ShipmentId  = - 1;
                    }
                    else if (shipmentInfo != null && shipmentInfo.State==1)
                    {
                        entity.OrderNO = shipmentInfo.OrderNO;
                        entity.State = shipmentInfo.State;
                    }
                    else
                    {
                        return -1;
                    }
                    return bll.Edit(entity);
                }

                try
                {
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return 0;
        }

        [AjaxMethod]
        public bool IsOperability(int id)
        {
            SKT.LeanMES.Shipment.BLL.Shipment bll = new LeanMES.Shipment.BLL.Shipment();
            SKT.LeanMES.Shipment.Model.ShipmentInfo  shipmentInfo = bll.GetInfo(id);
            if (shipmentInfo != null)
            {
                if (shipmentInfo.State == 1)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return true;
            }
        }

        [AjaxMethod]
        public int Audi(int id, int flag)
        {
            SKT.LeanMES.Shipment.BLL.Shipment bll = new LeanMES.Shipment.BLL.Shipment();
            SKT.LeanMES.Shipment.Model.ShipmentInfo shipmentInfo = bll.GetInfo(id);
            if (shipmentInfo != null)
            {
                if (shipmentInfo.State == 3)
                {
                    return -2;
                }
                else if (shipmentInfo.State == 1)
                {
                    if (flag == 1)
                    {
                        shipmentInfo.State = 2;
                        shipmentInfo.AuditBy = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                        shipmentInfo.AuditDateTime = DateTime.Now;
                    }
                    else if (flag == 2)
                    {
                        return 0;
                    }
                    else
                    {
                        return -1;
                    }

                }
                else if (shipmentInfo.State == 2)
                {
                    if (flag == 1)
                    {
                        return 0;
                    }
                    else if (flag == 2)
                    {
                        shipmentInfo.State = 1;
                        shipmentInfo.RejectBy = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                        shipmentInfo.RejectDateTime = DateTime.Now;
                    }
                    else
                    {
                        return -1;
                    }
                }
                return bll.Edit(shipmentInfo);
            }
            else
            {
                return -1;
            }

           
        }
    }
}