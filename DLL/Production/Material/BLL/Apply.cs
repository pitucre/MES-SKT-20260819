using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Material.Model;
using Newtonsoft.Json;
using SKT.LeanMES.Model;
using System.Text.RegularExpressions;
using System.Linq;

namespace SKT.LeanMES.Material.BLL
{
    public class Apply
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 保存领料申请单
        /// </summary>
        /// <param name="entity">Apply 实体对象。</param>
        public void Edit(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ApplyId", SqlDbType.BigInt),
                new SqlParameter("@ApplyType", SqlDbType.Int),
                new SqlParameter("@MOCode", SqlDbType.VarChar, 20),
                new SqlParameter("@DepCode", SqlDbType.VarChar, 20),
                new SqlParameter("@WhCode", SqlDbType.VarChar, 20),
                new SqlParameter("@UseDateTime", SqlDbType.DateTime),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@applyDtl", SqlDbType.Structured)
            };
            ComMethod.Edit<ApplyInfo>(strJson, "Prod_Apply_Edit", parms);
        }

        public void Edit(ApplyInfo entity, String entityDtl)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ApplyId", SqlDbType.BigInt),
                new SqlParameter("@ApplyType", SqlDbType.Int),
                new SqlParameter("@MOCode", SqlDbType.VarChar, 20),
                new SqlParameter("@DepCode", SqlDbType.VarChar, 20),
                new SqlParameter("@WhCode", SqlDbType.VarChar, 20),
                new SqlParameter("@UseDateTime", SqlDbType.DateTime),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@applyDtl", SqlDbType.NVarChar,Int32.MaxValue)
            };
            parms[0].Value = entity.ApplyId;
            parms[1].Value = entity.ApplyType;
            parms[2].Value = entity.MOCode;
            parms[3].Value = entity.DepCode;
            parms[4].Value = entity.WhCode;
            parms[5].Value = entity.UseDateTime;
            parms[6].Value = entity.Remark;
            parms[7].Value = entity.CreateBy;
            //parms[8].Value = JsonConvert.DeserializeObject<ApplyDtlInfo>(strJson);
            parms[8].Value = entityDtl;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Apply_Edit", parms);

        }
        /// <summary>
        /// 根据 ApplyId 字符串删除 Apply 信息。
        /// </summary>
        /// <param name="idString">ApplyId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Prod_Apply_Delete");
        }

        /// <summary>
        /// 根据 ApplyId 获取实体信息。
        /// </summary>
        /// <param name="applyId">ApplyId。</param>
        /// <returns>Apply 实体对象。</returns>
        public ApplyInfo GetInfo(Int32 applyId)
        {
            return ComMethod.GetInfo<ApplyInfo>(applyId, "Prod_Apply_GetInfo");
        }

        /// <summary>
        /// 根据 ApplyId 获取实体信息。
        /// </summary>
        /// <param name="applyId">ApplyId。</param>
        /// <returns>Apply 实体对象。</returns>
        public ApplyInfo GetInfo2(Int32 applyId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ApplyId",SqlDbType.NVarChar,50)
            };
            parms[0].Value = applyId;

            return ComMethod.GetList<ApplyInfo>("Prod_Apply_GetInfo",parms).FirstOrDefault();
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Apply 实体对象。</returns>
        public ApplyInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<ApplyInfo>(fieldValue, "Prod_Apply_GetInfo");
        }

        /// <summary>
        /// 分页获取 Apply 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="applyCount">apply 总数。</param>
        /// <returns>Apply 列表。</returns>
        public List<ApplyInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            //表名或者视图
            string strTb = "vwPrepare";//"Prod_Apply";
            //主键
            string strKey = "ApplyId";//"ApplyId";
            //查询栏位字串         
            string strColumns = @"[ApplyId], [ApplyNo], [ApplyType], [MOCode], [DepCode], [DepName], [WhCode], [WhName], [UseDateTime], [Remark], [Statue], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime],ApplyClass";
            list = ComMethod.GetComList<ApplyInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        /// <summary>
        /// 分页获取 Apply明细 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="applyCount">apply 总数。</param>
        /// <returns>Apply 列表。</returns>
        public List<ApplyInfo> GetAllDetails(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            //表名或者视图
            string strTb = "vwPrepareDetails";//"Prod_Apply";
            //主键
            string strKey = "PrepareMaterialId";//"ApplyId";
            //查询栏位字串         
            string strColumns = @"[ApplyId],PrepareMaterialId, [ApplyNo], [ApplyType], [MOCode], [DepCode], [DepName], [WhCode], [WhName], [UseDateTime], [Remark], [Statue], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime],PrepareMaterialNo,ApplyClass";
            list = ComMethod.GetComList<ApplyInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        // 编辑手工领料申请单 - 根据选择的领料申请ID获取领料申请单详细
        public string GetMaterialApply(string applyId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ApplyId",SqlDbType.NVarChar,50)
            };
            parms[0].Value = applyId;

            return ComMethod.GetList("upsGetMaterialApply", parms);
        }
        //领料申请时，选择生产投料单列表
        public List<ApplyInfo> MaterialApplySelMO(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            //表名或者视图
            string strTb = "vwMaterialApplySelMO";
            //主键
            string strKey = "MOID";
            //查询栏位字串
            string strColumns = @"MOID,MOCode,ItemCode,ItemName,StartTime";
            list = ComMethod.GetComList<ApplyInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        //领料申请时，根据选择的生产投料单，带出物料信息
        public List<ApplyInfo> MaterialApplySelItem(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            //表名或者视图
            string strTb = "vwMaterialApplySelItem";
            //主键
            string strKey = "MODtlID";
            //查询栏位字串
            string strColumns = @"MODtlID,MODtlNO,MOID,MOCode,ItemCode,ItemName,ItemID,AuxQtyMust,AuxStockQty,Qty,ApplyQtySum";
            list = ComMethod.GetComList<ApplyInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, "MODtlNO", searchSettings);

            return list;
        }

        //领料申请时，根据选择的生产投料单，自动带出所有物料信息
        public string[][] MaterialApplyAllItem(string moCode)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@MOCode",SqlDbType.NVarChar,50)
            };
            parms[0].Value = moCode;

            string strSql = @"SELECT MODtlID,MODtlNO,MOID,MOCode,ItemCode,ItemName,AuxQtyMust,AuxStockQty,Qty,ApplyQtySum
                                FROM vwMaterialApplySelItem WHERE MOCode=@MOCode";
            list = ComMethod.GetListBySql<ApplyInfo>(strSql, parms);

            string[][] listArr = null;
            listArr = new string[list.Count][];
            for (int i = 0; i < list.Count; i++)
            {
                string[] arrIn = new string[9];
                arrIn[0] = list[i].MODtlID.ToString();
                arrIn[1] = list[i].MOID.ToString();
                arrIn[2] = list[i].MODtlNO.ToString();
                arrIn[3] = list[i].ItemCode.ToString();
                arrIn[4] = list[i].ItemName.ToString();
                arrIn[5] = list[i].AuxQtyMust.ToString();
                arrIn[6] = list[i].AuxStockQty.ToString();
                arrIn[7] = list[i].Qty.ToString();
                arrIn[8] = list[i].ApplyQtySum.ToString();
                listArr[i] = arrIn;
            }

            return listArr;
        }

        /// <summary>
        /// 发料交接确认操作
        /// </summary>
        /// <param name="deliverCode">领料申请单ID</param>
        /// <param name="userName"></param>
        public void SaveApplyMaterialHandover(String applyId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@IdString",SqlDbType.NVarChar,200),
                  new SqlParameter("@UserName",SqlDbType.NVarChar,50)
            };
            parms[0].Value = applyId;
            parms[1].Value = userName;
            ComMethod.Get("uspSaveApplyMaterialHandover", parms);
        }

        /// <summary>
        /// 还原陆工修改的部分，他的应该是WMS上的
        /// </summary>
        /// <returns></returns>
        public List<MaterialUnitInfo> CheckGrnMaterialPrepare(String ItemStr, String Grn, Int32 flage, String grnStr)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ItemStr",SqlDbType.NVarChar,int.MaxValue),
                  new SqlParameter("@Grn",SqlDbType.NVarChar,int.MaxValue),
                  new SqlParameter("@Flage",SqlDbType.Int),
                  new SqlParameter("@GrnStr",SqlDbType.NVarChar,int.MaxValue)
            };
            parms[0].Value = ItemStr;
            parms[1].Value = Grn;
            parms[2].Value = flage;
            parms[3].Value = grnStr;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckGrnMaterialPrepare", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.PartId = rdr.GetInt32(2);
                    entity.Flage = rdr.GetInt32(3);
                    entity.IssueWay = rdr.GetInt32(4);
                    entity.ConfigType = rdr["ConfigType"].ToString();
                    entity.MinData = rdr["MinData"] == null || rdr["MinData"] == DBNull.Value ? string.Empty : rdr["MinData"].ToString();

                    entity.MinGrn = Convert.ToString(rdr["MinGrn"]);
                    entity.CBarCode=rdr["cBarCode"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 领料单打印资料获取
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public string GetApplyPrint(int intId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ApplyId",SqlDbType.Int)
            };
            parms[0].Value = intId;
            return ComMethod.GetList("upsGetApplyPrint", parms);
        }


        /// <summary>
        /// 根据领料单号返回明细数据 --字符流
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public byte[] GetApplyPdfByte(int intId, int applyType, string strXmlFilePath, string strImgPath, string strItemId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ApplyId",SqlDbType.Int),
            };
            parms[0].Value = intId;
            DataSet ds = ComMethod.GetListDataSet("upsGetApplyPrint", parms, "dtApplyForm");
          
            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        /// <summary>
        /// 领料单打印资料获取
        /// </summary>
        /// <param name="buyOrder"></param>
        /// <returns></returns>
        public string GetApplyInfo(string ApplyNo)
        {
            string sqlString = string.Format(@"IF NOT EXISTS(SELECT 1 FROM Prod_Apply WHERE  ApplyNo= '{0}')
                BEGIN
                    RAISERROR('领料单不存在', 12, 1)
                    RETURN
                END;
                DECLARE @MergeApplyNo VARCHAR(50),@Msg VARCHAR(500);
                SELECT @MergeApplyNo=ISNULL(MergeApplyNo,'') FROM Prod_MergeApply WHERE ApplyNo='{0}';
                IF @MergeApplyNo<>''
                BEGIN
                SET @Msg='领料单【{0}】已合并为母领料单【'+@MergeApplyNo+'】，请用母领料单发料';
                RAISERROR(@Msg,12,1);   
                RETURN;
                END;
                SELECT * FROM Prod_Apply WHERE ApplyNo = '{0}'", ApplyNo);
            return ComMethod.GetListBySql(sqlString, null);
        }

        public List<ApplyInfo> GetItemInPurOrder(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            //表名或者视图
            string strTb = "vwItemInPurOrder";
            //主键
            string strKey = "ItemID";
            //查询栏位字串
            string strColumns = @"AutoID,POID,POCode,ItemID,ItemName,ItemCode ";
            list = ComMethod.GetComList<ApplyInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public List<ApplyInfo> GetApplyDetailView(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            //表名或者视图
            string strTb = "vwApplyDetailView";
            //主键
            string strKey = "ApplyDtlId";
            //查询栏位字串
            string strColumns = @" [ApplyDtlId],[ApplyNo],[SrcOrderType],[ApplyTypeDesc]
                            ,[MOCode],[DepCode],[DepName]
                            ,[WhCode],[WhName]
                            ,[ItemCode],[ItemName],[ItemSpec]
                            ,[ApplyQty],[StockQty],[LeftQty]
                            ,[UseDateTime],[StatueDesc],ModifyBy,ModifyDateTime";
            list = ComMethod.GetComList<ApplyInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public DataTable DtApplyDetailView(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            return ComMethod.ConvertToDataTable(GetApplyDetailView(startRow, maxRows, sortExpression, searchSettings));

        }

        public DataTable GetApplyDetailExportView(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwApplyDetailView";
            //主键
            string strKey = "ApplyDtlId";
            //查询栏位字串
            string strColumns = @" ApplyTypeDesc AS '类型',
		                            SrcOrderType AS '单据来源',
		                            ApplyNo AS '领料单号',
		                            MOCode AS '工单号',
		                            DepCode AS '领料部门编码',
		                            DepName AS '领料部门名称',
		                            ItemCode AS '物料编码',
		                            ItemName AS '物料名称',
		                            ItemSpec AS '物料规格',
		                            WhCode AS '仓库编码',
		                            WhName AS '仓库名称',
		                            ApplyQty AS '申请数量',
		                            StockQty AS '已发数量',
		                            LeftQty AS '剩余数量',
		                            CONVERT(varchar(10),UseDateTime,120) AS '使用日期',
		                            StatueDesc AS '状态' ";
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, strTb, strKey, strColumns, searchSettings, sortExpression));
        }

        /*成品出货*/
        public List<MaterialIQCInfo> CheckCPrepareBySN(int scanType, string SN)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@scanType",SqlDbType.Int),
                new SqlParameter("@SN",SqlDbType.VarChar,50),
            };
            param[0].Value = scanType;
            param[1].Value = SN;
            var list = ComMethod.GetList<MaterialIQCInfo>("uspCheckCPrepare", param);
            return list;
        }
        public void SavePrepareBySN(int ApplyId, string SNList, string UserName)
        {
            DataTable dt = JsonToDataTable(SNList);
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@ApplyId",SqlDbType.Int),
                //new SqlParameter("@SNList",SqlDbType.VarChar,8000),
                new SqlParameter("@SNList",SqlDbType.Structured),
                new SqlParameter("@UserName",SqlDbType.VarChar,50),
            };
            param[0].Value = ApplyId;
            param[1].Value = dt;
            param[2].Value = UserName;
            //ComMethod.Edit("uspSaveCPrepare", param);
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveCPrepare", param);
        }

        public List<ApplyInfo> GetPrepareMaterialList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            //表名或者视图
            string strTb = "Prod_PrepareMaterial";//"Prod_Apply";
            //主键
            string strKey = "PrepareMaterialId";//"ApplyId";
            //查询栏位字串
            string strColumns = @"PrepareMaterialId,PrepareMaterialNo";
            list = ComMethod.GetComList<ApplyInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public List<ApplyInfo> GetPrepareMaterialNo(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            //表名或者视图
            string strTb = "vwMaterialGrn";//"Prod_Apply";
            //主键
            string strKey = "RecordId";//"ApplyId";
            //查询栏位字串
            string strColumns = @"SerialNumber,BalanceQty";
            list = ComMethod.GetComList<ApplyInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        #region 获取备料单下GRN数量
        /// <summary>
        /// 获取备料单下GRN数量
        /// </summary>
        /// <param name="prepareMaterialNo"></param>
        /// <returns></returns>
        public int GetMaterialGrnNumber(string prepareMaterialNo, int statue)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PrepareMaterialNo", SqlDbType.VarChar,100),
                new SqlParameter("@Statue", SqlDbType.Int),
                new SqlParameter("@returnValue", SqlDbType.Int)
            };

            parms[0].Value = prepareMaterialNo;
            parms[1].Value = statue;
            parms[2].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetMaterialGrnNumber", parms);
            int retvalue = 0;
            retvalue = Convert.ToInt32(parms[2].Value);
            return retvalue;
        }
        #endregion

        /// <summary>
        /// PDA线边仓GRN明细查询
        /// </summary>
        /// <param name="MOCode"></param>
        /// <param name="ApplyNo"></param>
        /// <param name="PrepareMaterialNo"></param>
        /// <param name="SN"></param>
        /// <param name="Statue"></param>
        /// <returns></returns>
        public List<ApplyInfo> PrepareMaterialGrnDel(string MOCode, string ApplyNo, string SN, int Statue)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            string sqlStr = "";
            if (MOCode != "")
            {
                sqlStr += " and d.Mocode='" + MOCode + "'";
            }
            if (ApplyNo != "")
            {
                sqlStr += " and a.applyNo='" + ApplyNo + "'";
            }

            if (SN != "")
            {
                sqlStr += " and a.SerialNumber like '%" + SN + "%'";
            }

            if (Statue == -1)
            {
                sqlStr += " and a.[status] in (18,1,2)";
            }
            else
            {
                sqlStr += " and a.[status] in (" + Statue + ")";
            }

            string cmdTxt = @"SELECT a.SerialNumber,b.BalanceQty, 
                                c.ItemCode,d.Mocode,a.applyNo,
                                  CASE a.[status]  
                                              when 18 THEN '待线边仓接收'                               
                                              when 1 THEN '在线边仓'
                                              when 2 THEN '在产线'
				                              else '' end as Statue
                                  FROM vwProMaterialMember a
                                  inner join Prod_ApplyDtl c on a.applyNO = c.applyNo
                                  INNER JOIN Prod_MaterialUnit b ON a.SerialNumber = b.SerialNumber and c.ItemId=b.PartId
                                  left join Prod_Apply d on a.applyNo = d.applyNo
                                  where 1 = 1" + sqlStr;
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
            if (dt != null && dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    ApplyInfo entity = new ApplyInfo();
                    entity.SerialNumber = dt.Rows[i][0].ToString();
                    entity.BalanceQty = Convert.ToInt32(dt.Rows[i][1]);
                    entity.ItemCode = dt.Rows[i][2].ToString(); ;
                    entity.MOCode = dt.Rows[i][3].ToString();
                    entity.ApplyNo = dt.Rows[i][4].ToString();
                    entity.StatueDesc = dt.Rows[i][5].ToString();
                    list.Add(entity);
                }
            }
            #region
            //List<ApplyInfo> list = new List<ApplyInfo>();
            ////表名或者视图
            //string strTb = "vwPrepareMaterialGrn";//"Prod_Apply";
            ////主键
            //string strKey = "RecordId";//"ApplyId";
            ////查询栏位字串
            //string strColumns = @"SerialNumber,BalanceQty, ItemCode,Mocode,applyNo,PrepareMaterialNo,Statue";
            //list = ComMethod.GetComList<ApplyInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            #endregion
            return list;
        }

        /// <summary>
        ///  PDA线边仓接收领料单，工单，备料单查询
        /// </summary>
        /// <param name="MOCode"></param>
        /// <param name="ApplyNo"></param>
        /// <param name="Type"></param>
        /// <returns></returns>
        public List<string> GetOrderDetails(string MOCode, string ApplyNo, string Type)
        {
            string column = "";
            string sqlStr = "";
            switch (Type)
            {
                case "工单":
                    column = "a.MOCode";
                    break;

                case "领料单":
                    column = "a.ApplyNo";
                    if (MOCode != "")
                    {
                        sqlStr += " and a.mocode='" + MOCode + "'";
                    }
                    break;

                case "备料单":
                    column = "b.PrepareMaterialNo";
                    if (MOCode != "")
                    {
                        sqlStr += " and a.mocode='" + MOCode + "'";
                    }
                    if (ApplyNo != "")
                    {
                        sqlStr += " and a.ApplyNo='" + ApplyNo + "'";
                    }
                    break;
                default:
                    break;
            }
            List<string> list = new List<string>();
            string cmdTxt = " SELECT  distinct " + column + "  FROM Prod_Apply a  LEFT JOIN Prod_PrepareMaterial b  ON a.ApplyNo = b.ApplyNo  where a.mocode<>''  " + sqlStr;
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
            if (dt != null && dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    list.Add(dt.Rows[i][0].ToString());
                }
            }
            return list;
        }

        /// <summary>
        /// 仓库备料看板—数据列表
        /// </summary>
        /// <returns></returns>
        public IList<ApplyInfo> GetMaterialPrepareInfo()
        {
            return ComMethod.GetList<ApplyInfo>("uspMaterialPrepareInfo", new SqlParameter[] { });
        }

        /// <summary>
        /// 仓库备料看板—今日发料统计、近一月发料统计
        /// </summary>
        /// <param name="type">类型 0：查今日发料统计 1：查近一月发料统计</param>
        /// <returns></returns>
        public IList<ApplyInfo> GetMaterialPrepareKanban(int type)
        {
            SqlParameter[] parms = {
                new SqlParameter("@Type", SqlDbType.Int)
            };
            parms[0].Value = type;
            return ComMethod.GetList<ApplyInfo>("uspMaterialPrepareKanban", parms);
        }

        #region 分页获取合并领料单信息
        /// <summary>
        /// 分页获取合并领料单信息
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="applyCount">apply 总数。</param>
        /// <returns>Apply 列表。</returns>
        public List<ApplyInfo> GetMergeApplyAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ApplyInfo> list = new List<ApplyInfo>();
            //表名或者视图
            string strTb = "vwMergeApply";//"Prod_MergeApply";
            //主键
            string strKey = "MergeId";//"MergeId";
            //查询栏位字串         
            string strColumns = @"MergeId, RowId, MergeApplyNo, ApplyNo, CreateBy, CreateDateTime,Statue";
            list = ComMethod.GetComList<ApplyInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        #endregion

        #region 通过领料单查询明细信息
        /// <summary>
        /// 通过领料单查询明细信息
        /// </summary>
        /// <param name="CustomerOrder"></param>
        /// <param name="NumberType"></param>
        /// <returns></returns>
        public ApplyInfo GetApplyDtlInfo(string ApplyNo)
        {
            ApplyInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ApplyNo", SqlDbType.VarChar,100)
            };
            parms[0].Value = ApplyNo;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetApplyDtlInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ApplyInfo();
                    entity.ApplyNo = rdr.GetString(0);
                    entity.ItemQty = rdr.GetInt32(1);
                }
                rdr.Close();
            }
            return entity;

        }
        #endregion

        #region 保存合并领料单信息
        /// <summary>
        /// 保存合并领料单信息
        /// </summary>
        /// <param name="entityList"></param>
        /// <param name="UserName"></param>
        public void SaveMergeApply(String entityList, string UserName)
        {
            DataTable dt = JsonToDataTable(entityList);
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@MergeApply",SqlDbType.Structured)
            };
            parms[0].Value = UserName;
            parms[1].Value = dt;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveMergeApply", 2000000, parms);
        }
        #endregion

        #region 将 Json 解析成 DateTable
        /// <summary>    
        /// 将 Json 解析成 DateTable   
        /// Json 数据格式如:  
        ///{table:[{column1:1,column2:2,column3:3},{column1:1,column2:2,column3:3}]} 
        /// </summary>    
        /// <param name="strJson">要解析的 Json 字符串</param>    
        /// <returns>返回 DateTable</returns>    
        public static DataTable JsonToDataTable(string strJson)
        {
            // 取出表名    
            var rg = new Regex(@"(?<={)[^:]+(?=:\[)", RegexOptions.IgnoreCase);
            string strName = rg.Match(strJson).Value;
            DataTable tb = null;
            // 去除表名    
            strJson = strJson.Substring(strJson.IndexOf("[") + 1);
            strJson = strJson.Substring(0, strJson.IndexOf("]"));
            // 获取数据    
            rg = new Regex(@"(?<={)[^}]+(?=})");
            MatchCollection mc = rg.Matches(strJson);
            for (int i = 0; i < mc.Count; i++)
            {
                string strRow = mc[i].Value;
                string[] strRows = strRow.Split(',');
                // 创建表    
                if (tb == null)
                {
                    tb = new DataTable();
                    tb.TableName = strName;
                    foreach (string str in strRows)
                    {
                        var dc = new DataColumn();
                        string[] strCell = str.Split(':');
                        dc.ColumnName = strCell[0].Replace("\"", "");
                        tb.Columns.Add(dc);
                    }
                    tb.AcceptChanges();
                }
                // 增加内容    
                DataRow dr = tb.NewRow();
                for (int j = 0; j < strRows.Length; j++)
                {
                    dr[j] = strRows[j].Split(':')[1].Replace("\"", "");
                }
                tb.Rows.Add(dr);
                tb.AcceptChanges();
            }
            return tb;
        }
        #endregion

        #region 取消合并领料单
        /// <summary>
        /// 取消合并领料单
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void CancelMerge(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveCancelMergeApply", parms);
        }
        #endregion


        /// <summary>
        /// 还原陆工修改的部分，他的应该是WMS上的
        /// </summary>
        /// <returns></returns>
        public List<MaterialUnitInfo> CheckGrnMaterialPrepareNew(String ItemStr, String Grn, Int32 flage, String grnStr)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ItemStr",SqlDbType.NVarChar,int.MaxValue),
                  new SqlParameter("@Grn",SqlDbType.NVarChar,int.MaxValue),
                  new SqlParameter("@Flage",SqlDbType.Int),
                  new SqlParameter("@GrnStr",SqlDbType.NVarChar,int.MaxValue)
            };
            parms[0].Value = ItemStr;
            parms[1].Value = Grn;
            parms[2].Value = flage;
            parms[3].Value = grnStr;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckGrnMaterialPrepare_ST2", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.PartId = rdr.GetInt32(2);
                    entity.Flage = rdr.GetInt32(3);
                    entity.IssueWay = rdr.GetInt32(4);
                    entity.ConfigType = rdr["ConfigType"].ToString();
                    entity.MinData = rdr["MinData"] == null || rdr["MinData"] == DBNull.Value ? string.Empty : rdr["MinData"].ToString();

                    entity.MinGrn = Convert.ToString(rdr["MinGrn"]);
                    entity.CBarCode = rdr["cBarCode"].ToString();
                    entity.ItemCode = ComMethod.FromDatabase<string>(rdr["ItemCode"]);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }


        #region 形态转换单打印


        public byte[] GetFormChangeListPrintPdfByte(string FormChangeId, int applyType, string strXmlFilePath, string strImgPath, string strItemId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@FormChangeId",SqlDbType.VarChar,50),
            };
            parms[0].Value = FormChangeId;
            DataSet ds = ComMethod.GetListDataSet("upsGetFormChangeListPrint", parms, "dtForm");

            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        #endregion
    }
}