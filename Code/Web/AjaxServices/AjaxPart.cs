using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPart
    {
        //[AjaxMethod]
        //public int PartEdit(PartInfo entity, String factoryDate)
        //{
        //    try
        //    {
        //        SKT.LeanMES.Equipment.BLL.Part bll = new SKT.LeanMES.Equipment.BLL.Part();
        //        entity.FactoryDate = Convert.ToDateTime(factoryDate);
        //        if (entity.PartId == -1) //add new one record
        //        {
        //            entity.CreateBy = AccountController.GetCurrentUser().UserName;
        //            entity.ModifyBy = "";
        //        }
        //        else // update selected record
        //        {
        //            entity.CreateBy = "";
        //            entity.ModifyBy = AccountController.GetCurrentUser().UserName;
        //        }
        //        return bll.Edit(entity);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //        return 0;
        //    }
        //}

        /// <summary>
        /// add 20171012 zhuxi 
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int PartEdit(PartInfo entity)
        {
            try
            {
                SKT.LeanMES.Equipment.BLL.Part bll = new SKT.LeanMES.Equipment.BLL.Part();
              
                if (entity.PartId == -1) //add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else // update selected record
                {
                    entity.CreateBy = "";
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                }
                return bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }

        /// <summary>
        /// 删除备件设备关系
        /// </summary>
        /// <param name="partId">备件ID</param>

        /// <param name="itemIdString">设备ID</param>
        [AjaxMethod]
        public void RemovePartOutEquipment(int partId,string itemIdString)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                var bll = new LeanMES.Equipment.BLL.Part();
                bll.RemovePartOutEquiment(partId, itemIdString, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        ///保存备件与设备关系
        /// </summary>
        /// <param name="partId">备件ID</param>
        /// <param name="itemIdString">设备ID</param>
        /// <returns></returns>
        [AjaxMethod]
        public int SavePartInEquiment(int partId,string itemIdString)
        {
            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                var bll = new LeanMES.Equipment.BLL.Part();
                return bll.SavePartInEquiment(partId, itemIdString, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return 0;
        }


        [AjaxMethod]
        public PartInfo GetPartInfo(string partCode)
        {
            var partInfo=new PartInfo();
            try
            {
                SKT.LeanMES.Equipment.BLL.Part bll = new SKT.LeanMES.Equipment.BLL.Part();
                partInfo= bll.GetInfo(partCode);

                return partInfo;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return partInfo;
            }
        }

        /// <summary>
        /// 备件出入库
        /// </summary>
        /// <param name="PartId"></param>
        /// <param name="Type"></param>
        /// <param name="Qty"></param>
        /// <param name="opType">Type=1(0=新增入库  1=产线入库)  Type=2(0=使用出库 1=报废出库)</param>
        [AjaxMethod]
        public void InOut(int PartId, int Type, int Qty,string remark,int opType)
        {
            try
            {
                var userName = AccountController.GetCurrentUserInfo().UserName;
                new Part().InOut(PartId, Type, Qty, userName,remark,opType);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}