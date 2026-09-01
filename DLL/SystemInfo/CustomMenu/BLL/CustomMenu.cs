using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CustomMenu.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CustomMenu.BLL
{
    public class CustomMenu
    {
        private Int32 recordCount = 0;


        #region 获取模块信息
        /// <summary>
        /// 获取模块信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<CustomMenuInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CustomMenuInfo> list = new List<CustomMenuInfo>();
            CustomMenuInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwCustomModules", "Sequence",
                "fatherKey, KeyCNValues, KeyENValues, CreateBy, CreateDateTime, ModifyBy, ModifyDateTime, Remark,Sequence", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CustomMenuInfo();
                    entity.FatherKey = rdr.GetString(0);
                    entity.KeyCNValues = rdr.GetString(1);
                    entity.KeyENValues = rdr.GetString(2);
                    entity.CreateBy = rdr.GetString(3);
                    entity.CreateDateTime = rdr.GetDateTime(4);
                    entity.ModifyBy = rdr.GetString(5);
                    entity.ModifyDateTime = rdr.GetDateTime(6);
                    entity.Remark = rdr.GetString(7);
                    entity.Sequence = rdr.GetInt32(8);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        #endregion

        #region 保存自定义模块信息
        /// <summary>
        /// 保存自定义模块信息
        /// </summary>
        /// <param name="KeyCNValues"></param>
        /// <param name="KeyENValues"></param>
        /// <param name="seq"></param>
        /// <param name="FatherKey"></param>
        /// <param name="userName"></param>
        public void EditCustomMenu(string KeyCNValues, string KeyENValues, float seq, string FatherKey, string userName,string Remark)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@KeyCNValues",SqlDbType.VarChar,100),
                new SqlParameter("@KeyENValues",SqlDbType.NVarChar,100),
                new SqlParameter("@Seq",SqlDbType.Float),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@FatherKey",SqlDbType.VarChar,100),
                new SqlParameter("@Remark",SqlDbType.VarChar,500)
            };

            parms[0].Value = KeyCNValues;
            parms[1].Value = KeyENValues;
            parms[2].Value = seq;
            parms[3].Value = userName;
            parms[4].Value = FatherKey;
            parms[5].Value = Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveCustomMenu", parms);
        }
        #endregion

        #region 获取自定义界面信息
        /// <summary>
        /// 获取自定义界面信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<CustomMenuInfo> GetCustomPage(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CustomMenuInfo> list = new List<CustomMenuInfo>();
            CustomMenuInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwCustomPage", "PageId",
                "PageId, PageName, PageCName, PageEName, PageDesc, PageContent, Module, ModuleCName,ModuleEName,Icon,Url,Sequence,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,DesignJSON", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CustomMenuInfo();
                    entity.PageId = rdr.GetInt32(0);
                    entity.PageName = rdr.GetString(1);
                    entity.PageCName = rdr.GetString(2);
                    entity.PageEName = rdr.GetString(3);
                    entity.PageDesc = rdr.GetString(4);
                    entity.PageContent = rdr.GetString(5);
                    entity.Module = rdr.GetString(6);
                    entity.ModuleCName = rdr.GetString(7);
                    entity.ModuleEName = rdr.GetString(8);
                    entity.Icon = rdr.GetString(9);
                    entity.Url = rdr.GetString(10);
                    entity.Sequence = rdr.GetInt32(11);
                    entity.CreateBy = rdr.GetString(12);
                    entity.CreateDateTime = rdr.GetDateTime(13);
                    entity.ModifyBy = rdr.GetString(14);
                    entity.ModifyDateTime = rdr.GetDateTime(15);
                    entity.DesignJSON = rdr.GetString(16);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        #endregion

        #region 保存自定义界面信息
        /// <summary>
        /// 保存自定义界面信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public Int32 EditCustomPage(CustomMenuInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PageId", SqlDbType.Int),
                new SqlParameter("@PageName", SqlDbType.NVarChar, 100),
                new SqlParameter("@PageCName", SqlDbType.NVarChar, 50),
                new SqlParameter("@PageEName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Icon", SqlDbType.NVarChar, 50),
                new SqlParameter("@Sequence", SqlDbType.Int),
                new SqlParameter("@Module", SqlDbType.NVarChar, 50),
                new SqlParameter("@PageDesc", SqlDbType.NVarChar, 50),
                new SqlParameter("@PageContent", SqlDbType.NText),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@DesignJSON", SqlDbType.NVarChar, 20000),
                new SqlParameter("@IsCodeDesign", SqlDbType.Bit),
                new SqlParameter("@PageContentSub", SqlDbType.NText),
                new SqlParameter("@PType", SqlDbType.Int)
            };

            parms[0].Value = entity.PageId;
            parms[1].Value = entity.PageName;
            parms[2].Value = entity.PageCName;
            parms[3].Value = entity.PageEName;
            parms[4].Value = entity.Icon;
            parms[5].Value = entity.Sequence;
            parms[6].Value = entity.Module;
            parms[7].Value = entity.PageDesc;
            parms[8].Value = SKT.Common.Utility.EncryptHelper.Encrypt(entity.PageContent);
            parms[9].Value = entity.CreateBy;
            parms[10].Value = entity.ModifyBy;
            parms[11].Value = entity.DesignJSON ?? "";
            parms[12].Value = entity.IsCodeDesign == true ? 1 : 0;
            parms[13].Value = SKT.Common.Utility.EncryptHelper.Encrypt(entity.PageContentSub);
            parms[14].Value = entity.PType;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveCustomPage", parms);

            return (Int32)parms[0].Value;
        }
        #endregion

        #region 根据界面ID获取界面信息
        /// <summary>
        /// 根据界面ID获取界面信息
        /// </summary>
        /// <param name="PageId"></param>
        /// <returns></returns>
        public CustomMenuInfo GetCustomPageInfo(Int32 PageId)
        {
            CustomMenuInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PageId", SqlDbType.Int)
            };

            parms[0].Value = PageId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetCustomPageInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CustomMenuInfo();
                    entity.PageId = rdr.GetInt32(0);
                    entity.PageName = rdr.GetString(1);
                    entity.PageCName = rdr.GetString(2);
                    entity.PageEName = rdr.GetString(3);
                    entity.PageDesc = rdr.GetString(4);
                    entity.PageContent = SKT.Common.Utility.EncryptHelper.Decrypt(rdr.GetString(5));
                    entity.Module = rdr.GetString(6);
                    entity.ModuleCName = rdr.GetString(7);
                    entity.ModuleEName = rdr.GetString(8);
                    entity.Icon = rdr.GetString(9);
                    entity.Url = rdr.GetString(10);
                    entity.Sequence = rdr.GetInt32(11);
                    entity.CreateBy = rdr.GetString(12);
                    entity.CreateDateTime = rdr.GetDateTime(13);
                    entity.ModifyBy = rdr.GetString(14);
                    entity.ModifyDateTime = rdr.GetDateTime(15);
                    entity.DesignJSON = rdr["DesignJSON"].ToString();
                    entity.SubSystem = rdr["SubSystem"].ToString();
                    entity.IsCodeDesign =Convert.ToBoolean(rdr["IsCodeDesign"]);
                    entity.PageContentSub =string.IsNullOrEmpty(rdr["PageContentSub"].ToString())?"":SKT.Common.Utility.EncryptHelper.Decrypt(rdr["PageContentSub"].ToString());
                    entity.PType = Convert.ToInt32(rdr["PType"]);
                }
                rdr.Close();
            }

            return entity;
        }
        #endregion

        #region 删除自定义界面信息
        /// <summary>
        /// 删除自定义界面信息
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void DeleteCustomPage(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteCustomPage", parms);
        }
        #endregion

        #region 根据ID获取自定义模块信息
        /// <summary>
        /// 根据ID获取自定义模块信息
        /// </summary>
        /// <param name="FatherKey"></param>
        /// <returns></returns>
        public CustomMenuInfo GetCustomMenuInfo(string FatherKey)
        {
            CustomMenuInfo CustomInfo = new CustomMenuInfo();

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@FatherKey",SqlDbType.VarChar,100)
            };

            parms[0].Value = FatherKey;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetCustomMenuInfo", parms))
            {
                if (rdr.Read())
                {
                    CustomInfo.KeyCNValues = rdr.GetString(0);
                    CustomInfo.KeyENValues = rdr.GetString(1);
                    CustomInfo.Sequence = rdr.GetInt32(2);
                    CustomInfo.Remark = rdr.GetString(3);
                }
                rdr.Close();
            }
            return CustomInfo;
        }
        #endregion

        #region 删除自定义模块
        /// <summary>
        /// 删除自定义模块
        /// </summary>
        /// <param name="reportTypeId"></param>
        /// <param name="username"></param>
        public void DeleteCustomMenuInfo(string FatherKey, string username)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@FatherKey",SqlDbType.VarChar,100),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = FatherKey;
            parms[1].Value = username;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteCustomMenuInfo", parms);
        }
        #endregion

        #region 获取界面信息
        /// <summary>
        /// 获取界面信息
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public String GetContentInfo(string name)
        {
            String content = "";

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PageName", SqlDbType.NVarChar,50)
            };

            parms[0].Value = name;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPageContentInfo", parms))
            {
                if (rdr.Read())
                {
                    content = SKT.Common.Utility.EncryptHelper.Decrypt(rdr.GetString(0));
                }
                rdr.Close();
            }

            return content;
        }
        #endregion

        #region 获取从属界面信息
        /// <summary>
        /// 获取从属界面信息
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public String GetContentSubInfo(string name)
        {
            String content = "";

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PageName", SqlDbType.NVarChar,50)
            };
            parms[0].Value = name;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPageContentSubInfo", parms))
            {
                if (rdr.Read())
                {
                    content = SKT.Common.Utility.EncryptHelper.Decrypt(rdr.GetString(0));
                }
                rdr.Close();
            }
            return content;
        }
        #endregion

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
