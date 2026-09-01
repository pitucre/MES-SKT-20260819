using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Container.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Data.SqlClient;
using System.Data;

namespace SKT.LeanMES.Container.BLL
{
    public class ColorBoxPacking
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ColorBoxPacking 信息。
        /// </summary>
        /// <param name="entity">ColorBoxPacking 实体对象。</param>
        public Int32 Edit(ColorBoxPackingInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaterialUnitId", SqlDbType.BigInt),
                new SqlParameter("@PID", SqlDbType.Int),
                new SqlParameter("@CID", SqlDbType.Int),
                new SqlParameter("@SerialNumber", SqlDbType.VarChar, 50),
                new SqlParameter("@PartId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@CreationTime", SqlDbType.DateTime),
                new SqlParameter("@FinishTime", SqlDbType.DateTime),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@LastUpdate", SqlDbType.DateTime),
                new SqlParameter("@Status", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Flag", SqlDbType.Int),
                new SqlParameter("@PackDateTime", SqlDbType.DateTime)
            };

            parms[0].Value = entity.MaterialUnitId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.PID;
            parms[2].Value = entity.CID;
            parms[3].Value = entity.SerialNumber;
            parms[4].Value = entity.PartId;
            parms[5].Value = entity.StationId;
            parms[6].Value = entity.CreationTime;
            parms[7].Value = entity.FinishTime;
            parms[8].Value = entity.LineId;
            parms[9].Value = entity.LastUpdate;
            parms[10].Value = entity.Status;
            parms[11].Value = entity.CreateBy;
            parms[12].Value = entity.ModifyBy;
            parms[13].Value = entity.Flag;
            parms[14].Value = entity.PackDateTime;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ColorBoxPacking_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ColorBoxPackingId 字符串删除 ColorBoxPacking 信息。
        /// </summary>
        /// <param name="idString">ColorBoxPackingId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ColorBoxPacking_Delete", parms);
        }

        /// <summary>
        /// 根据 ColorBoxPackingId 获取实体信息。
        /// </summary>
        /// <param name="colorBoxPackingId">ColorBoxPackingId。</param>
        /// <returns>ColorBoxPacking 实体对象。</returns>
        public ColorBoxPackingInfo GetInfo(Int32 colorBoxPackingId)
        {
            ColorBoxPackingInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = colorBoxPackingId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ColorBoxPacking_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ColorBoxPackingInfo(rdr.GetInt64(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetInt32(8), rdr.GetDateTime(9),
                        rdr.GetInt32(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14),
                        rdr.GetInt32(15), rdr.GetDateTime(16));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ColorBoxPacking 实体对象。</returns>
        public ColorBoxPackingInfo GetInfo(String fieldValue)
        {
            ColorBoxPackingInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_ColorBoxPacking_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ColorBoxPackingInfo(rdr.GetInt64(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetInt32(8), rdr.GetDateTime(9),
                        rdr.GetInt32(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14),
                        rdr.GetInt32(15), rdr.GetDateTime(16));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ColorBoxPacking 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="colorBoxPackingCount">colorBoxPacking 总数。</param>
        /// <returns>ColorBoxPacking 列表。</returns>
        public List<ColorBoxPackingInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ColorBoxPackingInfo> list = new List<ColorBoxPackingInfo>();
            ColorBoxPackingInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Prod_ColorBoxPacking", "ColorBoxPackingId",
                "[MaterialUnitId], [PID], [CID], [SerialNumber], [PartId], [StationId], [CreationTime], [FinishTime], [LineId], [LastUpdate], [Status], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Flag], [PackDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ColorBoxPackingInfo(rdr.GetInt64(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetInt32(8), rdr.GetDateTime(9),
                        rdr.GetInt32(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetDateTime(14),
                        rdr.GetInt32(15), rdr.GetDateTime(16));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 执行彩盒包装存储过程返回包装信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="carTon"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<ColorBoxPackingInfo> GetColorPackingInfo(String grn, String carTon, String userName, Int32 itemId)
        {
            List<ColorBoxPackingInfo> list = new List<ColorBoxPackingInfo>();

            ColorBoxPackingInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@ItemId",SqlDbType.Int)
            };

            parms[0].Value = grn;
            parms[1].Value = carTon;
            parms[2].Value = userName;
            parms[3].Value = itemId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspColorPackMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new ColorBoxPackingInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.PackDataTimeStr = rdr.GetDateTime(2).ToString();
                    entity.CartonSn = rdr.GetString(3);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        ///  关闭和打开包装箱
        /// </summary>
        /// <param name="cartonSN"></param>
        /// <param name="userName"></param>
        /// <param name="flag"></param>
        public void DoColoseOrOpenColorPack(String cartonSN, String userName,Int32 flag)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CartonSN", SqlDbType.VarChar, 50),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@Flag", SqlDbType.Int)
            };

            parms[0].Value = cartonSN;
            parms[1].Value = userName;
            parms[2].Value = flag;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspColoseOrOpenColorPack", parms);
        }
        /// <summary>
        /// 获取彩盒内已包装的物料列表
        /// </summary>
        /// <param name="cartonsn"></param>
        /// <returns></returns>
        public List<ColorBoxPackingInfo> GetPackedItemList(string cartonsn)
        {
            List<ColorBoxPackingInfo> list = new List<ColorBoxPackingInfo>();
            ColorBoxPackingInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50)
            };

            parms[0].Value = cartonsn;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPackedGRNByColorCartonSN", parms))
            {
                while (rdr.Read())
                {
                    entity = new ColorBoxPackingInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.MaterialUnitId = rdr.GetInt64(1);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 从彩盒包装箱内移除GRN
        /// </summary>
        /// <param name="cartonsn"></param>
        /// <param name="grnsn"></param>
        /// <param name="userName"></param>
        /// <param name="allUnitId"></param>
        public void RemoveGRN(string cartonsn, string grnsn, string userName, string allUnitId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@GRNSN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@AllUnitId",SqlDbType.VarChar,100)
            };

            parms[0].Value = cartonsn;
            parms[1].Value = grnsn;
            parms[2].Value = userName;
            parms[3].Value = allUnitId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRemoveGRNFromColorCarton", parms);
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
