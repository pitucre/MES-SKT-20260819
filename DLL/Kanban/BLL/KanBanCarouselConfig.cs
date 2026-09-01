using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Kanban.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace SKT.LeanMES.Kanban.BLL
{
    public class KanBanCarouselConfig
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 看板轮播配置—新增/编辑
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="json"></param>
        public void Edit(KanBanCarouselConfigInfo entity, string json)
        {
            DataTable dtDetail = JsonToDataTable(json);

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CarouselConfigId", SqlDbType.Int),
                new SqlParameter("@CarouselName", SqlDbType.NVarChar,50),
                new SqlParameter("@CarouselTime", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar,1000),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar,20),
                new SqlParameter("@CarouselConfigDetail", SqlDbType.Structured)
            };

            parms[0].Value = entity.CarouselConfigId;
            parms[1].Value = entity.CarouselName;
            parms[2].Value = entity.CarouselTime;
            parms[3].Value = entity.Remark;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = dtDetail;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspKanBanCarouselConfigEdit", parms);
        }


        /// <summary>
        /// 看板轮播配置—删除
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="json"></param>
        public void Delete(KanBanCarouselConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CarouselConfigIds", SqlDbType.VarChar),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar,20),
            };

            parms[0].Value = entity.CarouselConfigIds;
            parms[1].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspKanBanCarouselConfigDelete", parms);
        }


        /// <summary>
        /// 获取 KanBanCarouselConfigInfo 信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public KanBanCarouselConfigInfo GetInfo(KanBanCarouselConfigInfo entity)
        {

            string sql = "SELECT CarouselConfigId,CarouselName,CarouselTime,Remark,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime FROM KanBan_CarouselConfig WHERE CarouselConfigId = @CarouselConfigId";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CarouselConfigId", SqlDbType.Int)
            };

            parms[0].Value = entity.CarouselConfigId;

            return ComMethod.GetBySql<KanBanCarouselConfigInfo>(sql, parms);
        }

        /// <summary>
        /// 分页获取 KanBanCarouselConfigInfo 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="materialIQCCount">总数。</param>
        /// <returns>KanBanCarouselConfigInfo 列表。</returns>
        public List<KanBanCarouselConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwKanBan_CarouselConfig";
            //主键
            string strKey = "CarouselConfigId";
            //查询栏位字串
            string strColumns = @"CarouselConfigId,CarouselName,CarouselTime,Remark,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime";
            var list = ComMethod.GetComList<KanBanCarouselConfigInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }


        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        #region 将 Json 解析成 DateTable
        /// <summary>    
        /// 将 Json 解析成 DateTable   
        /// Json 数据格式如:  
        ///     {table:[{column1:1,column2:2,column3:3},{column1:1,column2:2,column3:3}]}///</summary>    
        /// <param name="strJson">要解析的 Json 字符串</param>    
        /// <returns>返回 DateTable</returns>    
        public static DataTable JsonToDataTable(string strJson)
        {
            // 取出表名    
            var rg = new Regex(@"(?<={)[^:]+(?=:\[)", RegexOptions.IgnoreCase);
            string strName = rg.Match(strJson).Value;
            DataTable tb = null;
            // 去除表名    
            strJson = strJson.Substring(strJson.IndexOf("[") + 1);
            strJson = strJson.Substring(0, strJson.IndexOf("]"));
            // 获取数据    
            rg = new Regex(@"(?<={)[^}]+(?=})");
            MatchCollection mc = rg.Matches(strJson);
            for (int i = 0; i < mc.Count; i++)
            {
                string strRow = mc[i].Value;
                string[] strRows = strRow.Split(',');
                // 创建表    
                if (tb == null)
                {
                    tb = new DataTable();
                    tb.TableName = strName;
                    foreach (string str in strRows)
                    {
                        var dc = new DataColumn();
                        string[] strCell = str.Split(':');
                        dc.ColumnName = strCell[0].Replace("\"", "");
                        tb.Columns.Add(dc);
                    }
                    tb.AcceptChanges();
                }
                // 增加内容    
                DataRow dr = tb.NewRow();
                for (int j = 0; j < strRows.Length; j++)
                {
                    dr[j] = strRows[j].Split(':')[1].Replace("\"", "");
                }
                tb.Rows.Add(dr);
                tb.AcceptChanges();
            }
            return tb;
        }
        #endregion


    }
}
