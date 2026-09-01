using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.Turnover.BLL;
using SKT.LeanMES.Turnover.Model;
using AjaxPro;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxTurnover
    {
        /// <summary>
        /// 编辑周转工具分组
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditTurnoverGroup(TurnoverGroupInfo entity)
        {
            try
            {
                TurnoverGroup bll = new TurnoverGroup();

                if (entity.TurnoverGroupId == -1)
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
        /// 编辑周转工具种类
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void EditTurnoverType(TurnoverTypeInfo entity)
        {
            try
            {
                TurnoverType bll = new TurnoverType();

                if (entity.TurnoverTypeId == -1)
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
        /// 注册一个周转工具编号
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void TurnoverNumberAdd(TurnoverDataInfo entity)
        {
            if (SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(AccountController.GetCurrentUser().UserId, 20170104))
            {
                try
                {
                    TurnoverData bll = new TurnoverData();

                    entity.ModifyBy = "";
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;

                    bll.Edit(entity);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
            }
            else
            {
                throw new Exception(Resources.Messages.NotWarranttedToOperater);
            }
        }

        /// <summary>
        /// 删除一个周转工具编号
        /// </summary>
        /// <param name="turnoverNumber">周转工具编号</param>
        /// <param name="turnoverGroupId">周转工具分组Id</param>
        [AjaxMethod]
        public void TurnoverNumberDelete(String turnoverNumber, Int32 turnoverGroupId)
        {
            if (SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(AccountController.GetCurrentUser().UserId, 20170104))
            {
                try
                {
                    TurnoverData bll = new TurnoverData();

                    bll.Delete(turnoverNumber, AccountController.GetCurrentUser().UserName, turnoverGroupId);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
            }
            else
            {
                throw new Exception(Resources.Messages.NotWarranttedToOperater);
            }
        }


        /***********打印包装箱号***************/
        //[AjaxMethod]
        //public string GetCartonData(string orderNo, string qty, string endor, string rohs, string date, string box, string model, string po, string spec, string left)
        //{
        //    string strLabel = "";
        //    try
        //    {
        //        DataTable dtCarton = new DataTable();
        //        dtCarton.Columns.Add(new DataColumn("order", typeof(string)));
        //        dtCarton.Columns.Add(new DataColumn("qty", typeof(string)));
        //        dtCarton.Columns.Add(new DataColumn("endor", typeof(string)));
        //        dtCarton.Columns.Add(new DataColumn("rohs", typeof(string)));
        //        dtCarton.Columns.Add(new DataColumn("date", typeof(string)));
        //        dtCarton.Columns.Add(new DataColumn("box", typeof(string)));
        //        dtCarton.Columns.Add(new DataColumn("model", typeof(string)));
        //        dtCarton.Columns.Add(new DataColumn("po", typeof(string)));
        //        dtCarton.Columns.Add(new DataColumn("spec", typeof(string)));
        //        DataRow row = dtCarton.NewRow();
        //        row["endor"] = "供应商：" + endor;
        //        row["box"] = "箱号：" + box;
        //        row["po"] = "订单号：" + po;
        //        row["order"] = "工单号：" + orderNo;
        //        row["qty"] = "数量：" + qty;
        //        row["rohs"] = "环保：" + rohs;
        //        row["spec"] = "品名规格：" + spec;
        //        row["model"] = "机种型号:" + model;
        //        row["date"] = "生产日期：" + System.DateTime.Now.ToString("yyyy-MM-dd");
        //        //System.DateTime.Now.ToShortDateString();
        //        dtCarton.Rows.Add(row);
        //        strLabel = (new ZPLPrinter()).ZPLPrintCartonNumberLabel(dtCarton, true, left);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //    return strLabel;
        //}

        /************End************/


        /***********打印包装箱号升级版本 watson 2015-04-04***************/
        //[AjaxMethod]
        //public string GetCartonLabelData(Int32 ContainerID, string orderNo, string qty, string box, string modelspec, string left)
        //{
        //    string strLabel = "";
        //    string strLabelName = "";
        //    try
        //    {
        //        ContainerDocument conDocument = new ContainerDocument();
        //        DataTable dtLabel = conDocument.GetProcedureByContainerID(ContainerID, orderNo, box);
        //        if (dtLabel != null && dtLabel.Rows.Count > 0)
        //        {
        //            for (int i = 0; i < dtLabel.Columns.Count; i++)
        //            {
        //                if (dtLabel.Columns[i].ColumnName.ToUpper().Trim() == "QTY")
        //                {
        //                    dtLabel.Rows[0][i] = qty;
        //                }
        //                if (dtLabel.Columns[i].ColumnName.ToUpper().Trim() == "SPEC")
        //                {
        //                    dtLabel.Rows[0][i] = modelspec;
        //                }
        //            }
        //        }
        //        strLabelName = conDocument.GetLabelNameByContainerID(ContainerID);
        //        strLabel = (new ZPLPrinter()).ZPLPrintBoxCartonLabel(dtLabel, true, strLabelName, left);
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //    }
        //    return strLabel;
        //}
        /************End************/ 
    }
}