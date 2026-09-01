using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.CapacityVerfyRecord.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxCapacityVerfyRecord
    {
        /// <summary>
        /// 编辑设备类型
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void CapacityVerfyRecordEdit(int ID, string Salary)
        {
            try
            {
                SKT.LeanMES.CapacityVerfyRecord.BLL.CapacityVerfyRecord bll = new SKT.LeanMES.CapacityVerfyRecord.BLL.CapacityVerfyRecord();

                var ModifyBy = AccountController.GetCurrentUser().UserName;

                var num = bll.Update(ID, Salary, ModifyBy);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        [AjaxMethod]
        public void Audit(string ids)
        {
            try
            {
                SKT.LeanMES.CapacityVerfyRecord.BLL.CapacityVerfyRecord bll = new SKT.LeanMES.CapacityVerfyRecord.BLL.CapacityVerfyRecord();
                string UserName = AccountController.GetCurrentUser().UserName;
                bll.Audit(ids, UserName);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.InnerException.Message);
            }
        }

        /// <summary>
        /// frank.fang 2017-03-31获取产能信息
        /// </summary>
        /// <param name="datetime">查询时间</param>
        /// <param name="usercode">工号</param>
        [AjaxMethod]
        public List<CapacityVerfyInfo> GetCapacityInfo(string datetime, string usercode, int OpeId)
        {
            List<CapacityVerfyInfo> list = null;
            try
            {

                SKT.LeanMES.CapacityVerfyRecord.BLL.CapacityVerfy bll = new SKT.LeanMES.CapacityVerfyRecord.BLL.CapacityVerfy();
                list = bll.GetCapacityInfo(datetime, usercode, OpeId, 0);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;

        }

        /// <summary>
        /// 产能确认
        /// </summary>
        /// <param name="date">查询日期</param>
        /// <param name="remark">备注信息</param>
        /// <param name="userId">确认用户ID</param>
        /// <param name="scanData">数据集合</param>
        [AjaxMethod]
        public void SaveCapacityRecordEdit(string date, string remark, int userId, string scanData)
        {
            try
            {
                string verfyBy = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                (new SKT.LeanMES.CapacityVerfyRecord.BLL.CapacityVerfy()).SaveCapacityRecordEdit(date, remark, userId, scanData, "0", 0, verfyBy);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}