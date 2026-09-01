/*================================================================
* Copyright (C) 2016 深圳市深科特信息技术有限公司
* 版权所有。
*
* 文件名：AjaxCommon.cs
* 文件功能描述：公用的ajax类，此类中存放一些通用性高的ajax方法
*
* 创建标识： Alen Liu 20160420
*
* 修改标识： 
* 修改描述：  
==================================================================*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using System.Data;
using System.Web.UI.WebControls;
using SKT.Common.Model;
using System.Xml;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxCommon
    {
        #region Excel导入导出数据，服务器上需要安装Excel
        /// <summary>
        /// 导出数据到Excel，服务器上需要安装Excel
        /// </summary>
        /// <param name="dt">数据表</param>
        /// <param name="filename">导出生成的Excel文件名</param>
        /// <param name="encoding">编码</param>
        [AjaxMethod]
        public void ExportToExcel(DataTable dt, string filename, string encoding)
        {
            AppCode.Utility.ExcelHelper.ExportToExcel(dt, filename, encoding);
        }

        /// <summary>
        /// 导出数据到Excel，服务器上需要安装Excel
        /// </summary>
        /// <param name="dt">数据表</param>
        /// <param name="filename">导出生成的Excel文件名</param>
        [AjaxMethod]
        public void ExportToExcel(DataTable dt, string filename)
        {
            AppCode.Utility.ExcelHelper.ExportToExcel(dt, filename);
        }

        /// <summary>
        /// 导出数据到Excel，服务器上需要安装Excel
        /// </summary>
        /// <param name="dt">数据表</param>
        [AjaxMethod]
        public void ExportToExcel(DataTable dt)
        {
            AppCode.Utility.ExcelHelper.ExportToExcel(dt);
        }

        /// <summary>
        /// 导入Excel数据返回DataTable，服务器上需要安装Excel
        /// </summary>
        /// <param name="excelFilePath">要导入数据的Excel文件路径，上传服务器上的Excel文件路径</param>
        /// <returns>返回DataTable</returns>
        [AjaxMethod]
        public DataTable ExcelToDataTable(string excelFilePath)
        {
            return AppCode.Utility.ExcelHelper.QueryExcel(excelFilePath, WebHelper.ExcelConnString);
        }

        /// <summary>
        /// 导入Excel数据返回DataTable，服务器上需要安装Excel
        /// </summary>
        /// <param name="excelFilePath">要导入数据的Excel文件路径，上传服务器上的Excel文件路径</param>
        /// <param name="sheetIndex">要导入的sheet序号,从0开始</param>
        /// <returns>返回DataTable</returns>
        [AjaxMethod]
        public DataTable ExcelToDataTable(string excelFilePath, int sheetIndex)
        {
            return AppCode.Utility.ExcelHelper.QueryExcel(excelFilePath, sheetIndex, WebHelper.ExcelConnString);
        }

        /// <summary>
        /// 导入Excel数据返回DataTable，服务器上需要安装Excel
        /// </summary>
        /// <param name="excelFilePath">要导入数据的Excel文件路径，上传服务器上的Excel文件路径</param>
        /// <param name="sheetName">要导入的Sheet名字，如:Sheet1</param>
        /// <returns>返回DataTable</returns>
        [AjaxMethod]
        public DataTable ExcelToDataTable(string excelFilePath, string sheetName)
        {
            return AppCode.Utility.ExcelHelper.QueryExcel(excelFilePath, sheetName, WebHelper.ExcelConnString);
        }
        #endregion

        #region Excel导出导入数据，服务器上不需要安装Excel
        /// <summary>
        /// Excel导出数据，服务器上不需要安装Excel
        /// </summary>
        /// <param name="dt">数据表</param>
        [AjaxMethod]
        public void HSSExportToExcel(DataTable dt)
        {
            AppCode.Utility.ExcelHelper.HSSExportToExcel(dt);
        }

        /// <summary>
        /// Excel导出数据，服务器上不需要安装Excel
        /// </summary>
        /// <param name="gridview">GridView</param>
        [AjaxMethod]
        public void HSSExportToExcel(GridView gridview)
        {
            AppCode.Utility.ExcelHelper.HSSExportToExcel(gridview);
        }

        /// <summary>
        /// Excel导出数据，服务器上不需要安装Excel
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="list">List</param>
        [AjaxMethod]
        public void HSSExportToExcel<T>(List<T> list)
        {
            AppCode.Utility.ExcelHelper.HSSExportToExcel<T>(list);
        }

        /// <summary>
        /// Excel导出数据，服务器上不需要安装Excel
        /// </summary>
        /// <param name="fileName">导出生成的Excel文件名</param>
        /// <param name="dt">数据表</param>
        [AjaxMethod]
        public void HSSExportToExcel(string fileName, DataTable dt)
        {
            AppCode.Utility.ExcelHelper.HSSExportToExcel(fileName, dt);
        }

        /// <summary>
        /// Excel导出数据，服务器上不需要安装Excel
        /// </summary>
        /// <param name="fileName">导出生成的Excel文件名</param>
        /// <param name="gridview">要导出数据的GridView</param>
        [AjaxMethod]
        public void HSSExportToExcel(string fileName, GridView gridview)
        {
            AppCode.Utility.ExcelHelper.HSSExportToExcel(fileName, gridview);
        }

        /// <summary>
        /// Excel导出数据，服务器上不需要安装Excel
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="fileName">导出生成的Excel文件名</param>
        /// <param name="list">List</param>
        [AjaxMethod]
        public void HSSExportToExcel<T>(string fileName, List<T> list)
        {
            AppCode.Utility.ExcelHelper.HSSExportToExcel<T>(fileName, list);
        }

        /// <summary>
        /// Excel导入数据，服务器上不需要安装Excel
        /// </summary>
        /// <param name="filePath">要导入的Excel文件路径</param>
        /// <returns>返回DataTable</returns>
        [AjaxMethod]
        public DataTable HSSExcelToDataTable(string filePath)
        {
            return AppCode.Utility.ExcelHelper.HSSExcelToDataTable(filePath);
        }

        /// <summary>
        /// Excel导入数据，服务器上不需要安装Excel
        /// </summary>
        /// <param name="filePath">要导入的Excel文件路径</param>
        /// <param name="sheetName">要导入的Sheet名字</param>
        /// <returns>返回DataTable</returns>
        [AjaxMethod]
        public DataTable HSSExcelToDataTable(string filePath, string sheetName)
        {
            return AppCode.Utility.ExcelHelper.HSSExcelToDataTable(filePath, sheetName);
        }
        #endregion

        #region
        private Int32 recordCount = 0;
        public List<UpgradeVersion> GetAllVersion(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            XmlDocument xd = new XmlDocument();
            xd.Load(System.Web.HttpContext.Current.Server.MapPath("~/App_Data/LeanMES-Version-Upgrade.xml"));

            List<UpgradeVersion> UVlist = new List<UpgradeVersion>();
            XmlNodeList xnl = xd.GetElementsByTagName("Upgrade");
            foreach (XmlNode xn in xnl)
            {
                UpgradeVersion UV = new UpgradeVersion();
                UV.Version = xn.Attributes["Version"].InnerText.ToString();
                foreach (XmlNode item in xn.ChildNodes)
                {
                    if (item.Name.ToUpper() == "VersionID".ToUpper())
                    {
                        UV.VersionID = Convert.ToInt32(item.InnerText);
                    }
                    else if (item.Name.ToUpper() == "UpgradeDatetime".ToUpper())
                    {
                        UV.UpgradeDatetime = Convert.ToDateTime(item.InnerText);
                    }
                    else if (item.Name.ToUpper() == "Description".ToUpper())
                    {
                        UV.Description = item.InnerText;
                    }
                    else if (item.Name.ToUpper() == "Remark".ToUpper())
                    {
                        UV.Remark = item.InnerText;
                    }
                }
                UVlist.Add(UV);
            }

            if (searchSettings.ExtensionCondition != "")
            {
                if (searchSettings.ExtensionCondition.IndexOf("Version") > 0)
                {
                    UVlist = UVlist.Where(kk => kk.Version.Contains(searchSettings.ExtensionCondition.Split(new char[] { '%' })[1])).ToList();
                }

                if(searchSettings.ExtensionCondition.IndexOf(">=") > 0)
                {
                    string createDateTimeStart = searchSettings.ExtensionCondition.Split(new char[] { '>' })[1].Split(new char[] { '\'' })[1];
                    UVlist = UVlist.Where(kk => kk.UpgradeDatetime >= Convert.ToDateTime(createDateTimeStart)).ToList();
                }

                if (searchSettings.ExtensionCondition.IndexOf("<=") > 0)
                {
                    string createDateTimeStart = searchSettings.ExtensionCondition.Split(new char[] { '<' })[1].Split(new char[] { '\'' })[1];
                    UVlist = UVlist.Where(kk => kk.UpgradeDatetime <= Convert.ToDateTime(createDateTimeStart)).ToList();
                }
            }

            recordCount = UVlist.Count();
            UVlist = UVlist.Skip(startRow).Take(maxRows).ToList();            
            return UVlist;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        #endregion

    }

    [Serializable]
    public class UpgradeVersion
    {
        public int VersionID { set; get; }
        public string Version { set; get; }
        public DateTime UpgradeDatetime { set; get; }
        public string Description { set; get; }
        public string Remark { set; get; }
    }
}