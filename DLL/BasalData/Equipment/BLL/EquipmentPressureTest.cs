using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Equipment.Model; 
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentPressureTest
    {
        public void Edit(EquipmentPressureTestInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentPressureTestId", SqlDbType.Int),
                new SqlParameter("@EquipmentId", SqlDbType.Int),
                new SqlParameter("@EquipmentCode", SqlDbType.NVarChar),
                new SqlParameter("@EquipmentName", SqlDbType.NVarChar),
                new SqlParameter("@TestCycle", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.NVarChar),
            };

            parms[0].Value = entity.EquipmentPressureTestId;
            parms[1].Value = entity.EquipmentId;
            parms[2].Value = entity.EquipmentCode;
            parms[3].Value = entity.EquipmentName;
            parms[4].Value = entity.TestCycle;
            parms[5].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentPressureTestEdit", parms);
        }

        public void EditDtl(EquipmentPressureTestInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentPressureTestId", SqlDbType.Int),
                new SqlParameter("@Equation", SqlDbType.NVarChar),
                new SqlParameter("@Pressure", SqlDbType.NVarChar),
                new SqlParameter("@UserName", SqlDbType.NVarChar),
            };

            parms[0].Value = entity.EquipmentPressureTestId;
            parms[1].Value = entity.Equation;
            parms[2].Value = entity.Pressure;
            parms[3].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentPressureTestDtl", parms);
        }

        /// <summary>
        /// 获取机台测试信息
        /// </summary>
        /// <param name="equipmentPressureTestId"></param>
        /// <returns></returns>
        public EquipmentPressureTestInfo GetInfo(Int32 equipmentPressureTestId)
        {
            string sql = @" SELECT * FROM vwEquipmentPressureTest where EquipmentPressureTestId = @EquipmentPressureTestId";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentPressureTestId", SqlDbType.Int),
            };

            parms[0].Value = equipmentPressureTestId;

            return ComMethod.GetBySql<EquipmentPressureTestInfo>(sql, parms);
        }

        /// <summary>
        /// 获取机台测试操作历史
        /// </summary>
        /// <param name="equipmentPressureTestId"></param>
        /// <returns></returns>
        public List<EquipmentPressureTestInfo> GetInfoDtl(Int32 equipmentPressureTestId)
        {
            string sql = @" SELECT EquipmentPressureTestDtlId ,
                           EquipmentPressureTestId ,
                           Equation ,
                           Pressure ,
                           Tester ,
                           CONVERT(VARCHAR(20),TestTime,120) AS TestTime 
                           FROM Basal_EquipmentPressureTestDtl where EquipmentPressureTestId = @EquipmentPressureTestId";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentPressureTestId", SqlDbType.Int),
            };

            parms[0].Value = equipmentPressureTestId;

            return ComMethod.GetListBySql<EquipmentPressureTestInfo>(sql, parms);
        }

        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentPressureTestDelete", parms);
        }

        /// <summary>
        /// 分页获取  资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="productAODApplyCount">productAODApply 总数。</param>
        /// <returns>ProductAODApply 列表。</returns>
        public List<EquipmentPressureTestInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwEquipmentPressureTest";
            //主键
            string strKey = "EquipmentPressureTestId";
            //查询栏位字串
            string strColumns = @"EquipmentPressureTestId ,
                                   EquipmentId ,
                                   EquipmentCode ,
                                   EquipmentName ,
                                   TestCycle ,
                                   Pressure ,
                                   Equation ,
                                   Tester ,
                                   TestTime ,     
                                   CreateBy ,
                                   CreateDateTime ,
                                   ModifyBy ,
	                               ModifyDateTime ,NextTestTime,TestStatus ";
            return ComMethod.GetComList<EquipmentPressureTestInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        private Int32 recordCount = 0;
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
