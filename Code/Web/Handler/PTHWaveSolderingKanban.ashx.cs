using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Web.AppCode.Utility;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// PTHWaveSolderingKanban 的摘要说明
    /// </summary>
    public class PTHWaveSolderingKanban : IHttpHandler
    {
        int lineId = -1;

        public void ProcessRequest(HttpContext context)
        {
            SqlInjectableHelper.Validation(context);

            context.Response.ContentType = "text/plain";
            string type = context.Request["Type"];
            if (type == "GetPTHWaveSolderingKanban")
            {
                GetPTHWaveSolderingKanbanInfo(context);
            }
            else if (type == "AddPTHWaveSolderingKanbanData")
            {
                lineId = Convert.ToInt32(context.Request["LineId"]);
                //读取文件数据
                //var flag1 = GetFileDataPTH(@"D:\年利亚\PTH\logdir", @"D:\年利亚\PTH\stadir");
                //context.Response.Write(flag1 ? "OK" : "NG");
            }
            context.Response.Flush();
            context.Response.End();
        }

        /// <summary>
        /// PTH波峰焊实时看板
        /// </summary>
        /// <param name="context"></param>
        private void GetPTHWaveSolderingKanbanInfo(HttpContext context)
        {
            string lineId = context.Request["LineId"];
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@LineId",SqlDbType.Int)

            };
            parms[0].Value = lineId;
            var dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetPTHWaveSolderingKanbanInfo", parms);
            //序列化
            string jsonStr = JsonConvert.SerializeObject(dt);
            context.Response.Write(jsonStr);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        #region 读取PTH波峰焊文件数据

        readonly string module = "PTH波峰焊实时看板";

        /// <summary>
        /// 获取PTH波峰焊看板数据
        /// </summary>
        private bool GetFileDataPTH(string sourceLogDir, string sourceDataDir)
        {
            var arrLogFiles = Directory.GetFiles(sourceLogDir, "*.log");

            DataTable dtLog = null;//Log文件数据（为了取产品编码）
            DataTable dtData = null;//实际数据
            var completeList = GetPTHCompleteFile(lineId);//已经读取完成的文件
            //遍历文件
            foreach (var item in arrLogFiles)
            {
                string fileName = Path.GetFileName(item);//文件名称
                string dataPath = string.Format("{0}\\{1}.sta", sourceDataDir, Path.GetFileNameWithoutExtension(item));//数据文件路径
                if (completeList != null && completeList.Count > 0)
                {
                    //如果文件已经读取，则不需要再次写入数据
                    bool isComplete = completeList.Any(p => p.LineId == lineId && string.Equals(p.FileName, fileName, StringComparison.CurrentCultureIgnoreCase));
                    if (isComplete)
                    {
                        //移动日志文件
                        MoveFile(item, sourceLogDir);
                        //移动数据文件
                        if (File.Exists(dataPath))
                        {
                            MoveFile(dataPath, sourceDataDir);
                        }
                        continue;
                    }
                }
                //读取log文件数据
                dtLog = ReadPTHLogFileToTable(item);
                if (dtLog == null)
                {
                    continue;
                }
                //判断数据文件是否存在，存在则读取数据文件
                if (File.Exists(dataPath))
                {
                    dtData = ReadPTHDataFileToTable(dataPath);
                }

                if (dtLog != null && dtLog.Rows.Count > 0 && dtData != null && dtData.Rows.Count > 0)
                {
                    DateTime data = Convert.ToDateTime(dtData.Rows[0]["DateTime"]);
                    //将日志转为List集合
                    var listLog = dtLog.AsEnumerable().Select(p => new
                    {
                        DateTime = Convert.ToDateTime(string.Format("{0}-{1}-{2} {3}", data.Year, data.Month, data.Day, p.Field<string>("Time"))),
                        Detail = p.Field<string>("Detail")
                    });

                    StringBuilder sbSql = new StringBuilder();
                    var guid = System.Guid.NewGuid().ToString("N").ToUpper();
                    //遍历数据
                    foreach (DataRow drData in dtData.Rows)
                    {
                        //获取产品编码
                        DateTime time = Convert.ToDateTime(drData["DateTime"]);
                        var logItem = listLog.Where(p => p.DateTime <= time).OrderByDescending(p => p.DateTime).FirstOrDefault();
                        if (logItem == null)
                        {
                            InsertSystemErrorLog(module, string.Format("未获取到日志文件日期信息，文件名称：{0}，产线Id：{1}", item, lineId));
                            break;
                        }
                        var detail = logItem.Detail;
                        var itemCode = detail.Substring(0, detail.LastIndexOf(".job"));
                        itemCode = itemCode.Substring(detail.LastIndexOf(@"\") + 1);
                        var leadFlag = itemCode.Contains("-R") ? 0 : 1;//有铅无铅标识 若产品编码有-R的为无铅，-N或无-R的为有铅
                        itemCode = itemCode.Replace("-R", string.Empty).Replace("-N", string.Empty);

                        //获取实际最大温差
                        int[] arrDiff = {
                           string.Equals(drData["PreheatAreaStatus1B"].ToString(),"恒温工作") ? Convert.ToInt32(drData["PreheatAreaActual1B"]) - Convert.ToInt32(drData["PreheatAreaSet1B"]) : 0,
                            string.Equals(drData["PreheatAreaStatus2B"].ToString(), "恒温工作") ? Convert.ToInt32(drData["PreheatAreaActual2B"]) - Convert.ToInt32(drData["PreheatAreaSet2B"]): 0,
                            string.Equals(drData["PreheatAreaStatus3B"].ToString(), "恒温工作") ? Convert.ToInt32(drData["PreheatAreaActual3B"]) - Convert.ToInt32(drData["PreheatAreaSet3B"]): 0,
                            string.Equals(drData["SprayAreaStatusB"].ToString(), "恒温工作") ? Convert.ToInt32(drData["SprayAreaActualB"]) - Convert.ToInt32(drData["SprayAreaSetB"]): 0,
                            string.Equals(drData["PreheatAreaStatus1T"].ToString(), "恒温工作") ? Convert.ToInt32(drData["PreheatAreaActual1T"]) - Convert.ToInt32(drData["PreheatAreaSet1T"]): 0,
                            string.Equals(drData["PreheatAreaStatus2T"].ToString(), "恒温工作") ? Convert.ToInt32(drData["PreheatAreaActual2T"]) - Convert.ToInt32(drData["PreheatAreaSet2T"]): 0,
                            string.Equals(drData["PreheatAreaStatus3T"].ToString(), "恒温工作") ? Convert.ToInt32(drData["PreheatAreaActual3T"]) - Convert.ToInt32(drData["PreheatAreaSet3T"]): 0,
                            string.Equals(drData["SprayAreaStatusT"].ToString(), "恒温工作") ? Convert.ToInt32(drData["SprayAreaActualT"]) - Convert.ToInt32(drData["SprayAreaSetT"]): 0,
                            string.Equals(drData["TinFurnaceStatus"].ToString(), "恒温工作") ? Convert.ToInt32(drData["TinFurnaceActual"]) - Convert.ToInt32(drData["TinFurnaceSet"]): 0
                        };
                        var max = arrDiff.Max();
                        var min = arrDiff.Min();
                        var actualMaxTemperature = Math.Abs(max) > Math.Abs(min) ? max : min;

                        //将数据保存到数据库                       
                        sbSql.AppendFormat("{0} SELECT '{1}',{2},'{3}','{4}','{5}','{6}','{7}',{8},{9},{10},{11},{12},{13},{14},{15},{16},'{17}',{18},{19},'{20}',{21},{22},'{23}',{24},{25},'{26}',{27},{28},'{29}',{30},{31},'{32}',{33},{34},'{35}',{36},{37},'{38}',{39},{40},'{41}',{42}",
                            sbSql.Length <= 0 ? string.Empty : " UNION ALL",
                            guid,
                            lineId, //LineId
                            fileName,//FileNameLog,
                            Path.GetFileName(dataPath),   //FileNameData,
                            Convert.ToDateTime(drData["DateTime"]),//DateTime,
                            itemCode,                              //ItemCode,
                            drData["StoveType"].ToString(), //StoveType,
                            leadFlag,//LeadFlag 
                            Convert.ToInt32(drData["SetSpeed"]),//SetSpeed 
                            Convert.ToInt32(drData["ActualSpeed"]),//ActualSpeed 
                            Convert.ToDecimal(drData["PeakSet1"]),//PeakSet1 
                            Convert.ToDecimal(drData["PeakActual1"]),//PeakActual1 
                            Convert.ToDecimal(drData["PeakSet2"]),//PeakSet2 
                            Convert.ToDecimal(drData["PeakActual2"]),//PeakActual2 
                            Convert.ToInt32(drData["TinFurnaceSet"]),//TinFurnaceSet 
                            Convert.ToInt32(drData["TinFurnaceActual"]),//TinFurnaceActual 
                            drData["TinFurnaceStatus"].ToString(),//TinFurnaceStatus 
                            Convert.ToInt32(drData["PreheatAreaSet1B"]),//PreheatAreaSet1B 
                            Convert.ToInt32(drData["PreheatAreaActual1B"]),//PreheatAreaActual1B 
                            drData["PreheatAreaStatus1B"].ToString(),//PreheatAreaStatus1B 
                            Convert.ToInt32(drData["PreheatAreaSet2B"]),//PreheatAreaSet2B 
                            Convert.ToInt32(drData["PreheatAreaActual2B"]),//PreheatAreaActual2B 
                            drData["PreheatAreaStatus2B"].ToString(),//PreheatAreaStatus2B 
                            Convert.ToInt32(drData["PreheatAreaSet3B"]),//PreheatAreaSet3B 
                            Convert.ToInt32(drData["PreheatAreaActual3B"]),//PreheatAreaActual3B 
                            drData["PreheatAreaStatus3B"].ToString(),//PreheatAreaStatus3B 
                            Convert.ToInt32(drData["SprayAreaSetB"]),//SprayAreaSetB 
                            Convert.ToInt32(drData["SprayAreaActualB"]),//SprayAreaActualB 
                            drData["SprayAreaStatusB"].ToString(),//SprayAreaStatusB 
                            Convert.ToInt32(drData["PreheatAreaSet1T"]),//PreheatAreaSet1T 
                            Convert.ToInt32(drData["PreheatAreaActual1T"]),//PreheatAreaActual1T 
                            drData["PreheatAreaStatus1T"].ToString(),//PreheatAreaStatus1T 
                            Convert.ToInt32(drData["PreheatAreaSet2T"]),//PreheatAreaSet2T 
                            Convert.ToInt32(drData["PreheatAreaActual2T"]),//PreheatAreaActual2T 
                            drData["PreheatAreaStatus2T"].ToString(),//PreheatAreaStatus2T 
                            Convert.ToInt32(drData["PreheatAreaSet3T"]),//PreheatAreaSet3T 
                            Convert.ToInt32(drData["PreheatAreaActual3T"]),//PreheatAreaActual3T 
                            drData["PreheatAreaStatus3T"].ToString(),//PreheatAreaStatus3T 
                            Convert.ToInt32(drData["SprayAreaSetT"]),//SprayAreaSetT 
                            Convert.ToInt32(drData["SprayAreaActualT"]),//SprayAreaActualT 
                            drData["SprayAreaStatusT"].ToString(),//SprayAreaStatusT
                            actualMaxTemperature
                        ).AppendLine();
                    }

                    #region 保存数据
                    try
                    {
                        if (sbSql.Length > 0)
                        {
                            SqlParameter[] prams = new SqlParameter[]
                            {
                                new SqlParameter("@Guid", SqlDbType.VarChar, 40) { Value=guid },
                                new SqlParameter("@Sql", SqlDbType.NVarChar, -1) { Value=sbSql.ToString()}
                            };
                            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAddPTHWaveSolderingKanbanInfo", prams);
                        }
                    }
                    catch (Exception ex)
                    {
                        //记录错误日志
                        InsertSystemErrorLog(module, string.Format("保存数据失败，文件名称：{0}，产线Id：{1}", fileName, lineId), ex);
                        return false;
                    }
                    #endregion
                }
            }
            return true;
        }


        /// <summary>
        /// 读取txt数据
        /// </summary>
        /// <param name="filePath"></param>
        /// <returns></returns>
        private DataTable ReadPTHLogFileToTable(string filePath)
        {
            //文件路径和文件名
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[]
            {
                new DataColumn("Time",typeof(string)),
                new DataColumn("UserName",typeof(string)),
                new DataColumn("Info",typeof(string)),
                new DataColumn("Detail",typeof(string)),
            });
            DataRow dr;
            try
            {
                using (StreamReader reader = new StreamReader(filePath, Encoding.Default))
                {
                    string line;
                    string[] arr;
                    while (reader.EndOfStream == false)
                    {
                        line = reader.ReadLine();
                        line = line.Replace("        ", "      ").Replace("      ", "	");//先把8个空格字符替换成6个空格字符，再将6个空格字符替换成'	'字符
                        arr = line.Split('	');//列之间的分隔符

                        //只读取有产品编码的行
                        if (arr.Length >= 4 && arr[3].StartsWith("进入操作模式并加载处方文件"))
                        {
                            dr = dt.NewRow();
                            for (int i = 0; i < 4; i++)
                            {
                                if (arr.Length > i)
                                {
                                    dr[i] = arr[i].Trim();
                                }
                            }
                            dt.Rows.Add(dr);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //记录错误日志
                InsertSystemErrorLog(module, string.Concat("读取文件失败，文件名称：", Path.GetFileName(filePath)), ex);
            }
            return dt;
        }


        /// <summary>
        /// 读取txt数据
        /// </summary>
        /// <param name="filePath"></param>
        /// <returns></returns>
        private DataTable ReadPTHDataFileToTable(string filePath)
        {
            //文件路径和文件名
            DataTable dt = new DataTable();
            //添加列
            dt.Columns.Add("DateTime", typeof(DateTime));//时间
            dt.Columns.Add("StoveType", typeof(string));//锡炉类型
            dt.Columns.Add("SetSpeed", typeof(int));//设定运输速度
            dt.Columns.Add("ActualSpeed", typeof(int));//实际运输速度
            //循环创建波峰设定参数、实际参数
            for (int i = 1; i <= 2; i++)
            {
                dt.Columns.Add("PeakSet" + i.ToString(), typeof(decimal));//波峰N设定参数
                dt.Columns.Add("PeakActual" + i.ToString(), typeof(decimal));//波峰N实际参数
            }
            dt.Columns.Add("TinFurnaceSet", typeof(int));//锡炉设定值
            dt.Columns.Add("TinFurnaceActual", typeof(int));//锡炉实际值
            dt.Columns.Add("TinFurnaceStatus", typeof(string));//锡炉状态
            //循环创建预热区'N'B设定值、预热区'N'B实际值、预热区'N'B状态
            for (int i = 1; i <= 3; i++)
            {
                dt.Columns.Add(string.Format("PreheatAreaSet{0}B", i.ToString()), typeof(int));//预热区'N'B设定值
                dt.Columns.Add(string.Format("PreheatAreaActual{0}B", i.ToString()), typeof(int));//预热区'N'B实际值
                dt.Columns.Add(string.Format("PreheatAreaStatus{0}B", i.ToString()), typeof(string));//预热区'N'B状态
            }
            dt.Columns.Add("SprayAreaSetB", typeof(int));//喷雾区B设定值
            dt.Columns.Add("SprayAreaActualB", typeof(int));//喷雾区B实际值
            dt.Columns.Add("SprayAreaStatusB", typeof(string));//喷雾区B状态
            //循环创建预热区'N'T设定值、预热区'N'T实际值、预热区'N'T状态
            for (int i = 1; i <= 3; i++)
            {
                dt.Columns.Add(string.Format("PreheatAreaSet{0}T", i.ToString()), typeof(int));//预热区'N'T设定值
                dt.Columns.Add(string.Format("PreheatAreaActual{0}T", i.ToString()), typeof(int));//预热区'N'T实际值
                dt.Columns.Add(string.Format("PreheatAreaStatus{0}T", i.ToString()), typeof(string));//预热区'N'T状态
            }
            dt.Columns.Add("SprayAreaSetT", typeof(int));//喷雾区T设定值
            dt.Columns.Add("SprayAreaActualT", typeof(int));//喷雾区T实际值
            dt.Columns.Add("SprayAreaStatusT", typeof(string));//喷雾区T状态
            int index = 0;
            DataRow dr = null;
            try
            {
                using (StreamReader reader = new StreamReader(filePath, Encoding.Default))
                {
                    //是否为第一行（如果HeadYes为TRUE，则第一行为标题行）
                    string line;

                    while (reader.EndOfStream == false)
                    {
                        line = reader.ReadLine();
                        index++;
                        if (line.StartsWith("日期:"))
                        {
                            dr = dt.NewRow();
                            line = line.Replace(" ", string.Empty).Replace("日期:", string.Empty);
                            string date = line.Substring(0, line.IndexOf("时间:"));
                            string time = line.Substring(line.IndexOf("时间:") + "时间:".Length);
                            dr["DateTime"] = Convert.ToDateTime(string.Format("{0} {1}", date, time));
                        }
                        else if (line.StartsWith("锡炉类型:"))
                        {
                            dr["StoveType"] = line.Substring(line.IndexOf(",") + 1).Replace(" ", string.Empty);
                        }
                        else if (line.StartsWith("运输速度:"))
                        {
                            line = line.Substring("运输速度:".Length).Replace(" ", string.Empty);
                            var arr = line.Split(',');
                            dr["SetSpeed"] = Convert.ToInt32(arr[1].Replace("实际速度", string.Empty));
                            dr["ActualSpeed"] = string.Equals(arr[2], "未启动") ? -1 : Convert.ToInt32(arr[2]);
                        }
                        else if (line.StartsWith("导轨宽度: "))
                        {
                            continue;
                        }
                        else if (line.StartsWith("波峰"))
                        {
                            var idx = Convert.ToInt32(line.Substring("波峰".Length, 1));
                            line = line.Substring(string.Format("波峰{0}:", idx.ToString()).Length);
                            var arr = line.Replace(" ", string.Empty).Split(',');
                            dr[string.Concat("PeakSet", idx.ToString())] = Convert.ToDecimal(arr[1].Replace("状态", string.Empty).Replace("实际高度", string.Empty));//设定值
                            dr[string.Concat("PeakActual", idx.ToString())] = string.Equals(arr[2], "未启动") ? -1 : Convert.ToDecimal(arr[2]);//实际值
                        }
                        else if (line.StartsWith("温区名:"))
                        {
                            line = line.Substring("温区名:".Length);
                            var arr = line.Replace(" ", string.Empty).Split(',');
                            arr[1] = arr[1].Replace("实际值", string.Empty);//预热区'N'设定值
                            arr[2] = arr[2].Replace("温区状态", string.Empty);//预热区'N'实际值
                            switch (arr[0])
                            {
                                case "预热区1B设定值": dr["PreheatAreaSet1B"] = arr[1]; dr["PreheatAreaActual1B"] = arr[2]; dr["PreheatAreaStatus1B"] = arr[3]; break;
                                case "预热区2B设定值": dr["PreheatAreaSet2B"] = arr[1]; dr["PreheatAreaActual2B"] = arr[2]; dr["PreheatAreaStatus2B"] = arr[3]; break;
                                case "预热区3B设定值": dr["PreheatAreaSet3B"] = arr[1]; dr["PreheatAreaActual3B"] = arr[2]; dr["PreheatAreaStatus3B"] = arr[3]; break;
                                case "喷雾区B设定值": dr["SprayAreaSetB"] = arr[1]; dr["SprayAreaActualB"] = arr[2]; dr["SprayAreaStatusB"] = arr[3]; break;
                                case "预热区1T设定值": dr["PreheatAreaSet1T"] = arr[1]; dr["PreheatAreaActual1T"] = arr[2]; dr["PreheatAreaStatus1T"] = arr[3]; break;
                                case "预热区2T设定值": dr["PreheatAreaSet2T"] = arr[1]; dr["PreheatAreaActual2T"] = arr[2]; dr["PreheatAreaStatus2T"] = arr[3]; break;
                                case "预热区3T设定值": dr["PreheatAreaSet3T"] = arr[1]; dr["PreheatAreaActual3T"] = arr[2]; dr["PreheatAreaStatus3T"] = arr[3]; break;
                                case "喷雾区T设定值": dr["SprayAreaSetT"] = arr[1]; dr["SprayAreaActualT"] = arr[2]; dr["SprayAreaStatusT"] = arr[3]; break;
                                case "锡炉设定值": dr["TinFurnaceSet"] = arr[1]; dr["TinFurnaceActual"] = arr[2]; dr["TinFurnaceStatus"] = arr[3]; dt.Rows.Add(dr); break;//此时，需要将行添加到DataTable中
                            }
                        }
                        else
                        {
                            continue;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                //记录错误日志
                InsertSystemErrorLog(module, string.Concat("读取文件失败，文件名称：", Path.GetFileName(filePath)), ex);
            }
            return dt;
        }


        /// <summary>
        /// 根据产线Id获取已写入数据库的SMT文件信息
        /// </summary>
        /// <param name="lineId"></param>
        /// <returns></returns>
        private IList<PTHWaveSolderingCompleteFileInfo> GetPTHCompleteFile(int lineId)
        {
            List<PTHWaveSolderingCompleteFileInfo> list = null;
            try
            {
                SqlParameter[] prams = new SqlParameter[]
                    {
                        new SqlParameter("@LineId", SqlDbType.Int) { Value=lineId }
                    };
                string sql = "SELECT LineId,FileName FROM dbo.Prod_PTHWaveSolderingCompleteFile WHERE LineId = @LineId";
                list = ComMethod.GetListBySql<PTHWaveSolderingCompleteFileInfo>(sql, prams, SQLHelper.MESConnString);
            }
            catch (Exception ex)
            {
                //记录错误日志
                InsertSystemErrorLog(module, string.Format("获取产线Id{0}已写入文件信息失败", lineId.ToString()), ex);
            }
            return list;
        }

        #endregion

        /// <summary>
        /// 移动文件
        /// </summary>
        /// <param name="sourceFileName"></param>
        /// <param name="sourceDir"></param>
        private void MoveFile(string sourceFileName, string sourceDir)
        {
            try
            {
                string targetDir = string.Concat(sourceDir, "\\ReadComple");
                if (!Directory.Exists(targetDir))
                {
                    Directory.CreateDirectory(targetDir);
                }
                File.Move(sourceFileName, string.Concat(targetDir, "\\", Path.GetFileName(sourceFileName)));
            }
            catch (Exception ex)
            {
                //记录错误日志
                InsertSystemErrorLog(module, string.Format("移动文件【{0}】失败", sourceFileName), ex);
            }
        }

        /// <summary>
        /// 系统错误信息插入
        /// </summary>
        /// <param name="moudle"></param>
        /// <param name="msg"></param>
        /// <param name="ex"></param>
        private void InsertSystemErrorLog(string moudle, string msg, Exception ex = null)
        {
            string errorMsg = string.Empty;
            if (ex != null)
            {
                errorMsg = string.Format("{0}；错误信息：{1}{2}，详细信息：{3}", msg, ex.Message, ex.InnerException == null ? string.Empty : ex.InnerException.Message, ex.StackTrace);
            }
            else
            {
                errorMsg = msg;
            }

            if (errorMsg.Length > 500)
            {
                errorMsg = errorMsg.Substring(0, 500);
            }
            var cmdTxt = @" INSERT INTO [dbo].[SYS_SystemErrorLog](UserName,CreateDateTime,ErrorMsg,Remark)
                         VALUES('admin',GETDATE(),@ErrorMsg,@Remark)";
            SqlParameter[] parms = new SqlParameter[] {
                    new SqlParameter("@ErrorMsg",SqlDbType.NVarChar,500),
                    new SqlParameter("@Remark",SqlDbType.NVarChar,500)
                };
            parms[0].Value = errorMsg;
            parms[1].Value = moudle;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, cmdTxt, parms);
        }
    }

    /// <summary>
    /// PTH波峰焊数据文件实体
    /// </summary>
    public class PTHWaveSolderingLog
    {
        public DateTime DateTime { get; set; }

        public string UserName { get; set; }

        public string Info { get; set; }

        public string Detail { get; set; }
    }

    /// <summary>
    /// PTH波峰焊已完成读取文件实体
    /// </summary>
    public class PTHWaveSolderingCompleteFileInfo
    {
        public int Id { get; set; }
        /// <summary>
        /// 产线Id
        /// </summary>
        public int LineId { get; set; }
        /// <summary>
        /// 文件名称
        /// </summary>
        public string FileName { get; set; }
    }
}