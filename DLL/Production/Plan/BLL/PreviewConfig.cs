using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Plan.Model;

namespace SKT.LeanMES.Plan.BLL
{
    public class PreviewConfig
    {
     
        /// <summary>
        /// 编辑（添加或更新） PreviewConfig 信息。
        /// </summary>
        /// <param name="entity">PreviewConfig 实体对象。</param>
        public Int32 Edit(PreviewConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PreviewDay", SqlDbType.Int),
                new SqlParameter("@IsLine", SqlDbType.Bit),
                new SqlParameter("@IsCheckLoad", SqlDbType.Bit),
                new SqlParameter("@PlanTime", SqlDbType.VarChar),
                new SqlParameter("@IsEnable", SqlDbType.Bit),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 300),
            };

            parms[0].Value = entity.PreviewDay;
            parms[1].Value = entity.IsLine;
            parms[2].Value = entity.IsCheckLoad;
            parms[3].Value = entity.PlanTime;
            parms[4].Value = entity.IsEnable;
            parms[5].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPreviewConfigEdit", parms);

            return (Int32)parms[0].Value;
        }




        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <returns>PreviewConfigInfo 实体对象。</returns>
        public PreviewConfigInfo GetInfo()
        {
            PreviewConfigInfo entity = null;
           
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPreviewConfig", null))
            {
                if (rdr.Read())
                {
                    entity = new PreviewConfigInfo();
                    entity.IsEnable = Convert.ToInt32(rdr["IsEnable"]);
                    entity.IsLine = Convert.ToInt32(rdr["IsLine"]);
                    entity.IsCheckLoad = Convert.ToInt32(rdr["IsCheckLoad"]);
                    entity.PlanTime = Convert.ToString(rdr["PlanTime"]);
                    entity.PreviewDay = Convert.ToInt32(rdr["PreviewDay"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
            
                }
                rdr.Close();
            }

            return entity;
        }



    }
}