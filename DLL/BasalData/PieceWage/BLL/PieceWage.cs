using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.PieceWage.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
 
namespace SKT.LeanMES.PieceWage.BLL
{
    public class PieceWage
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） PieceWage 信息。
        /// </summary>
        /// <param name="entity">PieceWage 实体对象。</param>
        public Int32 Edit(int pieceWageId, int txtStationId, int txtEquipmentId, int txtItemId, Decimal txtPrice, string Remark, string CreateBy, string ModifyBy, string NO)
        { 
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PieceWageId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@EquipmentId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@Price", SqlDbType.Decimal),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 100),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 100),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500),
                new SqlParameter("@NO", SqlDbType.NVarChar, 100)
            };

            parms[0].Value = pieceWageId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = txtStationId;
            parms[2].Value = txtEquipmentId;
            parms[3].Value = txtItemId;
            parms[4].Value = txtPrice;
            parms[5].Value = CreateBy;
            parms[6].Value = ModifyBy;
            parms[7].Value = Remark;
            parms[8].Value = NO;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_PieceWage_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PieceWageId 字符串删除 PieceWage 信息。
        /// </summary>
        /// <param name="idString">PieceWageId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_PieceWage_Delete", parms);
        }

        /// <summary>
        /// 根据 PieceWageId 获取实体信息。
        /// </summary>
        /// <param name="pieceWageId">PieceWageId。</param>
        /// <returns>PieceWage 实体对象。</returns>
        public PieceWageInfo GetInfo(Int32 pieceWageId)
        {
            PieceWageInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = pieceWageId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_PieceWage_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PieceWageInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(3), rdr.GetInt32(5), rdr.GetDecimal(7),
                        rdr.GetDateTime(8), rdr.GetString(9), rdr.GetDateTime(10), rdr.GetString(11), rdr.GetString(12));
                    entity.Station = Convert.ToString(rdr[2]);
                    entity.EquipmentCode = Convert.ToString(rdr[4]);
                    entity.ItemCode = Convert.ToString(rdr[6]);
                    entity.NO = Convert.ToString(rdr[13]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PieceWage 实体对象。</returns>
        public PieceWageInfo GetInfo(String fieldValue)
        {
            PieceWageInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_PieceWage_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new PieceWageInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetDecimal(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 PieceWage 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="pieceWageCount">pieceWage 总数。</param>
        /// <returns>PieceWage 列表。</returns>
        public List<PieceWageInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PieceWageInfo> list = new List<PieceWageInfo>();
            PieceWageInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwPieceWage", "PieceWageId",
                "[PieceWageId], [StationId],Station, [EquipmentId],EquipmentCode, [ItemId],ItemCode, [Price], [CreateDateTime], [CreateBy], [ModifyDateTime], [ModifyBy], [Remark],NO", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PieceWageInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(3), rdr.GetInt32(5), rdr.GetDecimal(7), 
                        rdr.GetDateTime(8), rdr.GetString(9), rdr.GetDateTime(10), rdr.GetString(11), rdr.GetString(12));
                    entity.Station = Convert.ToString(rdr[2]);
                    entity.EquipmentCode = Convert.ToString(rdr[4]);
                    entity.ItemCode = Convert.ToString(rdr[6]);
                    entity.NO = Convert.ToString(rdr[13]);
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
        /// Wesely 2017-07-31: 保存补件数据
        /// </summary>
        /// <param name="Date"></param>
        /// <param name="Wages"></param>
        /// <param name="Remark"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public int UspSavePatch(string Date, string Wages, string Remark, int userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Date", SqlDbType.DateTime),
                new SqlParameter("@Wages", SqlDbType.Decimal),
                new SqlParameter("@Remark", SqlDbType.VarChar,500),
                new SqlParameter("@userId", SqlDbType.Int)       
            };
            parms[0].Value = Convert.ToDateTime(Date);
            parms[1].Value = Wages;
            parms[2].Value = Remark;
            parms[3].Value = userId;
            int num = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "UspSavePatch", parms);
            return num;
        }
    }
}