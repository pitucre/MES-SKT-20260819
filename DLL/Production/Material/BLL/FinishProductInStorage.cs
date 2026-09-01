using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.Material.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Material.BLL
{
   public class FinishProductInStorage
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 模块入库。
        /// </summary>
        /// <param name="entity"> 实体对象。</param>
        public string Edit(FinishProductInStorageInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter ("@SN",SqlDbType.NVarChar,50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar,20),
                new  SqlParameter("@Msg",SqlDbType.VarChar,50)
              };

            parms[0].Value = entity.SN;
            parms[1].Value = entity.CreateBy;
            parms[2].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_FinishProductInStorage_Edit", parms);
            return parms[2].Value.ToString();

        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="idString">EsopFileId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_FinishProductInStorage_Delete", parms);
        }


        /// <summary>
        /// 分页获取 Item 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemCount">item 总数。</param>
        /// <returns>Item 列表。</returns>
        public List<FinishProductInStorageInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            try
            {
                List<FinishProductInStorageInfo> list = new List<FinishProductInStorageInfo>();
                FinishProductInStorageInfo entity = null;

                SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, " [Prod_FinishProductInStorage]  A inner join [Prod_SerialNumber]  B on A.UID =B.UID AND B.SNTypeID = 0 ", "Id",
                    " A.Id,A.UID,(case A.status when 1 then N'在库' when 2 then N'出库' when 3 then N'返工' end) as status_cn,A.CreateBy,A.CreateDateTime,B.value ", searchSettings, sortExpression);

                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
                {
                    while (rdr.Read())
                    {
                        entity = new FinishProductInStorageInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetString(5));
                        list.Add(entity);

                    }
                    rdr.Close();
                }

                recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);    
                return list;
            }catch(Exception ex)
            {
                return null;
            }
        
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}
