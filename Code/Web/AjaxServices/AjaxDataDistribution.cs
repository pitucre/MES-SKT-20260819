using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.DataDistribution.BLL;
using SKT.Common.Model;
using SKT.LeanMES.DataDistribution.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxDataDistribution
    {
        /// <summary>
        /// 数据下发增加和编辑 by liwen 20200924
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void DataDistributionEdit(DataDistributionInfo entity)
        {
            try
            {
                DataDistributionBll bll = new DataDistributionBll();

                if (entity.ID == -1)
                {
                    entity.AddPerson =Convert.ToString(AccountController.GetCurrentUser().UserId);
                    entity.AddPersonName = AccountController.GetCurrentUser().UserName;
                }
                else
                {
                    entity.UpdatePerson = Convert.ToString(AccountController.GetCurrentUser().UserId);
                    entity.UpdatePersonName = AccountController.GetCurrentUser().UserName;
                }
                bll.Edit(entity);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public List<DataDistributionInfo> GetDataDistributionALL()
        {
            SearchSettings searchSettings = new SearchSettings();
            DataDistributionBll bll = new DataDistributionBll();
            List<DataDistributionInfo> list = bll.GetAll(0, int.MaxValue, "ID", searchSettings);
            return list;
        }

        /// <summary>
        /// 下发分配部门
        /// </summary>
        [AjaxMethod]
        public void AssignDataDistributionDepart(String IDS)
        {
            try
            {
                (new YDataDistributionOrgnization()).Add(IDS);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 移除分配部门
        /// </summary>
        [AjaxMethod]
        public void RemoveDataDistributionDepart(string IDS)
        {
            try
            {
                (new YDataDistributionOrgnization()).Remove(IDS);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 下发数据到事业部
        /// </summary>
        [AjaxMethod]
        public void DataDistributionOp(string prameter, string DepartCodeList,string CreateBy,string typename)
        {
            try
            {
                DataDistributionSYBConfig obj = new DataDistributionSYBConfig();
                if (typename == "OrgDataDistributionOperate")
                {
                    //下发账套
                    obj.DataDistributionOrgOp(prameter, DepartCodeList, CreateBy);
                }
                else if (typename == "MaterialDataDistributionOperate") {
                    //下发产品
                    obj.DataDistributionOp(prameter, DepartCodeList, CreateBy);
                }
                else if (typename == "SupplierDataDistributionOperate")
                {
                    //下发供应商
                    obj.DataDistributionSupplierOp(prameter, DepartCodeList, CreateBy);
                }
                else if (typename == "CustomerDataDistributionOperate")
                {
                    //下发客户
                    obj.DataDistributionCustomerOp(prameter, DepartCodeList, CreateBy);
                }
                else if (typename == "ShopOrderDataDistributionOperate")
                {
                    //下发工单
                    obj.DataDistributionShopOrderOp(prameter, DepartCodeList, CreateBy);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}