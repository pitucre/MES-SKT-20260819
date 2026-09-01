using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.SDP.Model;
using System.Xml;
using SKT.LeanMES.Process;
using SKT.LeanMES.ProductionCollection.Activity;
using SKT.LeanMES.ProductionCollection;
using SKT.LeanMES.ProductionCollection.Utility;
namespace SKT.LeanMES.SDP.Exec
{
    public class Execution
    {
        static string[] ErrorList = new string[]
        {
            "正常",
            "无工位操作资格",
            "无资源使用资格",
            "序号不存在",
            "Unit状态不正确",
            "关联的路由状态不正常",
            "所选工位不正确",
            "产品状态不正常",
            "工单状态不正常",
            "无产品操作资格"
        };
        //数据源参数列表
        public static IList<RouteDetailDataSourceParamInfo> DataSourceParamList = null;
        //控件ID值列表
        public static Dictionary<string, string> ControlValueList = new Dictionary<string, string>();
        //控件属性列表
        public static IList<ControlerInfo> ControlerInfoList = new List<ControlerInfo>();

        //页面基础信息
        public static string[] BaseDataArr = null;
        //当前数据源参数ID
        public static int DataSourceParamId;
        /// <summary>
        /// 页面基础信息
        /// </summary>
        /// <param name="BaseData">用户名+路由+工序+工单+资源+当前时间</param>
        public Execution(string BaseData)
        {
            if (!string.IsNullOrEmpty(BaseData))
                BaseDataArr = BaseData.Split('_');
            DataTable DataSourceTb = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, "SELECT * FROM SDP_RouteDetailDataSourceParam");
            DataSourceParamList = SKT.LeanMES.SDP.Exec.DataTableToList<RouteDetailDataSourceParamInfo>.ConvertToModel(DataSourceTb);
        }
        #region 操作
        /// <summary>
        /// 执行多个操作时以,隔开
        /// </summary>
        /// <param name="acId"></param>
        /// <param name="stationid"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        public string Exec(string acId, string value)
        {
            string ExecResult = "";
            string result = "";
            string[] valuearr = value.Split('$');
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@acId", SqlDbType.VarChar)
            };
            parms[0].Value = acId;
            string sqlstr = @"SELECT * FROM SDP_Activity T
                                JOIN dbo.SDP_FunctionExecStep T1 ON T1.AC_ID=T.Id
                                LEFT JOIN dbo.SDP_RouteDetailDataSource T2 ON T2.RouteDetailDataSourceID=T1.DataSourceId --AND T2.RouteId=T.RouteId AND T2.StationId=T.StationId
                                LEFT JOIN dbo.SDP_DataSource T4 ON T4.DataSourceID=T2.DataSourceID
                                WHERE T.Id=@acId";
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sqlstr, parms);
            DataView dv = new DataView(dt);
            dv.Sort = "LogicID ASC";

            ExecBLL eb = new ExecBLL();
            for (int i = 0; i < dv.Count; i++)
            {
                DataSourceParamId = string.IsNullOrEmpty(dv[i]["RouteDetailDataSourceID"].ToString()) ? 0 : Convert.ToInt32(dv[i]["RouteDetailDataSourceID"]);
                string stepName = dv[i]["stepName"].ToString();
                string stepType = dv[i]["stepType"].ToString();
                string stepXml = dv[i]["stepXml"].ToString();
                string SQLType = dv[i]["SQLType"].ToString();
                string SQlInfo = dv[i]["SQlInfo"].ToString();
                string DataSourceType = dv[i]["DataSourceType"].ToString();
                string TabColumn = dv[i]["TabColumn"].ToString();
                string Paramters = dv[i]["Paramters"].ToString();
                string DataSourceControlId = dv[i]["DataSourceControlId"].ToString();
                HandleType type = (HandleType)Enum.Parse(typeof(HandleType), stepType);
                SqlType sqltype = SQLType == "" ? SqlType.SqlText : (SqlType)Enum.Parse(typeof(SqlType), SQLType);
                #region
                //eb = Fatcy.Start(type);
                //eb.sqltype = sqltype;
                //eb.SQlInfo = SQlInfo;
                //eb.DataSourceControlId = DataSourceControlId;
                //eb.DataSourceType = DataSourceType;
                //eb.stepXml = stepXml;
                //eb.Paramters = Paramters;
                //eb.valuearr = valuearr[i];
                //result += eb.Exec();
                #endregion
                switch (type)
                {
                    case HandleType.BindTable:
                        BindTable(sqltype, SQlInfo, DataSourceControlId, DataSourceType, stepXml, Paramters, valuearr[i], ref ExecResult);
                        break;
                    case HandleType.BindValue:
                        BindValue(sqltype, SQlInfo, DataSourceControlId, DataSourceType, stepXml, Paramters, valuearr[i], ref ExecResult);
                        break;
                    case HandleType.Focus:
                        Focus(DataSourceControlId, ref ExecResult);
                        break;
                    case HandleType.RemoveValue:
                        RemoveValue(DataSourceControlId, ref ExecResult);
                        break;
                    case HandleType.Excute:
                        Excute(sqltype, SQlInfo, DataSourceControlId, DataSourceType, stepXml, Paramters, valuearr[i], ref ExecResult);
                        break;
                    case HandleType.AlertMessage:
                        AlertMessage(stepXml, ref ExecResult);
                        break;
                    case HandleType.UnitComplete:
                        UnitComplete(valuearr[i], ref ExecResult);
                        break;
                    case HandleType.SNCheck:
                        if (IsSN(valuearr[i], ref ExecResult))
                            break;
                        return ExecResult.TrimStart(',');
                    case HandleType.Show:
                        Show(DataSourceControlId, ref ExecResult);
                        break;
                    case HandleType.Hidden:
                        Hidden(DataSourceControlId, ref ExecResult);
                        break;
                    case HandleType.SetValue:
                        SetValue(sqltype, SQlInfo, DataSourceControlId, DataSourceType, stepXml, Paramters, valuearr[i], ref ExecResult);
                        break;
                    case HandleType.Print:
                        SetPrintValue(sqltype, SQlInfo, DataSourceControlId, DataSourceType, stepXml, Paramters, valuearr[i], ref ExecResult);
                        break;
                }
            }
            return ExecResult.TrimStart(',');
        }

        /// <summary>
        /// 打印
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        public static void SetPrintValue(SqlType type, string info, string ControlId, string datasourcetype, string stepXml, string paramname, string value, ref string ExecResult)
        {
            XmlDocument xoc = new XmlDocument();
            xoc.LoadXml(stepXml);
            //<stepxml><ruleType>-2</ruleType><doc>1</doc><control>uictrl_1500884520614141_text</control></stepxml>
            string labelType = xoc.SelectNodes("//ruleType")[0].InnerText;
            string controlId = xoc.SelectNodes("//control")[0].InnerText;
            string labelSequence = "1";
            switch(labelType)
            {
                case "-2":
                    labelSequence = "1"; //产品条码序号默认是1
                    break;
                case "-3":
                    labelSequence = "2"; //物料条码序号默认是2
                    break;
                case "-4":
                    labelSequence = "3"; //包装箱条码序号默认是3
                    break;
                case "-5":
                    labelSequence = "4"; //栈板条码序号默认是4
                    break;
                default:
                    break;              //其余未定
            }

            StringBuilder sbResult = new StringBuilder();
            sbResult.AppendLine(string.Format("labelType = '{0}';", labelType));//打印类型赋值
            sbResult.AppendLine(string.Format("SNInfo = $(\"#{0}\").val();", controlId)); //设置打印的内容
            sbResult.AppendLine(string.Format("labelSequence = '{0}';", labelSequence));  //产品的序号  
            sbResult.AppendLine("AutoAddJSAndPrint();");    //调用打印方法
            ExecResult = sbResult.ToString();
        }

        /// <summary>
        /// 设置值
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        /// <returns></returns>
        public static void BindValue(SqlType type, string info, string ControlId, string datasourcetype, string column, string paramname, string value, ref string ExecResult)
        {
            try
            {
                XmlDocument xoc = new XmlDocument();
                xoc.LoadXml(column);
                string name = xoc.SelectNodes("//DataTextField")[0].InnerText;
                string code = xoc.SelectNodes("//DataValueField")[0].InnerText;

                string controlType = Reverse1(ControlId);
                controlType = Reverse1(controlType.Substring(0, controlType.ToString().IndexOf('_')));
                string result = "-1";
                DataTable dt = new DataTable();
                string[] paramarr = paramname.Split(',');
                string[] valuearr = StringToArr(value);
                SqlParameter[] parms = new SqlParameter[paramarr.Length];
                for (int i = 0; i < paramarr.Length; i++)
                {
                    parms[i] = new SqlParameter(paramarr[i], SqlDbType.VarChar);
                    if (paramarr[i] == "")
                    {
                        parms[i].Value = "";
                    }
                    else
                    {
                        if (valuearr[i] == "")
                        {
                            var c = DataSourceParamList.Where(m => m.ParamName == paramarr[i].ToString() && m.RouteDetailDataSourceID == DataSourceParamId).ToList()[0].ControlId;
                            parms[i].Value = ControlValueList[c];
                        }
                        else
                        {
                            parms[i].Value = valuearr[i];
                        }
                    }
                }
                dt = DataTableSQLHelp(type, info, parms);

                if (dt.Rows.Count <= 0)
                    return;
                result = "$('#" + ControlId + "').empty(),";
                result += "$('#" + ControlId + "').append({0})";
                string tempstr = "";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    switch (controlType)
                    {
                        case "checkbox":
                            tempstr += "<input name='uictrl_NewField' value='" + dt.Rows[i][code].ToString() + "' checked='' type='checkbox'>" + dt.Rows[i][name].ToString() + "&nbsp;";
                            break;
                        case "radios":
                            tempstr += "<input name='uictrl_NewField' value='" + dt.Rows[i][code].ToString() + "' checked='' type='radio'>" + dt.Rows[i][name].ToString() + "&nbsp;";
                            break;
                        case "select":
                            tempstr += "<option value='" + dt.Rows[i][code].ToString() + "'>" + dt.Rows[i][name].ToString() + "</option>";
                            break;
                    }
                }
                result = string.Format(result, "\"" + tempstr + "\"");
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                //return result;
            }
            catch (Exception)
            {
            }
        }
        /// <summary>
        /// 弹出页面
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        /// <returns></returns>
        public static void ChoosePage(SqlType type, string info, string ControlId, string datasourcetype, string column, string paramname, string value, ref string ExecResult)
        {
            try
            {
                string result = @"chooseFlag = 1;
            dialog({ title: '<%=Resources.Common.ChooseWindow %>', src: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&rnd=' + 
            Math.random(), width: 600, height: 300 })";
                ExecResult = ExecResult.TrimStart(',') + "," + result;
                return;
            }
            catch (Exception)
            {

            }
        }
        /// <summary>
        /// 设置值
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        /// <returns></returns>
        public static void SetValue(SqlType type, string info, string ControlId, string datasourcetype, string column, string paramname, string value, ref string ExecResult)
        {
            try
            {
                string result = "";

                XmlDocument xoc = new XmlDocument();
                xoc.LoadXml(column);
                string code = xoc.SelectNodes("//DataValueField")[0].InnerText;

                
                string[] paramarr = paramname.Split(',');
                string[] valuearr = StringToArr(value);
                SqlParameter[] parms = new SqlParameter[paramarr.Length];
                for (int i = 0; i < paramarr.Length; i++)
                {
                    parms[i] = new SqlParameter(paramarr[i], SqlDbType.VarChar);
                    parms[i].Value = valuearr[i];
                }
                DataTable dt = DataTableSQLHelp(type, info, parms);
                if (dt.Rows.Count > 0)
                {
                    result = "$('#" + ControlId + "').val('" + dt.Rows[0][code] + "')";
                    ExecResult = ExecResult.TrimEnd(',') + "," + result;
                    ControlValueList.Add(ControlId, value);
                }
                else
                {
                    return;
                }
            }
            catch (Exception)
            {
            }
        }
        /// <summary>
        /// 显示
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        /// <returns></returns>
        public static void Show(string ControlId, ref string ExecResult)
        {
            try
            {
                string result = "";
                result = "$('#" + ControlId + "').show()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return;
            }
            catch (Exception)
            {
            }
        }
        /// <summary>
        /// 隐藏
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        /// <returns></returns>
        public static void Hidden(string ControlId, ref string ExecResult)
        {
            try
            {
                string result = "";
                result = "$('#" + ControlId + "').hide()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return;
            }
            catch (Exception)
            {
            }
        }
        /// <summary>
        /// 弹出消息
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        /// <returns></returns>
        public static void AlertMessage(string column, ref string ExecResult)
        {
            XmlDocument xoc = new XmlDocument();
            xoc.LoadXml(column);
            string msg = xoc.SelectNodes("//message")[0].InnerText;
            try
            {
                string result = "";
                result = "alert('" + msg + "')";
                ExecResult = ExecResult.TrimEnd(',') + ";" + result;
                return;
            }
            catch (Exception)
            {
            }
        }
        /// <summary>
        /// 清除
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        /// <returns></returns>
        public static void RemoveValue(string ControlId, ref string ExecResult)
        {
            try
            {
                string result = "";
                result = "$('#" + ControlId + "').val('')";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return;
            }
            catch (Exception)
            {
            }
        }
        /// <summary>
        /// 执行
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        public static void Excute(SqlType type, string info, string ControlId, string datasourcetype, string column, string paramname, string value, ref string ExecResult)
        {
            string result = "";
            try
            {
                string[] paramarr = paramname.Split(',');
                string[] valuearr = StringToArr(value);
                SqlParameter[] parms = new SqlParameter[paramarr.Length];
                for (int i = 0; i < paramarr.Length; i++)
                {
                    parms[i] = new SqlParameter(paramarr[i], SqlDbType.VarChar);
                    parms[i].Value = valuearr[i];
                }
                result = StringSQLHelp(type, info, parms);

                if (info == "uspExecActivity")
                {
                    ExecResult = ExecResult.TrimEnd(',') + "," + "show('" + valuearr[3] + "扫描过站完成!',true)";
                }
                else
                {
                    ExecResult = ExecResult.TrimEnd(',') + "," + "show('" + result + "',true)";
                }
                return;
            }
            catch (Exception ex)
            {
                ExecResult = ExecResult.TrimEnd(',') + "," + "show('" + ex.Message + "',false)";
            }
        }
        /// <summary>
        /// 保存
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        /// <returns></returns>
        public static void Save(SqlType type, string info, string ControlId, string datasourcetype, string column, string paramname, string value, ref string ExecResult)
        {
            string result = "";
            try
            {
                string[] paramarr = paramname.Split(',');
                string[] valuearr = StringToArr(value);
                SqlParameter[] parms = new SqlParameter[paramarr.Length];
                for (int i = 0; i < paramarr.Length; i++)
                {
                    parms[i] = new SqlParameter(paramarr[i], SqlDbType.VarChar);
                    parms[i].Value = valuearr[i];
                }
                result = StringSQLHelp(type, info, parms);

                if (info == "uspExecActivity")
                {
                    ExecResult = ExecResult.TrimEnd(',') + "," + "show('" + valuearr[3] + "扫描过站完成!',true)";
                }
                else
                {
                    ExecResult = ExecResult.TrimEnd(',') + "," + "show('" + result + "',true)";
                }
                return;
            }
            catch (Exception ex)
            {
                ExecResult = ExecResult.TrimEnd(',') + "," + "show('" + ex.Message + "',false)";
            }
        }
        /// <summary>
        /// 更新
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        /// <returns></returns>
        public static void Update(SqlType type, string info, string ControlId, string datasourcetype, string column, string paramname, string value, ref string ExecResult)
        {
            string result = "";
            try
            {
                SqlParameter[] parms = null;
                string[] paramarr = paramname.Split(',');
                string[] valuearr = StringToArr(value);
                for (int i = 0; i < paramarr.Length; i++)
                {
                    parms = new SqlParameter[]{
                new SqlParameter(paramarr[i], SqlDbType.VarChar)};
                    parms[i].Value = valuearr[i];
                }

                result = StringSQLHelp(type, info, parms);

                return;
            }
            catch (Exception ex)
            {
                ExecResult = ExecResult.TrimEnd(',') + "," + "show('" + ex.Message + "',false)";
            }
        }
        /// <summary>
        /// 聚焦
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="ControlId"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <param name="ExecResult"></param>
        /// <returns></returns>
        public static void Focus(string ControlId, ref string ExecResult)
        {
            try
            {
                string result = "";
                result = "$('#" + ControlId + "').focus().select()";
                ExecResult = ExecResult.TrimEnd(',') + "," + result;
                return;
            }
            catch (Exception)
            {
            }
        }
        /// <summary>
        /// 执行绑定操作
        /// </summary>
        /// <param name="type"></param>
        /// <param name="info"></param>
        /// <param name="id"></param>
        /// <param name="datasourcetype"></param>
        /// <param name="column"></param>
        /// <param name="paramname"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        public static void BindTable(SqlType type, string info, string ControlId, string datasourcetype, string column, string paramname, string value, ref string ExecResult)
        {
            try
            {
                string result = "-1";

                XmlDocument xoc = new XmlDocument();
                xoc.LoadXml(column);
                string[] colarr = new string[xoc.SelectNodes("//Column").Count];
                for (int i = 0; i < xoc.SelectNodes("//Column").Count; i++)
                {
                    colarr[i] = xoc.SelectNodes("//Column")[i].Attributes["SourceColumnName"].Value;
                }
                //绑定方式
                var bindType = xoc.SelectNodes("BindColumns")[0].Attributes["BoundType"].Value;
                //显示行数
                int rowCount = Convert.ToInt32(xoc.SelectNodes("BindColumns")[0].Attributes["showrowcount"].Value);
                DataTable dt = new DataTable();
                string[] paramarr = paramname.Split(',');
                string[] valuearr = StringToArr(value);
                SqlParameter[] parms = new SqlParameter[paramarr.Length];
                for (int i = 0; i < paramarr.Length; i++)
                {
                    parms[i] = new SqlParameter(paramarr[i], SqlDbType.VarChar);
                    if (paramarr[i] == "")
                    {
                        parms[i].Value = "";
                    }
                    else
                    {
                        if (valuearr[i] == "")
                        {
                            var c = DataSourceParamList.Where(m => m.ParamName == paramarr[i].ToString() && m.RouteDetailDataSourceID == DataSourceParamId).ToList()[0].ControlId;
                            parms[i].Value = ControlValueList[c];
                        }
                        else
                        {
                            parms[i].Value = valuearr[i];
                        }
                    }
                }
                dt = DataTableSQLHelp(type, info, parms);

                if (dt.Rows.Count <= 0)
                {
                    ExecResult = ExecResult.TrimEnd(',') + "," + "show('未查询到信息！','false')";
                    return;
                }
                TableBoundType bindtype = (TableBoundType)Enum.Parse(typeof(TableBoundType), bindType);
                string tempstr = "";
                switch (bindtype)
                {
                    case TableBoundType.ReBound:
                        result = "$('#" + ControlId + "_copy" + " tr:gt(0)').remove(),";
                        result += "$('#" + ControlId + "_copy" + " tr:eq(0)').after({0})";

                        for (int i = 0; i < (dt.Rows.Count > rowCount ? rowCount : dt.Rows.Count); i++)
                        {
                            if ((i + 1) % 2 == 1)
                            {
                                tempstr += "<tr class='ListTableOddRow'>";
                            }
                            else
                            {
                                tempstr += "<tr class='ListTableEvenRow'>";
                            }
                            for (int j = 0; j < colarr.Length; j++)
                            {
                                tempstr += "<td>" + dt.Rows[i][colarr[j]].ToString() + "</td>";
                            }
                            tempstr += "</tr>";
                        }
                        result = string.Format(result, "\"" + tempstr + "\"");
                        ExecResult = ExecResult.TrimEnd(',') + "," + result;
                        break;
                    case TableBoundType.Superimposed:
                        for (int i = 0; i < (dt.Rows.Count > rowCount ? rowCount : dt.Rows.Count); i++)
                        {
                            if ((i + 1) % 2 == 1)
                            {
                                tempstr += "<tr class='ListTableOddRow'>";
                            }
                            else
                            {
                                tempstr += "<tr class='ListTableEvenRow'>";
                            }
                            for (int j = 0; j < colarr.Length; j++)
                            {
                                tempstr += "<td>" + dt.Rows[i][colarr[j]].ToString() + "</td>";
                            }
                            tempstr += "</tr>";
                        }
                        //result = "  if ($('#" + ControlId + "_copy').find('tr').length < " + rowCount + ") {"
                        //            + "$('#" + ControlId + "_copy').append(" + "\"" + tempstr + "\"" + ");"
                        //            + "} else {"
                        //            + "$('#" + ControlId + "_copy  tr:eq(0)').remove();"
                        //            + "$('#" + ControlId + "_copy').append(" + "\"" + tempstr + "\"" + ");"
                        //              + " }   ";
                        result = "TabelBind('" + ControlId + "_copy'" + "," + rowCount + "," + "\"" + tempstr  +"\"" + ")";
                        ExecResult = ExecResult.TrimEnd(',') + "," + result;
                        break;
                }
                return;
            }
            catch
            {

            }
        }
        #endregion

        #region 返回类型
        private static DataTable DataTableSQLHelp(SqlType type, string info, SqlParameter[] param)
        {
            DataTable dt = new DataTable();
            switch (type)
            {
                case SqlType.SqlText:
                    dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, info, param);
                    break;
                case SqlType.Procedure:
                    dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, info, param);
                    break;
                case SqlType.WebService:
                    break;
            }
            return dt;
        }
        private static string StringSQLHelp(SqlType type, string info, SqlParameter[] param)
        {
            string result = "";
            switch (type)
            {
                case SqlType.SqlText:
                    result = SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, info, param).ToString();
                    break;
                case SqlType.Procedure:
                    result = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, info, param).ToString();
                    break;
                case SqlType.WebService:
                    break;
            }
            return result;
        }
        private static int IntSQLHelp(SqlType type, string info, SqlParameter[] param)
        {
            int result = -1;
            switch (type)
            {
                case SqlType.SqlText:
                    result = SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, info, param);
                    break;
                case SqlType.Procedure:
                    result = SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, info, param);
                    break;
                case SqlType.WebService:
                    break;
            }
            return result;
        }
        #endregion

        #region 公用方法
        #region 判断SN
        /// <summary>
        /// 0：正常；
        /// 1: 无工位操作资格；
        /// 2：无资源使用资格；
        /// 3：序号不存在；
        /// 4：Unit状态不正确；
        /// 5：关联的路由状态不正常；
        /// 6：所选工位不正确；
        /// 7：产品状态不正常；
        /// 8：工单状态不正常；
        /// 9：无产品操作资格
        /// </summary>
        /// <param name="SN"></param>
        /// <param name="Route"></param>
        /// <returns></returns>
        public static bool IsSN(string SN, ref string ExecResult)
        {
            ProductionCollectionInfo model = new ProductionCollectionInfo();
            model.SerialNumber = SN;
            model.UserId = Convert.ToInt32(BaseDataArr[0]);
            model.StationId = Convert.ToInt32(BaseDataArr[2]);
            model.ResourceId = BaseDataArr[4] == "" ? 0 : Convert.ToInt32(BaseDataArr[4]);
            int Irt = SNProcessValidation.Start(model);
            if (Irt == 0)
            {
                return true;
            }
            else
            {
                ExecResult += ExecResult.TrimEnd(',') + "," + "show('" + ErrorList[Irt] + "',false)";
                return false;
            }
        }
        #endregion
        /// <summary>
        /// 过站方法
        /// </summary>
        /// <param name="UnitID"></param>
        /// <param name="OpeID"></param>
        /// <param name="IsPass"></param>
        /// <param name="LineID"></param>
        /// <param name="UserID"></param>
        /// <param name="ResID"></param>
        /// <param name="EnterTime"></param>
        private void UnitComplete(string sn, ref string ExecResult)
        {
            ProductionCollectionInfo model = new ProductionCollectionInfo();
            try
            {
                model.SerialNumber = sn;
                //用户名
                model.UserId = Convert.ToInt32(BaseDataArr[0]);
                //工位 工序
                model.StationId = Convert.ToInt32(BaseDataArr[2]);
                //资源
                model.ResourceId = BaseDataArr[4] == "" ? 0 : Convert.ToInt32(BaseDataArr[4]);
                model.RelationNumber = "";
                //状态
                model.StatusId = Convert.ToInt32(BaseDataArr[6]);
                ExecActivity.Start(model);
                ExecResult += ExecResult.TrimEnd(',') + "," + "show('" + model.SerialNumber + "过站成功！',true)";
            }
            catch (Exception ex)
            {
                ExecResult += ExecResult.TrimEnd(',') + "," + "show(''" + model.SerialNumber + "过站失败！',false)";
            }
        }
        /// <summary>
        /// 获取二级参数（各方法的参数）
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        private static string[] StringToArr(string str)
        {
            return str.Split('&');
        }
        /// <summary>
        /// 翻转字符串
        /// </summary>
        /// <param name="original"></param>
        /// <returns></returns>
        private static string Reverse1(string original)
        {
            char[] arr = original.ToCharArray();
            Array.Reverse(arr);
            return new string(arr);
        }
        /// <summary>
        /// 得到一个时间戳
        /// </summary>
        /// <returns></returns>
        private static string GetTimeStamp()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return Convert.ToInt64(ts.TotalSeconds).ToString();
        }
        #endregion
    }
}
