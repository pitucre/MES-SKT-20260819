using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Container.Model;
using SKT.LeanMES.Container.BLL;
using System.Data;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxContainer
    {
        #region 容器列表新增编辑删除
        /// <summary>
        ///更新或者增加容器信息
        /// </summary>
        /// <param name="entity">容器实体类</param>
        /// <param name="PLStr"></param>
        /// <param name="PLVStr"></param>
        /// <param name="RevStr"></param>
        /// <param name="SOIDStr"></param>
        /// <param name="SONStr"></param>
        /// <param name="MinQStr"></param>
        /// <param name="MaxQStr"></param>
        /// <param name="SeaStr"></param>
        /// <param name="DNStr"></param>
        /// <param name="DIDStr"></param>
        [AjaxMethod]
        public void EditContainer(ContainerInfo entity, string PLStr, string PLVStr, string RevStr, string SOIDStr, string MinQStr, string MaxQStr, string PLVIDStr, string SeaStr, string DIDStr, string CDIDStr, string PackingTypeStr)
        {
            try
            {
                SKT.LeanMES.Container.BLL.Container bllContainer = new SKT.LeanMES.Container.BLL.Container();
                if (entity.ContainerId == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bllContainer.Edit(entity, PLStr, PLVStr, RevStr, SOIDStr, MinQStr, MaxQStr, PLVIDStr, SeaStr, DIDStr, CDIDStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取容器信息包装信息列表
        /// </summary>
        /// <param name="ContainerId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ContainerPackingLevelInfo> GetContainerPackingLevel(string ContainerId)
        {
            try
            {
                SKT.LeanMES.Container.BLL.ContainerPackingLevel bllContainerPackingLevel = new SKT.LeanMES.Container.BLL.ContainerPackingLevel();

                List<ContainerPackingLevelInfo> Listentity = bllContainerPackingLevel.GetInfo(ContainerId);
                return Listentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public List<ContainerDocumentInfo> GetContainerDocument(string ContainerId)
        {
            try
            {
                SKT.LeanMES.Container.BLL.ContainerDocument bllGetContainerDocument = new SKT.LeanMES.Container.BLL.ContainerDocument();

                List<ContainerDocumentInfo> Listentity = bllGetContainerDocument.GetInfo(ContainerId);
                return Listentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public bool ContainerDocumentDelete(string ContainerDocumentID)
        {
            try
            {
                SKT.LeanMES.Container.BLL.ContainerDocument bllContainerDocument = new SKT.LeanMES.Container.BLL.ContainerDocument();
                bllContainerDocument.Delete(ContainerDocumentID, AccountController.GetCurrentUser().UserName);
                return true;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return false;
            }
        }

        [AjaxMethod]
        public bool ContainerPackingLevelDelete(string ContainerPackingLevelID)
        {
            try
            {
                SKT.LeanMES.Container.BLL.ContainerPackingLevel bllContainerPackingLevel = new SKT.LeanMES.Container.BLL.ContainerPackingLevel();
                bllContainerPackingLevel.Delete(ContainerPackingLevelID, AccountController.GetCurrentUser().UserName);
                return true;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return false;
            }
        }
        #endregion

        #region 打印更重打印
        [AjaxMethod]
        public int GetNextIDByTypeValue(string typeValue)
        {
            try
            {
                SKT.LeanMES.Container.BLL.Container bllData = new LeanMES.Container.BLL.Container();
                return bllData.GetNextIDByTypeValue(typeValue);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return -1;
            }
        }

        [AjaxMethod]
        public string PrintMoreCaronSNStr(int NextID, int Qty, int ContainerID, int OpeID, int ResID, int UserID)
        {
            string cartonNumberStr = "";
            try
            {
                SKT.LeanMES.Container.BLL.Container numberBll = new LeanMES.Container.BLL.Container();
                cartonNumberStr = numberBll.PrintMoreCaronSNStr(NextID, Qty, ContainerID, OpeID, ResID, UserID);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return cartonNumberStr;
        }

        /***********打印包装箱号升级版本 watson 2015-04-04***************/
        [AjaxMethod]
        public string GetCartonLabelData(Int32 ContainerID, string orderNo, string qty, string box, string modelspec, string left)
        {
            string strLabel = "";
            //string strLabelName = "";

            //try
            //{
            //    ContainerDocument conDocument = new ContainerDocument();
            //    DataTable dtLabel = conDocument.GetProcedureByContainerID(ContainerID, orderNo, box);
            //    if (dtLabel != null && dtLabel.Rows.Count > 0)
            //    {
            //        for (int i = 0; i < dtLabel.Columns.Count; i++)
            //        {
            //            if (dtLabel.Columns[i].ColumnName.ToUpper().Trim() == "QTY")
            //            {
            //                dtLabel.Rows[0][i] = qty;
            //            }
            //            if (dtLabel.Columns[i].ColumnName.ToUpper().Trim() == "SPEC")
            //            {
            //                dtLabel.Rows[0][i] = modelspec;
            //            }
            //        }
            //        strLabelName = conDocument.GetLabelNameByContainerID(ContainerID);
            //        SKT.LeanMES.Print.BLL.ZPLPrinter zplPrint = new Print.BLL.ZPLPrinter();
            //        //strLabel = zplPrint.ZPLPrintBoxCartonLabel(dtLabel, true, strLabelName, left);
            //    }
            //}
            //catch (Exception ex)
            //{
            //    WebHelper.HandleException(ex);
            //}
            return strLabel;
        }
        /************End************/  
        #endregion
    }
}