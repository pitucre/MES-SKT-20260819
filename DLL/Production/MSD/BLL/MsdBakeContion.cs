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
   public class MsdBakeContion
    {


        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取烘烤条件信息。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mslCount">msl 总数。</param>
        /// <returns>Msl 列表。</returns>
        public List<MsdBakeContionInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MsdBakeContionInfo> list = new List<MsdBakeContionInfo>();
            //表名或者视图
            string strTb = "vwMsd_BakeContion";////Msd_BakeContion
            //主键
            string strKey = "Bid";
            //查询栏位字串
            string strColumns = @"[Bid], [MSL], [HoursNum], [Temperature],[TemperatureTwo], [Remark], [AddTime], [ModifyDateTime], [CreateBy],[HoursNum2], [OverrunExposureTime],ModifyBy";

            return ComMethod.GetComList<MsdBakeContionInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 编辑（添加或更新） MsdMetriel 信息。
        /// </summary>
        /// <param name="entity">MsdMetriel 实体对象。</param>
        public Int32 Edit(MsdBakeContionInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                
                new SqlParameter("@Bid", SqlDbType.Int),
                new SqlParameter("@MSL", SqlDbType.VarChar,30),
                new SqlParameter("@HoursNum", SqlDbType.VarChar,100),
                new SqlParameter("@Temperature", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.VarChar,30),
                new SqlParameter("@TemperatureTwo", SqlDbType.Int),
                 //2018-06-05 by zhili 增加字段
                new SqlParameter("@HoursNum2", SqlDbType.Int),
                new SqlParameter("@OverrunExposureTime", SqlDbType.VarChar,100),
            };

            parms[0].Value = entity.Bid;
            parms[1].Value = entity.Msl;
            parms[2].Value = entity.HoursNum;
            parms[3].Value = entity.Temperature;
            parms[4].Value = entity.Remark;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.TemperatureTwo;
            //2018-06-05 by zhili 增加字段
            parms[7].Value = entity.HoursNum2;
            parms[8].Value = entity.OverrunExposureTime;

            return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Msd_proc_BakeContionEdit", parms);

        }

        /// <summary>
        /// 删除 MsdMetriel 信息。
        /// </summary>
        /// <param name="entity">MsdMetriel 实体对象。</param>
        public Int32 Delele(int itemId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int)

            };

            parms[0].Value = itemId;

            return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Msd_MsdMeteriel_Delete", parms);

        }


        /// <summary>
        /// 根据 bid 获取实体信息。
        /// </summary>
        /// <param name="bid">bid。</param>
        /// <returns>MsdContainer 实体对象。</returns>
        public MsdBakeContionInfo GetInfo(Int32 bid)
        {
            return ComMethod.GetInfo<MsdBakeContionInfo>(bid, "Msd_Proc_GetBakeContionInfo");
        }

        /// <summary>
        /// 获取 MsdMetriel 信息。
        /// </summary>
        /// <param name="fieldValue">MsdMetriel 实体对象。</param>
        public MsdBakeContionInfo GetInfo(string fieldValue)
        {

            return ComMethod.GetInfo<MsdBakeContionInfo>(fieldValue, "Msd_Proc_GetBakeContionInfo");
            //MsdBakeContionInfo entity = new MsdBakeContionInfo();

            //SqlParameter[] parms = new SqlParameter[]{

            //    new SqlParameter("@Bid", SqlDbType.Int,4)
            //};
            //parms[0].Value = bid;

            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Item_GetInfo", parms))
            //{
            //    if (rdr.Read())
            //    {
            //        entity.Bid = Convert.ToInt32(rdr["Bid"]);
            //        entity.Msl = Convert.ToString(rdr["MSL"]);
            //        entity.HoursNum = Convert.ToInt32(rdr["HoursNum"]);
            //        entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
            //        entity.Remark = Convert.ToString(rdr["Remark"]);
            //        entity.Temperature = Convert.ToInt32(rdr["Temperature"]);

            //    }
            //    rdr.Close();
            //}
            //return entity;
        }


        /// <summary>
        /// 根据 Bid 字符串删除 MsdContion 信息。
        /// </summary>
        /// <param name="idString">Bid 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Msd_Prod_Contion_Delete", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
