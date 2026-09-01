using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using SKT.LeanMES.Kanban.BLL;
using SKT.LeanMES.Kanban.Model;
using System.Runtime.InteropServices;
using System.Web;
using System.Text;
using SKT.Common.DAL.Marshal;
using System.Data;
using System.Web.UI;

namespace SKT.LeanMES.Web.Kanban
{
    public partial class KanbanSingle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));
                string tmpName = Request.QueryString["name"];

                string Tmp_ClientIP = "";
                string Tmp_ClientMac = "";
                GetClientMac(out Tmp_ClientIP, out Tmp_ClientMac);
                hidMachineMac.Value = Tmp_ClientMac;


                if (tmpName == null)
                {


                    string cmdTxt = "SELECT top 1 TemplateName FROM dbo.Report_Template WHERE TemplateDesc like '{" + Tmp_ClientMac + "}%'";
                    DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.ReportConnString, cmdTxt, null);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        Response.Redirect("~/Kanban/KanbanPage.aspx?name=" + dt.Rows[0][0] + "&full=1");
                    }
                    else
                    {
                        //不执行MAC地址新增，因为发布后的MES，无法获取客户端MAC地址
                        //return;
                        try
                        {
                            //将当前设备的MAC地址提交到服务器，供维护
                            string cmdTxt1 = string.Format("if not exists(select 1 from Kanban_DeviceMac where MacAddress = '{2}') begin INSERT INTO Kanban_DeviceMac(MacAddress,Remark) VALUES('{0}','{1}') end", Tmp_ClientMac, Tmp_ClientIP, Tmp_ClientMac);
                            SQLHelper.ExecuteNonQueryText(SQLHelper.ReportConnString, cmdTxt1, null);

                            //如果根据当前MAC地址没有找到对应的看板，则让界面每5秒刷新一次，一旦维护了该MAC对应的看板则会立即显示
                            var script = "setInterval(function () {window.location.reload();}, 1000 * 5); ";
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "msgBox", script, true);
                        }
                        catch (Exception ex)
                        {
                            WebHelper.HandleException("Kanban", ex, false);
                        }
                    }
                    return;
                }

                MasterInfo kanbanMaster = new Master().GetKanbanPageByTmp(tmpName);
                if (kanbanMaster != null)
                {
                    int tmpID = kanbanMaster.RptTemplateId;
                    int masterID = kanbanMaster.KanbanMasterId;
                    string masterTitle = kanbanMaster.Title;
                    hfMasterTitle.Value = masterTitle;              //master.title
                    hfMasterFoot.Value = kanbanMaster.FootHtml;

                    List<MasterInfo> listContain = new Master().GetMapMaster(tmpID);
                    if (listContain != null && listContain.Count > 0)
                    {
                        hfContainList.Value = new JavaScriptSerializer().Serialize(listContain);//容器列表
                    }
                }
                hfServerTime.Value = DateTime.Now.ToString("yyyy-MM-dd");

            }
            catch (Exception ex)
            {
                WebHelper.HandleException("KanbanPageError", ex, true);
            }
        }

        [DllImport("Iphlpapi.dll")]
        static extern int SendARP(Int32 DestIP, Int32 SrcIP, ref Int64 MacAddr, ref Int32 PhyAddrLen);

        [DllImport("Ws2_32.dll")]
        static extern Int32 inet_addr(string ipaddr);

        ///<summary>  
        /// SendArp获取MAC地址  
        ///</summary>  
        ///<param name="RemoteIP">目标机器的IP地址如(192.168.1.1)</param>  
        ///<returns>目标机器的mac 地址</returns>  
        public static string GetMacAddress(string RemoteIP)
        {
            StringBuilder macAddress = new StringBuilder();
            try
            {
                Int32 remote = inet_addr(RemoteIP);
                Int64 macInfo = new Int64();
                Int32 length = 6;
                SendARP(remote, 0, ref macInfo, ref length);
                string temp = Convert.ToString(macInfo, 16).PadLeft(12, '0').ToUpper();
                int x = 12;
                for (int i = 0; i < 6; i++)
                {
                    if (i == 5)
                    {
                        macAddress.Append(temp.Substring(x - 2, 2));
                    }
                    else
                    {
                        macAddress.Append(temp.Substring(x - 2, 2) + "-");
                    }
                    x -= 2;
                }
                return macAddress.ToString();
            }
            catch
            {
                return macAddress.ToString();
            }
        }

        //获取客户IP地址#region 获取客户IP地址
        public static string GetClientIP()
        {
            string result = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (null == result || result == String.Empty)
            {
                result = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

            if (null == result || result == String.Empty)
            {
                result = HttpContext.Current.Request.UserHostAddress;
            }
            return result;
        }

        //获取客户MAC地址#region 获取客户MAC地址
        public static string GetClientMac(out string Tmp_ClientIP, out string Tmp_ClientMac)
        {
            Tmp_ClientIP = "";
            Tmp_ClientMac = "";
            try
            {
                string strClientIP = GetClientIP();
                Int32 ldest = inet_addr(strClientIP); //目的地的ip
                Int64 macinfo = new Int64();
                Int32 len = 6;
                int res = SendARP(ldest, 0, ref macinfo, ref len);
                string mac_src = macinfo.ToString("X");

                if (mac_src == "0")
                {
                    if (strClientIP == "192.168.0.88")
                        Tmp_ClientIP = "本地测试";
                    else
                        Tmp_ClientIP = strClientIP;
                    //return;
                }

                while (mac_src.Length < 12)
                {
                    mac_src = mac_src.Insert(0, "0");
                }

                for (int i = 0; i < 11; i++)
                {
                    if (0 == (i % 2))
                    {
                        if (i == 10)
                        {
                            Tmp_ClientMac = Tmp_ClientMac.Insert(0, mac_src.Substring(i, 2));
                        }
                        else
                        {
                            Tmp_ClientMac = "-" + Tmp_ClientMac.Insert(0, mac_src.Substring(i, 2));
                        }
                    }
                }
                return Tmp_ClientMac;
            }
            catch
            {
                return "";
            }

        }
    }
}