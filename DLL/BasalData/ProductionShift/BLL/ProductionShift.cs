using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.ProductionShift.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.ProductionShift.BLL
{
    public class ProductionShift
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SHIFT 信息。
        /// </summary>
        /// <param name="entity">SHIFT 实体对象。</param>
        public Int32 Edit(ProductionShiftInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ShiftId", SqlDbType.Int),
                new SqlParameter("@ShiftName", SqlDbType.NVarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.ShiftId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ShiftName;
            parms[2].Value = entity.Remark;
            parms[3].Value = entity.ModifyBy;
            parms[4].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ProductionShift_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PId 字符串删除 SHIFT 信息。
        /// </summary>
        /// <param name="idString">PId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ProductionShift_Delete", parms);
        }

        /// <summary>
        /// 根据 PId 获取实体信息。
        /// </summary>
        /// <param name="PId">PId。</param>
        /// <returns>SHIFT 实体对象。</returns>
        public ProductionShiftInfo GetInfo(Int32 PId)
        {
            ProductionShiftInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = PId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ProductionShift_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ProductionShiftInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SHIFT 实体对象。</returns>
        public ProductionShiftInfo GetInfo(String fieldValue)
        {
            ProductionShiftInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ProductionShift_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SHIFT 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="sHIFTCount">sHIFT 总数。</param>
        /// <returns>SHIFT 列表。</returns>
        public List<ProductionShiftInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ProductionShiftInfo> list = new List<ProductionShiftInfo>();
            ProductionShiftInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_Shift", "ShiftId",////Basal_Shift
                "[ShiftId], [ShiftName], [Remark], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ProductionShiftInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        public List<Shift_MemberInfo> Get24All(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<Shift_MemberInfo> list = new List<Shift_MemberInfo>();
            //表名或者视图
            string strTb = "vw_ShiftMember";//"Prod_Apply";
                                            //主键
            string strKey = "MemberId";//"ApplyId";
                                       //查询栏位字串         
            string strColumns = @"[MemberId], ProductionShift";
            list = ComMethod.GetComList<Shift_MemberInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}