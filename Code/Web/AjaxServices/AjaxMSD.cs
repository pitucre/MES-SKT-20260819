using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.MSD.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMSD
    {
        #region MSL信息维护
        
        /// <summary>
        /// 湿度等级信息编辑
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Int32 MslEdit(MslInfo entity)
        {
            int mslId = -1;
            try
            {
                if (entity.MslId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                mslId =  new SKT.LeanMES.MSD.BLL.Msl().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return mslId;
        }

        /// <summary>
        /// 获取湿度等级相关信息
        /// </summary>
        /// <param name="mslId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public MslInfo GetMSLInfo(int mslId)
        {
            var entity = new MslInfo();
            try
            {
                entity = new SKT.LeanMES.MSD.BLL.Msl().GetInfo(mslId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        #endregion

        #region MSD容器信息维护
        
        /// <summary>
        /// 编辑MSD容器信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Int32 MsdContainerEdit(MsdContainerInfo entity)
        {
            int msdContainerId = -1;
            try
            {
                if (entity.MsdContainerId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                msdContainerId = new SKT.LeanMES.MSD.BLL.MsdContainer().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return msdContainerId;
        }

        #endregion

        #region MSD客户端数据维护

        /// <summary>
        ///  采集MSD物料的开包信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void MSDUnPack(string grn, int stationId, int resId)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            var entity = new MslInfo();
            try
            {
                 new SKT.LeanMES.MSD.BLL.MsdClient().MSDUnPack(grn,stationId,resId,userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }            
        }

        /// <summary>
        /// 采集MSD物料的封装信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="containerCode"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void MSDPack(string grn, string containerCode, int stationId, int resId)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            var entity = new MslInfo();
            try
            {
                new SKT.LeanMES.MSD.BLL.MsdClient().MSDPack(grn,containerCode, stationId, resId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        ///  获取MSD物料的基本信息
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public MSDProductInfo GetMSDProductInfo(string grn)
        {
            var entity = new MSDProductInfo();
            try
            {
                entity = new SKT.LeanMES.MSD.BLL.MsdClient().GetMSDProductInfo(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        /// <summary>
        /// 获取MSD物料的操作历史
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MsdClientInfo> GetMSDOperateHistory(string grn)
        {
            var list = new List<MsdClientInfo>();
            try
            {
                list = new SKT.LeanMES.MSD.BLL.MsdClient().GetMSDOperateHistory(grn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 采集MSD物料的入炉信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="containerCode"></param>
        /// <param name="bakeTemp"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void MSDBake(string grn, string containerCode,decimal bakeTemp, int stationId, int resId)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            var entity = new MslInfo();
            try
            {
                new SKT.LeanMES.MSD.BLL.MsdClient().MSDBake(grn, containerCode,bakeTemp, stationId, resId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 采集MSD物料的出炉信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        [AjaxMethod]
        public void MSDUnBake(string grn, int stationId, int resId)
        {
            string userName = AccountController.GetCurrentUser().UserName;
            var entity = new MslInfo();
            try
            {
                new SKT.LeanMES.MSD.BLL.MsdClient().MSDUnBake(grn, stationId, resId, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion
    }
}