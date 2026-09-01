using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Customer.Model;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxCustomer
    {
        /// <summary>
        /// 更新或者增加客服信息
        /// </summary>
        /// <param name="entity">客户实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void EditCustomer(SKT.LeanMES.Customer.Model.CustomerInfo entity)
        {
            try
            {
                if (entity.CustomerID == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                new SKT.LeanMES.Customer.BLL.Customer().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 更新或者增加客服项目信息
        /// </summary>
        /// <param name="entity">客户项目实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void ProjectEdit(SKT.LeanMES.Customer.Model.ProjectInfo entity)
        {
            try
            {
                if (entity.ProjectId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                new SKT.LeanMES.Customer.BLL.Project().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #region 保存订单信息
        /// <summary>
        /// 保存订单信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void CustomerOrderEdit(ProjectInfo entity)
        {
            try
            {
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                SKT.LeanMES.Customer.BLL.Project bll = new SKT.LeanMES.Customer.BLL.Project();
                bll.CustomerOrderEdit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 通过订单号获取订单明细
        /// /// </summary>
        /// <param name="InspectionTemplateId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<CustomerOrderDtlInfo> GetOrderDtlList(string OrderCode)
        {
            List<CustomerOrderDtlInfo> list = new List<CustomerOrderDtlInfo>();
            try
            {
                SKT.LeanMES.Customer.BLL.Project bll = new SKT.LeanMES.Customer.BLL.Project();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition += string.Format("  CustomerOrder='{0}' ", OrderCode);
                //search.AddCondition("CustomerOrder", OrderCode);
                list = bll.GetCustomerOrderDtlAll(0, int.MaxValue, "", search);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 订单新增、修改
        /// </summary>
        /// <param name="strjosn"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void CustomerOrderEditNew(string strjosn)
        {
            try
            {
                SKT.LeanMES.Customer.BLL.Project bll = new SKT.LeanMES.Customer.BLL.Project();
                bll.CustomerOrderEditNew(strjosn);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

    }
}