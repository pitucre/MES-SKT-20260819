using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CustomMenu.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;

namespace SKT.LeanMES.CustomMenu.BLL
{

    public class MenuBottonConfig
    {
        private int recordCount = 0;
        public List<MenuBottonConfigEntity> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MenuBottonConfigEntity> list = new List<MenuBottonConfigEntity>();
            SqlParameter[] parms = new SqlParameter[] {
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@Module",SqlDbType.VarChar,50),
                 new SqlParameter("@Search",SqlDbType.VarChar,100)
            };
            parms[0].Value = Convert.ToInt32(searchSettings.Conditions["id"]);
            parms[1].Value = searchSettings.Conditions["name"];
            parms[2].Value = searchSettings.Conditions["search"];
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Framework_Pages_Menu", parms))
            {
                while (rdr.Read())
                {
                    MenuBottonConfigEntity entity = new MenuBottonConfigEntity();
                    entity.name = rdr.GetString(0);
                    entity.module = rdr.GetString(1);
                    entity.url = rdr.GetString(2);
                    entity.popedom = rdr.GetInt32(5);
                    entity.flag = rdr.GetInt32(6);
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = list.Count;
            return list;
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        public object ExeMenuBottonExt(string procname, string xml, int userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@xml", SqlDbType.Xml),
                new SqlParameter("@userId",  SqlDbType.Int),
                new SqlParameter("@text",  SqlDbType.NVarChar,200)

            };
            parms[0].Value = xml;
            parms[1].Value = userId;
            parms[2].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, procname, parms);
            return parms[2].Value;
        }
        public void Edit(string xml, string module, string page, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Doc", SqlDbType.Xml),
                new SqlParameter("@Module",  SqlDbType.VarChar,100),
                new SqlParameter("@Page",  SqlDbType.VarChar,100),
                new SqlParameter("@UserName",  SqlDbType.VarChar,100)
            };
            parms[0].Value = xml;
            parms[1].Value = module;
            parms[2].Value = page;
            parms[3].Value = username;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_FrameworkButtonsExt_Edit", parms);
        }
        public void Import(string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@UserName",  SqlDbType.VarChar,100)
            };
            parms[0].Value = username;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_FrameworkButtonsExt_Import", parms);
        }

        public string GetButtonText(string page, string hander)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@page", SqlDbType.VarChar,100),
                new SqlParameter("@hander",  SqlDbType.VarChar,100),
                new SqlParameter("@text",  SqlDbType.NVarChar,30)
            };
            parms[0].Value = page;
            parms[1].Value = hander;
            parms[2].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_FrameworkButtonsExt_GetText", parms);
            return parms[2].Value.ToString();
        }
        public List<FrameworkButtonsExt> GetButtons(string page)
        {
            List<FrameworkButtonsExt> list = new List<FrameworkButtonsExt>();
            SqlParameter[] parms = new SqlParameter[] {
                 new SqlParameter("@Page",SqlDbType.VarChar,100)
            };
            parms[0].Value = page;
            FrameworkButtonsExt entity = new FrameworkButtonsExt();
            PropertyInfo[] info = entity.GetType().GetProperties();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, "select t1.*,ISNULL(t2.ModelName,'') TempName from Framework_ButtonsExt t1 left join SDP_UIModel t2 on t1.TempId = t2.ModelId where t1.page = @Page", parms))
            {
                while (rdr.Read())
                {
                    FrameworkButtonsExt en = new FrameworkButtonsExt();
                    foreach (var item in info)
                    {
                        if (rdr[item.Name] != DBNull.Value)
                            item.SetValue(en, rdr[item.Name], null);
                    }
                    list.Add(en);
                }
                rdr.Close();
            }
            recordCount = list.Count;
            return list;
        }
    }
}
