using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.Container.BLL;
using SKT.LeanMES.Container.Model;
using AjaxPro;
using SKT.Common.Model;
namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxDIPPackaging
    {
        /// <summary>
        /// 楼层编辑
        /// </summary>
        /// <param name="model"></param>
        [AjaxMethod]
        public void FloorInfoEdit(SKT.LeanMES.Container.Model.FloorInfoInfo model)
        {
            try
            {
                new FloorInfo().Edit(model);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 楼层线别编辑
        /// </summary>
        /// <param name="model"></param>
        [AjaxMethod]
        public void FloorLineInfoEdit(SKT.LeanMES.Container.Model.FloorLineInfoInfo model)
        {
            try
            {
                new FloorLineInfo().Edit(model);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// DIP包装计划编辑
        /// </summary>
        /// <param name="model"></param>
        /// <param name="txtPlanDatiTime"></param>
        [AjaxMethod]
        public void DIPPackagingPlanEdit(SKT.LeanMES.Container.Model.DIPPackagingPlanInfo model, string txtPlanDatiTime)
        {
            try
            {
                model.PlanDatiTime = DateTime.Parse(txtPlanDatiTime);
                new DIPPackagingPlan().Edit(model);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 根据物料代码查询物料信息
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public SKT.LeanMES.Product.Model.ItemInfo GetItemModel(string ItemCode)
        {
            SKT.LeanMES.Product.BLL.Item bll = new LeanMES.Product.BLL.Item();
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("ItemCode", ItemCode);
            var list = bll.GetAll(0, 10, "", searchSettings);
            if (list.Count > 0)
            {
                return list[0];
            }
            else
            {
                return new LeanMES.Product.Model.ItemInfo();
            }
        }
  

      
      
      
     
    }
}