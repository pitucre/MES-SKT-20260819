using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.MSD.Model;

namespace SKT.LeanMES.MSD.BLL
{
   public class MsdThermostat
    {


        private Int32 recordCount = 0;
        /// <summary>
        /// 分页获取MSD 物料信息资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>Item 列表。</returns>
        public List<MsdThermostatInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MsdThermostatInfo> list = new List<MsdThermostatInfo>();
            MsdThermostatInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwMsd_ThermostatInfo", "Tid",
                @"Tid ,
            SerialNumber ,
            ItemCode ,
            ItemName ,
            ItemSpec,
            ContainerCode ,
            ContainerName ,
            AddTime ,
            OutTime ,
            TotalThermostat ,
            CreateUser ,
            CreateTime ,
            ModifyDateTime ,
            ModefyUser ,
            Remark,Tstatus"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MsdThermostatInfo();
                    entity.Tid = Convert.ToInt32(rdr["Tid"]);
                    entity.ContainerCode = Convert.ToString(rdr["ContainerCode"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.ItemSpec = Convert.ToString(rdr["ItemSpec"]);
                    entity.ContainerName = Convert.ToString(rdr["ContainerName"]);
                    entity.SerialNumber = Convert.ToString(rdr["SerialNumber"]);
                    entity.Tstatus = Convert.ToString(rdr["Tstatus"]);
                    
                    entity.AddTime = Convert.ToDateTime(rdr["AddTime"]);
                    entity.OutTime = Convert.ToDateTime(rdr["OutTime"]);
                    entity.TotalThermostat = Convert.ToDecimal(rdr["TotalThermostat"]);
                    entity.CreateUser = Convert.ToString(rdr["CreateUser"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModefyUser"]);
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
