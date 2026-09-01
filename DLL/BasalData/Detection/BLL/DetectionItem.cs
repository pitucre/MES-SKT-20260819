using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Detection.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Detection.BLL
{
    public class DetectionItem
    {
        private int recordCount;

        public Int32 Edit(DetectionItemInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@DetectionItemId", SqlDbType.Int),
                new SqlParameter("@DetectionCode", SqlDbType.VarChar),
                new SqlParameter("@DetectionName", SqlDbType.VarChar),
                new SqlParameter("@DetectionDesc", SqlDbType.VarChar),
                new SqlParameter("@Versions", SqlDbType.VarChar),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@SL", SqlDbType.Decimal),
                new SqlParameter("@USL", SqlDbType.Decimal),
                new SqlParameter("@LSL", SqlDbType.Decimal),
                new SqlParameter("@CL", SqlDbType.Decimal),
                new SqlParameter("@UCL", SqlDbType.Decimal),
                new SqlParameter("@LCL", SqlDbType.Decimal),
                new SqlParameter("@CreateBy", SqlDbType.VarChar),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar),
            };

            parms[0].Value = entity.DetectionItemId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.DetectionCode;
            parms[2].Value = entity.DetectionName;
            parms[3].Value = entity.DetectionDesc;
            parms[4].Value = entity.Versions;
            parms[5].Value = entity.StationId;
            parms[6].Value = entity.SL;
            parms[7].Value = entity.USL;
            parms[8].Value = entity.LSL;
            parms[9].Value = entity.CL;
            parms[10].Value = entity.UCL;
            parms[11].Value = entity.LCL;
            parms[12].Value = entity.CreateBy;
            parms[13].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_DetectionItem_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 DetectionItemId 字符串删除 DetectionItem 信息。
        /// </summary>
        /// <param name="idString">DetectionItemId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_DetectionItem_Delete", parms);
        }


        public DetectionItemInfo GetInfo(Int32 detectionItemId)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<DetectionItemInfo>(detectionItemId, "Prod_DetectionItem_GetInfo");
        }

        /// <summary>
        /// 分页获取   资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eSOPMacCount">eSOPMac 总数。</param>
        /// <returns>ESOPMac 列表。</returns>
        public List<DetectionItemInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DetectionItemInfo> list = new List<DetectionItemInfo>();
            //表名或者视图
            string strTb = "vwGetDetectionItemInfo";
            //主键
            string strKey = "DetectionItemId";
            //查询栏位字串
            string strColumns = @" DetectionItemId ,
                                   DetectionCode ,
                                   DetectionName ,
                                   DetectionDesc ,
                                   Versions ,
                                   StationId ,
                                   SL ,
                                   USL ,
                                   LSL ,
                                   CL ,
                                   UCL ,
                                   LCL ,
                                   CreateBy ,
                                   CreateTime ,
                                   ModifyBy ,
                                   ModifyTime,Station";

            return ComMethod.GetComList<DetectionItemInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
