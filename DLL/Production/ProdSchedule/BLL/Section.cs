using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Schedule.BLL
{

    /// <summary>
    /// 工艺段
    /// </summary>
    public class Section
    {
        private Int32 recordCount = 0;


        /// <summary>
        /// 分页获取 Schedule 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="scheduleCount">schedule 总数。</param>
        /// <returns>Schedule 列表。</returns>
        public List<SectionInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SectionInfo> list = new List<SectionInfo>();
            SectionInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSection", "Id",
                "Id, [WorkSEQ]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SectionInfo(rdr.GetInt32(0), rdr.GetString(1));

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


    public class SectionInfo
    {
        private int id;
        private string sectionCode;
        private string sectionName;

        public SectionInfo() { }

        /// <summary>
        /// 构造工艺段
        /// </summary>
        /// <param name="sectionCode"></param>
        /// <param name="sectionName"></param>
        public SectionInfo( int id, string sectionCode)
        {
            this.id = id;
            this.sectionCode = sectionCode;


        }

        /// <summary>
        /// id
        /// </summary>
        public int Id
        {
            set { this.id = value; }
            get { return this.id; }
        }

        /// <summary>
        /// 工艺段编码
        /// </summary>
        public string SectionCode
        {
            set { this.sectionCode = value; }
            get { return this.sectionCode; }
        }

        /// <summary>
        /// 工艺段名称
        /// </summary>
        public string SectionName
        {
            set { this.sectionName = value; }
            get { return this.sectionName; }
        }
    }
}
