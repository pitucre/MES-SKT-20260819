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
using System.Web.SessionState;

namespace SKT.LeanMES.Web.Handler
{
    /// <summary>
    /// SMTRefluxFurnaceKanban 的摘要说明
    /// </summary>
    public class SMTRefluxFurnaceKanban : IHttpHandler, IRequiresSessionState
    {
        int lineId = -1;

        public void ProcessRequest(HttpContext context)
        {
            var userInfo = AccountController.GetCurrentUser();
            SqlInjectableHelper.Validation(context);

            context.Response.ContentType = "text/plain";
            string type = context.Request["Type"];
            if (type == "GetSMTRefluxFurnaceKanban")
            {
                GetSMTRefluxFurnaceKanbanInfo(context);
            }
            else if (type == "AddSMTRefluxFurnaceKanbanData")
            {
                lineId = Convert.ToInt32(context.Request["LineId"]);
                //读取文件数据
                //var flag1 = GetFileDataSMT(@"D:年利亚\bak");
                //context.Response.Write(flag1 ? "OK" : "NG");
            }
            context.Response.Flush();
            context.Response.End();
        }

        /// <summary>
        /// SMT回流炉实时看板
        /// </summary>
        /// <param name="context"></param>
        private void GetSMTRefluxFurnaceKanbanInfo(HttpContext context)
        {
            string lineId = context.Request["LineId"];
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@LineId",SqlDbType.Int)

            };
            parms[0].Value = lineId;
            var dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetSMTRefluxFurnaceKanbanInfo", parms);
            //序列化
            string jsonStr = JsonConvert.SerializeObject(dt);
            context.Response.Write(jsonStr);
        }



        #region 读取SMT回流炉数据

        readonly string module = "SMT回流炉实时看板";
        const string ITEM_FALG = ".JOB";//产品标识，包含此字符表示是产品

        /// <summary>
        /// 获取文件数据
        /// </summary>
        public bool GetFileDataSMT(string sourceDir)
        {
            var arrFiles = Directory.GetFiles(sourceDir, "*data.txt");
            int lineId = 3;
            int index;
            DataTable dt;
            var completeList = GetSMTCompleteFile(lineId);//已经读取完成的文件

            //遍历文件
            foreach (var item in arrFiles)
            {
                string fileName = Path.GetFileName(item);//文件名称
                if (completeList != null && completeList.Count > 0)
                {
                    //如果文件已经读取，则不需要再次写入数据
                    bool isComplete = completeList.Any(p => p.LineId == lineId && string.Equals(p.FileName, fileName, StringComparison.CurrentCultureIgnoreCase));
                    if (isComplete)
                    {
                        MoveFile(item, sourceDir);
                        continue;
                    }
                }
                //读取文件数据
                dt = ReadSMTTxtFileToTable(item, '	');
                StringBuilder sbSql = new StringBuilder();
                StringBuilder sbSingle = new StringBuilder();
                var guid = System.Guid.NewGuid().ToString("N").ToUpper();
                string itemInfo = string.Empty;//产品信息（包括产品编码、面别、有铅无铅）
                string itemCode = string.Empty;//产品编码
                string face = string.Empty;//面别
                int leadFlag = -1;//有铅、无铅标识 （0：无铅 1：有铅）
                string otherInfo = string.Empty;//产品编码后的其他信息
                bool cooldownFlag = false;//是否冷却数据
                index = 0;

                #region 遍历文件数据
                //遍历数据
                foreach (DataRow dr in dt.Rows)
                {
                    string firstLineCell = dr[0].ToString();//第一列对应的单元格的值
                    if (string.IsNullOrEmpty(firstLineCell))
                    {
                        continue;
                    }
                    if (firstLineCell.EndsWith(ITEM_FALG, StringComparison.CurrentCultureIgnoreCase))
                    {
                        //表示是产品
                        #region 获取产品编码、面别、有铅无铅标识
                        itemInfo = firstLineCell;
                        itemCode = string.Empty;
                        face = string.Empty;
                        otherInfo = string.Empty;

                        firstLineCell = firstLineCell.Substring(0, firstLineCell.LastIndexOf(ITEM_FALG));

                        int topCharIdx = firstLineCell.IndexOf("-TOP", StringComparison.CurrentCultureIgnoreCase);
                        int botCharIdx = firstLineCell.IndexOf("-BOT", StringComparison.CurrentCultureIgnoreCase);
                        int tbCharIdx = firstLineCell.IndexOf("-TB", StringComparison.CurrentCultureIgnoreCase);

                        //根据产品信息获取产品编码、产品面别、有铅无铅标识
                        if (topCharIdx > -1)
                        {
                            face = "TOP";
                            itemCode = firstLineCell.Substring(0, topCharIdx);
                            otherInfo = firstLineCell.Substring(topCharIdx);
                        }
                        else if (botCharIdx > -1)
                        {
                            face = "BOT";
                            itemCode = firstLineCell.Substring(0, botCharIdx);
                            otherInfo = firstLineCell.Substring(botCharIdx);
                        }
                        else if (tbCharIdx > -1)
                        {
                            face = "TB";
                            itemCode = firstLineCell.Substring(0, tbCharIdx);
                            otherInfo = firstLineCell.Substring(tbCharIdx);
                        }
                        leadFlag = otherInfo.IndexOf("-R", StringComparison.CurrentCultureIgnoreCase) > -1 ? 0 : 1;//有-R则表示无铅
                        cooldownFlag = false;
                        #endregion
                    }
                    else if (string.Equals(firstLineCell, "DataId", StringComparison.CurrentCultureIgnoreCase))
                    {
                        //表示是列头，例如：（DataId DateTime SP 0 PV 0 等）
                        continue;
                    }
                    else if (string.Equals(firstLineCell, "Cooldown", StringComparison.CurrentCultureIgnoreCase))
                    {
                        //表示是冷却表示
                        cooldownFlag = true;
                    }
                    else
                    {
                        #region 拼接成SELECT语句
                        sbSingle.Clear();
                        decimal actualMaxTemperature = 0;//实际最大温差
                        for (int i = 0; i <= 19; i++)
                        {
                            var diff = Convert.ToDecimal(dr["PV" + i.ToString() + ""]) - Convert.ToDecimal(dr["SP" + i.ToString() + ""]);
                            actualMaxTemperature = Math.Abs(diff) > actualMaxTemperature ? diff : actualMaxTemperature;
                            sbSingle.AppendFormat(",{0},{1},{2}", dr["SP" + i.ToString() + ""].ToString(), dr["PV" + i.ToString() + ""].ToString(), dr["OP" + i.ToString() + ""].ToString());
                        }

                        sbSql.AppendFormat("{0} SELECT '{1}',{2},'{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}'{11},{12}",
                            index == 0 ? string.Empty : "UNION ALL",
                            guid,//GUID
                            lineId,//LineId,
                            fileName,//FileName,
                            itemInfo,//ItemInfo,
                            itemCode,//ItemCode,
                            face,//Face,
                            leadFlag,//LeadFlag
                            cooldownFlag ? 1 : 0, //CooldownFlag
                            dr["DataId"].ToString(),//DataId
                            dr["DateTime"].ToString(),//DateTime
                            sbSingle.ToString(),
                            actualMaxTemperature
                            ).AppendLine();

                        index++;
                        #endregion
                    }
                }
                #endregion

                #region 保存数据
                try
                {
                    SqlParameter[] prams = new SqlParameter[]
                    {
                        new SqlParameter("@Guid", SqlDbType.VarChar, 40) { Value=guid },
                        new SqlParameter("@Sql", SqlDbType.NVarChar, -1) { Value=sbSql.ToString()}
                    };
                    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAddSMTRefluxFurnaceKanbanInfo", prams);
                }
                catch (Exception ex)
                {
                    //记录错误日志
                    InsertSystemErrorLog(module, string.Format("保存数据失败，文件名称：{0}，产线Id：{1}", fileName, lineId), ex);
                    return false;
                }
                #endregion
            }
            return true;
        }

        /// <summary>
        /// 根据产线Id获取已写入数据库的SMT文件信息
        /// </summary>
        /// <param name="lineId"></param>
        /// <returns></returns>
        private IList<SMTRefluxFurnaceCompleteFileInfo> GetSMTCompleteFile(int lineId)
        {
            List<SMTRefluxFurnaceCompleteFileInfo> list = null;
            try
            {
                SqlParameter[] prams = new SqlParameter[]
                    {
                        new SqlParameter("@LineId", SqlDbType.Int) { Value=lineId }
                    };
                string sql = "SELECT LineId,FileName FROM dbo.Prod_SMTRefluxFurnaceCompleteFile WHERE LineId = @LineId";
                list = ComMethod.GetListBySql<SMTRefluxFurnaceCompleteFileInfo>(sql, prams, SQLHelper.MESConnString);
            }
            catch (Exception ex)
            {
                //记录错误日志
                InsertSystemErrorLog(module, string.Format("获取产线Id{0}已写入文件信息失败", lineId.ToString()), ex);
            }
            return list;
        }

        /// <summary>
        /// 读取txt数据
        /// </summary>
        /// <param name="filePath"></param>
        /// <param name="span"></param>
        /// <returns></returns>
        private DataTable ReadSMTTxtFileToTable(string filePath, char span)
        {
            //文件路径和文件名
            DataTable dt = new DataTable();
            DataRow dr;
            try
            {
                using (StreamReader reader = new StreamReader(filePath, Encoding.Default))
                {
                    //是否为第一行（如果HeadYes为TRUE，则第一行为标题行）
                    int idx = 0;
                    string line;
                    string[] arr;
                    while (reader.EndOfStream == false)
                    {
                        line = reader.ReadLine();
                        arr = line.Split(span);//列之间的分隔符

                        if (idx == 0)
                        {
                            //添加列
                            dt.Columns.Add("DataId", typeof(string));
                            dt.Columns.Add("DateTime", typeof(string));
                            for (int i = 0; i <= 19; i++)
                            {
                                dt.Columns.Add("SP" + i.ToString(), typeof(string));
                                dt.Columns.Add("PV" + i.ToString(), typeof(string));
                                dt.Columns.Add("OP" + i.ToString(), typeof(string));
                            }
                            idx++;
                        }

                        dr = dt.NewRow();
                        //只读取前62列数据
                        for (int i = 0; i < 62; i++)
                        {
                            if (arr.Length > i)
                            {
                                dr[i] = arr[i].Replace("\0", string.Empty).Trim();
                            }
                            else
                            {
                                break;
                            }
                        }
                        dt.Rows.Add(dr);
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
        private void InsertSystemErrorLog(string moudle, string msg, Exception ex)
        {
            string errorMsg = string.Format("{0}；错误信息：{1}{2}，详细信息：{3}", msg, ex.Message, ex.InnerException == null ? string.Empty : ex.InnerException.Message, ex.StackTrace);
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


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

    /// <summary>
    /// SMT回流炉已完成读取文件实体
    /// </summary>
    public class SMTRefluxFurnaceCompleteFileInfo
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