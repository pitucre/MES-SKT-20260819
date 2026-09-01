using System;
using System.Data;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data.SqlClient;
using System.Collections.Generic;


namespace SKT.LeanMES.DBservice.BLL
{
    //公共用基础方法
    public class DbService
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 执行存储过程，返回Json字串
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">Json参数字串</param>
        /// <returns>Json字串</returns>
        public string ExecSpc(string strSpc, string strJson, string strConn = null)
        {
            return ComMethod.EditBack(strJson, strSpc, strConn);		
        }

        /// <summary>
        /// 执行存储过程进行编辑储存等动作
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">Json参数字串</param>
        /// <returns>Json字串</returns>
        public void Edit(string strSpc, string strJson)
        {
             ComMethod.Edit(strJson, strSpc);
        }

        /// <summary>
        /// 执行存储过程进行编辑储存等动作 --通过临时表传列表数据给存储过程
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">Json参数字串
        /// Json字串 属性TempColumns 是包含要存储如临时表的列表, 该栏位字串格式为 Columns1,Columns2,Columns3 ...
        /// 生成的临时表 #TempTable， #TempTable1， #TempTable2...
        /// </param>
        /// <returns>Json字串</returns>
        public string ExcuteSpcByTemp(string strSpc, string strJson, DataSet ds = null)
        {
            return ComMethod.ExcuteSpcByTemp(strSpc, strJson, ds);
        }

        /// <summary>
        /// 分页获取列表数据
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="strTb">表名或者视图</param>
        /// <param name="strKey">主键</param>
        /// <returns>AgingBasic 列表。</returns>
        public DataSet GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings, String strTb, String strKey)
        {
            //return ComMethod.GetComList(ref recordCount, startRow, maxRows, strTb, strKey, sortExpression, searchSettings);
            sortExpression = sortExpression != "" && sortExpression != null ? "ORDER BY " + sortExpression : sortExpression;
            return ComMethod.GetComList(ref recordCount, startRow + 1, startRow + maxRows, strTb, sortExpression, searchSettings);
        }

        /// <summary>
        /// 分页获取列表数据
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="strTb">表名或者视图</param>
        /// <param name="strKey">主键</param>
        /// <returns>AgingBasic 列表。</returns>
        public DataSet GetAll2(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings, String strTb, ref int intCount)
        {
            //return ComMethod.GetComList(ref recordCount, startRow, maxRows, strTb, strKey, sortExpression, searchSettings);
            sortExpression = sortExpression != "" && sortExpression != null ? "ORDER BY " + sortExpression : sortExpression;
            return ComMethod.GetComList(ref intCount, startRow + 1, startRow + maxRows, strTb, sortExpression, searchSettings);
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
        /// 获取行数
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <param name="strTb"></param>
        /// <param name="strKey"></param>
        /// <returns></returns>
        public Int32 GetCount(SearchSettings searchSettings, String strTb, String strKey)
        {
            return this.recordCount;
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
        public T GetInfo<T>(string strSpc, int intId) where T:class
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
        public DataSet GetTbViewListDs(string strTb, String sortExpression, SearchSettings searchSettings, string strRecordIDField = null, string searchIDField = null,int maxRow=0)
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
        public string GetTbViewList(string strTb, String strJson, string sortExpression, string strConn =null)
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

        ///// <summary>
        ///// 获取PDF报表文档
        ///// </summary>
        ///// <param name="intId"></param>
        ///// <returns></returns>
        //public string Import(string strSpc, string strJson, string strTargetPath, string strXmlFilePath,
        //    string strImgPath, string strDataTable = null)
        //{
        //    DataSet ds = ComMethod.GetListDataSet(strSpc, strJson, strDataTable);
        //    //PDF产生
        //    return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
        //}
    }
}
