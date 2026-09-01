using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Quality.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class SealedSample
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SealedSample 信息。
        /// </summary>
        /// <param name="entity">SealedSample 实体对象。</param>
        public Int32 Edit(SealedSampleInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SampleId", SqlDbType.Int),
                new SqlParameter("@SampleCode", SqlDbType.VarChar, 50),
                new SqlParameter("@LotCode", SqlDbType.VarChar, 50),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@SampleType", SqlDbType.VarChar, 50),
                new SqlParameter("@SampleQty", SqlDbType.Int),
                new SqlParameter("@SupplierId", SqlDbType.Int),
                new SqlParameter("@SampleStatusId", SqlDbType.Int),
                new SqlParameter("@SampleTime", SqlDbType.DateTime),
                new SqlParameter("@EffectiveTime", SqlDbType.DateTime),
                new SqlParameter("@SaveTime", SqlDbType.DateTime),
                new SqlParameter("@SamplePicture", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.SampleId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.SampleCode;
            parms[2].Value = entity.LotCode;
            parms[3].Value = entity.ItemId;
            parms[4].Value = entity.SampleType;
            parms[5].Value = entity.SampleQty;
            parms[6].Value = entity.SupplierId;
            parms[7].Value = entity.SampleStatusId;
            parms[8].Value = entity.SampleTime;
            parms[9].Value = entity.EffectiveTime;
            parms[10].Value = entity.SaveTime;
            parms[11].Value = entity.SamplePicture;
            parms[12].Value = entity.CreateBy;
            parms[13].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_SealedSample_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SealedSampleId 字符串删除 SealedSample 信息。
        /// </summary>
        /// <param name="idString">SealedSampleId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_SealedSample_Delete", parms);
        }

        /// <summary>
        /// 根据 SealedSampleId 获取实体信息。
        /// </summary>
        /// <param name="sealedSampleId">SealedSampleId。</param>
        /// <returns>SealedSample 实体对象。</returns>
        public SealedSampleInfo GetInfo(Int32 sealedSampleId)
        {
            SealedSampleInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = sealedSampleId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_SealedSample_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SealedSampleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetDateTime(8), rdr.GetDateTime(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14),
                        rdr.GetDateTime(15));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SealedSample 实体对象。</returns>
        public SealedSampleInfo GetInfo(String fieldValue)
        {
            SealedSampleInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_SealedSample_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SealedSampleInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetInt32(7), rdr.GetDateTime(8), rdr.GetDateTime(9),
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14),
                        rdr.GetDateTime(15));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SealedSample 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="sealedSampleCount">sealedSample 总数。</param>
        /// <returns>SealedSample 列表。</returns>
        public List<SealedSampleInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SealedSampleInfo> list = new List<SealedSampleInfo>();
            SealedSampleInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Quality_SealedSample a LEFT JOIN dbo.Basal_Item b ON a.ItemId=b.ItemID LEFT JOIN dbo.Basal_Supplier c ON a.SupplierId=c.SupplierId INNER JOIN Quality_SealedSampleStatus d ON a.SampleStatusId=d.SampleStatusId ", "SampleId",
                "[SampleId],[SampleCode],b.ItemCode,a.[SampleType],b.ItemName,[SampleQty],c.VendorName,d.[Status],[SampleTime], [EffectiveTime], [SaveTime], [SamplePicture]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SealedSampleInfo();
                    entity.SampleId = rdr.GetInt32(0);
                    entity.SampleCode = rdr.GetString(1);
                    entity.ItemCode = rdr.GetString(2);
                    entity.SampleType = rdr.GetString(3);
                    entity.ItemName = rdr.GetString(4);
                    entity.SampleQty = rdr.GetInt32(5);
                    entity.VendorName = rdr.GetString(6);
                    entity.Status = rdr.GetString(7);
                    entity.SampleTime = rdr.GetDateTime(8);
                    entity.EffectiveTime = rdr.GetDateTime(9);
                    entity.SaveTime = rdr.GetDateTime(10);
                    entity.SamplePicture = rdr.GetString(11);
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

    }
}
