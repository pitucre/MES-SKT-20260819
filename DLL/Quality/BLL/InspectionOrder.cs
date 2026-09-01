using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class InspectionOrder
    {
        private Int32 recordCount = 0;



        public void SaveMaterialHand(Int32  InsepctionId,Int32 iqcResult,String userName,string desc,string dealRemark)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IQCFormId", SqlDbType.Int),
                new SqlParameter("@IQCResultId", SqlDbType.Int, 150),
                new SqlParameter("@HanderUser", SqlDbType.VarChar, 20),
                new SqlParameter("@Desc", SqlDbType.VarChar, 300),
                new SqlParameter("@DealRemark", SqlDbType.VarChar, 300)
            };

            parms[0].Value = InsepctionId;
            parms[1].Value = iqcResult;
            parms[2].Value = userName;
            parms[3].Value = desc;
            parms[4].Value = dealRemark;
            ComMethod.Edit("uspSaveMaterialHand", parms);

        }
        /// <summary>
        /// 编辑（添加或更新） InspectionOrder 信息。
        /// </summary>
        /// <param name="entity">InspectionOrder 实体对象。</param>
        public void Edit(InspectionOrderInfo entity)
        {


        }

        /// <summary>
        /// 根据 InspectionOrderId 字符串删除 InspectionOrder 信息。
        /// </summary>
        /// <param name="idString">InspectionOrderId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Quality_InspectionOrder_Delete");
        }

        /// <summary>
        /// 根据 InspectionOrderId 获取实体信息。
        /// </summary>
        /// <param name="inspectionOrderId">InspectionOrderId。</param>
        /// <returns>InspectionOrder 实体对象。</returns>
        public InspectionOrderInfo GetInfo(Int64 inspectionOrderId)
        {
            return ComMethod.GetInfo<InspectionOrderInfo>(inspectionOrderId, "Quality_InspectionOrder_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionOrder 实体对象。</returns>
        public InspectionOrderInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<InspectionOrderInfo>(fieldValue, "Quality_InspectionOrder_GetInfo");
        }

        ///// <summary>
        ///// 分页获取 InspectionOrder 资料。
        ///// </summary>
        ///// <param name="startRow">起始行。</param>
        ///// <param name="maxRows">最大行数。</param>
        ///// <param name="sortExpression">排序表达式。</param>
        ///// <param name="searchSettings">搜索配置信息。</param>
        ///// <param name="inspectionOrderCount">inspectionOrder 总数。</param>
        ///// <returns>InspectionOrder 列表。</returns>
        //public List<InspectionOrderInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        //{
        //    List<InspectionOrderInfo> list = new List<InspectionOrderInfo>();
        //    //表名或者视图
        //    string strTb = "Quality_InspectionOrder";
        //    //主键
        //    string strKey = "IOrderId";
        //    //查询栏位字串
        //    string strColumns = @"[IOrderId], [ItemCode], [InspectionTypeId], [InspectionOrderNo], [SourceTarget], [TargetType], [DealResult], 
        //        [InspectionResult], [InspectionQty], [QualifiedQty], [InspectionUser], [StartDatetime], [EndDatetime], [Statue], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]";
        //    list = ComMethod.GetComList<InspectionOrderInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

        //    return list;
        //}


        /// <summary>
        /// 分页获取 InspectionOrder 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionOrderCount">inspectionOrder 总数。</param>
        /// <returns>InspectionOrder 列表。</returns>
        public List<InspectionOrderInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionOrderInfo> list = new List<InspectionOrderInfo>();
            //表名或者视图
            string strTb = "vwInspectionOrder";
            //主键
            string strKey = "IOrderId";    
            string strColumns = @"[IOrderId],[ItemCode],[InspectionTypeId],[InspectionOrderNo],[SourceTarget],[TargetType],[DealResult],[InspectionResult],
                  [InspectionQty],[QualifiedQty],[InspectionUser],[StartDatetime],[EndDatetime],[Statue],[CreateBy],[CreateDateTime],[ModifyBy],
                  [ModifyDateTime],[Remark],[AuditStatus],[AuditBy],InspectionTypeName,ItemName,UploadFile,FlieName,OrderNo,
                  GroupAffirmStatusName,ProjectAffirmStatusName,AuditStatusName,AuditResult,LineId,ProjectAffirmStatus,GroupAffirmStatus,InspectionSelectType,SystemType,CPN,ResourceId,Station,LineName";
            list = ComMethod.GetComList<InspectionOrderInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// IQC列表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<InspectionOrderInfo> GetAllIQCList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<InspectionOrderInfo> list = new List<InspectionOrderInfo>();
            InspectionOrderInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaterialIQCBatchAndVer", "IOrderId",
                "[IOrderId], [InspectionOrderNo], [ItemCode],[CreateDateTime],[CreateBy],[StatueResult],[DealResult], VendorCode, VendorName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new InspectionOrderInfo();
                    entity.IOrderId = rdr.GetInt32(0);
                    entity.InspectionOrderNo = rdr.GetString(1);
                    entity.ItemCode = rdr.GetString(2);
                    entity.CreateDateTime = rdr.GetDateTime(3);
                    entity.CreateBy = rdr.GetString(4);
                    entity.StatueResult = rdr.GetString(5);
                    entity.DealResult = rdr.GetString(6);
                    entity.VendorCode = rdr.GetString(7);
                    entity.VendorName = rdr.GetString(8);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 审核
        /// </summary>
        /// <param name="Id"></param>
        /// <param name="res"></param>
        /// <param name="Rem"></param>
        /// <param name="UserId"></param>
        public void InspectionOrderConfirmationSave(int Id, string res, string Rem, int UserId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderId", SqlDbType.VarChar, 1000),
                new SqlParameter("@AuditResult", SqlDbType.NVarChar, 50),
                new SqlParameter("@AuditRemark", SqlDbType.NVarChar, 200),
                new SqlParameter("@UserId", SqlDbType.Int)

            };

            parms[0].Value = Id;
            parms[1].Value = res;
            parms[2].Value = Rem;
            parms[3].Value = UserId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrder_Confirmation", parms);
        }

        /// <summary>
        /// 组长审核
        /// </summary>
        /// <param name="Id"></param>
        /// <param name="res"></param>
        /// <param name="Rem"></param>
        /// <param name="UserId"></param>
        public void InspectionOrderSaveGroupAffirm(int Id, string res, string Rem, int UserId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderId", SqlDbType.VarChar, 1000),
                new SqlParameter("@AuditResult", SqlDbType.NVarChar, 50),
                new SqlParameter("@AuditRemark", SqlDbType.NVarChar, 200),
                new SqlParameter("@UserId", SqlDbType.Int)

            };

            parms[0].Value = Id;
            parms[1].Value = res;
            parms[2].Value = Rem;
            parms[3].Value = UserId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrder_GroupAffirm", parms);
        }

        /// <summary>
        /// 工程审核
        /// </summary>
        /// <param name="Id"></param>
        /// <param name="res"></param>
        /// <param name="Rem"></param>
        /// <param name="UserId"></param>
        public void InspectionOrderSaveProjectAffirm(int Id, string res, string Rem, int UserId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderId", SqlDbType.VarChar, 1000),
                new SqlParameter("@AuditResult", SqlDbType.NVarChar, 50),
                new SqlParameter("@AuditRemark", SqlDbType.NVarChar, 200),
                new SqlParameter("@UserId", SqlDbType.Int)

            };

            parms[0].Value = Id;
            parms[1].Value = res;
            parms[2].Value = Rem;
            parms[3].Value = UserId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_InspectionOrder_ProjectAffirm", parms);
        }


        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 根据检验单ID获取模版信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetIqcFormModel(Int32 intId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            return ComMethod.GetList("upsGetIQCTemplateModel", parms);
        }

        /// <summary>
        /// 根据检验单ID获取模版检验项信息
        /// </summary>
        /// <param name="intIqcId">IQC单号</param>
        /// <param name="intTempId">模版ID</param>
        /// <returns></returns>
        public string GetIqcFormItem(Int32 intIqcId, Int32 intTempId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@TemplateId", SqlDbType.Int)
				};
            parms[0].Value = intIqcId;
            parms[1].Value = intTempId;
            return ComMethod.GetList("upsGetIQCTemplateItem", parms);
        }

        /// <summary>
        /// 根据检验单ID获取模版LCR检验项信息
        /// </summary>
        /// <param name="intIqcId">IQC单号</param>
        /// <returns></returns>
        public string GetIqcFormLcrItem(Int32 intIqcId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int)
				};
            parms[0].Value = intIqcId;
            return ComMethod.GetList("upsGetIQCTemplateLcrItem", parms);
        }

        /// <summary>
        /// 根据检验单ID获取相检验单退料信息。
        /// </summary>
        /// <param name="intIqcId">IQC单号</param>
        /// <returns>strJson</returns>
        public string GetIQCFormGrnBack(Int32 intIqcId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int)
				};
            parms[0].Value = intIqcId;
            return ComMethod.GetList("uspGetIQCFormGrnBack", parms);
        }

        /// <summary>
        /// 撤回
        /// </summary>
        public void UndoIQCByID(string InspectionId, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@UserName", SqlDbType.VarChar,20)
                };
            parms[0].Value = InspectionId;
            parms[1].Value = UserName;
            ComMethod.GetList("uspUndoIQCByID", parms);
        }

        /// <summary>
        /// 根据检验单ID获取相检验单退料信息。
        /// </summary>
        /// <param name="intIqcId">IQC单号</param>
        /// <returns>strJson</returns>
        public string GetIQCFormGrnBackByGrn(string strGrn, Int32 intIqcId)
        {
            string strSql = @"SELECT -1 AS IQCGrnNgId, B.InspectionId, B.ItemId, A.GRN, A.BalanceQty TotalQty, 0 NgQty, A.BalanceQty OKQty, '' AS Remark, B.ItemCode 
                            FROM Prod_DeliverGRNDtl A INNER JOIN Prod_MaterialIQC B ON A.DeliverNo = B.DeliverNo
                            WHERE B.InspectionId = @InspectionId AND A.GRN = @GRN";

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@GRN", SqlDbType.VarChar, 50),
					new SqlParameter("@InspectionId", SqlDbType.Int)
				};
            parms[0].Value = strGrn;
            parms[1].Value = intIqcId;
            return ComMethod.GetBySql(strSql, parms);
        }

        /// <summary>
        /// IQC检验 维护GRN  扫描GRN事件
        /// </summary>
        /// <param name="strGrn"></param>
        /// <param name="intIqcId"></param>
        /// <returns></returns>
        public string GetIQCFormGrnBackByGrnIqcId(string strGrn, Int32 intIqcId)
        {
            string strSql = @"SELECT -1 AS IQCGrnNgId, B.InspectionId, B.ItemId, A.GRN, A.BalanceQty TotalQty, 0 NgQty, A.BalanceQty OKQty, '' AS Remark, B.ItemCode 
                            FROM Prod_DeliverGRNDtl A INNER JOIN Prod_MaterialIQC B ON A.DeliverDtlId = B.DeliverDtlId
                            WHERE B.InspectionId = @InspectionId AND A.GRN = @GRN";

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@GRN", SqlDbType.VarChar, 50),
					new SqlParameter("@InspectionId", SqlDbType.Int)
				};
            parms[0].Value = strGrn;
            parms[1].Value = intIqcId;
            return ComMethod.GetBySql(strSql, parms);
        }
        /// <summary>
        /// 根据检验单ID获取相检验单退料信息。
        /// </summary>
        /// <param name="intIqcId">IQC单号</param>
        /// <returns>strJson</returns>
        public string GetIQCFormPrint(Int32 intIqcId)
        {
            string strSql = @"SELECT A.InspectionId, A.InspectionNo, A.POCode, A.DeliverNo, A.DeliverDtlId, A.ItemId, A.ItemCode, A.SuplierCode, A.InspectionResult, 
	                            A.InspectionUser, A.InspectionQty, A.QualifiedQty, A.Statue, A.UrgentLevel, A.Remark, A.CreateBy, A.CreateDateTime, A.ModifyBy, 
	                            A.ModifyDateTime, A.IsGRN, B.ItemName, C.VendorName, B.ItemGroupID, 
	                            B.Units, D.Position
                            FROM Prod_MaterialIQC A INNER JOIN Basal_Item B ON A.ItemId = B.ItemId
	                            INNER JOIN Basal_Supplier C ON A.SuplierCode = C.VendorCode 
	                            LEFT JOIN Prod_POorderDtl D ON A.POCode = D.POCode
                            WHERE A.InspectionId = @InspectionId";

            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int)
				};
            parms[0].Value = intIqcId;
            return ComMethod.GetBySql(strSql, parms);
        }


        /// <summary>
        /// 返回PDF页面显示的值
        /// add by zhuxi 20170925
        /// </summary>
        /// <param name="InspectionId"></param>
        /// <param name="strXmlFilePath"></param>
        /// <param name="strImgPath"></param>
        /// <returns></returns>
        public byte[] GetInspectionOrderPDF(string InspectionId, string strXmlFilePath, string strImgPath)
        {
            DataSet ds = null;
            DataTable dt = GetInspectionOrderTable(InspectionId);
            if (dt != null && dt.Rows.Count > 0)
            {
                var InspecQuery = from t in dt.AsEnumerable()
                                  group t by new
                                  {
                                      t1 = t.Field<string>("OrderNo"),
                                      t2 = t.Field<int>("OrderQty"),
                                      t3 = t.Field<string>("ItemName"),
                                      t4 = t.Field<string>("LineName"),
                                      t5 = t.Field<string>("Station"),
                                      t6 = t.Field<string>("Class"),
                                      t7 = t.Field<string>("SendMan"),
                                      t8 = t.Field<int>("SampleQty"),

                                      t9 = t.Field<string>("GroupAffirmResult"),
                                      t10 = t.Field<string>("GroupAffirmBy"),
                                      t11 = t.Field<string>("ProjectAffirmResult"),
                                      t12 = t.Field<string>("ProjectAffirmBy"),
                                      t13 = t.Field<string>("ProjectAffirmRemark"),

                                      t14 = t.Field<string>("AuditResult"),
                                      t15 = t.Field<string>("AuditBy"),
                                      t16 = t.Field<string>("CreateBy"),
                                      t17 = t.Field<string>("InspectionTypeName"),
                                      t18 = t.Field<string>("InspectionTemplateName")

                                  } into m
                                  select new
                                  {
                                      OrderNo = m.Key.t1,
                                      OrderQty = m.Key.t2,
                                      ItemName = m.Key.t3,
                                      LineName = m.Key.t4,
                                      Station = m.Key.t5,
                                      Class = m.Key.t6,
                                      SendMan = m.Key.t7,
                                      SampleQty = m.Key.t8,
                                      GroupAffirmResult = m.Key.t9,
                                      GroupAffirmBy = m.Key.t10,

                                      ProjectAffirmResult = m.Key.t11,
                                      ProjectAffirmBy = m.Key.t12,
                                      ProjectAffirmRemark = m.Key.t13,
                                      AuditResult = m.Key.t14,
                                      AuditBy = m.Key.t15,
                                      CreateBy = m.Key.t16,
                                      InspectionTypeName = m.Key.t17,
                                      InspectionTemplateName = m.Key.t18
                                  };

                DataTable dts = GetInspectionOrderMemberTable(InspectionId);
                dt.TableName = "InspectionOrder";
                dts.TableName = "InspectionOrderMember";

                ds = new DataSet();
                ds.Tables.Add(dt);
                ds.Tables.Add(dts);

            }
            return SKT.LeanMES.CommonHelper.BLL.PDFHelper.getPDFByte(SKT.LeanMES.CommonHelper.BLL.PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        /// <summary>
        /// 返回IPQC巡检单主表信息add by zhuxi 20170925
        /// </summary>
        /// <param name="InspectionId"></param>
        /// <returns></returns>
        private DataTable GetInspectionOrderTable(string InspectionId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@InspectionId",SqlDbType.Int),
            };
            parms[0].Value = Convert.ToInt32(InspectionId);
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionOrderTable", parms);
        }

        /// <summary>
        /// 返回IPQC巡检单子表信息 add by zhuxi 20170925
        /// </summary>
        /// <param name="InspectionId"></param>
        /// <returns></returns>
        private DataTable GetInspectionOrderMemberTable(string InspectionId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@IOrderId",SqlDbType.Int),
            };
            parms[0].Value = Convert.ToInt32(InspectionId);
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetInspectionOrderById", parms);
        }

        /// <summary>
        /// IQC检验开始记录
        /// </summary>
        /// <param name="inspectionId"></param>
        /// <param name="userName"></param>
        public void IQCInspectionStart(int inspectionId , string userName,int qty)
        {
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@InspectionId",SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.NVarChar),
                new SqlParameter("@InspectionQty",SqlDbType.Int),
            };

            parms[0].Value = inspectionId;
            parms[1].Value = userName;
            parms[2].Value = qty;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspIQCInspectionStart", parms);
        }

        /// <summary>
        /// 获取IPQC工程检验数据包含明细
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        public DataSet IPQCInspectionProject(int Id)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IOrderId",SqlDbType.Int){ Value = Id}
            };

            return ComMethod.GetListDataSet("uspGetIPQCInspectionProjectInfo", parms);
        }

    }
}