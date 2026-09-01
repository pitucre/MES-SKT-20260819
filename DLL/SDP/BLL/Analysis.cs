using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Data;
using SKT.LeanMES.SDP.Model;
using System.Reflection;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using SKT.LeanMES.ProductionCollection.Utility;
using SKT.LeanMES.ProductionCollection;
namespace SKT.LeanMES.SDP.BLL
{
    public class Analysis
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
        public Analysis(string basedata)
        {
            basedataArr = basedata.Split('_');
            DataTable DataSourceTb = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, "SELECT * FROM SDP_RouteDetailDataSourceParam");
            DataSourceParamList = SKT.LeanMES.SDP.Exec.DataTableToList<RouteDetailDataSourceParamInfo>.ConvertToModel(DataSourceTb);
        }
        public Analysis()
        {
            DataTable DataSourceTb = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, "SELECT * FROM SDP_RouteDetailDataSourceParam");
            DataSourceParamList = SKT.LeanMES.SDP.Exec.DataTableToList<RouteDetailDataSourceParamInfo>.ConvertToModel(DataSourceTb);
        }
        /// <summary>
        /// 加载UI
        /// </summary>
        /// <param name="stationId">工序Id</param>
        /// <param name="sn"></param>
        /// <returns></returns>
        public string LoadPage(string stationId)
        {
            return analysishtml(stationId, "");
        }
        /// <summary>
        /// 预览UI
        /// </summary>
        /// <param name="stationId"></param>
        /// <param name="content">html内容</param>
        /// <returns></returns>
        public string LoadPage(string stationId, string content)
        {
            return analysishtml("", content);
        }
        /// <summary>
        /// 获取UI
        /// </summary>
        /// <param name="modelid">UI id</param>
        /// <returns></returns>
        public string GetInfo(string modelid)
        {
            string result = "";
            //string Content = "";
            //string Template = "";
            //string TemplateParse = "";
            //string TemplateData = "";
            //string Add_Fields = "";

            string sql = @"SELECT * FROM dbo.SDP_UIModel T 
                            INNER JOIN SDP_UIModelDetail T1 ON T1.ModelId=T.ModelId
                            WHERE T.ModelId=@ModelId";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ModelId", SqlDbType.VarChar)                
            };
            parms[0].Value = modelid;

            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, parms);
            if (dt.Rows.Count > 0)
            {
                result = dt.Rows[0]["Content"].ToString().Replace("\"", "'");
                //Template = dt.Rows[0]["Template"].ToString();
                //TemplateParse = dt.Rows[0]["TemplateParse"].ToString();
                //TemplateData = dt.Rows[0]["TemplateData"].ToString();
                //Add_Fields = dt.Rows[0]["Add_Fields"].ToString();
            }
            else
            {
                result = "show('未查询出加载页面信息！',false)";
            }

            return result;
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
            string itemid = "";
            string prodOrderId = "";
            //SN判定
            if (IsSN(sn, ref Route, ref itemid, ref prodOrderId, ref result))
            //  if (true)
            {
                // Route = "1062";
                //string data = Exec("", stationId, sn);
                DataView dv = new DataView();
                string content = "";
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
                        string tempcontent = "";
                        //事件ID
                        var acId = dv[i]["Id"].ToString();
                        //控件ID
                        var controlid = dv[i]["ControlId"].ToString();

                        if (dv[i]["EventType"].ToString() == "ChoosePage")
                        {
                            string ChoosePageId = "1";
                            string ChoosePageWidth = "600";
                            string ChoosePageheight = "300";
                            tempcontent = "eval( function " + controlid + "choosepagefunc" + "(list){ $('#" + controlid + "').val(list[0][1]) },"
                                      + "$('#" + controlid + "').unbind('click').bind('click',"
                                      + "function (){            chooseFlag = 1;"
                                      + "dialog({ title: '选择窗口', src: '/Framework/ChoosePage.aspx?PageId=" + ChoosePageId
                                      + "&Multiple=false&CallBackFunc=" + controlid + "choosepagefunc" + "&rnd='+ Math.random(), width: " + ChoosePageWidth + ", height: " + ChoosePageheight + "})})) ";
                        }
                        else
                        {
                            if (!string.IsNullOrEmpty(controlid))
                            {
                                string sqlstr1 = @"SELECT * FROM dbo.SDP_Activity T
                                                JOIN dbo.SDP_FunctionExecStep T1 ON T1.AC_ID=T.Id
                                                LEFT JOIN dbo.SDP_RouteDetailDataSource T2 ON T2.RouteId=T.RouteId AND T2.StationId=T.StationId AND T2.RouteDetailDataSourceID=T1.DataSourceId
                                                LEFT JOIN SDP_DataSource T3 ON T3.DataSourceID=T2.DataSourceID
                                                WHERE T.Id=" + acId;
                                DataTable dt1 = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sqlstr1);
                                DataView dv1 = new DataView(dt1);
                                dv1.Sort = " AC_ID,OrderId ";
                                string tempevent = "$('#" + controlid + "').unbind('" + dv[i]["EventType"].ToString() + "').bind('" + dv[i]["EventType"].ToString() + "',"
                                           + @"function (){  
                                                    labelStationId = '" + stationId.ToString() + @"';
                                                    labelItemId = '" + itemid + @"';
                                                    labelProdOrderId = '" + prodOrderId + "';";
                                //acId 事件id basedata基础数据（用户名+路由+工序+工单+资源+当前时间）
                                string p = "'acId':" + acId + ",'basedata':basedata ";

                                for (int J = 0; J < dv1.Count; J++)
                                {
                                    if (J == 0) { p += ",'value':"; }
                                    string[] parr = dv1[J]["Paramters"].ToString().Split(',');
                                    IList<RouteDetailDataSourceParamInfo> templist = new List<RouteDetailDataSourceParamInfo>();
                                    if (dv1[J]["RouteDetailDataSourceID"] != null && dv1[J]["RouteDetailDataSourceID"].ToString() != "")
                                        templist = DataSourceParamList.Where(k => k.RouteDetailDataSourceID == Convert.ToInt32(dv1[J]["RouteDetailDataSourceID"])).ToList();
                                    if (parr.Length > 0)
                                    {
                                        for (int m = 0; m < parr.Length; m++)
                                        {
                                            if (parr[m].ToString() == "")
                                            {
                                                p += "''" + "+'&'+";
                                            }
                                            else
                                            {
                                                if (templist.Where(k => k.ParamName == parr[m]).ToList()[0].ParamType == "FromUI")
                                                {
                                                    p += "$('#" + templist.Where(k => k.ParamName == parr[m]).ToList()[0].ControlId + "').val()" + "+'&'+";
                                                }
                                                else
                                                {
                                                    p += templist.Where(k => k.ParamName == parr[m]).ToList()[0].ParamValue.Trim('@') + "+'&'+";
                                                }
                                            }
                                        }
                                        p = p.Remove(p.Length - 5) + "+'$'+";
                                    }
                                }
                                p = p.Remove(p.Length - 5);
                                //执行事件方法
                                string tempfunction = "$.post('../SDPHandler/Operation.ashx?api=Exec',";
                                //方法参数
                                string tempparam = "{" + p + "},";
                                //回调方法;设置下品号，工单
                                string tempcallback = "function (data){ eval(data); })}) ";
                                //回调方法内容
                                string temptouch = ";" + "$('#" + controlid + "')." + dv[i]["EventType"].ToString() + "();";
                                tempcontent = tempevent + tempfunction + tempparam + tempcallback.ToString() + temptouch;
                            }
                            //var no = tempcontent.IndexOf("data", tempcontent.IndexOf("data") + 1);
                            //tempcontent = tempcontent.Remove(no, 4);
                            //tempcontent = tempcontent.Insert(no, data);
                        }
                        content += tempcontent;
                    }
                }
                return content;
            }
            else
            {
                return "show('" + result + "',false)";
            }
        }

        #region 解析html
        private static string analysishtml(string stationId, string content)
        {
            string result = "<script>";
            string Content = "";
            string Template = "";
            string TemplateParse = "";
            string TemplateData = "";
            string Add_Fields = "";
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
                else
                {
                    result = "show('未查询出加载页面信息！',false)";
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

            return analysishtml(Content, Template, TemplateParse, TemplateData, Add_Fields, result);
        }

        private static string analysishtml(string content, string template,string templateParse,string templateData,string add_Fields,string result)
        {
            #region 设置数据
            //string result = "<script>";
            string Content = content;
            string Template = template;
            string TemplateParse = templateParse;
            string TemplateData = templateData;
            string Add_Fields = add_Fields;
            string scriptstr = "";
            
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
                        scriptstr += "<div class='divHeader'>列表控件"
                                  + "<span style='float:right'><input type='button' onclick='tbAddRow(this)' value='添加一行'></input></span>"
                                  + "</div>"
                                  + "<table class='ListTable' id='" + id + "_copy' style=' width:" + mJObj["uictrlwidth"].ToString() + ";text-align:left'>"
                                  + "<tbody>{0}</tdoby></table>";

                        //列名
                        string Tempcolnamestr = "<tr  class='ListTableHeader'>";
                        //first行(例子)
                        string Tempcolstr = "<tr class='ListTableOddRow template'>";
                        //合计列
                        string sumstr = "";
                        string tempsumstr = "";
                        var sumarr = new string[columnNo.Length];
                        if (mJObj["uictrlsum"] != null && mJObj["uictrlsum"].ToString().IndexOf("1")>0)
                        {
                            sumstr = "<tbody id='tosum'><tr class='ListTableOddRow'>{0}</tr></tbody>";
                            tempsumstr = "";
                            sumarr = mJObj["uictrlsum"].ToString().Split('`');
                        }
                        for (int q = 0; q < columnNo.Length; q++)
                        {
                            if (sumarr[q] != null && sumarr[q].ToString() == "1")
                            {
                                Tempcolnamestr += "<th>" + columnNo[q] + "</th>";
                                Tempcolstr += "<td><input type='" + columnNotype[q] + "' IsNumber='1' onblur='sum_total(this)' name='" + columnNo[q] + q.ToString() + "'  class='" + (columnNotype[q] == "textarea" ? "TxexArea" : "TextBox") + "'></td>";
                                tempsumstr += "<td>" + "合计：<input type='text' class='input-small' name='" + columnNo[q] + q.ToString() + "' readonly='readonly' value=''>" + "</td>";
                            }
                            else if (sumarr[q] != null && sumarr[q].ToString() == "0")
                            {
                                Tempcolnamestr += "<th>" + columnNo[q] + "</th>";
                                Tempcolstr += "<td><input type='" + columnNotype[q] + "' name='" + columnNo[q] + q.ToString() + "' class='" + (columnNotype[q] == "textarea" ? "TextArea" : "TextBox") + "'></td>";
                                tempsumstr += "<td>" + "</td>";
                            }
                            else
                            {
                                Tempcolnamestr += "<th>" + columnNo[q] + "</th>";
                                Tempcolstr += "<td><input type='" + columnNotype[q] + "' name='" + columnNo[q] + q.ToString() + "' class='" + (columnNotype[q] == "textarea" ? "TextArea" : "TextBox") + "'></td>";
                            }
                        }
                        sumstr = string.Format(sumstr, tempsumstr + "<td></td>");
                        Tempcolnamestr += "<th>操作</th></tr>";
                        //+删除按钮
                        Tempcolstr += "<td><a href='javascript:void(0);' onclick='fnDeleteRow(this)' class='delrow hide' style='display: inline;'>删除</a></td></tr>";
                        scriptstr = string.Format(scriptstr, Tempcolnamestr + Tempcolstr + sumstr);

                        scriptstr = "$('#" + id + "').after(\"" + scriptstr + "\");$('#" + id + "').hide();";
                        #endregion
                        result += scriptstr;
                        break;
                    case "gridctrl":
                        id = mJObj["id"];
                        #region 生成table
                        columnNo = mJObj["uictrltitle"].ToString().Split('`').Where(m => m.Count(k => k.ToString() != "") > 0).ToArray();
                        columnNotype = mJObj["uictrlcoltype"].ToString().Split('`').Where(m => m.Count(k => k.ToString() != "") > 0).ToArray();
                        scriptstr = "<div class='divHeader'>" + mJObj["uictrllisttitle"].ToString() + "</div>"
                                  + "<table id=" + id + "_copy" + " class='ListTable' style=' width:" + mJObj["uictrlwidth"].ToString() + "';>{0}</table>";
                        string temp = "<tr  class='ListTableHeader'>";
                        for (int g = 0; g < columnNo.Length; g++)
                        {
                            temp += "<th>" + columnNo[g] + "</th>";
                        }
                        temp += "</tr>";
                        scriptstr = string.Format(scriptstr, temp);
                        result += "$('#" + id + "').after(\"" + scriptstr + "\");$('#" + id + "').hide();";
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
        public static bool IsSN(string SN, ref string Route,ref string itemid, ref string prodOrderId, ref string result)
        {
            ProductionCollection.Client.ProdCollectionCommon model = new ProductionCollection.Client.ProdCollectionCommon();
            int ResourceId = basedataArr[4] == "" ? 0 : Convert.ToInt32(basedataArr[4]);
            try
            {
                model.ProcessValidation(SN, Convert.ToInt32(basedataArr[0]), Convert.ToInt32(basedataArr[2]), ResourceId, false);

                SqlParameter[] parms = new SqlParameter[]{
                                new SqlParameter("@SN", SqlDbType.VarChar)};
                parms[0].Value = SN;
                string sql = @"SELECT B.Value AS Serail_Number,C.Station,A.* FROM dbo.Prod_Unit A INNER JOIN dbo.Prod_SerialNumber B ON A.UID = B.UID
                                            LEFT JOIN dbo.Basal_Station C ON A.OpeID = C.StationId
                                            INNER JOIN dbo.Basal_RouterDetail D ON A.R_ID = D.R_ID AND A.OpeID=D.Incoming_OpeID
                                            WHERE  B.Value=@SN";
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, sql, parms);

                Route = dt.Rows[0]["R_ID"].ToString();
                itemid = dt.Rows[0]["ItemID"].ToString();
                prodOrderId = dt.Rows[0]["ProdOrderID"].ToString();
                return true;
            }
            catch(Exception ex)
            {
                result = ex.Message;
                return false;
            }
        }
        #endregion


    }
}
