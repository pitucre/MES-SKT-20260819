using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using Microsoft.SqlServer.Server;
using SKT.LeanMES.Kanban.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Kanban.BLL
{
    public class Master
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Master 信息。
        /// </summary>
        /// <param name="entity">Master 实体对象。</param>
        public Int32 Edit(MasterInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ReportId", SqlDbType.Int),
                new SqlParameter("@ReportName", SqlDbType.NVarChar, 100),
                new SqlParameter("@ReportCNName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ReportENName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ReportIcon", SqlDbType.NVarChar, 50),
                new SqlParameter("@ReportSequence", SqlDbType.Int),
                new SqlParameter("@ReportType", SqlDbType.NVarChar, 50),
                new SqlParameter("@ReportDes", SqlDbType.NVarChar, 50),
                new SqlParameter("@ReportContent", SqlDbType.NVarChar,-1),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@DesignJSON", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleLValue", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleMValue", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleRValue", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleLCss", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleMCss", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleRCss", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleLType", SqlDbType.Int),
                new SqlParameter("@TitleMType", SqlDbType.Int),
                new SqlParameter("@TitleRType", SqlDbType.Int),
                new SqlParameter("@BindContList", SqlDbType.NVarChar, -1),
                new SqlParameter("@ContPlayTimeList", SqlDbType.NVarChar, -1),
                new SqlParameter("@Title", SqlDbType.NVarChar, -1),
                new SqlParameter("@FootHtml", SqlDbType.NVarChar, -1)
            };

            parms[0].Value = entity.TemplateId;
            parms[1].Value = entity.TemplateName;
            parms[2].Value = entity.ReportCNName;
            parms[3].Value = entity.ReportENName;
            parms[4].Value = entity.ReportIcon;
            parms[5].Value = entity.ReportSequence;
            parms[6].Value = entity.ReportType;
            parms[7].Value = entity.TemplateDesc;
            parms[8].Value = SKT.Common.Utility.EncryptHelper.Encrypt(entity.TemplateContent);
            parms[9].Value = entity.CreateBy;
            parms[10].Value = entity.ModifyBy;
            parms[11].Value = entity.DesignJson ?? "";
            parms[12].Value = entity.TitleLValue ?? "";
            parms[13].Value = entity.TitleMValue ?? "";
            parms[14].Value = entity.TitleRValue ?? "";
            parms[15].Value = entity.TitleLCss ?? "";
            parms[16].Value = entity.TitleMCss ?? "";
            parms[17].Value = entity.TitleRCss ?? "";
            parms[18].Value = entity.TitleLType;
            parms[19].Value = entity.TitleMType;
            parms[20].Value = entity.TitleRType;
            parms[21].Value = entity.BindContList;
            parms[22].Value = entity.ContPlayTimeList;
            parms[23].Value = entity.Title;
            parms[24].Value = entity.FootHtml;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_Template_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MasterId 字符串删除 Master 信息。
        /// </summary>
        /// <param name="idString">MasterId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void DeleteMaster(String idString)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000)
            };

            parms[0].Value = idString;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_Master_Delete", parms);
        }

        /// <summary>
        /// 根据 Id 字符串删除 控件 信息。
        /// </summary>
        /// <param name="idString">控件 字符串。</param>
        /// <returns>日志内容。</returns>
        public void DeleteComp(String idString)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000)
            };

            parms[0].Value = idString;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_Component_Delete", parms);
        }

        /// <summary>
        /// 根据 Id 字符串删除 Master 信息。
        /// </summary>
        /// <param name="idString">容器 字符串。</param>
        public void DeleteCont(String idString)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000)
            };

            parms[0].Value = idString;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_Container_Delete", parms);
        } 

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Master 实体对象。</returns>
        public MasterInfo GetInfo(int templateId)
        {
            MasterInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TemplateID", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = templateId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Kanban_Master_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MasterInfo();
                    entity.TemplateId = rdr.GetInt32(0);
                    entity.TemplateName = rdr.GetString(1);
                    entity.ReportCNName = rdr.GetString(2);
                    entity.ReportENName = rdr.GetString(3);
                    entity.RTDescription = rdr.GetString(4);
                    entity.TemplateContent = SKT.Common.Utility.EncryptHelper.Decrypt(rdr.GetString(5));
                    entity.ReportType = rdr.GetString(6);
                    entity.RTModuleCNValue = rdr.GetString(7);
                    entity.RTModuleENValue = rdr.GetString(8);
                    entity.ReportIcon = rdr.GetString(9);
                    entity.ReportUrl = rdr.GetString(10);
                    entity.ReportSequence = rdr.GetInt32(11);
                    entity.CreateBy = rdr.GetString(12);
                    entity.CreateDateTime = rdr.GetDateTime(13);
                    entity.ModifyBy = rdr.GetString(14);
                    entity.ModifyDateTime = rdr.GetDateTime(15);
                    entity.DesignJson = rdr["DesignJSON"].ToString();
                    entity.TitleLValue = rdr["TitleLValue"].ToString();
                    entity.TitleLType = (int)rdr["TitleLType"];
                    entity.TitleLCss = rdr["TitleLCss"].ToString();
                    entity.TitleMValue = rdr["TitleMValue"].ToString();
                    entity.TitleMType = (int)rdr["TitleMType"];
                    entity.TitleMCss = rdr["TitleMCss"].ToString();
                    entity.TitleRValue = rdr["TitleRValue"].ToString();
                    entity.TitleRType = (int)rdr["TitleRType"];
                    entity.TitleRCss = rdr["TitleRCss"].ToString();
                    entity.FootHtml = rdr["FootHtml"].ToString();
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Master 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="masterCount">master 总数。</param>
        /// <returns>Master 列表。</returns>
        public List<MasterInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MasterInfo> list = new List<MasterInfo>();
            MasterInfo entity = null;
            searchSettings.AddCondition("IsKanban", "1");

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwReportMember", "TemplateId",
                "TemplateId, [TemplateName],[ReportCNName], [ReportENName], [TemplateDesc], [ReportType],[ReportTypeCNName],[ReportTypeENName], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MasterInfo();
                    entity.RptTemplateId = rdr.GetInt32(0);
                    entity.TemplateName = rdr.GetString(1);
                    entity.ReportCNName = rdr.GetString(2);
                    entity.ReportENName = rdr.GetString(3);
                    entity.RTDescription = rdr.GetString(4);
                    entity.ReportType = rdr.GetString(5);
                    entity.RTModuleCNValue = rdr.GetString(6);
                    entity.RTModuleENValue = rdr.GetString(7);
                    entity.CreateBy = rdr.GetString(8);
                    entity.CreateTime = rdr.GetDateTime(9);
                    entity.CreateDateTime = rdr.GetDateTime(9);
                    entity.ModifyBy = rdr.GetString(10);
                    entity.ModifyTime = rdr.GetDateTime(11);
                    entity.ModifyDateTime = rdr.GetDateTime(11);
                    entity.CreateDateTime = rdr.GetDateTime(9);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        ///保存看板类型
        /// </summary>
        /// <param name="reportTypeName"></param>
        /// <param name="reportTypeNameEN"></param>
        /// <param name="seq"></param>
        /// <param name="reportTypeId"></param>
        /// <param name="userName"></param>
        public void EditKanbanType(string TypeName, string TypeNameEN, float seq, string TypeId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@KanbanTypeName",SqlDbType.VarChar,100),
                new SqlParameter("@KanbanTypeReName",SqlDbType.NVarChar,100),
                new SqlParameter("@Seq",SqlDbType.Float),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@KanbanTypeId",SqlDbType.VarChar,100)
            };

            parms[0].Value = TypeName;
            parms[1].Value = TypeNameEN;
            parms[2].Value = seq;
            parms[3].Value = userName;
            parms[4].Value = TypeId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCreateKanbanMenu", parms);
        }


        /// <summary>
        ///查看类型
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<Kanban.Model.MasterInfo> GetKanbanType(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MasterInfo> list = new List<MasterInfo>();
            MasterInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwKanbanModules", "Popedom",
                "[Name], [ReportCNValues], [ReportENValues], [Popedom],ModifyBy,ModifyDateTime,CreateBy,CreateDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MasterInfo();

                    entity.RTModuleName = rdr.GetString(0);
                    entity.RTModuleCNValue = rdr.GetString(1);
                    entity.RTModuleENValue = rdr.GetString(2);
                    entity.RTDescription = rdr.GetInt32(3).ToString();
                    entity.ModifyBy = rdr.GetString(4);
                    entity.ModifyDateTime = rdr.GetDateTime(5);
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateDateTime =Convert.ToDateTime(rdr["CreateDateTime"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 删除看板类型
        /// </summary>
        /// <param name="reportTypeId"></param>
        /// <param name="username"></param>
        public void DeleteKanbanType(string kanbanTypeId, string username)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ReportTypeId",SqlDbType.VarChar,100),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = kanbanTypeId;
            parms[1].Value = username;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Report_ReportTypeDelete", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 分页获取 Container 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="masterCount">master 总数。</param>
        /// <returns>Container 列表。</returns>
        public List<MasterInfo> GetAllContainer(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MasterInfo> list = new List<MasterInfo>();
            MasterInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwKanbanContainer"
                , "KanbanContainerId",
                "KanbanContainerId, ContainerName,LayoutType, EditOption, Title, Remark, " +
                "CreateBy, CreateTime, ModifyBy, ModifyTime,StatusFlag,IconSrc"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MasterInfo();
                    entity.KanbanContainerId = rdr.GetInt32(0);
                    entity.ContainerName = rdr["ContainerName"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.LayoutType = rdr["LayoutType"].ToString();
                    entity.EditOption = rdr["EditOption"].ToString();
                    entity.Title = rdr["Title"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateTime = rdr.GetDateTime(7);
                    entity.ModifyBy = rdr["ModifyBy"].ToString();
                    entity.ModifyTime = rdr.GetDateTime(9);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// uspGetMapMaster
        /// </summary>
        /// <returns>MapMaster 列表。</returns>
        public List<MasterInfo> GetMapMaster(Int32 template)
        {
            List<MasterInfo> list = new List<MasterInfo>();
            MasterInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@TemplateID",SqlDbType.Int)
            };
            parms[0].Value = template;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "uspGetMapMaster", parms))
            {
                while (rdr.Read())
                {
                    entity = new MasterInfo();

                    entity.KanbanContainerId = (int)rdr["ContainerId"];
                    entity.ContainerName = rdr["ContainerName"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.ShowSeq = (int)rdr["ShowSeq"];
                    entity.PlayMinutes = rdr["PlayMinutes"].ToString();
                    entity.ContainerTypeId = (int)rdr["ContainerTypeId"];
                    entity.Title = rdr["Title"].ToString();
                    entity.EditOption = rdr["EditOption"].ToString();
                    entity.LayoutType = rdr["LayoutType"].ToString();
                    entity.PositionType = (int)rdr["PositionType"];
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// uspGetMapMaster
        /// </summary>
        /// <returns>MapMaster 列表。</returns>
        public List<MasterInfo> GetMapContainer(Int32 containId)
        {
            List<MasterInfo> list = new List<MasterInfo>();
            MasterInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ContianerID",SqlDbType.Int)
            };
            parms[0].Value = containId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "uspGetMapContainer", parms))
            {
                while (rdr.Read())
                {
                    entity = new MasterInfo();

                    entity.KanbanContainerId = (int)rdr["ContainerId"];
                    entity.KanbanComponentId = (int)rdr["ComponentId"];
                    entity.ComponentName = rdr["ComponentName"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.ShowSeq = (int)rdr["ShowSeq"];

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 分页获取 控件 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>Component 列表。</returns>
        public List<MasterInfo> GetAllComponent(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MasterInfo> list = new List<MasterInfo>();
            MasterInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwKanbanComponent"
                , "KanbanComponentId",
                " KanbanComponentId ,ComponentTypeId ,ComponentName ,DataSource ,SourceType ,RefreshSec" +
                " ,TypeName ,Remark, CreateBy, CreateTime, ModifyBy, ModifyTime "
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MasterInfo();
                    entity.KanbanComponentId = rdr.GetInt32(0);
                    entity.ComponentName = rdr["ComponentName"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.DataSource = rdr["DataSource"].ToString();
                    entity.SourceType = rdr["SourceType"].ToString();
                    entity.RefreshSec = rdr["RefreshSec"].ToString();
                    entity.ComponentTypeId = (int)rdr["ComponentTypeId"];
                    entity.TypeName = rdr["TypeName"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateTime = rdr.GetDateTime(9);
                    entity.ModifyBy = rdr["ModifyBy"].ToString();
                    entity.ModifyTime = rdr.GetDateTime(11);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 编辑（添加或更新） Component 信息。
        /// </summary>
        public Int32 EditComponent(MasterInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@KanbanComponentId", SqlDbType.Int),
                new SqlParameter("@ComponentTypeId", SqlDbType.Int),
                new SqlParameter("@ComponentName", SqlDbType.NVarChar,50),
                new SqlParameter("@DataSource", SqlDbType.NVarChar,Int32.MaxValue),
                new SqlParameter("@SourceType", SqlDbType.NVarChar,200),
                new SqlParameter("@RefreshSec", SqlDbType.Float),
                new SqlParameter("@EditOption", SqlDbType.NVarChar,Int32.MaxValue),
                new SqlParameter("@RawCode", SqlDbType.NVarChar,Int32.MaxValue),
                new SqlParameter("@Remark", SqlDbType.NVarChar,2000),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar,50)
            };

            parms[0].Value = entity.KanbanComponentId;
            parms[1].Value = entity.ComponentTypeId;
            parms[2].Value = entity.ComponentName;
            parms[3].Value = entity.DataSource;
            parms[4].Value = entity.SourceType;
            parms[5].Value = entity.RefreshSec;
            parms[6].Value = entity.EditOption;
            parms[7].Value = entity.RawCode;
            parms[8].Value = entity.Remark;
            parms[9].Value = entity.CreateBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_Component_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 编辑（添加或更新）Container 信息。
        /// </summary>
        public Int32 EditContainer(MasterInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                
                new SqlParameter("@KanbanContainerId", SqlDbType.Int),
                new SqlParameter("@ContainerName", SqlDbType.NVarChar, 100),
                new SqlParameter("@LayoutType", SqlDbType.NVarChar, 100),
                new SqlParameter("@ComponentName", SqlDbType.NVarChar, -1),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 2000),
                new SqlParameter("@EditOption", SqlDbType.NVarChar, -1),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@TitleLValue", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleMValue", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleRValue", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleLCss", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleMCss", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleRCss", SqlDbType.NVarChar, -1),
                new SqlParameter("@TitleLType", SqlDbType.Int),
                new SqlParameter("@TitleMType", SqlDbType.Int),
                new SqlParameter("@TitleRType", SqlDbType.Int),
                new SqlParameter("@Title", SqlDbType.NVarChar, -1)

            };

            parms[0].Value = entity.KanbanContainerId;
            parms[1].Value = entity.ContainerName;
            parms[2].Value = entity.LayoutType;
            parms[3].Value = entity.ComponentName;
            parms[4].Value = entity.Remark;
            parms[5].Value = entity.EditOption ?? "";
            parms[6].Value = entity.CreateBy;

            parms[7].Value = entity.TitleLValue ?? "";
            parms[8].Value = entity.TitleMValue ?? "";
            parms[9].Value = entity.TitleRValue ?? "";
            parms[10].Value = entity.TitleLCss ?? "";
            parms[11].Value = entity.TitleMCss ?? "";
            parms[12].Value = entity.TitleRCss ?? "";
            parms[13].Value = entity.TitleLType;
            parms[14].Value = entity.TitleMType;
            parms[15].Value = entity.TitleRType;
            parms[16].Value = entity.Title;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_Container_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        ///获取控件信息By ID
        /// </summary>
        public MasterInfo GetCompInfo(int compId)
        {
            MasterInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ComponentID", SqlDbType.Int)
            };
            parms[0].Value = compId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString
                , "Kanban_Component_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MasterInfo();
                    entity.KanbanComponentId = rdr.GetInt32(0);
                    entity.ComponentName = rdr["ComponentName"].ToString();
                    entity.ComponentTypeId = (int)rdr["ComponentTypeId"];
                    entity.TypeName = rdr["TypeName"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                    entity.DataSource = rdr["DataSource"].ToString();
                    entity.SourceType = rdr["SourceType"].ToString();
                    entity.RefreshSec = rdr["RefreshSec"].ToString();
                    entity.EditOption = rdr["EditOption"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.Param1 = rdr["Param1"].ToString();
                    entity.Param2 = rdr["Param2"].ToString();
                    entity.Param3 = rdr["Param3"].ToString();
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        ///获取容器信息By ID
        /// </summary>
        public MasterInfo GetContInfo(int contId)
        {
            MasterInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@KanbanContainerId", SqlDbType.Int)
            };
            parms[0].Value = contId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString
                , "Kanban_Container_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MasterInfo();
                    entity.KanbanContainerId = rdr.GetInt32(0);
                    entity.ContainerName = rdr["ContainerName"].ToString();
                    entity.ContainerTypeId = (int)rdr["ContainerTypeId"];
                    entity.Remark = rdr["Remark"].ToString();
                    entity.EditOption = rdr["EditOption"].ToString();
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.RawCode = rdr["RawCode"].ToString();
                    entity.LayoutType = rdr["LayoutType"].ToString();
                    entity.PositionType = (int)rdr["PositionType"];
                    entity.TitleLValue = rdr["TitleLValue"].ToString();
                    entity.TitleLType = (int)rdr["TitleLType"];
                    entity.TitleLCss = rdr["TitleLCss"].ToString();
                    entity.TitleMValue = rdr["TitleMValue"].ToString();
                    entity.TitleMType = (int)rdr["TitleMType"];
                    entity.TitleMCss = rdr["TitleMCss"].ToString();
                    entity.TitleRValue = rdr["TitleRValue"].ToString();
                    entity.TitleRType = (int)rdr["TitleRType"];
                    entity.TitleRCss = rdr["TitleRCss"].ToString();
 
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        ///查看容器类型
        /// </summary>
        public List<Kanban.Model.MasterInfo> GetContainerType(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MasterInfo> list = new List<MasterInfo>();
            MasterInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows
                , "vwKanban_ContainerType"
                , "ContainerTypeId"
                , "ContainerTypeId,LayoutType,IconSrc,RawCode,Remark, CreateBy, CreateTime, ModifyBy, ModifyTime"
                , searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MasterInfo();

                    entity.ContainerTypeId = rdr.GetInt32(0);
                    entity.LayoutType = rdr.GetString(1);
                    entity.IconSrc = rdr.GetString(2);
                    entity.RawCode = rdr.GetString(3);
                    entity.Remark = rdr.GetString(4);
                    entity.CreateBy = rdr["CreateBy"].ToString();
                    entity.CreateTime = rdr.GetDateTime(6);
                    entity.ModifyBy = rdr["ModifyBy"].ToString();
                    entity.ModifyTime = rdr.GetDateTime(8);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public string GetContainerHtml(string layoutType)
        {
            string sql = " SELECT RawCode,PositionType FROM Kanban_ContainerType WHERE LayoutType='" + layoutType + "'";
            DataTable dbt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.ReportConnString, sql, null);
            return (new PubItems.BLL.PubItems().GetListJson(dbt));
        }

        public string GetContainerEditOption(int contId)
        {
            string sql = " SELECT EditOption FROM Kanban_Container WHERE KanbanContainerId=" + contId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.ReportConnString, sql, null))
            {
                if (rdr.Read())
                {
                    return rdr.GetString(0);

                }
                rdr.Close();
            }

            return "";
        }


        /// <summary>
        /// 删除容器类型  add by zhi.li 20160619
        /// </summary>
        /// <param name="containerTypeId"></param>
        /// <param name="username"></param>
        public void DeleteContainerType(string containerTypeId, string username)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ContainerTypeId",SqlDbType.VarChar,100),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = containerTypeId;
            parms[1].Value = username;


            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_ContainerType_Delete", parms);
        }

        /// <summary>
        ///获取容器类型信息By ContainerTypeId
        ///add by zhi.li 20160619
        /// </summary>
        public MasterInfo GetContainerTypeInfo(int containerTypeId)
        {
            MasterInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ContainerTypeId", SqlDbType.Int)
            };
            parms[0].Value = containerTypeId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString
                , "Kanban_ContainerType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MasterInfo();
                    entity.ContainerTypeId = (int)rdr["ContainerTypeId"];
                    entity.LayoutType = rdr["LayoutType"].ToString();
                    entity.IconSrc = rdr["IconSrc"].ToString();
                    entity.RawCode = rdr["RawCode"].ToString();
                    entity.Remark = rdr["Remark"].ToString();
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        ///根据templateName获取Kanban_Master 
        /// </summary>
        public MasterInfo GetKanbanPageByTmp(string tmpName)
        {
            MasterInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TemplateName", SqlDbType.NVarChar,100)
            };
            parms[0].Value = tmpName;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.ReportConnString
                , "Kanban_Master_PageInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MasterInfo();
                    entity.RptTemplateId = (int)rdr["RptTemplateId"];
                    entity.KanbanMasterId = (int)rdr["KanbanMasterId"];
                    entity.Title = rdr["Title"].ToString();
                    entity.FootHtml = rdr["FootHtml"].ToString();

                }
                rdr.Close();
            }
            return entity;
        }

        public string GetTabelByPager(int startRow, int pageSize, string sourceName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@startRow", SqlDbType.Int),
                new SqlParameter("@pageSize", SqlDbType.Int),
                new SqlParameter("@tableName", SqlDbType.NVarChar,50)
            };
            parms[0].Value = startRow;
            parms[1].Value = pageSize;
            parms[2].Value = sourceName;

            DataTable tb = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.ReportConnString, "uspGetTabelByPager", parms);
            return (new PubItems.BLL.PubItems().GetListJson(tb));
        }

        /// <summary>
        /// 编辑（添加或更新）容器 信息。
        /// </summary>
        public Int32 EditContainerType(int cId,string cName, string hCode, string cRemark, string user,int posType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ContId", SqlDbType.Int),
                new SqlParameter("@ContType", SqlDbType.NVarChar,50),
                new SqlParameter("@ContCode", SqlDbType.NVarChar,int.MaxValue),
                new SqlParameter("@Remark", SqlDbType.NVarChar,2000),
                new SqlParameter("@PositionType", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar,50)
            };

            parms[0].Value = cId;
            parms[1].Value = cName;
            parms[2].Value = hCode;
            parms[3].Value = cRemark;
            parms[4].Value = posType;
            parms[5].Value = user;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Kanban_ContainerType_Edit", parms);

            return (Int32)parms[0].Value;
        }

        public string GetKanbanProcData(string spName ,string strParas)
        {
            string sql = " EXEC " + spName + " " + strParas;
            DataTable dbt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.ReportConnString, sql, null);
            return (new PubItems.BLL.PubItems().GetListJson(dbt));
        }
        //获取产线状态 返回状态字符串 1 正常 2 待产 3 停线 add by peter on 2018-10-30
        public string GetLineStatusKanban()
        {

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@StatusStr",SqlDbType.NVarChar,100)
            };
            parms[0].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetLineStatusKanban", parms);
            return Convert.ToString(parms[0].Value);
        }

    }
}