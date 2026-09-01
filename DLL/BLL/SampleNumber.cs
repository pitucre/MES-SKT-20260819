using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.Common.Model;
using SKT.LeanMES.SampleNumberManagement.Model;

namespace SKT.LeanMES.SampleNumberManagement.BLL
{
    public class SampleNumber
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 根据物料编码获取样品数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<SampleNumberMainSubInfo> GetInfo(SampleNumberMainSubInfo entity)
        {
            string sql = @"SELECT 
                                SampleNumberMainId,SampleNumber,SampleName,Remark,CreateBy,CreateTime,ModifyTime,ModifyBy,ItemID,ItemCode,ItemName,ItemSpec,SubId,StationId,ExpirationDate,NextExpirationDate,PrototypeAttr,PrototypeAttrName,NcCodes,ScrapFlag,Station,ScrapFlagName
                            FROM vwBasal_SampleNumber 
                            WHERE ItemCode = @ItemCode";
            SqlParameter[] parms = new SqlParameter[]
             {
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50) { Value = entity.ItemCode }
             };
            return ComMethod.GetListBySql<SampleNumberMainSubInfo>(sql, parms);
        }

        /// <summary>
        /// 分页获取 样品 列表数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SampleNumberMainSubInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string columns = "SampleNumberMainId,SampleNumber,SampleName,Remark,CreateBy,CreateTime,ModifyTime,ModifyBy,ItemID,ItemCode,ItemName,ItemSpec,SubId,StationId,ExpirationDate,NextExpirationDate,PrototypeAttr,PrototypeAttrName,NcCodes,ScrapFlag,Station,ScrapFlagName";
            return ComMethod.GetComList<SampleNumberMainSubInfo>(ref this.recordCount, startRow, maxRows, "vwBasal_SampleNumber", string.Empty, columns, sortExpression, searchSettings);
        }


        /// <summary>
        /// 样品序号列表—新增、编辑、导入
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="json"></param>
        /// <param name="flag">类型：1、新增 2：编辑 3：导入</param>
        public void SampleNumberEdit(SampleNumberMainSubInfo entity, string json, int flag)
        {
            DataTable dt = null;
            if (!string.IsNullOrEmpty(json))
            {
                dt = ComMethod.JsonToDataTable(json);
            }
            SqlParameter[] parms = new SqlParameter[]
             {
                new SqlParameter("@Id", SqlDbType.Int) { Value = entity.Id },
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 30) { Value = entity.ItemCode },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
                new SqlParameter("@SampleNumberDtl", SqlDbType.Structured) { Value = dt }
             };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveBasal_SampleNumber", parms);
        }


        /// <summary>
        /// 样品序号列表—删除
        /// </summary>
        /// <param name="entity"></param>
        public void SampleNumberDelete(string ids, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]
                        {
                new SqlParameter("@SubIds", SqlDbType.VarChar, 4000) { Value = ids },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = userName },
                        };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSampleNumberDelete", parms);
        }

        /// <summary>
        /// 样品序号列表—报废
        /// </summary>
        /// <param name="entity"></param>
        public void PrototypeScrap(SampleNumberMainSubInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
                        {
                new SqlParameter("@SampleNumber", SqlDbType.VarChar, -1) { Value = entity.SampleNumber },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
                        };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPrototypeScrap", parms);
        }

        /// <summary>
        /// 样品序号列表—重检
        /// </summary>
        /// <param name="entity"></param>
        public void PrototypeRecheck(SampleNumberMainSubInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
                        {
                new SqlParameter("@SampleNumber", SqlDbType.VarChar, 50) { Value = entity.SampleNumber },
                new SqlParameter("@NextExpirationDate", SqlDbType.DateTime) { Value = entity.NextExpirationDate },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
                        };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPrototypeRecheck", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
