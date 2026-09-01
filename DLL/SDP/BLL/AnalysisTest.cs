using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.SDP.Model;
using SKT.Common.DAL.Marshal;
using System.Data;
using SKT.LeanMES.ProductionCollection;
using SKT.LeanMES.ProductionCollection.Utility;
using System.Data.SqlClient;
using System.Xml;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace BLL
{
    public class AnalysisTest
    {
        public static IList<RouteDetailDataSourceParamInfo> DataSourceParamList = null;
        public static string[] basedataArr = null;
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
        public AnalysisTest(string basedata)
        {
            basedataArr = basedata.Split('_');
            DataTable DataSourceTb = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, "SELECT * FROM SDP_RouteDetailDataSourceParam");
            DataSourceParamList = SKT.LeanMES.SDP.Exec.DataTableToList<RouteDetailDataSourceParamInfo>.ConvertToModel(DataSourceTb);
        }
        public AnalysisTest()
        {
            DataTable DataSourceTb = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, "SELECT * FROM SDP_RouteDetailDataSourceParam");
            DataSourceParamList = SKT.LeanMES.SDP.Exec.DataTableToList<RouteDetailDataSourceParamInfo>.ConvertToModel(DataSourceTb);
        }
        /// <summary>
        /// 绑定事件
        /// </summary>
        /// <param name="stationId">工序</param>
        /// <param name="sn">sn</param>
        /// <returns></returns>
        public string LoadActivity(string stationId, string sn)
        {
            string Route = "";
            string result = "";
            //SN判定
            if (IsSN(sn, ref Route, ref result))
            //  if (true)
            {
                // Route = "1062";
                DataView dv = new DataView();
                string content = "";
                string tempcontent = "";
                #region 获取数据
                string sqlstr = @"SELECT * FROM SDP_Activity T WHERE T.stationId=@stationId AND T.RouteId=@Route";
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@stationId", SqlDbType.VarChar),
                new SqlParameter("@Route", SqlDbType.VarChar)
                 };
                parms[0].Value = stationId;
                parms[1].Value = Route;
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sqlstr, parms);
                #endregion
                dv = new DataView(dt);
                dv.Sort = "SortNo ASC";
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dv.Count; i++)
                    {
                        string slqstr1 = @"SELECT * FROM SDP_FunctionExecStep WHERE AC_ID=" + dv[i]["AC_ID"].ToString();
                        DataView dv1 = new DataView(SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sqlstr));
                        dv1.Sort = "LogicID ASC";
                        for (int J = 0; J < dv1.Count; J++)
                        {
                            switch (dv1[J]["StepType"].ToString())
                            {
                                case "UnitComplete":
                                    string tempfun = "$.post('../SDPHandler/Operation.ashx?api=UnitComplete',{";
                                    string tempparam = GetParamStr(Convert.ToInt32(dv1[J]["DataSourceId"]));

                                    string tempfun1 = "},function(data){if(data==0){show('扫描过站成功！',true)}else{show('扫描过站失败！',false)} })" + "";
                                    tempcontent += tempfun + tempparam + tempfun1;
                                    break;
                                case "BindTable":
                                    tempfun = "$.post('../SDPHandler/Operation.ashx?api=BindTable',{";
                                    tempparam = GetParamStr(Convert.ToInt32(dv1[J]["DataSourceId"]));
                                    tempfun1 = "},function(data){ eval(data) });";
                                    tempcontent += tempfun + tempparam + tempfun1;
                                    break;
                                case "Focus":
                                    tempcontent += "$('#" + dv1[J]["DataSourceControlId"] + "').focus().select();";
                                    break;
                                case "RemoveValue":
                                    tempcontent += "$('#" + dv1[J]["DataSourceControlId"] + "').val('');";
                                    break;
                                case "Show":
                                    tempcontent += "$('#" + dv1[J]["DataSourceControlId"] + "').show();";
                                    break;
                                case "Hidden":
                                    tempcontent += "$('#" + dv1[J]["DataSourceControlId"] + "').hide();";
                                    break;
                                case "SetValue":
                                    break;
                                case "AlertMessage":
                                    tempcontent += "$('#" + dv1[J]["DataSourceControlId"] + "').val('');";
                                    break;
                                case "Update":
                                    tempcontent += "$('#" + dv1[J]["DataSourceControlId"] + "').val('');";
                                    break;
                                case "Save":
                                    tempcontent += "$('#" + dv1[J]["DataSourceControlId"] + "').val('');";
                                    break;
                            }
                        }
                    }
                }
                return tempcontent;
            }
            else
            {
                return "show('" + result + "',false)";
            }
        }

        #region 解析html
        private static string analysishtml(string stationId, string content)
        {
            #region 设置数据
            string result = "<script>";
            string Content = "";
            string Template = "";
            string TemplateParse = "";
            string TemplateData = "";
            string Add_Fields = "";
            string scriptstr = "";
            if (!string.IsNullOrEmpty(stationId))
            {
                string sql = @"SELECT * FROM dbo.SDP_UIModel T 
                            INNER JOIN dbo.SYS_PopedomInStation T1 ON T1.Popedom=T.ModelId
                            INNER JOIN SDP_UIModelDetail T2 ON T2.ModelId=T.ModelId
                            WHERE StationId=@stationId";
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@stationId", SqlDbType.VarChar)
                 };
                parms[0].Value = stationId;
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, parms);
                if (dt.Rows.Count > 0)
                {
                    Content = dt.Rows[0]["Content"].ToString().Replace("\"", "'");
                    Template = dt.Rows[0]["Template"].ToString();
                    TemplateParse = dt.Rows[0]["TemplateParse"].ToString();
                    TemplateData = dt.Rows[0]["TemplateData"].ToString();
                    Add_Fields = dt.Rows[0]["Add_Fields"].ToString();
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(content))
                {
                    content = content.Replace("\\\"", "'");
                    var ssss = JsonConvert.DeserializeObject(content);
                    var dt = JObject.Parse(content.ToString());

                    Content = dt["template"].ToString();
                    Template = dt["template"].ToString();
                    TemplateParse = dt["parse"].ToString();
                    TemplateData = dt["data"].ToString();
                    Add_Fields = dt["add_fields"].ToString();
                }
            }
            #endregion

            #region html属性解析
            var arrs = Newtonsoft.Json.Linq.JArray.Parse(TemplateData);
            for (int i = 0; i < arrs.Count; i++)
            {
                var mJObj = JObject.Parse(arrs[i].ToString());
                switch (mJObj["uictrltype"].ToString())
                {
                    //解析列表控件
                    case "listctrl":
                        var id = mJObj["id"];
                        #region 生成listtable
                        //列数
                        var columnNo = mJObj["uictrltitle"].ToString().Split('`').Where(m => m.Count(k => k.ToString() != "") > 0).ToArray();
                        //列类型
                        var columnNotype = mJObj["uictrlcoltype"].ToString().Split('`').Where(m => m.Count(k => k.ToString() != "") > 0).ToArray();

                        //生成table和添加按钮
                        scriptstr += "<div class='leftmenu-new-header'>列表控件"
                                  + "<span style='float:right'><input type='button' onclick='tbAddRow('data_1')' value='添加一行'></input></span>"
                                  + "</div>"
                                  + "<table class='ListTable' id='" + id + "_copy' style=' width:" + mJObj["uictrlwidth"].ToString() + ";text-align:left'>"
                                  + "<tbody>{0}</tdoby></table>";

                        //列名
                        string Tempcolnamestr = "<tr  class='ListTableHeader'>";
                        //first行(例子)
                        string Tempcolstr = "<tr class='ListTableOddRow'>";
                        for (int q = 0; q < columnNo.Length; q++)
                        {
                            Tempcolnamestr += "<th>" + columnNo[q] + "</th>";
                            Tempcolstr += "<td><input type='" + columnNotype[q] + "'></td>";
                        }
                        Tempcolnamestr += "<th>操作</th></tr>";
                        //+删除按钮
                        Tempcolstr += "<td><a href='javascript:void(0);' onclick='fnDeleteRow(this)' class='delrow hide' style='display: inline;'>删除</a></td></tr>";
                        scriptstr = String.Format(scriptstr, Tempcolnamestr + Tempcolstr);
                        scriptstr = "$('#" + id + "').after(\"" + scriptstr + "\");$('#" + id + "').hide();";
                        #endregion
                        result += scriptstr;
                        break;
                    case "gridctrl":
                        id = mJObj["id"];
                        #region 生成table
                        columnNo = mJObj["uictrltitle"].ToString().Split('`').Where(m => m.Count(k => k.ToString() != "") > 0).ToArray();
                        columnNotype = mJObj["uictrlcoltype"].ToString().Split('`').Where(m => m.Count(k => k.ToString() != "") > 0).ToArray();
                        scriptstr = "<div class='leftmenu-new-header'>" + mJObj["uictrllisttitle"].ToString() + "</div>"
                                  + "<table id=" + id + "_copy" + " class='ListTable' style=' width:" + mJObj["uictrlwidth"].ToString() + "';>{0}</table>";
                        string temp = "<tr  class='ListTableHeader'>";
                        for (int g = 0; g < columnNo.Length; g++)
                        {
                            temp += "<th>" + columnNo[g] + "</th>";
                        }
                        temp += "</tr>";
                        scriptstr = string.Format(scriptstr, temp);
                        result += "$('#" + id + "').after(\"" + scriptstr + "\");$('#" + id + "').hide()";
                        #endregion
                        break;
                    case "choosepagectrl":
                        break;
                    default:
                        result += stylestr(mJObj);
                        break;
                }
            }
            Content = Content.Replace("ue-table-interlace-color-single firstRow", "ListTableOddRow").Replace("ue-table-interlace-color-double", "ListTableEvenRow");
            return Content + result + "</script>";
            #endregion
        }
        /// <summary>
        /// 通用样式解析
        /// </summary>
        /// <param name="JObj"></param>
        /// <returns></returns>
        private static string stylestr(JObject JObj)
        {
            string temp = "";
            var id = JObj["id"];
            if (JObj["uictrlrich"] != null && JObj["uictrlrich"].ToString() != "")
            {

            }
            if (JObj["uictrlhide"] != null && JObj["uictrlhide"].ToString() == "1")
            {
                temp += "$('#" + id + "').hide();";
            }
            if (JObj["uictrlalign"] != null && JObj["uictrlalign"].ToString() != "")
            {
                temp += "$('#" + id + "').css('text-align','" + JObj["uictrlalign"].ToString() + "');";
            }
            if (JObj["uictrlfontsize"] != null && JObj["uictrlfontsize"].ToString() != "")
            {
                temp += "$('#" + id + "').css('fontsize','" + JObj["uictrlfontsize"].ToString() + "');";
            }
            if (JObj["uictrlwidth"] != null && JObj["uictrlwidth"].ToString() != "")
            {
                temp += "$('#" + id + "').css('width','" + JObj["uictrlwidth"].ToString() + "');";
            }
            if (JObj["uictrlheight"] != null && JObj["uictrlheight"].ToString() != "")
            {
                temp += "$('#" + id + "').css('height','" + JObj["uictrlheight"].ToString() + "');";
            }
            if (JObj["uictrldatatype"] != null && JObj["uictrldatatype"].ToString() != "")
            {
            }
            if (JObj["uictrlrequired"] != null && JObj["uictrlrequired"].ToString() != "")
            {
                temp += "$('#" + id + "').attr('IsRequired','1');";
            }
            if (JObj["uictrlregexp"] != null && JObj["uictrlregexp"].ToString() != "")
            {

            }
            if (JObj["uictrldatasource"] != null && JObj["uictrldatasource"].ToString() != "")
            {

            }
            if (JObj["uictrldatasourcetype"] != null && JObj["uictrldatasourcetype"].ToString() != "")
            {

            }
            return temp;
        }
        #endregion

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
        public static bool IsSN(string SN, ref string Route, ref string result)
        {
            ProductionCollectionInfo model = new ProductionCollectionInfo();
            model.SerialNumber = SN;
            model.UserId = Convert.ToInt32(basedataArr[0]);
            model.StationId = Convert.ToInt32(basedataArr[2]);
            model.ResourceId = basedataArr[4] == "" ? 0 : Convert.ToInt32(basedataArr[4]);
            int Irt = SNProcessValidation.Start(model);
            if (Irt == 0)
            {
                SqlParameter[] parms = new SqlParameter[]{
                                new SqlParameter("@SN", SqlDbType.VarChar)};
                parms[0].Value = SN;
                string sql = @"SELECT B.Value AS Serail_Number,C.Station,A.* FROM dbo.Prod_Unit A INNER JOIN dbo.Prod_SerialNumber B ON A.UID = B.UID
                                            LEFT JOIN dbo.Basal_Station C ON A.OpeID = C.StationId
                                            INNER JOIN dbo.Basal_RouterDetail D ON A.R_ID = D.R_ID AND A.OpeID=D.Incoming_OpeID
                                            WHERE  B.Value=@SN";
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, parms);

                Route = dt.Rows[0]["R_ID"].ToString();
                return true;
            }
            else
            {
                result = ErrorList[Irt];
                return false;
            }
        }
        #endregion
        /// <summary>
        /// 解析参数
        /// </summary>
        /// <param name="DataSourceId"></param>
        /// <returns></returns>
        public static string GetParamStr(int DataSourceId)
        {
            string tempparam = "";
            IList<RouteDetailDataSourceParamInfo> templist = DataSourceParamList.Where(a => a.RouteDetailDataSourceID == DataSourceId).ToList();
            if (templist.Count > 0)
            {
                tempparam = "value:";
                for (int k = 0; k < templist.Count; k++)
                {
                    if (templist[k].ParamType == "FromUI")
                    {
                        tempparam += "$('#" + templist[k].ControlId + "').val()" + "&";
                    }
                    else if (templist[k].ParamType == "DefaultValue")
                    {
                        tempparam += templist[k].ParamValue + "&";
                    }
                    else
                    {
                        tempparam += "'" + templist[k].ParamValue + "'" + "&";
                    }
                }
                tempparam = tempparam.TrimEnd('&');
            }
            return tempparam;
        }
    }
}
