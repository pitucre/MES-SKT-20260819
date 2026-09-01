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
   public class MsdEncapsulation
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
        public List<MsdEncapsulationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MsdEncapsulationInfo> list = new List<MsdEncapsulationInfo>();
            MsdEncapsulationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwMsd_EncapsulationInfo", "Eid",
                @"Eid ,
            SerialNumber ,
            ItemCode ,
            ItemName ,
            ItemSpec,
            CreateTime ,
            StartExposeTime ,
            EncapStatus ,
            TotalExposeMinute ,
            FloorLife ,
            CreateUser ,
            ModefyUser ,
            Remark ,
            ModifyDateTime"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MsdEncapsulationInfo();
                    entity.Eid = Convert.ToInt32(rdr["Eid"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.ItemSpec = Convert.ToString(rdr["ItemSpec"]);
                    entity.SerialNumber = Convert.ToString(rdr["SerialNumber"]); 
                    entity.StartExposeTime = Convert.ToDateTime(rdr["StartExposeTime"]);
                    entity.FloorLife = Convert.ToInt32(rdr["FloorLife"]);
                    entity.TotalExposeMinute = Convert.ToDecimal(rdr["TotalExposeMinute"]);
                    entity.CreateUser = Convert.ToString(rdr["CreateUser"]);
                    entity.EncapStatus = Convert.ToString(rdr["EncapStatus"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ModifyDateTime = Convert.ToDateTime(rdr["ModifyDateTime"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        /// <summary>
        /// 获取封装物料信息。
        /// </summary>
        /// <param name="serialNumber"> 实体对象。</param>
        public MsdEncapInfo GetEncapInfo(string serialNumber)
        {
            MsdEncapInfo entity = new MsdEncapInfo();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber", SqlDbType.VarChar,150)
            };
            parms[0].Value = serialNumber;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Msd_Proc_GetEncapsulationSerInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MsdEncapInfo();               
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemSpec = Convert.ToString(rdr["ItemSpec"]);
                    entity.SerialNumber = Convert.ToString(rdr["SerialNumber"]);
                    entity.FloorLife = Convert.ToInt32(rdr["FloorLife"]);
                    entity.EncapStatus = Convert.ToString(rdr["EncapStatus"]);
                    entity.TotalExposeMinute = Convert.ToDecimal(rdr["TotalExposeMinute"]);
                    entity.Msl = Convert.ToString(rdr["Msl"]);
                    entity.BakeCount = Convert.ToInt32(rdr["BakeCount"]);
                    entity.RemainMinute = Convert.ToDecimal(rdr["RemainMinute"]);
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 封装物料
        /// </summary>
        /// <param name="serialNumber">物料编码</param>
        /// <param name="optUser">操作人</param>
        public Int32 Encapsulation(string optUser,string serialNumber)
        {
            SqlParameter[] parms = new SqlParameter[]{

                new SqlParameter("@CreateUser", SqlDbType.VarChar,30),
                new SqlParameter("@SerialNumber", SqlDbType.VarChar,130)

            };

            parms[0].Value =optUser;
            parms[1].Value = serialNumber;
           
            return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Msd_Proc_Encapsulation", parms);

        }


        /// <summary>
        /// 开封
        /// </summary>
        /// <param name="serialNumber">物料编码</param>
        /// <param name="optUser">操作人</param>
        public Int32 OpenSeal(string optUser, string serialNumber)
        {
            SqlParameter[] parms = new SqlParameter[]{

                new SqlParameter("@CreateUser", SqlDbType.VarChar,30),
                new SqlParameter("@SerialNumber", SqlDbType.VarChar,130)

            };

            parms[0].Value = optUser;
            parms[1].Value = serialNumber;

            return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Msd_Proc_OpenSeal", parms);

        }

        /// <summary>
        /// 分页获取MSD 物料信息资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>Item 列表。</returns>
        public List<MSDKanBanInfo> GetMSDList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MSDKanBanInfo> list = new List<MSDKanBanInfo>();
            //表名或者视图
            string strTb = "vw_MSDKanBan";
            //主键
            string strKey = "Oid";
            //查询栏位字串
            string strColumns = @"Oid, SerialNumber,ItemCode, ItemName, OperateDes, ContainerCode,OperateTime, TotalExposeMinute, BalanceExposeMinute, FloorLife";
            list = ComMethod.GetComList<MSDKanBanInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
