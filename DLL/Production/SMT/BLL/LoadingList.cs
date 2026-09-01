
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.PubItems.BLL;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.SMT.BLL
{
    public class LoadingList
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LIST 信息。
        /// </summary>
        /// <param name="entity">LIST 实体对象。</param>
        public Int32 Edit(LoadinglistInfo entity, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@SetupName", SqlDbType.VarChar, 200),
                new SqlParameter("@CustomerName", SqlDbType.VarChar, 200),
                new SqlParameter("@Revision", SqlDbType.VarChar, 50),
                new SqlParameter("@StatusID", SqlDbType.TinyInt),
                new SqlParameter("@CreationTime", SqlDbType.DateTime),
                new SqlParameter("@LastUpdate", SqlDbType.DateTime),
                new SqlParameter("@IsFullSet", SqlDbType.Bit),
                new SqlParameter("@EquipmentLineId",SqlDbType.Int),
                new SqlParameter("@SequenceNo",SqlDbType.Int),
                new SqlParameter("@SmtLayout", SqlDbType.NVarChar, 100),
                new SqlParameter("@LoadingTypeId",SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 200),
                new SqlParameter("@CLNumber", SqlDbType.Decimal)
            };

            parms[0].Value = entity.ID;
            parms[1].Value = entity.ItemId;
            parms[2].Value = entity.SetupName;
            parms[3].Value = entity.CustomerName;
            parms[4].Value = entity.Revision;
            parms[5].Value = entity.StatusID;
            parms[6].Value = DateTime.Now;
            parms[7].Value = DateTime.Now;
            parms[8].Value = entity.IsFullSet;
            parms[9].Value = entity.EquipmentLineId;
            parms[10].Value = entity.SequenceNo;
            parms[11].Value = entity.SmtLayout;
            parms[12].Value = entity.LoadingTypeId;
            parms[13].Value = UserName;
            parms[14].Value = entity.CLNumber;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingList_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LISTId 字符串删除 LIST 信息。
        /// </summary>
        /// <param name="idString">LISTId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingList_Delete", parms);
        }

        /// <summary>
        /// 根据 LISTId 获取实体信息。
        /// </summary>
        /// <param name="lISTId">LISTId。</param>
        /// <returns>LIST 实体对象。</returns>
        public LoadinglistInfo GetInfo(Int32 lISTId)
        {
            LoadinglistInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = lISTId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingList_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LoadinglistInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3),
                        rdr.GetString(4), rdr.GetString(5), rdr.GetByte(6), rdr.GetDateTime(7), rdr.GetDateTime(8),
                        rdr.GetString(9), rdr.GetBoolean(10), rdr.GetString(11), rdr.GetInt32(12), rdr.GetInt32(13), rdr.GetInt32(14));
                    entity.CLNumber = rdr.GetDecimal(15);
                }
                rdr.Close();
            }

            return entity;
        }
        public LoadinglistInfo GetNameByIineId(int status, int lineId)
        {
            LoadinglistInfo listInfo = null;
            string sqlStr = "select ID, ItemId, SetupName from Prod_LoadingList where StatusID = @StatusID and LineID = @LineID ";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@StatusID",SqlDbType.Int,0),
                new SqlParameter("@LineID",SqlDbType.Int,0)
            };
            parms[0].Value = status;
            parms[1].Value = lineId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sqlStr, parms))
            {
                if (rdr.Read())
                {
                    listInfo = new LoadinglistInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2));
                }
                rdr.Close();
            }
            return listInfo;

        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LIST 实体对象。</returns>
        public List<LoadinglistInfo> GetInfo(String fieldValue)
        {
            List<LoadinglistInfo> list = new List<LoadinglistInfo>();

            LoadinglistInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingList_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3),
                        rdr.GetString(4), rdr.GetString(5), rdr.GetByte(6), rdr.GetDateTime(7), rdr.GetDateTime(8),
                        rdr.GetString(9), rdr.GetBoolean(10), rdr.GetString(11), rdr.GetInt32(12), rdr.GetInt32(13), rdr.GetInt32(14));

                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 分页获取 LIST 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="lISTCount">lIST 总数。</param>
        /// <returns>LIST 列表。</returns>
        public List<LoadinglistInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadinglistInfo> list = new List<LoadinglistInfo>();
            LoadinglistInfo entity = null;

            //SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_LoadingList a left join Prod_LoadingListStatus b on a.StatusID=b.id left join Basal_Line c on c.Lineid=a.LineID Left join Basal_Item d on d.ItemID=a.itemID ", "a.ID",
            //    "a.[ID], a.[ItemId], ISNULL(d.[ItemName],'') as ItemName, [SetupName], [CustomerName], [Revision], [ResId], [IsSwitchable], [IsRefDesignator], [FamilyMatrixID], b.[Description], a.[LineID], CASE WHEN c.[LineName] IS NULL THEN '' ELSE c.[LineName] END AS LineName, [CreationTime], [LastUpdate], ISNULL(d.[ItemCode],'') as ItemCode", searchSettings, sortExpression);
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwLoadingList"
                , "[ID]"
                , @"[ID],ItemId,ItemName, SetupName, [CustomerName], [Revision], [Description]
                    , EquipmentLineDisplayName,SequenceNo
                    , [CreationTime],CreateBy
                    , [LastUpdate],ItemCode,TypeName,SmtLayout,EquipmentLineType,CLNumber,ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo();
                    entity.ID = Convert.ToInt32(rdr["ID"]);
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.ItemName = rdr["ItemName"].ToString();
                    entity.SetupName = rdr["SetupName"].ToString();
                    entity.CustomerName = rdr["CustomerName"].ToString();
                    entity.Revision = rdr["Revision"].ToString();
                    entity.StatusStr = rdr["Description"].ToString();
                    entity.EquipmentLineDisplayName = rdr["EquipmentLineDisplayName"].ToString();
                    entity.SequenceNo = (int)rdr["SequenceNo"];
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreationTime = Convert.ToDateTime(rdr["CreationTime"]);
                    entity.TypeName = rdr["TypeName"].ToString();
                    entity.SmtLayout = rdr["SmtLayout"].ToString();
                    entity.EquipmentLineType = rdr["EquipmentLineType"].ToString();
                    entity.CLNumber = decimal.Parse(rdr["CLNumber"].ToString());

                    entity.ModifyBy = rdr["ModifyBy"].ToString();
                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime")))
                    {
                        entity.ModifyTime = Convert.ToDateTime(rdr["ModifyTime"]);
                    }

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 查看上料清单物料详情
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<LoadinglistInfo> GetAllGRN(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadinglistInfo> list = new List<LoadinglistInfo>();
            LoadinglistInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwLoadingListGRNRecords"
                , "[ID]"
                , @"ID, SetupName, Revision, ItemCode, ItemName, SerialNumber, CreationTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo();
                    entity.ID = rdr.GetInt32(0);
                    entity.SetupName = rdr.GetString(1);
                    entity.Revision = rdr.GetString(2);
                    entity.ItemCode = rdr.GetString(3);
                    entity.ItemName = rdr.GetString(4);
                    entity.SerialNumber = rdr.GetString(5);
                    entity.CreationTime = rdr.GetDateTime(6);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        /// <summary>
        /// 插入LoadingList 实体信息。
        /// </summary>
        /// <param name="entity">LIST 实体对象。</param>
        public int SaveLoadingList(LoadinglistInfo entity, DataTable GridTable)
        {

            int ErrorMsg = 0;

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@SetupName", SqlDbType.VarChar),
                new SqlParameter("@CustomerName", SqlDbType.VarChar),
                new SqlParameter("@Revision", SqlDbType.VarChar),
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@IsSwitchable", SqlDbType.Bit),
                new SqlParameter("@IsRefDesignator", SqlDbType.Bit),
                new SqlParameter("@FamilyMatrixID", SqlDbType.Int),
                new SqlParameter("@LineID", SqlDbType.Int),
                new SqlParameter("@LastUpdate", SqlDbType.VarChar),
                new SqlParameter("@LLData", SqlDbType.Structured),
                new SqlParameter("@IsFullSet",SqlDbType.Bit)
            };

            parms[0].Value = entity.ItemId; ;
            parms[1].Value = entity.SetupName;
            parms[2].Value = entity.CustomerName;
            parms[3].Value = entity.Revision;
            //parms[4].Value = entity.ResId;
            //parms[5].Value = entity.IsSwitchable;
            //parms[6].Value = entity.IsRefDesignator;
            //parms[7].Value = entity.FamilyMatrixID;
            //parms[8].Value = entity.LineID;
            parms[9].Value = entity.LastUpdate;
            parms[10].Value = GridTable;
            parms[11].Value = entity.IsFullSet;
            ErrorMsg = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_LoadingList_Add", parms);



            return ErrorMsg;


        }


        /// <summary>
        /// 插入LoadingList 实体信息。
        /// </summary>
        /// <param name="entity">LIST 实体对象。</param>

        public string SaveLoadingList(LoadinglistInfo entity)
        {
            string ErrorMsg = "";
            SqlConnection Conn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            Conn.ConnectionString = SQLHelper.MESConnString.ToString();
            SqlCommand myCommand = new SqlCommand("LoadingList_Add", Conn); //SQL 
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.Parameters.Add("@ItemId", SqlDbType.Int).Value = entity.ItemId;
            myCommand.Parameters.Add("@SetupName", SqlDbType.VarChar).Value = entity.SetupName;
            myCommand.Parameters.Add("@CustomerName", SqlDbType.VarChar).Value = entity.CustomerName;
            myCommand.Parameters.Add("@Revision", SqlDbType.VarChar).Value = entity.Revision;
            //myCommand.Parameters.Add("@ResId", SqlDbType.Int).Value = entity.ResId;
            //myCommand.Parameters.Add("@IsSwitchable", SqlDbType.Bit).Value = entity.IsSwitchable;
            //myCommand.Parameters.Add("@IsRefDesignator", SqlDbType.Bit).Value = entity.IsRefDesignator;
            //myCommand.Parameters.Add("@FamilyMatrixID", SqlDbType.Int).Value = entity.FamilyMatrixID;
            //myCommand.Parameters.Add("@LineID", SqlDbType.Int).Value = entity.LineID;
            myCommand.Parameters.Add("@LastUpdate", SqlDbType.VarChar).Value = entity.LastUpdate;


            SqlParameter returnvalue = myCommand.Parameters.Add("@returnvalue", SqlDbType.Int);
            returnvalue.Direction = ParameterDirection.ReturnValue;


            myCommand.Connection.Open();
            myCommand.ExecuteNonQuery();
            //ErrorMsg = myCommand.Parameters["Returnvalue"].Value.ToString();

            //int result = command.parameters["Returnvalue"].value;
            myCommand.Connection.Close();

            return ErrorMsg;

        }

        /// <summary>
        /// 获取Machine ID信息。
        /// </summary>
        /// <param name="entity">LIST 实体对象。</param>

        public int GetMachineID(string Name)
        {
            int MachineID = 0;

            SqlConnection Conn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            Conn.ConnectionString = SQLHelper.MESConnString.ToString();
            SqlCommand myCommand = new SqlCommand("Machine_ID", Conn); //SQL 
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.Parameters.Add("@MachineName", SqlDbType.NVarChar).Value = Name;

            myCommand.Connection.Open();
            SqlDataReader myReader = myCommand.ExecuteReader();
            if (myReader.Read())
            {
                MachineID = int.Parse(myReader["id"].ToString());
            }
            myCommand.Connection.Close();
            return MachineID;
        }

        /// <summary>
        /// 保存 LoadingListDetail 信息。
        /// </summary>


        public int GetLoadingListID(string Name)
        {
            int LoadingListID = 0;
            SqlConnection Conn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            Conn.ConnectionString = SQLHelper.MESConnString.ToString();
            SqlCommand myCommand = new SqlCommand("LoadingList_ID", Conn); //SQL 
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.Parameters.Add("@SetupName", SqlDbType.NVarChar).Value = Name;

            myCommand.Connection.Open();
            SqlDataReader myReader = myCommand.ExecuteReader();
            if (myReader.Read())
            {
                LoadingListID = int.Parse(myReader["id"].ToString());
            }
            myCommand.Connection.Close();
            return LoadingListID;
        }


        /// <summary>
        /// 保存 LoadingListDetail 信息。
        /// </summary>


        public int GetItemID(string ItemName)
        {
            int ItemID = 0;
            SqlConnection Conn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            Conn.ConnectionString = SQLHelper.MESConnString.ToString();
            SqlCommand myCommand = new SqlCommand("Item_ID", Conn); //SQL 
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.Parameters.Add("@ItemName", SqlDbType.NVarChar).Value = ItemName;

            myCommand.Connection.Open();
            SqlDataReader myReader = myCommand.ExecuteReader();
            if (myReader.Read())
            {
                ItemID = int.Parse(myReader["ItemID"].ToString());
            }
            myCommand.Connection.Close();
            return ItemID;
        }

        public int SaveLoadingListMachine(int LL_ID, int MachineID)
        {
            int LL_Machine_ID = 0;
            SqlConnection Conn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();
            Conn.ConnectionString = SQLHelper.MESConnString.ToString();
            SqlCommand myCommand = new SqlCommand("LoadingListMachine_Add", Conn); //SQL 
            myCommand.CommandType = CommandType.StoredProcedure;
            myCommand.Parameters.Add("@LLID", SqlDbType.Int).Value = LL_ID;
            myCommand.Parameters.Add("@MID", SqlDbType.Int).Value = MachineID;
            myCommand.Parameters.Add("@LLMID", SqlDbType.Int).Value = MachineID;

            myCommand.Parameters[0].Direction = ParameterDirection.Input;
            myCommand.Parameters[1].Direction = ParameterDirection.Input;
            myCommand.Parameters[2].Direction = ParameterDirection.Output;



            SqlParameter returnvalue = myCommand.Parameters.Add("@returnvalue", SqlDbType.Int);
            returnvalue.Direction = ParameterDirection.ReturnValue;


            myCommand.Connection.Open();
            myCommand.ExecuteNonQuery();
            LL_Machine_ID = int.Parse(myCommand.Parameters[2].Value.ToString());

            //int result = command.parameters["Returnvalue"].value;
            myCommand.Connection.Close();

            return LL_Machine_ID;

        }
        /// <summary>
        ///  获取用户当前选中线别上一次操作
        /// </summary>
        /// <param name="lId">线别id</param>
        /// <returns></returns>
        public LoadinglistInfo GetLastLineOpreation(int lId)
        {
            LoadinglistInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@lineID", SqlDbType.Int),
            };
            parms[0].Value = lId;


            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLastLineOpreation", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo();

                    entity.SetupName = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                }
                rdr.Close();
            }
            return entity;
        }
        /// <summary>
        /// 获取对应线别loadlist
        /// </summary>
        /// <param name="lId">线别id</param>
        /// <returns></returns>
        public List<LoadinglistInfo> GetLoadingSetupName(int lId)
        {
            LoadinglistInfo entity = null;
            List<LoadinglistInfo> list = new List<LoadinglistInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@lineID", SqlDbType.Int),
            };
            parms[0].Value = lId;


            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLoadingListSetupName", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo();

                    entity.ID = rdr.GetInt32(0);
                    entity.SetupName = rdr.GetString(1);
                    entity.Description = rdr.GetString(2);
                    entity.CreationTime_Str = rdr.GetDateTime(3).ToString();
                    entity.OrderNo = rdr.GetString(4);
                    entity.ResName = rdr.GetString(5);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 线别设置
        /// </summary>
        /// <param name="lineId"></param>
        /// <param name="loadlistId"></param>
        /// <returns></returns>
        public void ValidateMaterialOperation(string orderNo, int resId, int lineId, int loadlistId, int userId)
        {

            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@OrderNo",SqlDbType.VarChar),
                 new SqlParameter("@ResId",SqlDbType.Int),
                 new SqlParameter("@lineID", SqlDbType.Int),
                 new SqlParameter("@loadlistID", SqlDbType.Int),
                 new SqlParameter("@userId", SqlDbType.Int),
            };
            parms[0].Value = orderNo;
            parms[1].Value = resId;
            parms[2].Value = lineId;
            parms[3].Value = loadlistId;
            parms[4].Value = userId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidateLine", parms);
        }
        /// <summary>
        /// 保存报警历史记录
        /// </summary>
        /// <param name="lineId"></param>
        /// <param name="loadlistId"></param>
        /// <returns></returns>//flage, userId, hostname, Comment, action,errorCode,status
        public void SaveAlertHistory(int flage, string userId, string Hostname, string Comment, int action, string errorCode, int status)
        {

            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@flage",SqlDbType.Int),
                 new SqlParameter("@userId", SqlDbType.VarChar),
                 new SqlParameter("@Hostname", SqlDbType.VarChar),
                 new SqlParameter("@Comment", SqlDbType.VarChar),
                 new SqlParameter("@action",SqlDbType.Int),
                 new SqlParameter("@errorCode",SqlDbType.VarChar),
                 new SqlParameter("@status",SqlDbType.Int),
            };
            parms[0].Value = flage;
            parms[1].Value = userId;
            parms[2].Value = Hostname;
            parms[3].Value = Comment;
            parms[4].Value = action;
            parms[5].Value = errorCode;
            parms[6].Value = status;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveAlertHistory", parms);
        }

        /// <summary>
        /// 卸料 add  by weixia on 2016.8.13
        /// </summary>
        public void LoadListUnLoadMaterial(string FBillNo, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@FBillNo",SqlDbType.NVarChar,50),
                 new SqlParameter("@UserName", SqlDbType.VarChar,20)
            };

            parms[0].Value = FBillNo;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspLoadListUnLoadMaterial", parms);
        }

        /// <summary>
        /// add by weixia  on 2016.8.15查询数据
        /// ver.851
        /// </summary>
        /// <param name="lId"></param>
        /// <returns></returns>
        public List<LoadinglistInfo> GetLoadListBySearch(string FBillNo, int SearchType)
        {
            LoadinglistInfo entity = null;
            List<LoadinglistInfo> list = new List<LoadinglistInfo>();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FBillNo", SqlDbType.NVarChar,50),
                new SqlParameter("@SearchType", SqlDbType.Int)
            };
            parms[0].Value = FBillNo;
            parms[1].Value = SearchType;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLoadListBySearchs", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo();
                    entity.TableSlotSN = rdr["Position"].ToString();
                    entity.GrnStr = rdr["SerialNumber"].ToString();
                    entity.FeedStr = rdr["FeederSN"].ToString();
                    entity.EquipmentLineDisplayName = rdr["EquipmentName"].ToString();
                    //entity.LoadingListId = (int)rdr["LoadingListID"];
                    //entity.SetupName = rdr["SetupName"].ToString();
                    entity.BalanceQty = Convert.ToDecimal(rdr["BalanceQty"]);
                    entity.Area = rdr["Area"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 开拉/停拉执行动作
        /// ver.851
        /// </summary>
        public void ValidateSMTStartFeeMap(string FBillNo, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                 //new SqlParameter("@flage",SqlDbType.Int),
                 new SqlParameter("@FBillNo", SqlDbType.NVarChar,50),
                 new SqlParameter("@UserName", SqlDbType.NVarChar,20),

            };
            parms[0].Value = FBillNo;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidateSMTStartFeeMap", parms);
        }
        public void ValidateSMTStartFeeMaps(string FBillNo, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@FBillNo", SqlDbType.NVarChar,50),
                 new SqlParameter("@UserName", SqlDbType.NVarChar,20),

            };
            parms[0].Value = FBillNo;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidateSMTStartFeeMaps", parms);
        }
        /// <summary>
        /// 续料验证  add by weixia on 2016.8.12
        /// ver.851
        /// </summary>
        public void ValidateSMTAddFeed(int LoadListId, string FBillNo, String oldGRN, String newGRN, Int32 userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@LoadListId",SqlDbType.Int),
                 new SqlParameter("@FBillNo", SqlDbType.NVarChar,50),
                 new SqlParameter("@oldGRN", SqlDbType.NVarChar,100),
                 new SqlParameter("@newGRN", SqlDbType.NVarChar,100),
                 new SqlParameter("@UserId",SqlDbType.Int)
            };
            parms[0].Value = LoadListId;
            parms[1].Value = FBillNo;
            parms[2].Value = oldGRN;
            parms[3].Value = newGRN;
            parms[4].Value = userId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidateSMTAddFeed", parms);
        }
        /// <summary>
        /// 续料验证  
        /// ver.851
        /// </summary>
        public void ValidateSMTAddFeeds(string FBillNo, String oldGRN, String newGRN, Int32 userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@FBillNo", SqlDbType.NVarChar,50),
                 new SqlParameter("@oldGRN", SqlDbType.NVarChar,100),
                 new SqlParameter("@newGRN", SqlDbType.NVarChar,100),
                 new SqlParameter("@UserId",SqlDbType.Int)
            };
            parms[0].Value = FBillNo;
            parms[1].Value = oldGRN;
            parms[2].Value = newGRN;
            parms[3].Value = userId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidateSMTAddFeeds", parms);
        }
        /// <summary>
        /// add by weixia on 2016.8.12 上料验证
        /// ver.851
        /// </summary>
        public string ValidateSMTFeedMap(String slotSN, String grn, String feedSN, string FBillNo, Int32 loadListId, Int32 userID, int SlotHead)
        {
            string curNum = "";
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@SlotSN",SqlDbType.NVarChar),
                 new SqlParameter("@Grn", SqlDbType.NVarChar),
                 new SqlParameter("@FeedSN", SqlDbType.NVarChar),
                 new SqlParameter("@FBillNo", SqlDbType.NVarChar),
                 new SqlParameter("@LoadListId", SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@SlotHead",SqlDbType.Int)
            };
            parms[0].Value = slotSN;
            parms[1].Value = grn;
            parms[2].Value = feedSN;
            parms[3].Value = FBillNo;
            parms[4].Value = loadListId;
            parms[5].Value = userID;
            parms[6].Value = SlotHead;
            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidateSMTFeedMap", parms);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspValidateSMTFeedMap_Test", parms))
            {
                if (rdr.Read())
                {
                    curNum = rdr.GetString(0) ?? "";
                }
                rdr.Close();
            }
            return curNum;

        }
        /// <summary>
        /// 
        /// update 新增area区域                                       
        /// </summary>
        public string ValidateSMTFeedMaps(String slotSN, String grn, String feedSN, string FBillNo, Int32 loadListId, Int32 userID, int SlotHead, string area)
        {
            string curNum = "";
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@SlotSN",SqlDbType.NVarChar),
                 new SqlParameter("@Grn", SqlDbType.NVarChar),
                 new SqlParameter("@FeedSN", SqlDbType.NVarChar),
                 new SqlParameter("@FBillNo", SqlDbType.NVarChar),
                 new SqlParameter("@MachineId", SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@SlotHead",SqlDbType.Int),
                 new SqlParameter("@Area",SqlDbType.NVarChar)
            };
            parms[0].Value = slotSN;
            parms[1].Value = grn;
            parms[2].Value = feedSN;
            parms[3].Value = FBillNo;
            parms[4].Value = loadListId;
            parms[5].Value = userID;
            parms[6].Value = SlotHead;
            parms[7].Value = area;

            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidateSMTFeedMap", parms);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspValidateSMTFeedMap_Tests", parms))
            {
                if (rdr.Read())
                {
                    curNum = rdr.GetString(0) ?? "";
                }
                rdr.Close();
            }
            return curNum;

        }
        /// <summary>
        /// add by weixia on 2016.8.12 线别设置
        /// </summary>
        /// <param name="lineId"></param>
        /// <param name="resId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="loadListId"></param>
        /// <param name="userId"></param>
        public void CreateloadListLineSetUp(Int32 lineId, Int32 resId, Int32 prodOrderId, Int32 loadListId, Int32 userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@LineID",SqlDbType.Int),
                 new SqlParameter("@ResID", SqlDbType.Int),
                 new SqlParameter("@ProdOrderID", SqlDbType.Int),
                 new SqlParameter("@LoadlistID", SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int)
            };
            parms[0].Value = lineId;
            parms[1].Value = resId;
            parms[2].Value = prodOrderId;
            parms[3].Value = loadListId;
            parms[4].Value = userId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCreateloadListLineSetUp", parms);
        }

        /// <summary>
        /// 上料完成  2017-6-10
        /// ver.851
        /// </summary>
        public void SmtFinished(string FBillNo, string curUser = "")
        {
            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@FBillNo", SqlDbType.NVarChar,50),
                 new SqlParameter("@CurrentUser", SqlDbType.NVarChar,20),
            };
            parms[0].Value = FBillNo;
            parms[1].Value = curUser;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSMTFinished", parms);
        }

        /// <summary>
        /// 根据GRN获取对应信息
        /// </summary>
        public LoadinglistInfo GetSMTMaterialInfoByGRN(Int32 resId, Int32 prodOrderId, Int32 loadListId, String GRN)
        {
            LoadinglistInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ResID", SqlDbType.Int),
                new SqlParameter("@ProdOrderID", SqlDbType.Int),
                new SqlParameter("@LoadListId", SqlDbType.Int),
                new SqlParameter("@GRN", SqlDbType.NVarChar,100)
            };
            parms[0].Value = resId;
            parms[1].Value = prodOrderId;
            parms[2].Value = loadListId;
            parms[3].Value = GRN;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetSMTMaterialInfoByGRN", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo();
                    entity.BalanceQty = rdr.GetDecimal(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);

                }
                rdr.Close();
            }
            return entity;
        }
        public LoadinglistInfo GetSMTMaterialInfoByGRNs(Int32 loadListId, String slot)
        {
            LoadinglistInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@loadinglistid", SqlDbType.Int),
                new SqlParameter("@slot", SqlDbType.VarChar,50),
            };
            parms[0].Value = loadListId;
            parms[1].Value = slot;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSearchSlotInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo();
                    entity.ItemCode = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);

                }
                rdr.Close();
            }
            return entity;
        }
        /// <summary>
        /// 续料时：根据GRN获取对应信息
        /// </summary>
        public LoadinglistInfo GetCheckSMTMaterial(String GRN, Int32 checkType)
        {
            LoadinglistInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@GRN", SqlDbType.VarChar,100),
                new SqlParameter("@CheckType", SqlDbType.Int)
            };
            parms[0].Value = GRN;
            parms[1].Value = checkType;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckSMTMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo();
                    entity.BalanceQty = rdr.GetDecimal(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);

                }
                rdr.Close();
            }
            return entity;
        }

        public List<LoadinglistInfo> GetSMTStatusList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadinglistInfo> list = new List<LoadinglistInfo>();
            LoadinglistInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSMTStatusList"
                , "[ID]"
                , @"[OrderNO],[ID],ItemId,ItemName, SetupName, [CustomerName], [Revision], [ResId]
                , [FamilyMatrixID], [Description], [LineID], LineName, [CreationTime],ResName
                , [LastUpdate] ,ItemCode", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo();
                    entity.ID = (int)rdr["ID"];
                    entity.OrderNo = rdr["OrderNO"].ToString();
                    //entity.FamilyMatrixID = (int)rdr["FamilyMatrixID"];
                    //entity.ResId = (int)rdr["ResId"];
                    entity.ItemName = rdr["ItemName"].ToString();
                    entity.SetupName = rdr["SetupName"].ToString();
                    entity.CustomerName = rdr["CustomerName"].ToString();
                    entity.Revision = rdr["Revision"].ToString();
                    entity.Description = rdr["Description"].ToString();
                    entity.LineID = (int)rdr["LineID"];
                    entity.LineName = rdr["LineName"].ToString();
                    entity.CreationTime_Str = rdr["CreationTime"].ToString();
                    entity.ResName = rdr["ResName"].ToString();
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.LastUpdate = Convert.ToDateTime(rdr["LastUpdate"]);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public string GetSMTStatusListDtl(int OrderId, string ListName)
        {
            string sqlText = " SELECT * FROM [vwSMTStatusListDtl] WHERE ProdOrderID = " + OrderId + " AND SetupName='" + ListName.Trim() + "'";
            DataTable tb = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sqlText, null);
            return (new PubItems.BLL.PubItems()).GetListJson(tb);
        }
        public List<LoadinglistInfo> GetSMTStatusListView(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LoadinglistInfo> list = new List<LoadinglistInfo>();
            LoadinglistInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "[vwSMTAllDtl]"
                , "[ProdOrderID]"
                , @"TableSlotSN,FeederSN,GRN,EquipmentName,LoadingListID,OrderNO,ProdOrderID,MuQty,PreGRNQty,SNQty,StatusDesc,LineName,SmtTable,CreationTime,ItemCode,GRNItemCode,PlanBillNo,ActionType"
                , searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    //Modify By zhiman.yuan 2017-10-23
                    entity = new LoadinglistInfo();
                    entity.ProdOrderID = (int)rdr["ProdOrderID"];
                    entity.TableSlotSN = rdr["TableSlotSN"].ToString();
                    entity.GRN = rdr["GRN"].ToString();
                    entity.SNQty = rdr["SNQty"].ToString();
                    entity.PreGRNQty = rdr["PreGRNQty"].ToString();
                    entity.MUQTY = rdr["MUQTY"].ToString();
                    entity.StatusDesc = rdr["StatusDesc"].ToString();
                    entity.LineName = rdr["LineName"].ToString();
                    entity.SmtTable = rdr["SmtTable"].ToString();
                    entity.ItemCode = rdr["ItemCode"].ToString();
                    entity.GRNItemCode = rdr["GRNItemCode"].ToString();
                    entity.CreationTime = Convert.ToDateTime(rdr["CreationTime"]);
                    entity.EquipmentName = rdr["EquipmentName"].ToString();
                    entity.ActionType = rdr["ActionType"].ToString();
                    entity.PlanBillNo = rdr["PlanBillNo"].ToString();
                    entity.OrderNo = rdr["OrderNO"].ToString();
                    entity.FeedStr = rdr["FeederSN"].ToString();

                    list.Add(entity);
                }
                rdr.Close();
            }
            list = list.OrderBy(q => q.LineName).ThenBy(q => q.PlanBillNo).ThenBy(q => q.EquipmentName).ThenBy(q => q.TableSlotSN).ThenBy(q => q.CreationTime).ToList();
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public LoadinglistInfo GetSmtStatusNum(string planBillNo, int flag)
        {
            LoadinglistInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FBillNo", SqlDbType.NVarChar,50),
                new SqlParameter("@Flag", SqlDbType.Int)
            };
            parms[0].Value = planBillNo;
            parms[1].Value = flag;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetSmtStatusNum", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo();
                    entity.SNQty = rdr.GetString(0);
                }
                rdr.Close();
            }
            return entity;
        }
        public void Clean(string orderNo, int machineId, int userId)
        {
            //string strsql = @"DELETE  dbo.Prod_MachineTableSlotMuMap WHERE LoadingListID='" + loadinglistId + "'";
            string strsql = @"DELETE  dbo.Prod_MachineTableSlotMuMap WHERE PlanBillNo='" + orderNo + "' AND Equipment=" + machineId;

            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, strsql, null);

            string strsql1 = @"DELETE  dbo.Prod_MachineTableSlotMuMapHistory WHERE PlanBillNo='" + orderNo + "' AND Equipment=" + machineId;

            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, strsql1, null);

            //记录清除操作
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OperateType", SqlDbType.Int),
                new SqlParameter("@LinePlanNo", SqlDbType.NVarChar),
                new SqlParameter("@EquipementId", SqlDbType.Int),
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@Result", SqlDbType.Bit),
                new SqlParameter("@ErrorMsg", SqlDbType.NVarChar,200),
            };
            parms[0].Value = 2;
            parms[1].Value = orderNo;
            parms[2].Value = machineId;
            parms[3].Value = userId;
            parms[4].Value = 1;
            parms[4].Direction = ParameterDirection.InputOutput;
            parms[5].Value = "";
            parms[5].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectMaterialHitory", parms);

        }

        public string  CleanValidate(string orderNo, int machineId)
        {
            string strsql1 = @"select top 1 LastOperate from  dbo.vwGetMaterialHistory WHERE FBILLNO='" + orderNo + "' AND EquipmentID=" + machineId + " order by  BindTime desc";
            var result = "";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, strsql1, null))
            {
                while (rdr.Read())
                {
                    result = rdr.GetString(0);
                }
                rdr.Close();
            }
            return result;
        }

        /// <summary>
        /// 上料清单启用方法
        /// </summary>
        public void LoadingStatusStart(int id, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@id", SqlDbType.Int),
                  new SqlParameter("@UserName", SqlDbType.NVarChar,100),
            };
            parms[0].Value = id;
            parms[1].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "LoadingStatusStart", parms);
        }

        /// <summary>
        /// 获取GRN操作记录
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialHistoryInfo> GetMaterialHistory(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialHistoryInfo> list = new List<MaterialHistoryInfo>();
            //表名或者视图
            string strTb = "vwGetMaterialHistory";
            //主键
            string strKey = "MaterialHistoryId";
            //查询栏位字串
            string strColumns = @"[MaterialHistoryId], ProdOrderID ,OrderNO ,ItemCode ,ItemName ,ItemSpec ,
            Actual_Start_Date ,Actual_Completed_Date ,FBILLNO ,FQty , FPlanCommitDate ,FPlanFinishDate ,SerialNumber ,MatItemCode ,MatItemName ,MatItemSpec ,
            VendorCode ,VendorName ,DateCode ,Batch ,MPN ,LineName ,EquipmentCode ,EquipmentName ,SequenceNo ,LoadingListName ,Area,TableName ,Position , Point ,
            IsMain ,MainItemCode ,MainItemName ,SmtNum ,IsBindFeeder ,FeederSN ,FeederType ,BindPerson ,BindTime ,UnBindPerson ,UnBindTime ,LoadingPerson,
            LoadingTime , LoadingQty ,UnLoadingPerson ,UnLoadingTime ,UnLoadingQty ,UseQty , LastOperate";

            var resultList = ComMethod.GetComList<MaterialHistoryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            resultList = resultList.OrderBy(q => q.OrderNO).ThenBy(q => q.FBILLNO).ThenBy(q => q.EquipmentCode).ThenBy(q => q.Position).ToList();
            return resultList;
        }


        //删除GRN
        public void DeleteMaterialGRN(string planBillNo, string GRN,string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PlanBillNo", SqlDbType.VarChar,50),
                new SqlParameter("@DeleteGRN", SqlDbType.VarChar,50),
                new SqlParameter("@UserName", SqlDbType.VarChar,50)
            };
            parms[0].Value = planBillNo;
            parms[1].Value = GRN;
            parms[2].Value = UserName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteSMTMaterial", parms);

        }

        public string AreaScanNum(string orderNo, int equipmentId, string are)
        {
            string strsql1 = @"SELECT  CONVERT(NVARCHAR(50), COUNT(*)) AS CurNum
            FROM    Prod_MachineTableSlotMuMap
				WITH (NOLOCK) --20211227 Yang
            WHERE   PlanBillNo = '"+ orderNo + "' AND Equipment ="+ equipmentId + " AND Area='"+ are + "'";
            var result = "";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, strsql1, null))
            {
                while (rdr.Read())
                {
                    result = rdr.GetString(0);
                }
                rdr.Close();
            }
            return result;
        }

        /// <summary>
        /// SMT上料核对验证GRN、料站
        /// </summary>
        /// <param name="FBillNo">排程工单号</param>
        /// <param name="EquipmentId">机台Id</param>
        /// <param name="Position">料站</param>
        /// <param name="GRN">条码</param>
        /// <param name="IsCheckGRN">0:验证料站，1：验证GRN</param>
        public LoadinglistInfo IPQCSMTCheck(string FBillNo, int EquipmentId, string Position, string GRN, int IsCheckGRN)
        {
            LoadinglistInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FBillNo", SqlDbType.NVarChar,50),
                new SqlParameter("@EquipmentId", SqlDbType.Int),
                new SqlParameter("@Position", SqlDbType.NVarChar,50),
                new SqlParameter("@GRN", SqlDbType.NVarChar,50),
                new SqlParameter("@IsCheckGRN",  SqlDbType.Int)
            };
            parms[0].Value = FBillNo;
            parms[1].Value = EquipmentId;
            parms[2].Value = Position;
            parms[3].Value = GRN;
            parms[4].Value = IsCheckGRN;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspIPQCSMTCheck", parms))
            {
                while (rdr.Read())
                {
                    entity = new LoadinglistInfo();
                    entity.TableSlotSN = rdr["Position"].ToString();
                    entity.GrnStr = rdr["SerialNumber"].ToString();
                    entity.FeedStr = rdr["FeederSN"].ToString();
                    entity.EquipmentLineDisplayName = rdr["EquipmentName"].ToString();
                    entity.BalanceQty = Convert.ToDecimal(rdr["BalanceQty"]);
                    entity.Area = rdr["Area"].ToString();
                }
                rdr.Close();
            }
            return entity;
        }

    }

}