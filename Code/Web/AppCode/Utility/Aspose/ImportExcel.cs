
using Aspose.Cells;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;

namespace SKT.LeanMES.Web.AppCode.Utility.Aspose
{
    public static class ImportExcel
    {
        static ImportExcel()
        {
            string key = @"PExpY2Vuc2U+CiAgPERhdGE+CiAgICA8TGljZW5zZWRUbz5TdXpob3UgQXVuYm94IFNvZnR3YXJlIENvLiwgTHRkLjwvTGljZW5zZWRUbz4KICAgIDxFbWFpbFRvPnNhbGVzQGF1bnRlYy5jb208L0VtYWlsVG8+CiAgICA8TGljZW5zZVR5cGU+RGV2ZWxvcGVyIE9FTTwvTGljZW5zZVR5cGU+CiAgICA8TGljZW5zZU5vdGU+TGltaXRlZCB0byAxIGRldmVsb3BlciwgdW5saW1pdGVkIHBoeXNpY2FsIGxvY2F0aW9uczwvTGljZW5zZU5vdGU+CiAgICA8T3JkZXJJRD4xOTA4MjYwODA3NTM8L09yZGVySUQ+CiAgICA8VXNlcklEPjEzNDk3NjAwNjwvVXNlcklEPgogICAgPE9FTT5UaGlzIGlzIGEgcmVkaXN0cmlidXRhYmxlIGxpY2Vuc2U8L09FTT4KICAgIDxQcm9kdWN0cz4KICAgICAgPFByb2R1Y3Q+QXNwb3NlLlRvdGFsIGZvciAuTkVUPC9Qcm9kdWN0PgogICAgPC9Qcm9kdWN0cz4KICAgIDxFZGl0aW9uVHlwZT5FbnRlcnByaXNlPC9FZGl0aW9uVHlwZT4KICAgIDxTZXJpYWxOdW1iZXI+M2U0NGRlMzAtZmNkMi00MTA2LWIzNWQtNDZjNmEzNzE1ZmMyPC9TZXJpYWxOdW1iZXI+CiAgICA8U3Vic2NyaXB0aW9uRXhwaXJ5PjIwMjAwODI3PC9TdWJzY3JpcHRpb25FeHBpcnk+CiAgICA8TGljZW5zZVZlcnNpb24+My4wPC9MaWNlbnNlVmVyc2lvbj4KICAgIDxMaWNlbnNlSW5zdHJ1Y3Rpb25zPmh0dHBzOi8vcHVyY2hhc2UuYXNwb3NlLmNvbS9wb2xpY2llcy91c2UtbGljZW5zZTwvTGljZW5zZUluc3RydWN0aW9ucz4KICA8L0RhdGE+CiAgPFNpZ25hdHVyZT53UGJtNUt3ZTYvRFZXWFNIY1o4d2FiVEFQQXlSR0pEOGI3L00zVkV4YWZpQnd5U2h3YWtrNGI5N2c2eGtnTjhtbUFGY3J0c0cwd1ZDcnp6MytVYk9iQjRYUndTZWxsTFdXeXNDL0haTDNpN01SMC9jZUFxaVZFOU0rWndOQkR4RnlRbE9uYTFQajhQMzhzR1grQ3ZsemJLZFZPZXk1S3A2dDN5c0dqYWtaL1E9PC9TaWduYXR1cmU+CjwvTGljZW5zZT4=";
            new License().SetLicense(new MemoryStream(Convert.FromBase64String(key)));
        }

        /// <summary>
        /// 获取配置文件对象
        /// </summary>
        /// <typeparam name="TEntity">实体类型</typeparam>
        /// <param name="json">Json配置字符串</param>
        /// <returns>配置信息</returns>
        private static ImportExcelConfig GetConfig<TEntity>(string json)
        {
            if (!string.IsNullOrEmpty(json))
            {
                return JsonConvert.DeserializeObject<ImportExcelConfig>(json);
            }
            else
            {
                ImportExcelConfig result = new ImportExcelConfig()
                {
                    TableSchema = "dbo",
                    TableName = typeof(TEntity).Name
                };
                return result;
            }
        }

        /// <summary>
        /// 读取Excel文件数据到DataTable对象
        /// </summary>
        /// <param name="file">导入的Excel文件</param>
        /// <returns>DataTable数据</returns>
        public static DataTable ReadExcelToTable(string file)
        {
            TxtLoadOptions option = new TxtLoadOptions() { Encoding = Encoding.Default };
            Workbook wb = new Workbook(file, option);
            Worksheet sheet = wb.Worksheets[0];
            var data = sheet.Cells.ExportDataTableAsString(0, 0, sheet.Cells.MaxDataRow + 1, sheet.Cells.MaxDataColumn + 1);
            return data;
        }

        /// <summary>
        /// 导入的Excel数据转实体类列表
        /// </summary>
        /// <typeparam name="TEntity">实体类型</typeparam>
        /// <param name="config_json">Json配置</param>
        /// <param name="file">导入的Excel文件</param>
        /// <param name="fun_config">导入配置</param>
        /// <param name="fun_dealwith">对数据进行处理(可补全属性值)</param>
        /// <returns>结果数据集合</returns>
        public static List<TEntity> ImportToEntitys<TEntity>(string config_json, string file, Action<ImportExcelConfig> fun_config, Action<TEntity> fun_dealwith)
            where TEntity : class, new()
        {
            return ImportToEntitys(config_json, file, fun_config, fun_dealwith, i => true);
        }

        /// <summary>
        /// 导入的Excel数据转实体类列表
        /// </summary>
        /// <typeparam name="TEntity">实体类型</typeparam>
        /// <param name="config_json">Json配置</param>
        /// <param name="file">导入的Excel文件</param>
        /// <param name="fun_config">导入配置</param>
        /// <returns>结果数据集合</returns>
        public static List<TEntity> ImportToEntitys<TEntity>(string config_json, string file, Action<ImportExcelConfig> fun_config)
            where TEntity : class, new()
        {
            return ImportToEntitys<TEntity>(config_json, file, fun_config, i => { }, i => true);
        }

        /// <summary>
        /// 导入的Excel数据转实体类列表
        /// </summary>
        /// <typeparam name="TEntity">实体类型</typeparam>
        /// <param name="config_json">Json配置</param>
        /// <param name="file">导入的Excel文件</param>
        /// <param name="fun_dealwith">对数据进行处理(可补全属性值)</param>
        /// <returns>结果数据集合</returns>
        public static List<TEntity> ImportToEntitys<TEntity>(string config_json, string file, Action<TEntity> fun_dealwith)
            where TEntity : class, new()
        {
            return ImportToEntitys(config_json, file, i => { }, fun_dealwith, i => true);
        }

        /// <summary>
        /// 导入的Excel数据转实体类列表
        /// </summary>
        /// <typeparam name="TEntity">实体类型</typeparam>
        /// <param name="config_json">Json配置</param>
        /// <param name="file">导入的Excel文件</param>
        /// <param name="fun_config">导入配置</param>
        /// <param name="fun_dealwith">对数据进行处理(可补全属性值)</param>
        /// <param name="filter">过滤数据</param>
        /// <returns>结果数据集合</returns>
        public static List<TEntity> ImportToEntitys<TEntity>(string config_json, string file, Action<ImportExcelConfig> fun_config, Action<TEntity> fun_dealwith, Func<TEntity, bool> filter)
            where TEntity : class, new()
        {
            // Excel文件读取的Table数据
            var excel_table = ReadExcelToTable(file);

            // 导入Excel数据 配置文件
            ImportExcelConfig config = GetConfig<TEntity>(config_json);
            fun_config(config);
            config.FieldMappers = config.FieldMappers.Where(i => !string.IsNullOrWhiteSpace(i.ExcelColumnName)).Where(i => !string.IsNullOrWhiteSpace(i.TableFieldName)).Where(i => !i.IsIgnore).ToList();

            // 关联信息
            // DataColumn : excel_table 中的数据列
            // ImportExcelConfig.FieldMapper : config 配置文件中的映射关系
            // PropertyInfo : TEntity 实体类中的属性
            var relatedInfos = new List<Tuple<DataColumn, ImportExcelConfig.FieldMapper, PropertyInfo>>();

            // Excel文件读取的Table数据字典（列名，列信息）
            var exceltable_columnname_datacolumn = new List<Tuple<string, DataColumn>>();
            // 首行为表头
            var firstRow_header = excel_table.Rows[0];
            foreach (DataColumn col in excel_table.Columns)
            {
                if (!string.IsNullOrWhiteSpace(firstRow_header[col.ColumnName].ToString()))
                {
                    exceltable_columnname_datacolumn.Add(new Tuple<string, DataColumn>(firstRow_header[col.ColumnName].ToString().Trim(), col));
                }
            }

            // config配置文件中表列名数据字典（表列名，字段映射信息）
            Dictionary<string, ImportExcelConfig.FieldMapper> dic_config_tablefieldname_fieldmapper = new Dictionary<string, ImportExcelConfig.FieldMapper>();
            config.FieldMappers.ForEach(fieldMapper =>
            {
                if ((!string.IsNullOrWhiteSpace(fieldMapper.TableFieldName)) && (!dic_config_tablefieldname_fieldmapper.Keys.Contains(fieldMapper.TableFieldName)))
                {
                    dic_config_tablefieldname_fieldmapper.Add(fieldMapper.TableFieldName.Trim(), fieldMapper);
                }
            });

            // 遍历实体类属性
            typeof(TEntity).GetProperties(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)
                .ToList().ForEach(attrInfo =>
                {
                    if (dic_config_tablefieldname_fieldmapper.Keys.Contains(attrInfo.Name))
                    {
                        var fieldMapper = dic_config_tablefieldname_fieldmapper[attrInfo.Name];
                        var excelDataColumn = exceltable_columnname_datacolumn.FirstOrDefault(i => i.Item1.Equals(fieldMapper.ExcelColumnName));
                        if (excelDataColumn != null)
                        {
                            relatedInfos.Add(new Tuple<DataColumn, ImportExcelConfig.FieldMapper, PropertyInfo>(excelDataColumn.Item2, fieldMapper, attrInfo));
                        }
                    }
                });

            List<TEntity> list = new List<TEntity>();
            foreach (DataRow row in excel_table.Rows)
            {
                if (row.Equals(firstRow_header))
                {
                    continue;
                }

                var item = new TEntity();
                var val = string.Empty;

                relatedInfos.ForEach(relatedInfo =>
                                {
                                    val = row[relatedInfo.Item1].ToString();

                                    if (string.IsNullOrWhiteSpace(val) && (!string.IsNullOrWhiteSpace(relatedInfo.Item2.DefaultValue)))
                                    {
                                        val = relatedInfo.Item2.DefaultValue.Trim();
                                    }

                                    if (relatedInfo.Item2.Format.Formats.Count > 0)
                                    {
                                        if (relatedInfo.Item2.Format.Formats.ContainsKey(val))
                                        {
                                            val = relatedInfo.Item2.Format.Formats[val];
                                        }
                                        else
                                        {
                                            val = relatedInfo.Item2.Format.OtherValue;
                                        }
                                    }

                                    Type targetType = relatedInfo.Item3.PropertyType;
                                    if (targetType.IsGenericType && targetType.GetGenericTypeDefinition() == typeof(Nullable<>))
                                    {
                                        if (string.IsNullOrEmpty(val))
                                        {
                                            relatedInfo.Item3.SetValue(item, null, null);
                                        }
                                        else
                                        {
                                            relatedInfo.Item3.SetValue(item, Convert.ChangeType(val, targetType.GetGenericArguments().First()), null);
                                        }
                                    }
                                    else
                                    {
                                        relatedInfo.Item3.SetValue(item, Convert.ChangeType(val, relatedInfo.Item3.PropertyType), null);
                                    }
                                });

                fun_dealwith(item);
                list.Add(item);
            }

            return list.Where(filter).ToList();
        }

        /// <summary>
        /// 导入或导出Excel配置信息
        /// </summary>
        public class ImportExcelConfig
        {
            /// <summary>
            /// 模式
            /// </summary>
            public string TableSchema { get; set; }

            /// <summary>
            /// 表名
            /// </summary>
            public string TableName { get; set; }

            /// <summary>
            /// 字段映射列表
            /// </summary>
            public List<FieldMapper> FieldMappers { get; set; } = new List<FieldMapper>();

            /// <summary>
            /// 字段映射类
            /// </summary>
            public class FieldMapper
            {
                /// <summary>
                /// 构造函数
                /// </summary>
                public FieldMapper()
                {
                }

                /// <summary>
                /// 构造函数
                /// </summary>
                /// <param name="_ExcelColumnName">Excel文档中的列名</param>
                /// <param name="_TableFieldName">数据表中的字段名</param>
                public FieldMapper(string _ExcelColumnName, string _TableFieldName) : this(_ExcelColumnName, _TableFieldName, string.Empty)
                {
                }

                /// <summary>
                /// 构造函数
                /// </summary>
                /// <param name="_ExcelColumnName">Excel文档中的列名</param>
                /// <param name="_TableFieldName">数据表中的字段名</param>
                /// <param name="_DefaultValue">默认值
                /// <para>显式值为空或者类型转换出错时将由此值代替</para>
                /// </param>
                public FieldMapper(string _ExcelColumnName, string _TableFieldName, string _DefaultValue)
                {
                    ExcelColumnName = _ExcelColumnName;
                    TableFieldName = _TableFieldName;
                    DefaultValue = _DefaultValue;
                }

                /// <summary>
                /// Excel文档中的列名
                /// </summary>
                public string ExcelColumnName { get; set; }

                /// <summary>
                /// 数据表中的字段名
                /// </summary>
                public string TableFieldName { get; set; }

                /// <summary>
                /// 是否忽略
                /// <para>默认 false 不忽略</para>
                /// </summary>
                public bool IsIgnore { get; set; } = false;

                /// <summary>
                /// 是否移除值为空的项（整行数据）
                /// <para>默认 false 不移除</para>
                /// </summary>
                public bool IsRemoveEmptyItem { get; set; } = false;

                /// <summary>
                /// 格式化
                /// <para>例：Excel中的某列显式值为是、否，在映射后需要转换为true、false或1、0</para>
                /// </summary>
                public CustomFormat Format { get; set; } = new CustomFormat();

                /// <summary>
                /// 默认值
                /// <para>显式值为空或者类型转换出错时将由此值代替</para>
                /// </summary>
                public string DefaultValue { get; set; }

                /// <summary>
                /// 自定义格式化类
                /// </summary>
                public class CustomFormat
                {
                    /// <summary>
                    /// 格式化字典
                    /// </summary>
                    public Dictionary<string, string> Formats { get; set; } = new Dictionary<string, string>();

                    /// <summary>
                    /// 除字典外的默认值
                    /// </summary>
                    public string OtherValue { get; set; }
                }
            }
        }
    }
    ///// <summary>
    ///// 导入Excel基础数据
    ///// </summary>
    //public static class ImportExcel
    //{
    //    static ImportExcel()
    //    {
    //        string key = @"PExpY2Vuc2U+CiAgPERhdGE+CiAgICA8TGljZW5zZWRUbz5TdXpob3UgQXVuYm94IFNvZnR3YXJlIENvLiwgTHRkLjwvTGljZW5zZWRUbz4KICAgIDxFbWFpbFRvPnNhbGVzQGF1bnRlYy5jb208L0VtYWlsVG8+CiAgICA8TGljZW5zZVR5cGU+RGV2ZWxvcGVyIE9FTTwvTGljZW5zZVR5cGU+CiAgICA8TGljZW5zZU5vdGU+TGltaXRlZCB0byAxIGRldmVsb3BlciwgdW5saW1pdGVkIHBoeXNpY2FsIGxvY2F0aW9uczwvTGljZW5zZU5vdGU+CiAgICA8T3JkZXJJRD4xOTA4MjYwODA3NTM8L09yZGVySUQ+CiAgICA8VXNlcklEPjEzNDk3NjAwNjwvVXNlcklEPgogICAgPE9FTT5UaGlzIGlzIGEgcmVkaXN0cmlidXRhYmxlIGxpY2Vuc2U8L09FTT4KICAgIDxQcm9kdWN0cz4KICAgICAgPFByb2R1Y3Q+QXNwb3NlLlRvdGFsIGZvciAuTkVUPC9Qcm9kdWN0PgogICAgPC9Qcm9kdWN0cz4KICAgIDxFZGl0aW9uVHlwZT5FbnRlcnByaXNlPC9FZGl0aW9uVHlwZT4KICAgIDxTZXJpYWxOdW1iZXI+M2U0NGRlMzAtZmNkMi00MTA2LWIzNWQtNDZjNmEzNzE1ZmMyPC9TZXJpYWxOdW1iZXI+CiAgICA8U3Vic2NyaXB0aW9uRXhwaXJ5PjIwMjAwODI3PC9TdWJzY3JpcHRpb25FeHBpcnk+CiAgICA8TGljZW5zZVZlcnNpb24+My4wPC9MaWNlbnNlVmVyc2lvbj4KICAgIDxMaWNlbnNlSW5zdHJ1Y3Rpb25zPmh0dHBzOi8vcHVyY2hhc2UuYXNwb3NlLmNvbS9wb2xpY2llcy91c2UtbGljZW5zZTwvTGljZW5zZUluc3RydWN0aW9ucz4KICA8L0RhdGE+CiAgPFNpZ25hdHVyZT53UGJtNUt3ZTYvRFZXWFNIY1o4d2FiVEFQQXlSR0pEOGI3L00zVkV4YWZpQnd5U2h3YWtrNGI5N2c2eGtnTjhtbUFGY3J0c0cwd1ZDcnp6MytVYk9iQjRYUndTZWxsTFdXeXNDL0haTDNpN01SMC9jZUFxaVZFOU0rWndOQkR4RnlRbE9uYTFQajhQMzhzR1grQ3ZsemJLZFZPZXk1S3A2dDN5c0dqYWtaL1E9PC9TaWduYXR1cmU+CjwvTGljZW5zZT4=";   
    //        new License().SetLicense(new MemoryStream(Convert.FromBase64String(key)));
    //    }

    //    /// <summary>
    //    /// 获取配置文件对象
    //    /// </summary>
    //    /// <typeparam name="TEntity">实体类型</typeparam>
    //    /// <param name="json">Json配置字符串</param>
    //    /// <returns>配置信息</returns>
    //    private static ImportExcelConfig GetConfig<TEntity>(string json)
    //    {
    //        if (!string.IsNullOrEmpty(json))
    //        {
    //            return JsonConvert.DeserializeObject<ImportExcelConfig>(json);
    //        }
    //        else
    //        {
    //            ImportExcelConfig result = new ImportExcelConfig()
    //            {
    //                TableSchema = "dbo",
    //                TableName = typeof(TEntity).Name
    //            };
    //            return result;
    //        }
    //    }

    //    /// <summary>
    //    /// 读取Excel文件数据到DataTable对象
    //    /// </summary>
    //    /// <param name="file">导入的Excel文件</param>
    //    /// <returns>DataTable数据</returns>
    //    public static DataTable ReadExcelToTable(string file)
    //    {
    //        TxtLoadOptions option = new TxtLoadOptions() { Encoding = Encoding.Default };
    //        Workbook wb = new Workbook(file, option);
    //        Worksheet sheet = wb.Worksheets[0];
    //        var data = sheet.Cells.ExportDataTableAsString(0, 0, sheet.Cells.MaxDataRow + 1, sheet.Cells.MaxDataColumn + 1);

    //        return data;
    //    }

    //    /// <summary>
    //    /// 导入的Excel数据转实体类列表
    //    /// </summary>
    //    /// <typeparam name="TEntity">实体类型</typeparam>
    //    /// <param name="config_json">Json配置</param>
    //    /// <param name="file">导入的Excel文件</param>
    //    /// <param name="fun_dealwith_excelTable">对导入Excel文件解析出来的<see cref="DataTable"/>处理</param>
    //    /// <param name="fun_config">导入配置</param>
    //    /// <param name="fun_dealwith">对数据进行处理(可补全属性值)</param>
    //    /// <returns>结果数据集合</returns>
    //    public static List<TEntity> ImportToEntitys<TEntity>(string config_json, string file, Action<DataTable> fun_dealwith_excelTable, Action<ImportExcelConfig> fun_config, Action<TEntity> fun_dealwith)
    //        where TEntity : class, new()
    //    {
    //        return ImportToEntitys(config_json, file, fun_dealwith_excelTable, fun_config, fun_dealwith, i => true);
    //    }

    //    /// <summary>
    //    /// 导入的Excel数据转实体类列表
    //    /// </summary>
    //    /// <typeparam name="TEntity">实体类型</typeparam>
    //    /// <param name="config_json">Json配置</param>
    //    /// <param name="file">导入的Excel文件</param>
    //    /// <param name="fun_dealwith_excelTable">对导入Excel文件解析出来的<see cref="DataTable"/>处理</param>
    //    /// <param name="fun_config">导入配置</param>
    //    /// <returns>结果数据集合</returns>
    //    public static List<TEntity> ImportToEntitys<TEntity>(string config_json, string file, Action<DataTable> fun_dealwith_excelTable, Action<ImportExcelConfig> fun_config)
    //        where TEntity : class, new()
    //    {
    //        return ImportToEntitys<TEntity>(config_json, file, fun_dealwith_excelTable, fun_config, i => { }, i => true);
    //    }

    //    ///// <summary>
    //    ///// 导入的Excel数据转实体类列表
    //    ///// </summary>
    //    ///// <typeparam name="TEntity">实体类型</typeparam>
    //    ///// <param name="config_json">Json配置</param>
    //    ///// <param name="file">导入的Excel文件</param>
    //    ///// <param name="fun_dealwith_excelTable">对导入Excel文件解析出来的<see cref="DataTable"/>处理</param>
    //    ///// <param name="fun_dealwith">对数据进行处理(可补全属性值)</param>
    //    ///// <returns>结果数据集合</returns>
    //    //public static List<TEntity> ImportToEntitys<TEntity>(string config_json, string file, Action<DataTable> fun_dealwith_excelTable, Action<TEntity> fun_dealwith)
    //    //    where TEntity : class, new()
    //    //{
    //    //    return ImportToEntitys(config_json, file,fun_dealwith_excelTable, i => { }, fun_dealwith, i => true);
    //    //}

    //    /// <summary>
    //    /// 导入的Excel数据转实体类列表
    //    /// </summary>
    //    /// <typeparam name="TEntity">实体类型</typeparam>
    //    /// <param name="config_json">Json配置</param>
    //    /// <param name="file">导入的Excel文件</param>
    //    /// <param name="fun_dealwith_excelTable">对导入Excel文件解析出来的<see cref="DataTable"/>处理</param>
    //    /// <param name="fun_config">导入配置</param>
    //    /// <param name="fun_dealwith">对数据进行处理(可补全属性值)</param>
    //    /// <param name="filter">过滤数据</param>
    //    /// <returns>结果数据集合</returns>
    //    public static List<TEntity> ImportToEntitys<TEntity>(string config_json, string file, Action<DataTable> fun_dealwith_excelTable, Action<ImportExcelConfig> fun_config, Action<TEntity> fun_dealwith, Func<TEntity, bool> filter)
    //        where TEntity : class, new()
    //    {
    //        // Excel文件读取的Table数据
    //        var excel_table = ReadExcelToTable(file);

    //        //处理Excel读取的数据
    //        fun_dealwith_excelTable(excel_table);

    //        // 导入Excel数据 配置文件
    //        ImportExcelConfig config = GetConfig<TEntity>(config_json);
    //        fun_config(config);
    //        config.FieldMappers = config.FieldMappers.Where(i => !string.IsNullOrWhiteSpace(i.ExcelColumnName)).Where(i => !string.IsNullOrWhiteSpace(i.TableFieldName)).Where(i => !i.IsIgnore).ToList();

    //        // 关联信息
    //        // DataColumn : excel_table 中的数据列
    //        // ImportExcelConfig.FieldMapper : config 配置文件中的映射关系
    //        // PropertyInfo : TEntity 实体类中的属性
    //        var relatedInfos = new List<Tuple<DataColumn, ImportExcelConfig.FieldMapper, PropertyInfo>>();

    //        // Excel文件读取的Table数据字典（列名，列信息）
    //        var exceltable_columnname_datacolumn = new List<Tuple<string, DataColumn>>();
    //        // 首行为表头
    //        var firstRow_header = excel_table.Rows[0];
    //        foreach (DataColumn col in excel_table.Columns)
    //        {
    //            if (!string.IsNullOrWhiteSpace(firstRow_header[col.ColumnName].ToString()))
    //            {
    //                exceltable_columnname_datacolumn.Add(new Tuple<string, DataColumn>(firstRow_header[col.ColumnName].ToString().Trim(), col));
    //            }
    //        }

    //        // config配置文件中表列名数据字典（表列名，字段映射信息）
    //        Dictionary<string, ImportExcelConfig.FieldMapper> dic_config_tablefieldname_fieldmapper = new Dictionary<string, ImportExcelConfig.FieldMapper>();
    //        config.FieldMappers.ForEach(fieldMapper =>
    //        {
    //            if ((!string.IsNullOrWhiteSpace(fieldMapper.TableFieldName)) && (!dic_config_tablefieldname_fieldmapper.Keys.Contains(fieldMapper.TableFieldName)))
    //            {
    //                dic_config_tablefieldname_fieldmapper.Add(fieldMapper.TableFieldName.Trim(), fieldMapper);
    //            }
    //        });

    //        // 遍历实体类属性
    //        typeof(TEntity).GetProperties(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)
    //            .ToList().ForEach(attrInfo =>
    //            {
    //                if (dic_config_tablefieldname_fieldmapper.Keys.Contains(attrInfo.Name))
    //                {
    //                    var fieldMapper = dic_config_tablefieldname_fieldmapper[attrInfo.Name];
    //                    var excelDataColumn = exceltable_columnname_datacolumn.FirstOrDefault(i => i.Item1.Equals(fieldMapper.ExcelColumnName));
    //                    if (excelDataColumn != null)
    //                    {
    //                        relatedInfos.Add(new Tuple<DataColumn, ImportExcelConfig.FieldMapper, PropertyInfo>(excelDataColumn.Item2, fieldMapper, attrInfo));
    //                    }
    //                }
    //            });

    //        List<TEntity> list = new List<TEntity>();
    //        foreach (DataRow row in excel_table.Rows)
    //        {
    //            if (row.Equals(firstRow_header))
    //            {
    //                continue;
    //            }

    //            var item = new TEntity();
    //            var val = string.Empty;

    //            relatedInfos.ForEach(relatedInfo =>
    //                            {
    //                                val = row[relatedInfo.Item1].ToString();

    //                                if (string.IsNullOrWhiteSpace(val) && (!string.IsNullOrWhiteSpace(relatedInfo.Item2.DefaultValue)))
    //                                {
    //                                    val = relatedInfo.Item2.DefaultValue.Trim();
    //                                }

    //                                if (relatedInfo.Item2.Format.Formats.Count > 0)
    //                                {
    //                                    if (relatedInfo.Item2.Format.Formats.ContainsKey(val))
    //                                    {
    //                                        val = relatedInfo.Item2.Format.Formats[val];
    //                                    }
    //                                    else
    //                                    {
    //                                        val = relatedInfo.Item2.Format.OtherValue;
    //                                    }
    //                                }

    //                                Type targetType = relatedInfo.Item3.PropertyType;
    //                                if (targetType.IsGenericType && targetType.GetGenericTypeDefinition() == typeof(Nullable<>))
    //                                {
    //                                    if (string.IsNullOrEmpty(val))
    //                                    {
    //                                        relatedInfo.Item3.SetValue(item, null, null);
    //                                    }
    //                                    else
    //                                    {
    //                                        relatedInfo.Item3.SetValue(item, Convert.ChangeType(val, targetType.GetGenericArguments().First()), null);
    //                                    }
    //                                }
    //                                else
    //                                {
    //                                    relatedInfo.Item3.SetValue(item, Convert.ChangeType(val, relatedInfo.Item3.PropertyType), null);
    //                                }
    //                            });

    //            fun_dealwith(item);
    //            list.Add(item);
    //        }

    //        return list.Where(filter).ToList();
    //    }

    //    /// <summary>
    //    /// 导入或导出Excel配置信息
    //    /// </summary>
    //    public class ImportExcelConfig
    //    {
    //        /// <summary>
    //        /// 模式
    //        /// </summary>
    //        public string TableSchema { get; set; }

    //        /// <summary>
    //        /// 表名
    //        /// </summary>
    //        public string TableName { get; set; }

    //        /// <summary>
    //        /// 字段映射列表
    //        /// </summary>
    //        public List<FieldMapper> FieldMappers { get; set; } = new List<FieldMapper>();

    //        /// <summary>
    //        /// 字段映射类
    //        /// </summary>
    //        public class FieldMapper
    //        {
    //            /// <summary>
    //            /// 构造函数
    //            /// </summary>
    //            public FieldMapper()
    //            {
    //            }

    //            /// <summary>
    //            /// 构造函数
    //            /// </summary>
    //            /// <param name="_ExcelColumnName">Excel文档中的列名</param>
    //            /// <param name="_TableFieldName">数据表中的字段名</param>
    //            public FieldMapper(string _ExcelColumnName, string _TableFieldName) : this(_ExcelColumnName, _TableFieldName, string.Empty)
    //            {
    //            }

    //            /// <summary>
    //            /// 构造函数
    //            /// </summary>
    //            /// <param name="_ExcelColumnName">Excel文档中的列名</param>
    //            /// <param name="_TableFieldName">数据表中的字段名</param>
    //            /// <param name="_DefaultValue">默认值
    //            /// <para>显式值为空或者类型转换出错时将由此值代替</para>
    //            /// </param>
    //            public FieldMapper(string _ExcelColumnName, string _TableFieldName, string _DefaultValue)
    //            {
    //                ExcelColumnName = _ExcelColumnName;
    //                TableFieldName = _TableFieldName;
    //                DefaultValue = _DefaultValue;
    //            }

    //            /// <summary>
    //            /// Excel文档中的列名
    //            /// </summary>
    //            public string ExcelColumnName { get; set; }

    //            /// <summary>
    //            /// 数据表中的字段名
    //            /// </summary>
    //            public string TableFieldName { get; set; }

    //            /// <summary>
    //            /// 是否忽略
    //            /// <para>默认 false 不忽略</para>
    //            /// </summary>
    //            public bool IsIgnore { get; set; } = false;

    //            /// <summary>
    //            /// 是否移除值为空的项（整行数据）
    //            /// <para>默认 false 不移除</para>
    //            /// </summary>
    //            public bool IsRemoveEmptyItem { get; set; } = false;

    //            /// <summary>
    //            /// 格式化
    //            /// <para>例：Excel中的某列显式值为是、否，在映射后需要转换为true、false或1、0</para>
    //            /// </summary>
    //            public CustomFormat Format { get; set; } = new CustomFormat();

    //            /// <summary>
    //            /// 默认值
    //            /// <para>显式值为空或者类型转换出错时将由此值代替</para>
    //            /// </summary>
    //            public string DefaultValue { get; set; }

    //            /// <summary>
    //            /// 自定义格式化类
    //            /// </summary>
    //            public class CustomFormat
    //            {
    //                /// <summary>
    //                /// 格式化字典
    //                /// </summary>
    //                public Dictionary<string, string> Formats { get; set; } = new Dictionary<string, string>();

    //                /// <summary>
    //                /// 除字典外的默认值
    //                /// </summary>
    //                public string OtherValue { get; set; }
    //            }
    //        }
    //    }
    //}
}
