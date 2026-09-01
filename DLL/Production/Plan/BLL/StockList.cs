using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Plan.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Plan.BLL
{
    public class StockList
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 StandardLaborTime 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="standardLaborTimeCount">standardLaborTime 总数。</param>
        /// <returns>StandardLaborTime 列表。</returns>
        public List<StockListInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<StockListInfo> list = new List<StockListInfo>();
            //表名或者视图
            string strTb = "vwGetStockList";
            //主键
            string strKey = "StockListId";
            //查询栏位字串
            string strColumns = @"StockListId ,
                                   OrderNO ,
                                   TableName ,
                                   PartNumber ,
                                   ReplaceMaterial ,
                                   Positon ,
                                   Num ,
                                   EquipmentCode ,
                                   Location ,
                                   TotalNum ,
                                   ShouldIssue ,
                                   AlreadyIssue ,
                                   PreparedNum ,
                                   FeederType,
                                   ABCClass ,Area,CLNumber";
            var resultList  = ComMethod.GetComList<StockListInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            resultList = resultList.OrderBy(q => q.EquipmentCode).ThenBy(q=>q.Positon).ToList();
            return resultList;
        }

        /// <summary>
        /// 根据标识获取数据
        /// </summary>
        /// <param name="Id"></param>
        /// <returns></returns>
        public StockListInfo GetProdStockByID(int Id)
        {
            string sql = String.Format(@"SELECT StockListId,PartNumber AS itemCode,ItemID,Positon,EquipmentId,Num,FeederType,f.ID as 
            FeederTypeID,Area from Prod_StockList a 
            Left JOin Basal_FeerderType f on f.Name=a.FeederType where StockListId={0}", Id);

            return ComMethod.GetBySql<StockListInfo>(sql, new SqlParameter[] { });
        }

        /// <summary>
        /// 分页获取 StandardLaborTime 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="standardLaborTimeCount">standardLaborTime 总数。</param>
        /// <returns>StandardLaborTime 列表。</returns>
        public List<StockListInfo> GetStockListMaterial(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<StockListInfo> list = new List<StockListInfo>();
            //表名或者视图
            string strTb = "vwGetStockListMaterial";
            //主键
            string strKey = "ItemId";
            //查询栏位字串
            string strColumns = @"ItemId ,
                                  ItemCode ,
                                  ItemName ,
                                  ItemSpec ";

            return ComMethod.GetComList<StockListInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 新增电子备料清单替代料
        /// </summary>
        /// <param name="stockListId"></param>
        /// <param name="replaceItemCode"></param>
        /// <param name="userId"></param>
        public void AddStockListReplaceMaterial(int stockListId, string replaceItemCode, int userId, string location)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StockListId", SqlDbType.Int),
                new SqlParameter("@ReplaceItemCode", SqlDbType.VarChar),
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@Location", SqlDbType.NVarChar,100),
            };

            parms[0].Value = stockListId;
            parms[1].Value = replaceItemCode;
            parms[2].Value = userId;
            parms[3].Value = location;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAddStockListReplaceMaterial", parms);
        }

        /// <summary>
        /// 新增电子备料清单主料和料站信息
        /// </summary>
        /// <param name="linePlanOrder"></param>
        /// <param name="mainItemCode"></param>
        /// <param name="position"></param>
        /// <param name="num"></param>
        /// <param name="equipmentId"></param>
        /// <param name="userId"></param>
        /// <param name="feederType"></param>
        public void AddStockListPosition(string linePlanOrder, string mainItemCode, string position, decimal num, int equipmentId, int userId,string feederType,string area,int StockListId=0)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LinePlanOrder", SqlDbType.VarChar),
                new SqlParameter("@MainItemCode", SqlDbType.VarChar),
                new SqlParameter("@Position", SqlDbType.VarChar),
                new SqlParameter("@Num", SqlDbType.Decimal),
                new SqlParameter("@EquipmentId", SqlDbType.Int),
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@feederType", SqlDbType.VarChar),
                new SqlParameter("@Area", SqlDbType.VarChar),
                new SqlParameter("@StockListId", SqlDbType.Int),
            };

            parms[0].Value = linePlanOrder;
            parms[1].Value = mainItemCode;
            parms[2].Value = position;
            parms[3].Value = num;
            parms[4].Value = equipmentId;
            parms[5].Value = userId;
            parms[6].Value = feederType;
            parms[7].Value = area;
            parms[8].Value = StockListId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAddStockListPosition", parms);
        }

        /// <summary>
        /// 排产工单换线
        /// </summary>
        /// <param name="linePlanOrder"></param>
        /// <param name="lineId"></param>
        /// <param name="userName"></param>
        public void StockListChangeLine(string linePlanOrder, int lineId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LinePlanOrder", SqlDbType.VarChar),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar),
            };

            parms[0].Value = linePlanOrder;
            parms[1].Value = lineId;
            parms[2].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspStockListChangeLine", parms);
        }
        /// <summary>
        /// JIT发料
        /// </summary>
        /// <param name="linePlanOrder"></param>
        /// <param name="applyId"></param>
        /// <param name="grn"></param>
        /// <param name="equipmentId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        public string CollectStockListMaterial(string linePlanOrder, int applyId, string grn, int equipmentId, int userId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                        new SqlParameter("@LinePlanNo", SqlDbType.VarChar),
                        new SqlParameter("@ApplyId", SqlDbType.Int),
                        new SqlParameter("@GRN", SqlDbType.VarChar),
                        new SqlParameter("@EquipmentId", SqlDbType.Int),
                        new SqlParameter("@UserId", SqlDbType.Int),
                        new SqlParameter("@UserName", SqlDbType.VarChar),
                        new SqlParameter("@ItemCode", SqlDbType.VarChar,50),
                    };

            parms[0].Value = linePlanOrder;
            parms[1].Value = applyId;
            parms[2].Value = grn;
            parms[3].Value = equipmentId;
            parms[4].Value = userId;
            parms[5].Value = userName;
            parms[6].Value = "";
            parms[6].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectStockListMaterial", parms);

            return Convert.ToString(parms[6].Value);
        }
        /// <summary>
        /// 获取排产工单所排线别上的设备信息
        /// </summary>
        /// <param name="linePlanNo"></param>
        /// <returns></returns>
        public DataTable GetEquipmentList(string linePlanNo)
        {
            //string sql = String.Format(@"
            //                         SELECT distinct b.EquipmentId,b.EquipmentCode FROM dbo.Prod_LinePlan AS a  
            //                         INNER JOIN dbo.Basal_Equipment AS b ON a.LineId = b.LineId 
            //                          WHERE a.FBILLNO='{0}' AND a.State <>5", linePlanNo);
            string sql = String.Format(@"
                                     SELECT distinct b.EquipmentId,b.EquipmentCode FROM dbo.Prod_LinePlan AS a  
                                     INNER JOIN dbo.Basal_Equipment AS b ON a.LineId = b.LineId 
                                      WHERE a.FBILLNO='{0}' ", linePlanNo);

            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, null);
        }
        /// <summary>
        /// 获取排产工单所排线别上的设备信息
        /// </summary>
        /// <param name="linePlanNo"></param>
        /// <returns></returns>
        public DataTable GetPDAEquipmentList(string linePlanNo)
        {
            string sql = String.Format(@"
                                      SELECT distinct b.EquipmentId,b.EquipmentCode 
                                      FROM dbo.Prod_LinePlan AS a  
                                      INNER JOIN dbo.Basal_Equipment AS b ON a.LineId = b.LineId 
                                      INNER JOIN dbo.Prod_StockList AS c ON a.LinePlanId = c.OrderSchedulingId AND c.IsShow = 1 AND b.EquipmentId = c.EquipmentId 
                                      WHERE a.FBILLNO='{0}' AND a.State <>5 ", linePlanNo);

            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, null);
        }
        /// <summary>
        /// 获取领料单信息
        /// </summary>
        /// <param name="linePlanId"></param>
        /// <returns></returns>
        public DataTable GetApplyNo(string linePlanNo)
        {
            string sql = String.Format(@"
                                     SELECT c.ApplyId,c.ApplyNo FROM dbo.Prod_LinePlan AS a 
                                      INNER JOIN dbo.Prod_Order AS b  ON a.FInterID = b.ProdOrderID 
                                      INNER JOIN dbo.Prod_Apply AS c ON b.OrderNO = c.MOCode 
                                      WHERE a.FBILLNO = '{0}' and Statue>= 0", linePlanNo);

            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, null);
        }

        /// <summary>
        /// 获取JIT电子备料单信息
        /// </summary>
        /// <param name="linePlanId"></param>
        /// <returns></returns>
        public List<StockListInfo> GetJITStockList(string linePlanNo, int equipmentId)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@LinePlanNo", SqlDbType.VarChar),
                new SqlParameter("@EquipmentId", SqlDbType.Int),
            };
            param[0].Value = linePlanNo;
            param[1].Value = equipmentId;

            return ComMethod.GetList<StockListInfo>("uspGetStockListJITMaterial", param, null);
        }

        /// <summary>
        /// PDA扫描GRN接收物料
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        public void StockListMaterialReceive(string grn, int userId, string userName, string prepareMaterialNo, string getType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                        new SqlParameter("@GRN", SqlDbType.VarChar),
                        new SqlParameter("@UserId", SqlDbType.Int),
                        new SqlParameter("@UserName", SqlDbType.VarChar),
                        new SqlParameter("@PrepareMaterialNo", SqlDbType.VarChar),
                        new SqlParameter("@GetType", SqlDbType.VarChar)
                    };

            parms[0].Value = grn;
            parms[1].Value = userId;
            parms[2].Value = userName;
            parms[3].Value = prepareMaterialNo;
            parms[4].Value = getType;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPrepareMaterialGrnReceive", parms);
            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspStockListMaterialReceive", parms);
        }

        public void DeleteStockListPosition(int stockListId, string planOrderNo, string createBy)
        {
            SqlParameter[] parms = new SqlParameter[] {
                        new SqlParameter("@StockListId", SqlDbType.Int),
                        new SqlParameter("@PlanOrderNo", SqlDbType.NVarChar,200),
                        new SqlParameter("@CreateBy", SqlDbType.NVarChar,20)
            };
            parms[0].Value = stockListId;
            parms[1].Value = planOrderNo;
            parms[2].Value = createBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteStockPositon", parms);

        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
