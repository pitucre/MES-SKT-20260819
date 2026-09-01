using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Text;
using SKT.LeanMES.PubItems.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls.Expressions;
using SKT.LeanMES.CommonHelper.BLL;
using System.Reflection;

namespace SKT.LeanMES.PubItems.BLL
{
    public class PubItems
    {
        //通用快速型
        public string GetSelectType(string tableName,string fieldsForIndexValueName ,string andWhere)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();
            string sql = " SELECT "+fieldsForIndexValueName+" FROM "+tableName+" WHERE 1=1 " + andWhere;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, null))
            {
                int r = 0;
                while (rdr.Read())
                {
                    entity = new PubItemsInfo();
                    //var aa = rdr.GetInt32(0);
                    entity.ItemIndex = rdr.GetSqlValue(0).ToString();
                    entity.ItemValue = rdr.GetSqlValue(1).ToString();
                    entity.ItemName = rdr.GetSqlValue(2).ToString();
                    list.Add(entity);
                    r++;
                }
                rdr.Close();
            }
            return new JavaScriptSerializer().Serialize(list);
        }


        //用于获取工单状态分类，返回JSON格式
        public String GetOrderStatus(String sortExpression, SearchSettings searchSettings)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1, "Prod_OrderStatus", "RID",
    "[StatusID], [StatusDesc], [StatusFlag], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PubItemsInfo();
                    entity.ItemIndex = (int)rdr["StatusID"];
                    entity.ItemName = rdr["StatusDesc"].ToString();
                    entity.ItemValue = rdr["StatusID"].ToString();
                    entity.ItemStatus = rdr["StatusFlag"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            return new JavaScriptSerializer().Serialize(list);
        }

        /// <summary>
        /// 获取排产工单状态
        /// </summary>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public String GetOrderPlanStatus(String sortExpression, SearchSettings searchSettings)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1, "Prod_LinePlanStatus", "LinePlanStateId",
    "[StatusID], [StatusDesc], [StatusFlag], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PubItemsInfo();
                    entity.ItemIndex = (int)rdr["StatusID"];
                    entity.ItemName = rdr["StatusDesc"].ToString();
                    entity.ItemValue = rdr["StatusID"].ToString();
                    entity.ItemStatus = rdr["StatusFlag"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }

            list.Add(new PubItemsInfo { ItemIndex = -10, ItemName = "可释放", ItemValue = -10, ItemStatus = 1 });

            return new JavaScriptSerializer().Serialize(list);
        }

        //用于获取工单、产品；绑定路由的可选工序，返回JSON格式
        public String GetStationList(string Type, string TypeValue)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Type", SqlDbType.NVarChar, 200),
                new SqlParameter("@TypeValue", SqlDbType.NVarChar,200)
            };
            parms[0].Value = Type;          //ItemID or OrderID
            parms[1].Value = TypeValue;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPassRouterDetail", parms))
            {
                while (rdr.Read())
                {
                    entity = new PubItemsInfo();
                    entity.ItemIndex = (int)rdr["StationID"];
                    entity.ItemValue = rdr["Station"].ToString();
                    entity.ItemName = rdr["StationDesc"].ToString();
                    entity.ItemStatus = rdr["StationStatus"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            return new JavaScriptSerializer().Serialize(list);
        }

        //用于获取设计报表表格列信息
        public String GetDsTableCol(string Table)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TableName", SqlDbType.NVarChar, 50),
            };
            parms[0].Value = Table;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetReportDesign", parms))
            {
                while (rdr.Read())
                {
                    entity = new PubItemsInfo();
                    entity.ItemValue = rdr["colName"].ToString();
                    entity.ItemName = rdr["colDesc"].ToString();
                    entity.DataType = rdr["dataType"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            return new JavaScriptSerializer().Serialize(list);
        }

        //用于获取报表或看板模块的分类信息
        public String GetRptType(string subSysName)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SubSysName", SqlDbType.NVarChar, 50),
            };
            parms[0].Value = subSysName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetRptType", parms))
            {
                while (rdr.Read())
                {
                    entity = new PubItemsInfo();
                    entity.ItemName = rdr["RptTypeName"].ToString();
                    entity.ItemValue = rdr["ReportKey"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            return new JavaScriptSerializer().Serialize(list);
        }

        //用于获取 看板控件类型
        public String GetCompType(String sortExpression, SearchSettings searchSettings)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1
                , "Kanban_ComponentType"
                , "ComponentTypeId"
    , "ComponentTypeId ,TypeName, TypeCode, Param1 ,Param2,Param3,Remark", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PubItemsInfo();
                    entity.ItemValue = rdr["ComponentTypeId"].ToString();
                    entity.ItemName = rdr["Remark"].ToString() + "(" + rdr["TypeName"].ToString() + ")";
                    entity.ItemStatus = rdr["Param1"].ToString() + "@" + rdr["Param2"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            return new JavaScriptSerializer().Serialize(list);
        }


        //SMTexcel插入时，获取系统需求项
        public String GetSMTColName(String andWhere)
        {
            PubItemsInfo entity = null;
            List<PubItemsInfo> list = new List<PubItemsInfo>();

            string sql = " SELECT ColCode,SMTColName,ColDescription FROM Prod_SMTInsertColName WHERE 1=1 " + andWhere;
               
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, null))
            {
                while (rdr.Read())
                {
                    entity = new PubItemsInfo();
                    entity.ItemIndex = Convert.ToInt32(rdr["ColCode"]);
                    entity.ItemValue = rdr["SMTColName"].ToString();
                    entity.ItemName = rdr["ColDescription"].ToString();
                    list.Add(entity);
                }
                rdr.Close();
            }
            return new JavaScriptSerializer().Serialize(list);
        }


        //dataTable转JSON
        public String GetListJson(DataTable tb )
        {
            ArrayList arrayList = new ArrayList();
            foreach (DataRow dataRow in tb.Rows)
            {
                Dictionary<string, object> dictionary = new Dictionary<string, object>();  //实例化一个参数集合
                foreach (DataColumn dataColumn in tb.Columns)
                {
                    //modified by zhi.li 加个分支：时间日期格式化处理
                    if (dataRow[dataColumn.ColumnName].ToString().Contains("星期"))
                    {
                        string strFormat = Convert.ToDateTime(dataRow[dataColumn.ColumnName].ToString()).ToString("yyyy-MM-dd HH:mm:ss");
                        dictionary.Add(dataColumn.ColumnName, strFormat);
                    }
                    else
                    {
                        dictionary.Add(dataColumn.ColumnName, dataRow[dataColumn.ColumnName].ToString());
                    }

                       
                }
                arrayList.Add(dictionary); //ArrayList集合中添加键值
            }

            return new JavaScriptSerializer().Serialize(arrayList);
        }

        public String GetListJson(string spName)
        {
            if (spName.Trim() == "")
            {
                return "";
            }
            SqlParameter[] parms = new SqlParameter[]{
                //new SqlParameter("@param", SqlDbType.NVarChar, 50),
            };
            //parms[0].Value = dataSource;
            DataTable tb = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, spName, parms);

            return GetListJson(tb);
        }

        //获取路径下的文件名，如图片资源文件，返回JSON
        public string GetFilesNameByPath(string path)
        {
            //path = Server.MapPath("../OnlineService/KanbanImage/");       //path参数取值 
            DirectoryInfo di = new DirectoryInfo(path);
            // di.GetFiles("*.jpg");只获取jpg图片 di.GetFiles();获取文件夹下所有的文件 
            var fileInfo = di.GetFiles();
            int fileCount = fileInfo.Count();
            ArrayList fileList = new ArrayList();
            foreach (var file in fileInfo)
            {
                //fileList.Add(file.FullName);
                fileList.Add(file.Name);
            }
            return new JavaScriptSerializer().Serialize(fileList);
        }

        /// <summary>
        /// 执行存储过程，返回Json字串
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">Json参数字串</param>
        /// <returns>Json字串</returns>
        public string ExecSpc(string strSpc, string strJson)
        {
            return ComMethod.EditBack(strJson, strSpc);
        }

        /// <summary>
        /// 分页获取列表数据--纯Html页面数据获取
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="strTb">表名或者视图</param>
        /// <param name="strKey">主键</param>
        /// <returns>AgingBasic 列表。</returns>
        public string GetPageList(Int32 startRow, Int32 maxRows, String sortExpression, string strJson, String strTb, string strConn = null)
        {
            return ComMethod.GetComListJson(startRow, startRow + maxRows, strTb, sortExpression, strJson, strConn);
        }

        /// <summary>
        /// 分页获取列表数据--纯Html页面数据获取 -- 存储过程分页
        /// </summary>
        /// <param name="strSpc">存储过程闽菜</param>
        /// <param name="strJson">参数字串</param>
        /// <param name="startRow">起始行</param>
        /// <param name="maxRows">每页总数</param>
        /// <returns></returns>
        public string GetPageSpcList(String strSpc, string strJson, Int32 startRow, Int32 maxRows, string strConn = null)
        {
            return ComMethod.GetPageList(strSpc, strJson, startRow, startRow + maxRows, strConn);
        }

        /// <summary>
        /// 根据存储过程获取列表数据--返回Json字串--格式为｛data:[{},{}];data1:[{},{}]....｝ 
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns></returns>
        public string GetList(string strSpc, string strJson)
        {
            return ComMethod.GetListJson(strSpc, strJson);
        }

        /// <summary>
        /// 根据存储过程获取列表数据--返回dataset
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns></returns>
        public DataSet GetListDs(string strSpc, string strJson)
        {
            return ComMethod.GetListDataSet(strSpc, strJson);
        }

        /// <summary>
        /// 根据存储过程获取单笔数据--返回dataset
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns></returns>
        public DataSet Get(string strSpc, string strJson)
        {
            return ComMethod.Get(strSpc, strJson);
        }

        /// <summary>
        /// 根据存储过程获取单笔数据--返回dataset
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns></returns>
        public T Get<T>(string strSpc, string strJson) where T : class
        {
            return ComMethod.Get<T>(strSpc, strJson);
        }

        /// <summary>
        /// 根据存储过程获取单笔数据--返回dataset
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">Id字串</param>
        /// <returns></returns>
        public T GetInfo<T>(string strSpc, int intId) where T : class
        {
            return ComMethod.GetInfo<T>(intId, strSpc);
        }

        /// <summary>
        /// 根据存储过程获取单笔数据--返回dataset
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns></returns>
        public string GetJson(string strSpc, string strJson)
        {
            return ComMethod.GetJson(strSpc, strJson);
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        /// <param name="strSpc"></param>
        public void Delete(String idString, String userName, string strSpc)
        {
            ComMethod.Delete(idString, userName, strSpc);
        }

        /// <summary>
        /// 获取PDF报表文档
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetPdf(string strSpc, string strJson, string strTargetPath, string strXmlFilePath,
            string strImgPath, string strDataTable = "table")
        {
            DataSet ds = ComMethod.GetListDataSet(strSpc, strJson, strDataTable);
            //PDF产生
            return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
        }

        /// <summary>
        /// 获取PDF报表文档 -- 数据流
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public byte[] GetPdfBuff(string strSpc, string strJson, string strXmlFilePath,
            string strImgPath, string strDataTable = "table")
        {
            DataSet ds = ComMethod.GetListDataSet(strSpc, strJson, strDataTable);
            //PDF产生
            return PDFHelper.getPDFByte(PDFHelper.Language.Simplified, strXmlFilePath, ds, strImgPath);
        }

        /// <summary>
        /// 自动获取表/视图-栏位数据
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns>Json</returns>
        public string GetTbViewList(string strTb, String sortExpression, SearchSettings searchSettings)
        {
            return ComMethod.GetTbViewList(strTb, searchSettings, sortExpression);
        }

        /// <summary>
        /// 根据表或试图获取数据
        /// </summary>
        /// <param name="strTb">表或试图名称</param>
        /// <param name="sortExpression">排序字段</param>
        /// <param name="searchSettings">查询条件</param>
        /// <param name="strRecordIDField">主键</param>
        /// <param name="searchIDField">主键筛选字符串</param>
        /// <returns></returns>
        public DataSet GetTbViewListDs(string strTb, String sortExpression, SearchSettings searchSettings, string strRecordIDField = null, string searchIDField = null)
        {
            if (!string.IsNullOrWhiteSpace(searchIDField) && !string.IsNullOrWhiteSpace(strRecordIDField))
            {
                searchSettings = new SearchSettings();
                searchSettings.ExtensionCondition = strRecordIDField + " IN (" + searchIDField + ")";
            }
            return ComMethod.GetTbViewListDs(strTb, searchSettings, sortExpression);
        }

        /// <summary>
        /// 自动获取表/视图-栏位数据 - dataset
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns>Json</returns>
        public DataSet GetTbViewListDs(string strTb, string strJson, String sortExpression = "", string strConn = null)
        {
            return ComMethod.GetTbViewListDs(strTb, strJson, sortExpression, strConn);
        }

        /// <summary>
        /// 自动获取表/视图-栏位数据
        /// </summary>
        /// <param name="strTb">表名称/视图名称</param>
        /// <param name="strJson">参数字串--列表形式 格式为[{name:"", type:"", value:"", action:""},{},{}] 
        ///                       type:可以为:"="、"like"、"<>"、 默认"=", action可为: "and", "or" 默认 and</param>
        /// <returns>Json</returns>
        public string GetTbViewList(string strTb, String strJson, string sortExpression, string strConn = null)
        {
            return ComMethod.GetTbViewList(strTb, strJson, sortExpression, strConn);
        }

        /// <summary>
        /// 自动获取表/视图/存储过程-栏位信息
        /// </summary>
        /// <param name="strName"></param>
        /// <param name="strType"></param>
        /// <returns></returns>
        public string GetSpcTbViewColumns(string strName, string strType)
        {
            return ComMethod.GetSpcTbViewColumns(strName, strType);
        }
        public string GetTbOrViewColumns(string strTbOrView)
        {
            SqlParameter[] parms = new SqlParameter[] {
            };
            //parms[0].Value = strTbOrView;

            string strSql = @"select b.name colName, '' as colDesc, c.name DataType ,b.length colLength, 0 as ColType                   
                            FROM syscolumns b 
                            inner join systypes c on b.xtype=c.xusertype
                             LEFT JOIN SYS.extended_properties AS e ON b.colid = e.minor_id AND b.id=e.major_id                       
                            WHERE id=OBJECT_ID('" + strTbOrView + "') and colid > 1";
            return ComMethod.GetListBySql(strSql, parms);
        }
        /// <summary>
        /// Json转datatable
        /// </summary>
        /// <param name="strJson"></param>
        /// <returns></returns>
        public DataTable JsonToTable(string strJson)
        {
            return ComMethod.JsonToDataTable(strJson);
        }


        public static DataTable ToDataTable<T>(IEnumerable<T> collection)
        {
            var props = typeof(T).GetProperties();
            var dt = new DataTable();
            dt.Columns.AddRange(props.Select(p => new DataColumn(p.Name, p.PropertyType)).ToArray());
            if (collection.Count() > 0)
            {
                for (int i = 0; i < collection.Count(); i++)
                {
                    ArrayList tempList = new ArrayList();
                    foreach (PropertyInfo pi in props)
                    {
                        object obj = pi.GetValue(collection.ElementAt(i), null);
                        tempList.Add(obj);
                    }
                    object[] array = tempList.ToArray();
                    dt.LoadDataRow(array, true);
                }
            }
            return dt;
        }
    }
}
