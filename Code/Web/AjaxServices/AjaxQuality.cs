using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Quality.BLL;
using AjaxPro;
using SKT.Common.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxQuality
    {
        /// <summary>
        /// 更新或者增加良品率预警信息
        /// </summary>
        /// <param name="entity">良品率预警实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void WarnSettingsEdit(SKT.LeanMES.Quality.Model.WarnSettingsInfo entity)
        {
            try
            {
                new SKT.LeanMES.Quality.BLL.WarnSettings().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 对工单，产品，物料，在制品进行Hold 或者 UnHold操作。
        /// </summary>
        /// <param name="objectNO"></param>
        /// <param name="objectFlag">1 工单， 2 产品 ，3 物料， 4 在制品</param>
        /// <param name="causeDescription"></param>
        /// <param name="userName"></param>
        /// <param name="tag">1 Hold 2 UnHold</param>
        [AjaxMethod]
        public HoldInfo HoldOrUnHold(string objectNO, int objectFlag, string causeDescription, string userName, int tag)
        {
            HoldInfo model = new HoldInfo();

            try
            {
                model = (new SKT.LeanMES.Quality.BLL.Hold()).ObjectHoldOrUnHold(objectNO, objectFlag, causeDescription, userName, tag);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return model;
        }
        [AjaxMethod]
        public List<AQLRuleMemberInfo> GetAQLRuleMemberList(int id)
        {
            List<AQLRuleMemberInfo> list = new List<AQLRuleMemberInfo>();
            try
            {
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = " AQLRuleId=" + id;
                list = new LeanMES.Quality.BLL.AQLRuleMember().GetAll(0, int.MaxValue, "", search);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// InspectionItem
        /// </summary>
        /// <param name="entity">InspectionItemInfo Object</param>
        /// <returns></returns>
        [AjaxMethod]
        public void AQLRuleEdit(AQLRuleInfo entity, List<AQLRuleMemberInfo> list)
        {
            try
            {
                new LeanMES.Quality.BLL.AQLRule().Edit(entity, list);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// AQL PLAN
        /// </summary>
        /// <param name="entity">AQL PLAN OBJECT</param>
        /// <returns></returns>
        [AjaxMethod]
        public void AQLSampleEdit(int id, string name, string value, string description, string createdate, string create)
        {
            try
            {
                var entity = new AQLSampleInfo
                {
                    AQLSampleId = id,
                    AQLSampleName = name,
                    AQLSampleValue = double.Parse(value),
                    AQLSampleDescription = description,
                };
                if (id > 0)
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyDate = DateTime.Now;
                    entity.CreaterBy = create;
                    entity.CreateDate = string.IsNullOrEmpty(createdate) ? new DateTime(9999, 12, 31) : Convert.ToDateTime(createdate);
                }
                else
                {
                    entity.CreaterBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateDate = DateTime.Now;
                    entity.ModifyBy = "";
                    entity.ModifyDate = new DateTime(9999, 12, 31);
                }
                new SKT.LeanMES.Quality.BLL.AQLSample().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// InspectionType
        /// </summary>
        /// <param name="entity">InspectionTypeInfo Object</param>
        /// <returns></returns>
        [AjaxMethod]
        public void InspectionTypeEdit(string strJson)
        {
            try
            {
                new LeanMES.Quality.BLL.InspectionType().Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 模板编辑
        /// </summary>
        /// <param name="info">InspectionTemplateInfo Object</param>
        /// <returns></returns>
        [AjaxMethod]
        public void InspectionTemplateEdit(string strJson)
        {
            try
            {
                new LeanMES.Quality.BLL.InspectionTemplate().Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 模板编辑
        /// </summary>
        /// <param name="info">InspectionTemplateInfo Object</param>
        /// <returns></returns>
        [AjaxMethod]
        public int InspectionTemplateEditJW(string strJson)
        {
            int Id = -1;
            try
            {
                Id = new LeanMES.Quality.BLL.InspectionTemplate().EditJW(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            return Id;
        }

        [AjaxMethod]
        public void DeleteFAIInspectionTemplateFile(int id)
        {
            try
            {
                new LeanMES.Quality.BLL.InspectionTemplate().DeleteFAIInspectionTemplateFile(id);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 检验单审核
        /// </summary>
        /// <param name="id"></param>
        /// <param name="res"></param>
        /// <param name="rem"></param>
        /// <param name="UserId"></param>
        [AjaxMethod]
        public void InspectionOrderConfirmationSave(int id, string res, string rem, int UserId)
        {

            try
            {
                InspectionOrder bll = new InspectionOrder();
                bll.InspectionOrderConfirmationSave(id, res, rem, UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 组长审核
        /// </summary>
        /// <param name="id"></param>
        /// <param name="res"></param>
        /// <param name="rem"></param>
        /// <param name="UserId"></param>
        [AjaxMethod]
        public void InspectionOrderSaveGroupAffirm(int id, string res, string rem, int UserId)
        {

            try
            {
                InspectionOrder bll = new InspectionOrder();
                bll.InspectionOrderSaveGroupAffirm(id, res, rem, UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 工程审核
        /// </summary>
        /// <param name="id"></param>
        /// <param name="res"></param>
        /// <param name="rem"></param>
        /// <param name="UserId"></param>
        [AjaxMethod]
        public void InspectionOrderSaveProjectAffirm(int id, string res, string rem, int UserId)
        {

            try
            {
                InspectionOrder bll = new InspectionOrder();
                bll.InspectionOrderSaveProjectAffirm(id, res, rem, UserId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
 
    /// <summary>
    /// 通过模板ID获取检验项目
    /// </summary>
    /// <param name="InspectionTemplateId"></param>
    /// <returns></returns>
    [AjaxMethod]
        public List<InspectionTemplateMemberInfo> GetInspectionTemplateMemberByTempId(Int32 InspectionTemplateId)
        {
            List<InspectionTemplateMemberInfo> list = new List<InspectionTemplateMemberInfo>();
            try
            {
                InspectionTemplateMember bll = new InspectionTemplateMember();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = "a.[InspectionTemplateId] = " + InspectionTemplateId;
                list = bll.GetAllJW(0, int.MaxValue, " a.[CreateDateTime] asc ", search);
                //  list = bll.GetAll(0, int.MaxValue, "", search);
                list = list.OrderBy(r => r.OpenID).ToList();

                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        /// <summary>
        /// 通过模板ID获取检验项目
        /// </summary>
        /// <param name="InspectionTemplateId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<InspectionTemplateMemberInfo> GetInspectionTemplateMemberByTempId2(Int32 InspectionTemplateId)
        {
            List<InspectionTemplateMemberInfo> list = new List<InspectionTemplateMemberInfo>();
            try
            {
                InspectionTemplateMember bll = new InspectionTemplateMember();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = "a.[InspectionTemplateId] = " + InspectionTemplateId;
                list = bll.GetAllJW(0, int.MaxValue, " a.OpenId,a.[InspectionItemId] asc ", search);
                //  list = bll.GetAll(0, int.MaxValue, "", search);
                list = list.OrderBy(r => r.OpenID).ToList();

                return list;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        /// <summary>
        /// InspectionItem
        /// </summary>
        /// <param name="entity">InspectionItemInfo Object</param>
        /// <returns></returns>
        [AjaxMethod]
        public void InspectionTemplateItemEdit(string strJson)
        {
            try
            {
                new LeanMES.Quality.BLL.InspectionTemplateItem().Edit(strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// InspectionItem
        /// </summary>
        /// <param name="entity">InspectionItemInfo Object</param>
        /// <returns></returns>
        [AjaxMethod]
        public void InspectionItemEdit(InspectionItemInfo info)
        {
            try
            {
                info.Creater = AccountController.GetCurrentUser().UserName;
                info.CreateTime = DateTime.Now;
                new LeanMES.Quality.BLL.InspectionItem().Edit(info);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 批量导入QHold信息
        /// </summary>
        /// <param name="xml"></param>
        /// <param name="objectFlag"></param>
        /// <param name="userName"></param>
        /// <param name="tag"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<HoldInfo>  SaveQHold(string xml, int objectFlag,string userName, int tag, out string msg1, out string msg2)
        {
            msg1 = "";
            msg2 = "";
            List<HoldInfo> model = new List<HoldInfo>();
            try
            {
                model = (new SKT.LeanMES.Quality.BLL.Hold()).ObjectHoldOrUnHold(xml, objectFlag, userName, tag,out msg1,out msg2);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;

        }

        #region 查询物料条码信息
        /// <summary>
        /// 查询物料条码信息
        /// </summary>
        /// <param name="MoCode"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<HoldInfo> GetQueryGRN(string itemcode,string datecode,string lotcode,string vendorcode)
        {
            List<HoldInfo> list = null;
            try
            {
                list = (new SKT.LeanMES.Quality.BLL.Hold()).GetQueryGRN(itemcode, datecode, lotcode, vendorcode);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region 保存导入GRN信息
        /// <summary>
        /// 保存导入GRN信息
        /// </summary>
        /// <param name="entityList"></param>
        [AjaxMethod]
        public void SaveImportGRN(String entityList)
        {
            try
            {
                (new SKT.LeanMES.Quality.BLL.Hold()).SaveImportGRN(entityList, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion

        #region 批量导入UNHold信息
        [AjaxMethod]
        public List<HoldInfo> GetFileName() {
            List<HoldInfo> model = new List<HoldInfo>();
            try
            {            
                string cmdTxt = string.Format("  SELECT FILENAME FROM [Quality_HoldHistory]  GROUP BY FILENAME HAVING  FILENAME IS NOT NULL");
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    for (int k = 0; k < dt.Columns.Count; k++)
                    {
                        HoldInfo t = new HoldInfo();
                        t.ObjectCode = dt.Rows[i][k].ToString();
                        model.Add(t);
                    }
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;

        }

        [AjaxMethod]
        public List<HoldInfo> GetUnQholdALL(string fileName)
        {
            List<HoldInfo> model = new List<HoldInfo>();
            try
            {
                string cmdTxt = string.Format("  SELECT ObjectCode,OperatePerson,OperateDateTime FROM [Quality_HoldHistory] WHERE FILENAME='{0}'", fileName);
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    for (int k = 0; k < 1; k++)
                    {
                        HoldInfo t = new HoldInfo();
                        t.ObjectCode = dt.Rows[i][k].ToString();
                        t.OperatePerson = dt.Rows[i][k+1].ToString();
                        t.OperateDateTime = Convert.ToDateTime(dt.Rows[i][k + 2]);
                        model.Add(t);
                    }
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return model;

        }

        [AjaxMethod]
        public List<HoldInfo> SaveUnQHold(string SNList, int objectFlag, string userName, int tag,string fileName)
        {
            List<HoldInfo> list = new List<HoldInfo>(); 
                try
                {
                string objectNO = SNList.TrimEnd(',');
                 list = (new SKT.LeanMES.Quality.BLL.Hold()).SaveImportUnHold(objectNO, objectFlag, userName, tag,fileName);                 
                }
                catch (Exception ex)
                {                 
                    WebHelper.HandleException(ex);
                }         
            return list;

        }
        #endregion

        #region 查询QHold的工单信息
        /// <summary>
        /// 查询QHold的工单信息
        /// </summary>
        /// <param name="OrderNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<HoldInfo> GetQueryQHold(string objectNo)
        {
            List<HoldInfo> list = null;
            try
            {
                list = (new SKT.LeanMES.Quality.BLL.Hold()).GetQueryQHold(objectNo);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }
        #endregion

        #region 保存UnHold信息
        /// <summary>
        /// 保存UnHold信息
        /// </summary>
        /// <param name="entityList"></param>
        [AjaxMethod]
        public void SaveObjectUnHold(string entityList, int objectFlag, string causeDescription)
        {
            try
            {
                (new SKT.LeanMES.Quality.BLL.Hold()).SaveObjectUnHold(entityList, objectFlag, causeDescription, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        #endregion
    }
}