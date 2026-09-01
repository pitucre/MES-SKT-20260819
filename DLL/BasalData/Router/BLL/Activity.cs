using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Router.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;


namespace SKT.LeanMES.Router.BLL
{
    public class Activity
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 根据路由id,资源id获取对应的Activity
        /// </summary>
        /// <param name="rid"></param>
        /// <param name="opeId"></param>
        /// <returns></returns>
        public List<ActivityInfo> GetActivityCode(Int32 rid, Int32 opeId)
        {
            List<ActivityInfo> list = new List<ActivityInfo>();
            ActivityInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RId", SqlDbType.Int),
                new SqlParameter("@OpeId", SqlDbType.Int)
            };

            parms[0].Value = rid;
            parms[1].Value = opeId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ActivityGetCode", parms))
            {
                while (rdr.Read())
                {
                    entity = new ActivityInfo();
                    entity.AC_FunctionCode = SKT.Common.Utility.EncryptHelper.Decrypt(rdr.GetString(0));
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }
        /// <summary>
        /// add by weixia on 2015.5.13
        /// </summary>
        /// <param name="rid"></param>
        /// <param name="opeId"></param>
        /// <returns></returns>
         public List<ActivityInfo> GetActivityFunction(Int32 rid, Int32 opeId)
        {
            List<ActivityInfo> list = new List<ActivityInfo>();
            ActivityInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@RId", SqlDbType.Int),
                new SqlParameter("@OpeId", SqlDbType.Int)
            };

            parms[0].Value = rid;
            parms[1].Value = opeId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ActivityGetFunction", parms))
            {
                while (rdr.Read())
                {
                    entity = new ActivityInfo();
                    entity.AC_FunctionName = rdr.GetString(0);
                    entity.AC_Param_Value = rdr.GetString(1);
                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }
        
        /// <summary>
        /// 查出数据
        /// </summary>
        /// <param name="acId"></param>
        /// <returns></returns>
        public Int32 GetRtAtt(int acId)
        {
            int flag = 1;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ACId",SqlDbType.Int),
                new SqlParameter("@ActivityAttr",SqlDbType.VarChar,100)
            };

            parms[0].Value = acId;
            parms[1].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Activity_GetAcattr", parms);

            string att = Convert.ToString(parms[1].Value);
            if (att != "")
            {
                try
                {
                    string deEncry = SKT.Common.Utility.EncryptHelper.Decrypt(att);
                    string[] arr = new string[3];
                    arr = deEncry.Split(new char[] { ',' });
                    if (arr[0] != acId.ToString())
                    {
                        flag = -1;
                    }
                    else if (arr[1].ToLower() != "sys")
                    {
                        flag = 0;
                    }
                }
                catch (Exception ex)
                {
                    throw new MESException("lang", "InvalidAcAttr", ExceptionLevel.Error);
                }
            }
            else
            {
                flag = -1;
            }

            return flag;
        }
        /// <summary>
        /// 获取fundCode数据
        /// </summary>
        /// <param name="ac_id"></param>
        /// <returns></returns>
        public String GetFunctionCode(Int32 ac_id)
        {
            string code = "";

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AC_ID", SqlDbType.Int)
            };

            parms[0].Value = ac_id;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Activity_GetFunCode", parms))
            {
                if (rdr.Read())
                {
                    code = rdr.GetString(0);
                }
                rdr.Close();
            }
            return SKT.Common.Utility.EncryptHelper.Decrypt(code);
        }
        /// <summary>
        /// 编辑（添加或更新） ACTIVITY 信息。
        /// </summary>
        /// <param name="entity">ACTIVITY 实体对象。</param>
        public Int32 Edit(ActivityInfo entity, String aoidString, String ac_param_nameString, String ac_param_valueString, String ac_param_remarkString, String ac_sequenceString, String tabString, Int32 justEditOpeTypeACMember)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AC_ID", SqlDbType.Int),
                new SqlParameter("@AC_Name", SqlDbType.NVarChar, 100),
                new SqlParameter("@AC_Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@AC_FunctionName", SqlDbType.NVarChar, 50),
                new SqlParameter("@AC_FunctionCode", SqlDbType.Text),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),

                new SqlParameter("@aoidString", SqlDbType.NVarChar,4000),
                new SqlParameter("@ac_param_nameString", SqlDbType.NVarChar,4000),
                new SqlParameter("@ac_param_valueString", SqlDbType.NVarChar,4000),
                new SqlParameter("@ac_param_remarkString", SqlDbType.NVarChar,4000),
                new SqlParameter("@ac_sequenceString", SqlDbType.NVarChar,4000),
                new SqlParameter("@tabString", SqlDbType.NVarChar,4000),
                new SqlParameter("@JustEditOpeTypeACMember", SqlDbType.Int)
            };

            parms[0].Value = entity.AC_ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.AC_Name;
            parms[2].Value = entity.AC_Description;
            parms[3].Value = entity.AC_FunctionName;
            parms[4].Value = SKT.Common.Utility.EncryptHelper.Encrypt(entity.AC_FunctionCode);
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;

            parms[7].Value = aoidString;
            parms[8].Value = ac_param_nameString;
            parms[9].Value = ac_param_valueString;
            parms[10].Value = ac_param_remarkString;
            parms[11].Value = ac_sequenceString;
            parms[12].Value = tabString;
            parms[13].Value = justEditOpeTypeACMember;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Activity_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ActivityId 字符串删除 Activity 信息。
        /// </summary>
        /// <param name="idString">ActivityId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(Int32 acId, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AC_ID", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = acId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Activity_Delete", parms);
        }
        /// <summary>
        /// 更新参数
        /// </summary>
        /// <param name="acId"></param>
        public void UpdateAcAttr(int acId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ACId",SqlDbType.Int),
                new SqlParameter("@Attr",SqlDbType.VarChar,100)
            };

            parms[0].Value = acId;
            parms[1].Value = SKT.Common.Utility.EncryptHelper.Encrypt(acId.ToString() + ",Customize," + DateTime.Now.Millisecond.ToString());

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Activity_UpdateAttr", parms);
        }
        /// <summary>
        /// 根据 ActivityId 获取实体信息。
        /// </summary>
        /// <param name="activityId">ActivityId。</param>
        /// <returns>Activity 实体对象。</returns>
        public ActivityInfo GetInfo(Int32 activityId)
        {
            ActivityInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                 new SqlParameter("@AC_ID", SqlDbType.Int)
            };

            parms[0].Value = activityId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Activity_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ActivityInfo();
                    entity.AC_ID = rdr.GetInt32(0);
                    entity.AC_Name = rdr.GetString(1);
                    entity.AC_Description = rdr.GetString(2);
                    entity.AC_FunctionName = rdr.GetString(3);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Activity 实体对象。</returns>
        public ActivityInfo GetInfo(String fieldValue)
        {
            ActivityInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Activity_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ActivityInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Activity 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="activityCount">activity 总数。</param>
        /// <returns>Activity 列表。</returns>
        public List<ActivityInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ActivityInfo> list = new List<ActivityInfo>();
            ActivityInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Activity", "AC_ID",
                "[AC_ID], [AC_Name], [AC_Description], [AC_FunctionName],[AC_Attributes]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ActivityInfo();
                    entity.AC_ID = rdr.GetInt32(0);
                    entity.AC_Name = rdr.GetString(1);
                    entity.AC_Description = rdr.GetString(2);
                    entity.AC_FunctionName = rdr.GetString(3);
                    entity.AC_Attributes = (String.IsNullOrEmpty(rdr.GetString(4)) ? "N" : ((SKT.Common.Utility.EncryptHelper.Decrypt(rdr.GetString(4)).IndexOf(",SYS,") > -1) ? "Y" : "N"));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取绑定Activity的工位类型
        /// </summary>
        /// <param name="AC_ID"></param>
        /// <returns></returns>
        public List<ActivityInfo> GetActivityStationMeber(Int32 stationTypeId)
        {
            List<ActivityInfo> list = new List<ActivityInfo>();
            ActivityInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@stationTypeId",SqlDbType.Int)
            };
            parms[0].Value = stationTypeId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspActivityStationMember", parms))
            {
                while (rdr.Read())
                {
                    entity = new ActivityInfo();
                    entity.AC_ID = rdr.GetInt32(0);
                    entity.AC_Name = rdr.GetString(1);
                    entity.Seq = rdr.GetInt32(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 保存Configparams数据
        /// </summary>
        public void SaveConfigparams(String aoidString, String ac_param_valueString) 
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@AoidString",SqlDbType.NVarChar,2000),
                new SqlParameter("@Ac_param_valueString",SqlDbType.NVarChar,4000)
            };

            parms[0].Value = aoidString;
            parms[1].Value = ac_param_valueString;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ActivityOptions_Configparams", parms);
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}