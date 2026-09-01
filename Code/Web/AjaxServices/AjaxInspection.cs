using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using AjaxPro;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.GlobarParameter.Model;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxInspection
    {

        /// <summary>
        /// 通过检验单号获取检验项目
        /// </summary>
        /// <param name="InspectionOrderNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<InspectionTemplateMemberInfo> GetInspectionTemplateMember(String InspectionOrderNo)
        {
            try
            {
                InspectionTemplateMember bll = new InspectionTemplateMember();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = "  e.InspectionOrderNo = '" + InspectionOrderNo + "'";
                List<InspectionTemplateMemberInfo> list = bll.GetAllJoinItem(0, int.MaxValue, "a.Sorting", search);
                return list;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }

        /// <summary>
        /// 通过检验单号获取检验项目
        /// </summary>
        /// <param name="InspectionOrderNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<InspectionTemplateMemberInfo> GetInspectionTemplateMemberByTemplateId(Int32 TemplateId)
        {
            try
            {
                InspectionTemplateMember bll = new InspectionTemplateMember();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = " a.[InspectionTemplateId] = " + TemplateId + "";
                List<InspectionTemplateMemberInfo> list = bll.GetAll(0, int.MaxValue, "", search);
                return list;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }

        [AjaxMethod]
        public List<InspectionOrderMemberInfo> GetInspectionOrderMemberByOrderNoAndSN(String InspectionOrderNo, String SerialNumber)
        {
            List<InspectionOrderMemberInfo> list = new List<InspectionOrderMemberInfo>();
            try
            {
                InspectionOrderMember bll = new InspectionOrderMember();
                SearchSettings search = new SearchSettings();
                search.ExtensionCondition = "a.SerialNumber = '" + SerialNumber + "' AND b.InspectionOrderNo = '" + InspectionOrderNo + "'";
                list = bll.GetAll(0, Int32.MaxValue, "", search);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return list;
        }


        [AjaxMethod]
        public void SaveInspectionOrderMemberItem(InspectionOrderMemberItemInfo info)
        {
            try
            {
                InspectionOrderMemberItem bll = new InspectionOrderMemberItem();
                bll.Edit(info);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        [AjaxMethod]
        public void UpdateInspectionOrderMemberItem(InspectionOrderMemberItemInfo info)
        {
            try
            {
                InspectionOrderMemberItem bll = new InspectionOrderMemberItem();
                bll.Update(info);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }



        [AjaxMethod]
        public void SaveInspectionOrderMemberResult(Int32 IOMemberId, String DealResult)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[] {
                        new SqlParameter("@IOMemberId", SqlDbType.Int),
                        new SqlParameter("@DealResult", SqlDbType.VarChar,20)
                    };

                parms[0].Value = IOMemberId;
                parms[1].Value = DealResult;
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspInspectionOrderMemberResult", parms);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        [AjaxMethod]
        public void SaveInspectionOrderResult(Int32 IOrderId, String DealResult)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[] {
                        new SqlParameter("@IOrderId", SqlDbType.Int),
                        new SqlParameter("@DealResult", SqlDbType.VarChar,20)
                    };

                parms[0].Value = IOrderId;
                parms[1].Value = DealResult;
                SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, "uspInspectionOrderResult", parms);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }


        [AjaxMethod]
        public void SaveInspectionOrderResultComplete(Int32 IOrderId, String DealResult, string UserName, int StationId, int ResId)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[] {
                        new SqlParameter("@IOrderId", SqlDbType.Int),
                        new SqlParameter("@DealResult", SqlDbType.VarChar,20),
                        new SqlParameter("@UserName", SqlDbType.VarChar,20),
                        new SqlParameter("@StationId", SqlDbType.Int),
                        new SqlParameter("@ResId", SqlDbType.Int)
                    };

                parms[0].Value = IOrderId;
                parms[1].Value = DealResult;
                parms[2].Value = UserName;
                parms[3].Value = StationId;
                parms[4].Value = ResId;

                SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, "uspInspectionOrderResultComplete", parms);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }

        //通过单号和受检项目获取已检数量
        [AjaxMethod]
        public int GetInspectionQty(Int32 IOrderId, String InspectionItemName)
        {

            try
            {
                SqlParameter[] parms = new SqlParameter[] {
                        new SqlParameter("@IOrderId", SqlDbType.Int),
                        new SqlParameter("@InspectionItemName", SqlDbType.VarChar,150)
                    };

                parms[0].Value = IOrderId;
                parms[1].Value = InspectionItemName;

                using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionEDQty", parms))
                {
                    while (dr.Read())
                    {
                        int value = dr.GetInt32(0);
                        return value;
                    }
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return 0;
        }

        //通过检验项获取检验资数  flag｛1：检验单  2:受检对象｝
        [AjaxMethod]
        public int GetInspectionItemObjQty(Int32 IOrderId, Int32 IOMemberId, string InspectionItemName, Int32 flag)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[] {
                        new SqlParameter("@IOrderId", SqlDbType.Int),
                         new SqlParameter("@IOMemberId", SqlDbType.Int),
                          new SqlParameter("@Flag", SqlDbType.Int),
                        new SqlParameter("@InspectionItemName", SqlDbType.VarChar,150)
                    };

                parms[0].Value = IOrderId;
                parms[1].Value = IOMemberId;
                parms[2].Value = flag;
                parms[3].Value = InspectionItemName;

                using (SqlDataReader dr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionItemObjEDQty", parms))
                {
                    while (dr.Read())
                    {
                        int value = dr.GetInt32(0);
                        return value;
                    }
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return 0;
        }

        [AjaxMethod]
        public InspectionOrderInfo GetInspectionOrderInfo(String OrderNo)
        {
            try
            {
                InspectionOrder bll = new InspectionOrder();
                InspectionOrderInfo info = bll.GetInfo(OrderNo);
                return info;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        [AjaxMethod]
        public string AdditionalSerialNumber(int InspectionTypeId, int ItemId, string ItemCode, string SNStr, string CreateBy, int IOrderId, int OpeId)
        {
            try
            {
                InspectionOrderMember bll = new InspectionOrderMember();
                return bll.InspectionAdditionalMember(ref IOrderId, InspectionTypeId, ItemId, ItemCode, SNStr, CreateBy, OpeId);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        [AjaxMethod]
        public string AdditionalSerialNumberGeneral(int InspectionTypeId, int ItemId, string ItemCode, string SNStr, string CreateBy, int IOrderId, int OpeId, int LineId, int ResourceId, int StationId, int OrderId, int TemplateId)
        {
            try
            {
                InspectionOrderMember bll = new InspectionOrderMember();
                return bll.InspectionAdditionalMemberGeneral(ref IOrderId, InspectionTypeId, ItemId, ItemCode,
                    SNStr, CreateBy, OpeId, LineId, ResourceId, StationId, OrderId, TemplateId);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        //不良数量
        [AjaxMethod]
        public int GetInspectionUnqualifiedQty(int IOrderId, string InspectionItemName)
        {
            try
            {
                InspectionOrderMember bll = new InspectionOrderMember();
                return bll.GetInspectionUnqualifiedQty(IOrderId, InspectionItemName);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        //已检数量
        [AjaxMethod]
        public int GetInspectionEDQty(int IOrderId, string InspectionItemName)
        {
            try
            {
                InspectionOrderMember bll = new InspectionOrderMember();
                return bll.GetInspectionEDQty(IOrderId, InspectionItemName);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        //应抽百分比
        [AjaxMethod]
        public string GetInspectionNeedQtyPercentage(int IOrderId, string InspectionItemName)
        {
            string value = "";
            try
            {
                InspectionOrderMember bll = new InspectionOrderMember();
                value = bll.GetInspectionNeedQtyPercentage(IOrderId, InspectionItemName);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return value;
        }

        //应抽百分比
        [AjaxMethod]
        public int GetSamplingSampleQty(int LotSize, int AQLRuleTypeId, string ItemCode, int InspectionTemplateMemberId)
        {
            try
            {
                string LotAudit = "";
                GlobarParameterInfo info = new SKT.LeanMES.GlobarParameter.BLL.GlobarParameter().GetInfo("LotAudit");
                if (info != null)
                {
                    LotAudit = info.ParaValue;
                }
                else
                {
                    throw new Exception("未设定全局参数LotAudit");
                }

                SqlParameter[] parms = new SqlParameter[]{
                        new SqlParameter("@LotSize", SqlDbType.Int),
                        new SqlParameter("@LotAudit", SqlDbType.NVarChar, 50),
                        new SqlParameter("@AQLRuleTypeId", SqlDbType.Int),
                        new SqlParameter("@ItemCode", SqlDbType.NVarChar, 50),
                        new SqlParameter("@InspectionTemplateMemberId", SqlDbType.Int)
                    };

                parms[0].Value = LotSize;
                parms[1].Value = LotAudit;
                parms[2].Value = AQLRuleTypeId;
                parms[3].Value = ItemCode;
                parms[4].Value = InspectionTemplateMemberId;

                int Count = 0;
                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "GetSamplingSampleQty", parms))
                {
                    while (rdr.Read())
                    {
                        Count = rdr.GetInt32(0);
                    }
                    rdr.Close();
                }
                return Count;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.InnerException.Message);
            }
        }

        //更新受检对象的缺陷等级
        [AjaxMethod]
        public void UpdateBadGrades(int IOMemberId, string BadGrades)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOMemberId", SqlDbType.Int),
                new SqlParameter("@BadGrades", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = IOMemberId;
            parms[1].Value = BadGrades;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUpdateIOMemberBadGrades", parms);
        }

        /// <summary>
        /// 获取模版信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetIqcFormModel(int intId)
        {
            string str = "";
            try
            {
                str = (new InspectionOrder()).GetIqcFormModel(intId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }


        /// <summary>
        /// 获取模版信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetIqcFormItem(int intIqcId, int intTempId)
        {
            string str = "";
            try
            {
                str = (new InspectionOrder()).GetIqcFormItem(intIqcId, intTempId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 获取模版LCR信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetIqcFormLcrItem(int intIqcId)
        {
            string str = "";
            try
            {
                str = (new InspectionOrder()).GetIqcFormLcrItem(intIqcId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        [AjaxMethod]
        public void SaveIqcCheck(string strJson)
        {
            try
            {
                (new MaterialIQC()).Edit(strJson);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        //批量质检合格  add snake.lu 2021年2月24日14:41:29
        [AjaxMethod]
        public void SaveIqcALLCheck(string strJson)
        {
            try
            {
                (new MaterialIQC()).SaveIqcALLCheck(strJson);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 根据检验单ID获取相检验单退料信息。
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetIQCFormGrnBack(int intIqcId)
        {
            string str = "";
            try
            {
                str = (new InspectionOrder()).GetIQCFormGrnBack(intIqcId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        /// <summary>
        /// 根据检验单ID获取相检验单退料信息。
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetIQCFormGrnBackByGrn(string strGrn, Int32 intIqcId)
        {
            string str = "";
            try
            {
                str = (new InspectionOrder()).GetIQCFormGrnBackByGrn(strGrn, intIqcId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        /// <summary>
        /// IQC检验 维护GRN  扫描GRN事件
        /// </summary>
        /// <param name="strGrn"></param>
        /// <param name="intIqcId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetIQCFormGrnBackByGrnIqcId(string strGrn, Int32 intIqcId)
        {
            string str = "";
            try
            {
                str = (new InspectionOrder()).GetIQCFormGrnBackByGrnIqcId(strGrn, intIqcId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
        [AjaxMethod]
        public void SaveIqcGrnBack(string strJson)
        {
            try
            {
                (new MaterialIQC()).SaveIqcGrnBack(strJson);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        /// <summary>
        /// 根据检验单ID获取IQC检验单打印信息。
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetIQCFormPrint(int intIqcId)
        {
            string str = "";
            try
            {
                str = (new InspectionOrder()).GetIQCFormPrint(intIqcId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }

        [AjaxMethod]
        public void SaveMaterialHand(Int32 inspectionId, Int32 checkResult, string desc, string delaRemark)
        {
            try
            {
                string userName = SKT.LeanMES.Web.AccountController.GetCurrentUserInfo().UserName;
                (new InspectionOrder()).SaveMaterialHand(inspectionId, checkResult, userName, desc, delaRemark);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public List<InspectionTemplateMemberInfo> GetInspectionMemberInfoById(Int32 IOrderId)
        {
            try
            {
                InspectionTemplateMember bll = new InspectionTemplateMember();
                List<InspectionTemplateMemberInfo> list = bll.GetInspectionMemberInfoById(IOrderId);
                return list;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        [AjaxMethod]
        public List<InspectionTemplateMemberInfo> GetInspectionMemberDetailById(Int32 IOrderId)
        {
            try
            {
                InspectionTemplateMember bll = new InspectionTemplateMember();
                List<InspectionTemplateMemberInfo> list = bll.GetInspectionMemberDetailById(IOrderId);
                return list;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        [AjaxMethod]
        public DataSet GetIPQCInspectionProjectInfo(Int32 IOrderId)
        {
            try
            {
                InspectionOrder bll = new InspectionOrder();
                return bll.IPQCInspectionProject(IOrderId);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        //*******GRN细项录入********/
        [AjaxMethod]
        public List<MaterialIQCInfo> uspSearchIQCInputGRNInfo(string IQCNo)
        {
            try
            {
                return new MaterialIQC().uspSearchIQCInputGRNInfo(IQCNo);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public int uspIsIQCInputGRNInfo(string IQCNo, string GRN)
        {
            try
            {
                return new MaterialIQC().uspIsIQCInputGRNInfo(IQCNo, GRN);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<InspectionInputGRNInfo> GetIQCInputGRNInfo(int Pid)
        {
            try
            {
                return new MaterialIQC().GetIQCInputGRNInfo(Pid);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void UpdateFixedInspectionItem(int Id, int Status)
        {
            try
            {
                new MaterialIQC().UpdateFixedInspectionItem(Id, Status);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        /// <summary>
        /// 更改备注检验项状态
        /// </summary>
        /// <param name="id"></param>
        [AjaxMethod]
        public void UpdateInspectionItemRemark(int Id, string remark)
        {
            try
            {
                new MaterialIQC().UpdateInspectionItemRemark(Id, remark);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public InspectionInputGRNInfo InsertIQCInputGRNInfo(InspectionInputGRNInfo model)
        {
            try
            {
                return new MaterialIQC().InsertIQCInputGRNInfo(model);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [AjaxMethod]
        public InspectionInputGRNInfo InsertInspectionTemplateItem(string InspectionNo, int InspectionTemplateId, int InspectionItemId, string UserName)
        {
            try
            {
                return new MaterialIQC().InsertInspectionTemplateItem(InspectionNo, InspectionTemplateId.ToString(), InspectionItemId.ToString(), UserName);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [AjaxMethod]
        public void DeleteInspectionTemplateItem(int InspectionTemplateId, int InspectionItemId)
        {
            try
            {
                new MaterialIQC().DeleteInspectionTemplateItem(InspectionTemplateId.ToString(), InspectionItemId.ToString());
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [AjaxMethod]
        public InspectionInputGRNInfo GetInspectionIQCInputGRNInfo(string InspectionIQCInputGRNInfoId)
        {
            try
            {
                return new MaterialIQC().GetInspectionIQCInputGRNInfo(InspectionIQCInputGRNInfoId);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void ChangIQCInputGRNInfoUnit(string InspectionItemId, string UnitName)
        {
            try
            {
                new MaterialIQC().ChangIQCInputGRNInfoUnit(InspectionItemId, UnitName);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [AjaxMethod]
        public void ChangIQCInputGRNInfoMethodValue(string InspectionItemId, string MethodValue, string UnitName, string OffsetUnitName)
        {
            try
            {
                new MaterialIQC().ChangIQCInputGRNInfoMethodValue(InspectionItemId, MethodValue, UnitName, OffsetUnitName);
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [AjaxMethod]
        public void InsertIQCInputGRNInfoDtl(string jsonStr)
        {
            try
            {
                new MaterialIQC().InsertIQCInputGRNInfoDtl(jsonStr);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
        [AjaxMethod]
        public void DeleteIQCInputGRNInfo(int Pid)
        {
            try
            {
                new MaterialIQC().DeleteIQCInputGRNInfo(Pid);
            }
            catch (Exception)
            {

                throw;
            }
        }

        /// <summary>
        /// IQC检验开始记录
        /// </summary>
        /// <param name="inspectionId"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void IQCInspectionStart(int inspectionId, int qty)
        {
            string userName = AccountController.GetCurrentUserInfo().UserName;
            try
            {
                new InspectionOrder().IQCInspectionStart(inspectionId, userName, qty);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void UndoIQCByID(string InspectionId, string UserName)
        {
            try
            {
                new InspectionOrder().UndoIQCByID(InspectionId, UserName);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
        }

        #region 根据GRN获取检验单号
        /// <summary>
        /// 根据GRN获取检验单号
        /// </summary>
        /// <param name="GRN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetIQCOrder(string GRN)
        {
            string IQCOrder = "";
            try
            {
                IQCOrder = (new MaterialIQC()).GetIQCOrder(GRN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return IQCOrder;
        }
        #endregion

        #region 记录IQC送检单打印信息

        /// <summary>
        /// 记录送检单打印补打情况
        /// </summary>
        /// <param name="inspectionId"></param>
        /// <param name="printType"></param>
        /// <param name="userName"></param>
        [AjaxMethod]
        public void ReceivePrintRecord(long inspectionId, int printType)
        {
            string userName = AccountController.GetCurrentUser().UserName;

            try
            {
                new MaterialIQC().ReceivePrintRecord(inspectionId, printType, userName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion

        /// <summary>
        /// 首件检验推送
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="operateType">操作类型（0：仅校验 1：校验及保存）</param>
        /// <returns></returns>
        [AjaxMethod]
        public FirstArticleInspectionInfo FirstArticleInspection(FirstArticleInspectionInfo entity, int operateType)
        {
            try
            {
                var modifyBy = AccountController.GetCurrentUser().UserName;
                SqlParameter[] parms = new SqlParameter[]
                {
                    new SqlParameter("@OrderNo", SqlDbType.VarChar) { Value = entity.OrderNo },
                    new SqlParameter("@OperateType", SqlDbType.Int) { Value = operateType },
                    new SqlParameter("@ModifyBy", SqlDbType.VarChar) { Value = modifyBy },
                };
                //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspFirstArticleInspection", parms);
                return ComMethod.Get<FirstArticleInspectionInfo>("uspFirstArticleInspection", parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 获取工单齐套情况
        /// </summary>
        /// <param name="orderNo"></param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable GetOrderKitting(string orderNo)
        {
            try
            {
                var modifyBy = AccountController.GetCurrentUser().UserName;
                SqlParameter[] parms = new SqlParameter[]
                {
                    new SqlParameter("@OrderNo", SqlDbType.VarChar) { Value = orderNo },
                    new SqlParameter("@ModifyBy", SqlDbType.VarChar) { Value = modifyBy },
                };
                return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetOrderKitting", parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
    }
}