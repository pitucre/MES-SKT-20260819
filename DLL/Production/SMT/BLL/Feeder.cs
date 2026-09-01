
using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SMT.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SMT.BLL
{
    public class Feeder
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） FEEDER 信息。
        /// </summary>
        /// <param name="entity">FEEDER 实体对象。</param>
        public Int32 Edit(FeederInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@SerialNumber", SqlDbType.VarChar, 50),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@FeederTypeID", SqlDbType.Int),
                new SqlParameter("@UserID", SqlDbType.Int),
                new SqlParameter("@StatusID", SqlDbType.Int),
                new SqlParameter("@MachineModelID", SqlDbType.Int),
                new SqlParameter("@MaxUseDuration", SqlDbType.Int),
                new SqlParameter("@MaxUnuseDuration", SqlDbType.Int),
                new SqlParameter("@MaxPickUp", SqlDbType.Int),
                new SqlParameter("@MaxPickUpErr", SqlDbType.Int),
                new SqlParameter("@PickUpErrRatio", SqlDbType.Int),
                new SqlParameter("@FeederCategoryID", SqlDbType.Int)
            };

            parms[0].Value = entity.ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.SerialNumber;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.FeederTypeID;
            parms[4].Value = entity.UserID;
            parms[5].Value = entity.StatusID;
            parms[6].Value = entity.MachineModelID;
            parms[7].Value = entity.MaxUseDuration;
            parms[8].Value = entity.MaxUnuseDuration;
            parms[9].Value = entity.MaxPickUp;
            parms[10].Value = entity.MaxPickUpErr;
            parms[11].Value = entity.PickUpErrRatio;
            parms[12].Value = entity.FeederCategoryID;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Feeder_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 FEEDERId 字符串删除 FEEDER 信息。
        /// </summary>
        /// <param name="idString">FEEDERId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Feeder_Delete", parms);
        }

        /// <summary>
        /// 根据 FEEDERId 获取实体信息。
        /// </summary>
        /// <param name="fEEDERId">FEEDERId。</param>
        /// <returns>FEEDER 实体对象。</returns>
        public FeederInfo GetInfo(Int32 fEEDERId)
        {
            FeederInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fEEDERId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Feeder_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FeederInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetDateTime(7), rdr.GetDateTime(8), rdr.GetInt32(9),
                        rdr.GetInt32(10), rdr.GetInt32(11), rdr.GetDateTime(12), rdr.GetDateTime(13), rdr.GetInt32(14),
                        rdr.GetInt32(15), rdr.GetInt32(16), rdr.GetInt32(17), rdr.GetInt32(18), rdr.GetInt32(19),
                        rdr.GetInt32(20), rdr.GetInt32(21), rdr.GetInt32(22));
                    entity.ModelName = rdr.GetString(23);
                    entity.User = rdr.GetString(24);
                    entity.FeederType = rdr.GetString(25);
                    entity.FeederCategory = rdr.GetString(26);
                    entity.Status = rdr.GetString(27);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>FEEDER 实体对象。</returns>
        public FeederInfo GetInfo(String fieldValue)
        {
            FeederInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Feeder_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new FeederInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4),
                       rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetDateTime(7), rdr.GetDateTime(8), rdr.GetInt32(9),
                       rdr.GetInt32(10), rdr.GetInt32(11), rdr.GetDateTime(12), rdr.GetDateTime(13), rdr.GetInt32(14),
                       rdr.GetInt32(15), rdr.GetInt32(16), rdr.GetInt32(17), rdr.GetInt32(18), rdr.GetInt32(19),
                       rdr.GetInt32(20), rdr.GetInt32(21), rdr.GetInt32(22));
                    entity.ModelName = rdr.GetString(23);
                    entity.User = rdr.GetString(24);
                    entity.FeederType = rdr.GetString(25);
                    entity.FeederCategory = rdr.GetString(26);
                    entity.Status = rdr.GetString(27);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 FEEDER 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="fEEDERCount">fEEDER 总数。</param>
        /// <returns>FEEDER 列表。</returns>
        public List<FeederInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FeederInfo> list = new List<FeederInfo>();
            FeederInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwFeederList", "ID",
                "ID, SerialNumber, Description, FeederTypeID, PickUp, AccumulatedErrPickUp, AccumulatedPickUp, StartUseTime, LastUnuseTime, MaxReel, StationID, UserID, CreationTime, LastUpdate, StatusID, MachineModelID, MaxUseDuration, MaxUnuseDuration, MaxPickUp, MaxPickUpErr, PickUpErrRatio, FeederCategoryID, NeedMaintenance, ModelName, UserName, FeederTypeName, FeederCategory, Status,ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new FeederInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetDateTime(7), rdr.GetDateTime(8), rdr.GetInt32(9),
                        rdr.GetInt32(10), rdr.GetInt32(11), rdr.GetDateTime(12), rdr.GetDateTime(13), rdr.GetInt32(14),
                        rdr.GetInt32(15), rdr.GetInt32(16), rdr.GetInt32(17), rdr.GetInt32(18), rdr.GetInt32(19),
                        rdr.GetInt32(20), rdr.GetInt32(21), rdr.GetInt32(22));

                    entity.ModelName = rdr.GetString(23);
                    entity.User = rdr.GetValue(24).ToString();
                    entity.FeederType = rdr.GetString(25);
                    entity.FeederCategory = rdr.GetString(26);
                    entity.Status = rdr.GetString(27);

                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime")))
                    {
                        entity.ModifyBy = rdr.GetString(28);
                        entity.ModifyTime = rdr.GetDateTime(29);
                    }

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 飞达绑定grn 20175/31/14:57 zhuchenglong
        /// </summary>
        /// <param name="feeder"></param>
        /// <param name="materialid"></param>
        /// <param name="username"></param>
        public void FeederBindMaterial(string feeder, string materialid, string username)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@feeder",SqlDbType.VarChar),
            new SqlParameter("@materialid", SqlDbType.VarChar),
            new SqlParameter("@username", SqlDbType.VarChar)
        };
            param[0].Value = feeder;
            param[1].Value = materialid;
            param[2].Value = username;
            CommonHelper.BLL.ComMethod.Edit("Prod_FeedAndMaterial_Edit", param);
        }
        /// <summary>
        /// 飞达换绑
        /// </summary>
        /// <param name="feeder"></param>
        /// <param name="newfeeder"></param>
        /// <param name="username"></param>
        public void ChangeBindSave(string feeder, string newfeeder, string username, int bindType)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@feeder",SqlDbType.VarChar),
            new SqlParameter("@newfeeder", SqlDbType.VarChar),
            new SqlParameter("@username", SqlDbType.VarChar),
            new SqlParameter("@BindType", SqlDbType.Int)

        };
            param[0].Value = feeder;
            param[1].Value = newfeeder;
            param[2].Value = username;
            param[3].Value = bindType;
            CommonHelper.BLL.ComMethod.Edit("Prod_FeedChangeBind", param);

        }
        /// <summary>
        /// 查询飞达替换日志
        /// </summary>
        /// <param name="feeder"></param>
        /// <returns></returns>
        public List<FeederChangeLog> GetFeederLog(string feeder)
        {
            string strsql = @"select OldFeeder,NewFeeder,AddDate from FeederChangeLog where OldFeeder='" + feeder + "'";
            List<FeederChangeLog> list = CommonHelper.BLL.ComMethod.GetListBySql<FeederChangeLog>(strsql, null);
            return list;
        }
        /// <summary>
        /// 飞达是否使用
        /// </summary>
        /// <param name="feeder"></param>
        public void IsFeederToUse(string feeder)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@feeder",SqlDbType.VarChar)

        };
            param[0].Value = feeder;

            CommonHelper.BLL.ComMethod.Edit("Prod_IsFeederToUse", param);
        }
        /// <summary>
        /// 查询飞达、GRN绑定关系(离线绑定)
        /// </summary>
        /// <param name="orderNo"></param>
        /// <returns></returns>
        public List<LoadinglistInfo> GetFeederAndMaterial()
        {
            //string strsql = @"SELECT t1.OrderNO,t4.TableSlotSN,ISNULL(t3.SerialNumber,'') AS FeedStr,ISNULL(t2.SerialNumber,'') AS GrnStr
            //                    FROM dbo.Prod_MachineTableSlotMuMap t
            //                    JOIN dbo.Prod_Order t1 ON t1.ProdOrderID=t.ProdOrderId
            //                    LEFT JOIN dbo.Prod_MaterialUnit t2 ON t2.MaterialUnitId=t.MaterialUnitID
            //                    LEFT JOIN dbo.Basal_Feeder t3 ON t3.ID=t.FeederID 
            //                    LEFT JOIN [Prod_MachineTableSlot] t4 ON t4.TableSlotID=t.MachineTableSlotID
            //                    WHERE  OrderNO='" + orderNo + "'  ORDER BY MachineTableSlotID";

            //string strsql = "SELECT FeedId AS FeedStr,MaterialIdCode AS GrnStr FROM dbo.Prod_FeedAndMaterial";
            string strsql = @"SELECT FeedId AS FeedStr,MaterialIdCode AS GrnStr,t2.ItemCode,
(case when (select count(1) from  Prod_MachineTableSlotMuMap a where a.FeederSN=t.FeedId)>0 then '已使用' else  '未使用' end) as States 
                                FROM dbo.Prod_FeedAndMaterial t 
                                JOIN dbo.Prod_MaterialUnit t1 ON t1.SerialNumber=t.MaterialIdCode
                                JOIN dbo.Basal_Item t2 ON t2.ItemID=t1.PartId";
            List<LoadinglistInfo> list = CommonHelper.BLL.ComMethod.GetListBySql<LoadinglistInfo>(strsql, null);
            return list;
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
    public class FeederChangeLog
    {
        public string OldFeeder { get; set; }
        public string NewFeeder { get; set; }
        public DateTime AddDate { get; set; }

    }
}