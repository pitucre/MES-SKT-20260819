/*-------------------------------------------------
// Copyright(C)2016 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:ClientProInfoConfig.cs
// 文件功能描述：用于生产采集模块中的产品信息以及生产计数的配置和数据获取
// 
// 创建标识：Larry.Lin 2016/07/27
// 
// 
//--------------------------------------------------*/
using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.ClientConfig.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Reflection;

namespace SKT.LeanMES.ClientConfig.BLL
{
    public class ClientProInfoConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ClientProInfoConfig 信息。
        /// </summary>
        /// <param name="entity">ClientProInfoConfig 实体对象。</param>
        public Int32 Edit(ClientProInfoConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ClientProInfoConfigId", SqlDbType.Int),
                new SqlParameter("@InfoName", SqlDbType.VarChar, 20),
                new SqlParameter("@DbName", SqlDbType.VarChar, 30),
                new SqlParameter("@IsDisplay", SqlDbType.Bit),
                new SqlParameter("@InfoType", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@DisplayStyle", SqlDbType.Int),
                new SqlParameter("@Popedom", SqlDbType.VarChar, 1000),
                new SqlParameter("@DisplayCSS", SqlDbType.NVarChar,400)
            };

            parms[0].Value = entity.ClientProInfoConfigId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.InfoName;
            parms[2].Value = entity.DbName;
            parms[3].Value = entity.IsDisplay;
            parms[4].Value = entity.InfoType;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = entity.DisplayStyle;
            parms[8].Value = entity.Popedom;
            parms[9].Value = entity.DisplayCSS;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_ClientProInfoConfig_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ClientProInfoConfigId 字符串删除 ClientProInfoConfig 信息。
        /// </summary>
        /// <param name="idString">ClientProInfoConfigId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_ClientProInfoConfig_Delete", parms);
        }

        /// <summary>
        /// 根据 ClientProInfoConfigId 获取实体信息。
        /// </summary>
        /// <param name="clientProInfoConfigId">ClientProInfoConfigId。</param>
        /// <returns>ClientProInfoConfig 实体对象。</returns>
        public ClientProInfoConfigInfo GetInfo(Int32 clientProInfoConfigId)
        {
            ClientProInfoConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = clientProInfoConfigId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_ClientProInfoConfig_GetInfo", parms))
            {
                if (rdr.HasRows)
                {
                    entity = Helper.SqlDataReaderConverToList<ClientProInfoConfigInfo>(rdr)[0];
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ClientProInfoConfig 实体对象。</returns>
        public ClientProInfoConfigInfo GetInfo(String fieldValue)
        {
            ClientProInfoConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_ClientProInfoConfig_GetInfo", parms))
            {
                if (rdr.HasRows)
                {
                    entity = Helper.SqlDataReaderConverToList<ClientProInfoConfigInfo>(rdr)[0];
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ClientProInfoConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="clientProInfoConfigCount">clientProInfoConfig 总数。</param>
        /// <returns>ClientProInfoConfig 列表。</returns>
        public List<ClientProInfoConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ClientProInfoConfigInfo> list = new List<ClientProInfoConfigInfo>();
            ClientProInfoConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SYS_ClientProInfoConfig", "ClientProInfoConfigId",
                "[ClientProInfoConfigId], [InfoName], [DbName], [IsDisplay], [InfoType], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [DisplayStyle], [DisplayCSS]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ClientProInfoConfigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetBoolean(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetInt32(9), rdr.GetString(10));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取客户端动态数据显示区域需要显示的内容列表
        /// </summary>
        /// <returns></returns>
        public IList<ClientProInfoConfigInfo> GetDisplayProInfo(string name)
        {
            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@PopedomName",SqlDbType.VarChar,50)
            };
            paras[0].Value = name;
            IList<ClientProInfoConfigInfo> list = new List<ClientProInfoConfigInfo>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_ClientProInfoConfig_GetDisplayInfo", paras))
            {
                list = Helper.SqlDataReaderConverToList<ClientProInfoConfigInfo>(rdr);
                rdr.Close();
            }
            return list == null ? new List<ClientProInfoConfigInfo>() : list;
        }

        /// <summary>
        /// 获取产品相关的动态信息
        /// </summary>
        /// <param name="dbNameList">需要获取的产品信息列表，用逗号隔开直接应用于sql中</param>
        /// <param name="filterSettings">查询的条件，配置为可以直接应用于sql查询中</param>
        /// <returns></returns>
        public DataTable GetProInfo(string dbNameList, string filterSettings, string currStationId)
        {
            SqlParameter[] param = new SqlParameter[]{
                                new SqlParameter("@DbNameList",DbType.String),
                                new SqlParameter("@FilterSettings",DbType.String),
                                new SqlParameter("@CurrStationId",DbType.String)
                            };
            param[0].Value = dbNameList;
            param[1].Value = filterSettings;
            param[2].Value = currStationId;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "SYS_ClientProInfoConfig_GetProInfo", param);
        }



        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 记录用户登录选择的工序资源等信息
        /// </summary>
        /// <param name="stationId"></param>
        /// <param name="redId"></param>
        /// <param name="userId"></param>
        /// <param name="hostName">用户主机名称</param>
        /// <param name="hostAddress">用户IP地址</param>
        public void SetUserLoginCache(int stationId, int redId, int userId, string hostName, string hostAddress)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@UserId", SqlDbType.Int),
                new SqlParameter("@HostName", SqlDbType.VarChar,50),
                new SqlParameter("@HostAddress", SqlDbType.VarChar,50)             
            };

            parms[0].Value = stationId;
            parms[1].Value = redId;
            parms[2].Value = userId;
            parms[3].Value = hostName;
            parms[4].Value = hostAddress;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSetUserLoginCache", parms);
        }

        /// <summary>
        /// 获取用户默认登录地址信息
        /// </summary>
        /// <param name="userId"></param>
        /// <returns></returns>
        public string GetUserLoginCache(int userId)
        {
            SqlParameter[] parms = new SqlParameter[]{              
                new SqlParameter("@UserId", SqlDbType.Int)        
            };

            parms[0].Value = userId;

            object result = SQLHelper.ExecuteScalarStoredProcedure(SQLHelper.MESConnString, "uspGetUserLoginCache", parms);
            if (result != null)
            {
                return result.ToString();
            }
            return "";
        }
    }
}