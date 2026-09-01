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
    public class MsdBake
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
        public List<MsdBakeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MsdBakeInfo> list = new List<MsdBakeInfo>();
            MsdBakeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwMsd_BakeInfo", "Gid",
                @"Gid,SerialNumber ,ItemCode,ItemName,ItemSpec,
            ContainerCode,
			ContainerName,
            ScanTime ,
            StartBakeTime ,
            PredictBakeTime ,
            BakeHours ,
            ActualHours ,
            EndBakeTime ,
            CreateUser,BakeStauts,CreateTime,ModifyDateTime,Remark,MinTemp,MaxTemp,Temperature,MSL,MachineType"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MsdBakeInfo();
                    entity.Gid = Convert.ToInt32(rdr["Gid"]);
                    entity.ContainerCode = Convert.ToString(rdr["ContainerCode"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.ItemSpec = Convert.ToString(rdr["ItemSpec"]);
                    entity.ContainerName = Convert.ToString(rdr["ContainerName"]);
                    entity.SerialNumber = Convert.ToString(rdr["SerialNumber"]);
                    entity.ScanTime = Convert.ToDateTime(rdr["ScanTime"]);
                    entity.StartBakeTime = Convert.ToDateTime(rdr["StartBakeTime"]);
                    entity.PredictBakeTime = Convert.ToDateTime(rdr["PredictBakeTime"]);
                    entity.BakeHours = Convert.ToDecimal(rdr["BakeHours"]);
                    entity.ActualHours = Convert.ToDecimal(rdr["ActualHours"]);
                    entity.EndBakeTime = Convert.ToDateTime(rdr["EndBakeTime"]);
                    entity.CreateUser = Convert.ToString(rdr["CreateUser"]);
                    entity.BakeStauts = Convert.ToString(rdr["BakeStauts"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.MinTemp = Convert.ToInt32(rdr["MinTemp"]);
                    entity.MaxTemp = Convert.ToInt32(rdr["MaxTemp"]);
                    entity.Temperature = Convert.ToInt32(rdr["Temperature"]);
                    entity.Msl = Convert.ToString(rdr["MSL"]);
                    entity.MachineType = Convert.ToString(rdr["MachineType"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }



        /// <summary>
        /// 根据 Grn和温度获取烘烤时长
        /// </summary>
        /// <param name="temperature">MaterialBurnId。</param>
        /// <returns> 实体对象。</returns>
        public MsdItemBakeInfo GetInfoItemBake(int temperature, string serialNumber)
        {
            MsdItemBakeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Temperature", SqlDbType.Int, 4),
                new SqlParameter("@SerialNumber", SqlDbType.NVarChar,150)
            };

            parms[0].Value = temperature;
            parms[1].Value = serialNumber;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Msd_Proc_GetItemBakeHoursInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MsdItemBakeInfo();
                    entity.SerialNumber = Convert.ToString(rdr["SerialNumber"]);
                    //entity.HoursNum = Convert.ToDecimal(rdr["HoursNum"]);
                    entity.HoursNumStr = Convert.ToString(rdr["HoursNum"]);
                    entity.MSL = Convert.ToString(rdr["MSL"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.ScanTime = Convert.ToDateTime(rdr["ScanTime"]);
                    entity.BakeCount = Convert.ToInt32(rdr["BakeCount"]);
                    entity.AlreadyBakeCount = Convert.ToInt32(rdr["AlreadyBakeCount"]);

                }
                rdr.Close();
            }

            return entity;
        }







        /// <summary>
        /// 获取 MsdBake 信息。
        /// </summary>
        /// <param name="serialNumber"> 实体对象。</param>
        /// /// <param name="status"> 烘烤状态。</param>
        public MsdBakeInfo GetInfo(string serialNumber,int status)
        {


            MsdBakeInfo entity = new MsdBakeInfo();

            SqlParameter[] parms = new SqlParameter[]{

                new SqlParameter("@SerialNumber", SqlDbType.VarChar,150),
                new SqlParameter("@Status", SqlDbType.Int,4)
            };
            parms[0].Value = serialNumber;
            parms[1].Value = status;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Msd_Proc_GetBakeInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MsdBakeInfo();
                    entity.Gid = Convert.ToInt32(rdr["Gid"]);
                    entity.EncapStauts = Convert.ToInt32(rdr["EncapStauts"]);
                    entity.ContainerCode = Convert.ToString(rdr["ContainerCode"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.ContainerName = Convert.ToString(rdr["ContainerName"]);
                    entity.SerialNumber = Convert.ToString(rdr["SerialNumber"]);
                    entity.ScanTime = Convert.ToDateTime(rdr["ScanTime"]);
                    entity.StartBakeTime = Convert.ToDateTime(rdr["StartBakeTime"]);
                    entity.PredictBakeTime = Convert.ToDateTime(rdr["PredictBakeTime"]);
                    entity.BakeHours = Convert.ToDecimal(rdr["BakeHours"]);
                    entity.ActualHours = Convert.ToDecimal(rdr["ActualHours"]);
                    entity.EndBakeTime = Convert.ToDateTime(rdr["EndBakeTime"]);
                    entity.CreateUser = Convert.ToString(rdr["CreateUser"]);
                    entity.BakeStauts = Convert.ToString(rdr["BakeStauts"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);

                }
                rdr.Close();
            }
            return entity;
        }


        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
