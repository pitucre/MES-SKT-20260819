/*-------------------------------------------------
// Copyright(C)2015 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:AjaxClientConfig.cs
// 文件功能描述：用于生产采集模块中的前台与数据库交互
// 
// 创建标识：Larry.Lin 2016/07/25
// 
// 
//--------------------------------------------------*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using System.Text;
using SKT.LeanMES.ClientConfig;
using System.Data;
using SKT.Common.Framework.Model;
using SKT.LeanMES.ClientConfig.Model;
using SKT.LeanMES.Order.Model;
using SKT.LeanMES.Order.BLL;
using SKT.LeanMES.CustomMenu.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data.SqlClient;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxClientConfig
    {
        enum InfoType
        { 
            ProInfo = 1,
            ProCalculate=2
        }

        enum DisplayType
        {
            NormalSpan=1,
            TextArea=2
        };
        [AjaxMethod]
        public object ExeMenuBottonExt(string procname, string xml, int userId)
        {
            try
            {
                return new SKT.LeanMES.CustomMenu.BLL.MenuBottonConfig().ExeMenuBottonExt(procname, xml, userId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        [AjaxMethod]
        public void SaveMenuBotton(string xml, string module, string page, string username)
        {
            try
            {
                new SKT.LeanMES.CustomMenu.BLL.MenuBottonConfig().Edit(xml, module, page, username);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public List<FrameworkButtonsExt> GetMenuBotton(string page)
        {
            try
            {
                return new SKT.LeanMES.CustomMenu.BLL.MenuBottonConfig().GetButtons(page);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 获取需显示参数信息
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetDisplayProInfo(string name) {
            SKT.LeanMES.ClientConfig.BLL.ClientProInfoConfig bll = new SKT.LeanMES.ClientConfig.BLL.ClientProInfoConfig();
            IList<SKT.LeanMES.ClientConfig.Model.ClientProInfoConfigInfo> modelList= bll.GetDisplayProInfo(name);
            //需从数据库获取信息的数据字段列表
            string dbNameList = "";
            //产品信息html
            StringBuilder proInfo = new StringBuilder();
            //生产计数html
            StringBuilder proCalculate = new StringBuilder();
             
            foreach (SKT.LeanMES.ClientConfig.Model.ClientProInfoConfigInfo model in modelList)
            {
                StringBuilder html = new StringBuilder();
                if (model.DisplayStyle ==Convert.ToInt32(DisplayType.TextArea))
                {
                    html.Append("<tr><td align='left' class='dds-panel-prodinfo-value'>");
                    html.Append("<textarea id='span-pi-" + model.DbName + "' rows='3' cols='30' class='dds-panel-proinfo-txtarea' readonly >");
                    html.Append("</textarea></td></tr>");
                }
                else
                {
                    html.Append("<tr><td align='left' class='dds-panel-prodinfo-name mesLang'>");
                    html.Append(model.InfoName+"：");
                    html.Append("</td>");
                    if (model.InfoType == Convert.ToInt32(InfoType.ProInfo))//产品信息
                    {
                        html.Append("</tr><tr>");
                    }

                    string style = model.DisplayCSS == "" ? "" : "style=\"" + model.DisplayCSS + "\"";
                    html.Append("<td align='left' class='dds-panel-prodinfo-value'>");
                    html.Append("<span id='span-pi-" + model.DbName + "' " + style + "></span>");
                    html.Append("</td></tr>");
                }

                if (model.InfoType ==Convert.ToInt32(InfoType.ProInfo))//产品信息
                {
                    proInfo.Append(html.ToString());
                }
                else if (model.InfoType == Convert.ToInt32(InfoType.ProCalculate))//生产计数
                {
                    proCalculate.Append(html.ToString());
                }
                dbNameList += model.DbName+",";
            }

            string proInfoStr = "";
            string proCalculateStr = "";
            if (!String.IsNullOrEmpty(proInfo.ToString()))
            {
                proInfoStr = "<table cellspacing='2' cellpadding='0' width='100%'>" + proInfo.ToString() + "</table>";
            }
            if (!String.IsNullOrEmpty(proCalculate.ToString()))
            {
                proCalculateStr = "<table cellspacing='2' cellpadding='0' width='100%'>" + proCalculate.ToString() + "</table>";
            }
             
            if (dbNameList.Length > 0) {
                dbNameList = dbNameList.Substring(0, dbNameList.Length-1);
            }

            return new string[] { dbNameList, proInfoStr, proCalculateStr };
        }

        /// <summary>
        /// 更新当前相关产品信息：工单号、产品代码等等...
        /// </summary>
        /// <param name="dbNameList"></param>
        /// <param name="filterSettings"></param>
        /// <returns></returns>
        [AjaxMethod]
        public DataTable GetProInfo(string dbNameList, string filterSettings, string currStationId)
        {
            try
            {
                if (dbNameList == "")
                {
                    return new DataTable();
                }
                SKT.LeanMES.ClientConfig.BLL.ClientProInfoConfig bll = new SKT.LeanMES.ClientConfig.BLL.ClientProInfoConfig();
                return bll.GetProInfo(dbNameList, filterSettings, currStationId);
            }
            catch (Exception ex) 
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        
        /// <summary>
        /// 加载buttonlist返回给页面
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ButtonInfo> LoadButtons(String pageName)
        {
            Boolean isWarrantted = false;
            Int32 userId = AccountController.GetCurrentUser().UserId;

            List<ButtonInfo> buttonList;

            isWarrantted = SKT.Common.Framework.BLL.Page.CheckPagePopedom(userId, pageName, out buttonList);
            return buttonList;
        }

        /// <summary>
        /// 检查是否有UI的页面权限
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool PagePopedomValidation(string pageName)
        {
            bool IsHavePopedom = false;            

            System.Data.SqlClient.SqlParameter[] param = new System.Data.SqlClient.SqlParameter[] {
                    new System.Data.SqlClient.SqlParameter("@PopedomName",SqlDbType.NVarChar),
                    new System.Data.SqlClient.SqlParameter("@Url",SqlDbType.NVarChar,500),
                    new System.Data.SqlClient.SqlParameter("@UserId",SqlDbType.Int),
                    };
            param[0].Value = pageName;
            param[1].Value = "Client/";//UI存放的目录
            param[2].Value = AccountController.GetCurrentUser().UserId;

            int PopedomId = 0;
            using (System.Data.SqlClient.SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "uspPopedomValidation", param))
            {
                while (rdr.Read())
                {
                    PopedomId = Convert.ToInt32(rdr["PopedomId"]);
                    IsHavePopedom = true;
                }
                rdr.Close();
            }
            if (PopedomId != 0 && !SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(AccountController.GetCurrentUser().UserId, PopedomId))
            {
                IsHavePopedom = false;
            }
            return IsHavePopedom;
        }


        /// <summary>
        /// 编辑或者新增站位权限配置信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public Int32 PopedomInStationEdit(PopedomInStationInfo entity) 
        {
            try
            {
                if (entity.PopedomInStationId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
               return new SKT.LeanMES.ClientConfig.BLL.PopedomInStation().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return -1;
            }
        }

        /// <summary>
        /// 编辑动态信息栏位信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Int32 ClientProInfoConfigEdit(ClientProInfoConfigInfo entity) 
        {
            try
            {
                if (entity.ClientProInfoConfigId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                return new SKT.LeanMES.ClientConfig.BLL.ClientProInfoConfig().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return -1;
            }
        }

        /// <summary>
        /// 根据当前工位和路由获取前后工位
        /// </summary>
        /// <param name="currStationId">当前工位</param>
        /// <param name="routeId">路由Id</param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetLastNextStation(int currStationId,int routeId)
        {
            SKT.LeanMES.ClientConfig.BLL.PopedomInStation bll = new LeanMES.ClientConfig.BLL.PopedomInStation();
            DataTable dt = bll.GetLastNextStation(currStationId, routeId);
            Boolean firstLast = true;
            Boolean firstNext = true;
            return GenLastNextStation(dt,firstLast,firstNext);
        }

        /// <summary>
        /// 获取当前工序前五个过站成功的条码
        /// </summary>
        [AjaxMethod]
        public string GetPassStationBySN(int StationId)
        {
            try
            {
                return (new LeanMES.ClientConfig.BLL.PopedomInStation()).GetPassStationBySN(StationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return ex.Message;
            }
        }

        /// <summary>
        /// 根据sn和当前站位获取前后工序-PDA
        /// </summary>
        /// <param name="currStationId"></param>
        /// <param name="serialNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetLastNextStationBySNPDA(int currStationId, string serialNumber)
        {
            //SKT.LeanMES.ProdUnit.BLL.ProdUnit bll = new SKT.LeanMES.ProdUnit.BLL.ProdUnit();
            //return GetLastNextStation(currStationId, bll.GetProdUnitInfo(serialNumber).RouterId);
            LeanMES.ClientConfig.BLL.PopedomInStation bll = new LeanMES.ClientConfig.BLL.PopedomInStation();
            if (string.IsNullOrEmpty(serialNumber))
            {
                serialNumber = "XXXXXX";//如果扫描X板为空会报错
            }
            DataTable dt = bll.GetNearStationBySNPDA(currStationId, serialNumber);
            Boolean firstLast = true;
            Boolean firstNext = true;
            return GenLastNextStationPDA(dt, firstLast, firstNext);

        }

        [AjaxMethod]
        public string[] GenLastNextStationPDA(DataTable dt, Boolean firstLast, Boolean firstNext)
        {
            StringBuilder lastStation = new StringBuilder();
            StringBuilder nextStation = new StringBuilder();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["InOrOut"].ToString().Equals("0"))
                {
                    //前一工序
                    if (firstLast)
                    {
                        lastStation.Append("<div><a class='dropdown-station-hd'  href='javascript:void(0);' title='" + dt.Rows[i]["Station"].ToString() + "'>" + TruncateChar(dt.Rows[i]["Station"].ToString(), 14) + "</a></div>");
                        lastStation.Append("<div class='dropdown-station-bd' id='laststationitems'>");
                        lastStation.Append(" <div class='dropdown-station-bd-panel'>");
                        firstLast = false;
                    }
                    else
                    {
                        lastStation.Append("<div>");
                        lastStation.Append(" <a href='javascript:void(0);' title='" + dt.Rows[i]["Station"].ToString() + "'>" + TruncateChar(dt.Rows[i]["Station"].ToString(), 14) + "</a>");
                        lastStation.Append("</div>");
                    }
                }
                else
                {
                    //后一工序
                    if (firstNext)
                    {
                        nextStation.Append("<div><a class='dropdown-station-hd'  href='javascript:void(0);' title='" + dt.Rows[i]["Station"].ToString() + "'>" + TruncateChar(dt.Rows[i]["Station"].ToString(), 14) + "</a></div>");
                        nextStation.Append("<div class='dropdown-station-bd' id='nextStationitems'>");
                        nextStation.Append(" <div class='dropdown-station-bd-panel'>");
                        firstNext = false;
                    }
                    else
                    {
                        nextStation.Append("<div>");
                        nextStation.Append(" <a href='javascript:void(0);' title='" + dt.Rows[i]["Station"].ToString() + "'>" + TruncateChar(dt.Rows[i]["Station"].ToString(), 14) + "</a>");
                        nextStation.Append("</div>");
                    }
                }
            }
            if (!firstLast)
            {
                lastStation.Append(" </div>");
                lastStation.Append("</div>");
            }
            if (!firstNext)
            {
                nextStation.Append(" </div>");
                nextStation.Append("</div>");
            }
            if (lastStation.ToString() == "")
            {
                lastStation.Append("<div><a class='dropdown-station-hd'  href='javascript:void(0);' title='Start'>Start</a></div>");
                lastStation.Append("<div class='dropdown-station-bd' id='laststationitems'>");
                lastStation.Append(" <div class='dropdown-station-bd-panel'>");
                lastStation.Append(" </div>");
                lastStation.Append("</div>");
            }
            return new string[] { lastStation.ToString(), nextStation.ToString(), dt.Rows[0]["OrderNo"].ToString(), dt.Rows[0]["ItemCode"].ToString(), dt.Rows[0]["QtyStr"].ToString(), dt.Rows[0]["ProdOrderID"].ToString() };
        }

        /// <summary>
        /// 根据sn和当前站位获取前后工序
        /// </summary>
        /// <param name="currStationId"></param>
        /// <param name="serialNumber"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetLastNextStationBySN(int currStationId,string serialNumber) 
        {
            //SKT.LeanMES.ProdUnit.BLL.ProdUnit bll = new SKT.LeanMES.ProdUnit.BLL.ProdUnit();
            //return GetLastNextStation(currStationId, bll.GetProdUnitInfo(serialNumber).RouterId);
            LeanMES.ClientConfig.BLL.PopedomInStation bll = new LeanMES.ClientConfig.BLL.PopedomInStation();
            if (string.IsNullOrEmpty(serialNumber))
            {
                serialNumber = "XXXXXX";//如果扫描X板为空会报错
            }
            DataTable dt = bll.GetNearStationBySN(currStationId, serialNumber);
            Boolean firstLast = true;
            Boolean firstNext = true;
            return GenLastNextStation(dt, firstLast, firstNext);
            
        }


        /// <summary>
        /// 根据生成前后工序HTML
        /// </summary>
        /*param eg:
            Station	                    InOrOut
            A-SMTRepair(BOT)	                0
            A-UnitCreation	                0
            A-PreReflow(BOT)(Pass)	        1
            A-SMTRepair(BOT)(Failed)	        1
         */
        [AjaxMethod]
        public string[] GenLastNextStation(DataTable dt, Boolean firstLast, Boolean firstNext)
        {
            StringBuilder lastStation = new StringBuilder();
            StringBuilder nextStation = new StringBuilder();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["InOrOut"].ToString().Equals("0"))
                {
                    //前一工序
                    if (firstLast)
                    {
                        lastStation.Append("<div><a class='dropdown-station-hd'  href='javascript:void(0);' title='" + dt.Rows[i]["Station"].ToString() + "'>" + TruncateChar(dt.Rows[i]["Station"].ToString(), 14) + "</a></div>");
                        lastStation.Append("<div class='dropdown-station-bd' id='laststationitems'>");
                        lastStation.Append(" <div class='dropdown-station-bd-panel'>");
                        firstLast = false;
                    }
                    else
                    {
                        lastStation.Append("<div>");
                        lastStation.Append(" <a href='javascript:void(0);' title='" + dt.Rows[i]["Station"].ToString() + "'>" + TruncateChar(dt.Rows[i]["Station"].ToString(), 14) + "</a>");
                        lastStation.Append("</div>");
                    }
                }
                else
                {
                    //后一工序
                    if (firstNext)
                    {
                        nextStation.Append("<div><a class='dropdown-station-hd'  href='javascript:void(0);' title='" + dt.Rows[i]["Station"].ToString() + "'>" + TruncateChar(dt.Rows[i]["Station"].ToString(), 14) + "</a></div>");
                        nextStation.Append("<div class='dropdown-station-bd' id='nextStationitems'>");
                        nextStation.Append(" <div class='dropdown-station-bd-panel'>");
                        firstNext = false;
                    }
                    else
                    {
                        nextStation.Append("<div>");
                        nextStation.Append(" <a href='javascript:void(0);' title='" + dt.Rows[i]["Station"].ToString() + "'>" + TruncateChar(dt.Rows[i]["Station"].ToString(), 14) + "</a>");
                        nextStation.Append("</div>");
                    }
                }
            }
            if (!firstLast)
            {
                lastStation.Append(" </div>");
                lastStation.Append("</div>");
            }
            if (!firstNext)
            {
                nextStation.Append(" </div>");
                nextStation.Append("</div>");
            }
            if (lastStation.ToString() == "")
            {
                lastStation.Append("<div><a class='dropdown-station-hd'  href='javascript:void(0);' title='Start'>Start</a></div>");
                lastStation.Append("<div class='dropdown-station-bd' id='laststationitems'>");
                lastStation.Append(" <div class='dropdown-station-bd-panel'>");
                lastStation.Append(" </div>");
                lastStation.Append("</div>");
            }
            return new string[] { lastStation.ToString(), nextStation.ToString() };
        }



        /// <summary>
        /// 根据工单获取路由Id并返回
        /// </summary>
        /// <param name="ProOrderId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int GetRouteIdByProOrderId(int ProOrderId)
        {
            SKT.LeanMES.Order.BLL.ShopOrder bll = new Order.BLL.ShopOrder();
            SKT.LeanMES.Order.Model.ShopOrderInfo model = new Order.Model.ShopOrderInfo();
            model = bll.GetInfoByOrderId(ProOrderId);
            if (model != null)
            {
                //如果工单没有配置路由，则继续查询对应产品的路由
                if (model.RouterId == -1)
                {
                    SKT.LeanMES.Product.BLL.Item itemBLL = new LeanMES.Product.BLL.Item();
                    SKT.LeanMES.Product.Model.ItemInfo itemModel = new LeanMES.Product.Model.ItemInfo();
                    itemModel = itemBLL.GetInfo(model.ItemId);
                    if (itemModel != null)
                    {
                        return itemModel.RouterID;
                    }
                    else
                    {
                        return -1;
                    }
                }
                return model.RouterId;
            }
            else 
            {
                return -1;
            }
        }

        [AjaxMethod] // 2016.09.07 Beck Ye取得ShopOrderInfo,如果从产品取路由,将值插入回ShopOrderInfo
        public ShopOrderInfo GetOrderInfoByProOrderId(int ProOrderId, int TypeFlag)
        {
            SKT.LeanMES.Order.BLL.ShopOrder bll = new Order.BLL.ShopOrder();
            SKT.LeanMES.Order.Model.ShopOrderInfo model = new Order.Model.ShopOrderInfo();
            model = bll.GetInfoByOrderId(ProOrderId);
            if (model != null)
            {
                //如果工单没有配置路由，则继续查询对应产品的路由
                if (model.RouterId == -1)
                {
                    SKT.LeanMES.Product.BLL.Item itemBLL = new LeanMES.Product.BLL.Item();
                    SKT.LeanMES.Product.Model.ItemInfo itemModel = new LeanMES.Product.Model.ItemInfo();
                    itemModel = itemBLL.GetInfo(model.ItemId);
                    if (itemModel != null)
                    {
                        model.RouterId = itemModel.RouterID;
                        return model;
                    }
                    else
                    {
                        return model;
                    }
                }
                return model;
            }
            else
            {
                return model;
            }
        }

        public int GetWorkOrderBySN(string serialNumber)
        {
            SKT.LeanMES.SerialNumber.BLL.SerialNumber bll = new SKT.LeanMES.SerialNumber.BLL.SerialNumber();
            
            return -1;
        }

        /// <summary>
        /// 用户相关工序信息编辑
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void UsersInStationEdit(UsersInStationInfo entity)
        {
            if (entity.UsersInStationId == -1)
            {
                entity.CreateBy = AccountController.GetCurrentUser().UserName;
                entity.ModifyBy = "";
            }
            else
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                entity.CreateBy = "";
            }
            try
            {
                new SKT.LeanMES.ClientConfig.BLL.UsersInStation().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #region 以下为通用方法，建议写到utility
        //**********************************以下为通用方法，建议写到utility***********************************************

        /// <summary>
        /// 获取资源****************建议写到通用方法里面
        /// </summary>
        /// <param name="resClass"></param>
        /// <param name="resKey"></param>
        /// <returns></returns>
        [AjaxMethod]
        public String GetResourceString(string resClass, string resKey)
        {
            string str = "";

            HttpCookie cookie = HttpContext.Current.Request.Cookies["lang"];
            string lang = cookie == null ? "zh-cn" : cookie.Value;
            Object resource = HttpContext.GetGlobalResourceObject(resClass, resKey, new System.Globalization.CultureInfo(lang));
            if (resource != null)
            {
                str = resource.ToString();
            }
            return str;
        }

        /// <summary>
        /// 截取字符段
        /// </summary>
        /// <param name="resource">被截取字符串</param>
        /// <param name="maxLength">最大允许长度</param>
        /// <returns></returns>
        public string TruncateChar(string resource,int maxLength)
        {
            if (resource.Length > maxLength)
            {
                resource = resource.Substring(0, maxLength - 3) + "...";
            }
            return resource;
        }

        #endregion


        [AjaxMethod]
        public void SaveGridCellsSet(string url, string gridId, string cells)
        {
            try
            {
                SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, @"delete SYS_UserGridCellsSet where UserName=@UserName and PageUrl=@PageUrl and GridId=@GridId
                insert into SYS_UserGridCellsSet(UserName, PageUrl, GridId, Cells) values(@UserName, @PageUrl, @GridId, @Cells)",
                new System.Data.SqlClient.SqlParameter[]{
                    new System.Data.SqlClient.SqlParameter("@UserName",AccountController.GetCurrentUser().UserName),
                    new System.Data.SqlClient.SqlParameter("@PageUrl",url),
                    new System.Data.SqlClient.SqlParameter("@GridId",gridId),
                    new System.Data.SqlClient.SqlParameter("@Cells",cells)
                });
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        [AjaxMethod]
        public void ResetGridCellsSet(string url, string gridId)
        {
            try
            {
                SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, @"delete SYS_UserGridCellsSet where UserName=@UserName and PageUrl=@PageUrl and GridId=@GridId",
                new System.Data.SqlClient.SqlParameter[]{
                    new System.Data.SqlClient.SqlParameter("@UserName",AccountController.GetCurrentUser().UserName),
                    new System.Data.SqlClient.SqlParameter("@PageUrl",url),
                    new System.Data.SqlClient.SqlParameter("@GridId",gridId)
                });
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 查询生产数据配置
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetMaterialSysConfig(int ConfigTypeId)
        {
            string Str = "";
            try
            {
                string Sql = @"SELECT ConfigResult FROM  Prod_MaterialSysConfig WITH(NOLOCK) WHERE ConfigTypeId=@ConfigTypeId";
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ConfigTypeId", SqlDbType.Int) { Value = ConfigTypeId }
            };
                Str = ComMethod.GetBySql(Sql, parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }

            return Str;

        }
    }

    public class GridCells
    {
        public string field { get; set; }
        public string title { get; set; }
        public string width { get; set; }
        public string sort { get; set; }
        public string format { get; set; }
        public int no { get; set; }
        public bool hide { get; set; }
        public bool rowspan { get; set; }
        public bool sum { get; set; }
    }
}//namespace SKT.LeanMES.Web.AjaxServices