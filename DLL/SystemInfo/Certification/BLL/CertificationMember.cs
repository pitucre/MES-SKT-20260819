using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Certification.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Certification.BLL
{
    public class CertificationMember
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） CertificationMember 信息。
        /// </summary>
        /// <param name="entity">CertificationMember 实体对象。</param>
        //public Int32 Edit(CertificationMemberInfo entity)
        //{
        //    SqlParameter[] parms = new SqlParameter[]{
        //        new SqlParameter("@CertificationMemberId", SqlDbType.Int),
        //        new SqlParameter("@UserId", SqlDbType.Int),
        //        new SqlParameter("@CertificationId", SqlDbType.Int),
        //        new SqlParameter("@Expiration_Date", SqlDbType.DateTime),
        //        new SqlParameter("@Certification_Date", SqlDbType.DateTime),
        //        new SqlParameter("@Warning_Sent", SqlDbType.VarChar, 5),
        //        new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
        //        new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
        //        new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
        //    };

        //    parms[0].Value = entity.CertificationMemberId;
        //    parms[0].Direction = ParameterDirection.InputOutput;
        //    parms[1].Value = entity.UserId;
        //    parms[2].Value = entity.CertificationId;
        //    parms[3].Value = entity.Expiration_Date;
        //    parms[4].Value = entity.Certification_Date;
        //    parms[5].Value = entity.Warning_Sent;
        //    parms[6].Value = entity.Remark;
        //    parms[7].Value = entity.ModifyBy;
        //    parms[8].Value = entity.CreateBy;

        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_CertificationMember_Edit", parms);

        //    return (Int32)parms[0].Value;
        //}

        /// <summary>
        /// 根据 CertificationMemberId 字符串删除 CertificationMember 信息。
        /// </summary>
        /// <param name="idString">CertificationMemberId 字符串。</param>
        /// <returns>日志内容。</returns>
        //public void Delete(String idString, String userName)
        //{
        //    SqlParameter[] parms = new SqlParameter[]{
        //        new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
        //        new SqlParameter("@UserName", SqlDbType.VarChar, 20)
        //    };

        //    parms[0].Value = idString;
        //    parms[1].Value = userName;

        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_CertificationMember_Delete", parms);
        //}

        /// <summary>
        /// 根据 CertificationMemberId 获取实体信息。
        /// </summary>
        /// <param name="certificationMemberId">CertificationMemberId。</param>
        /// <returns>CertificationMember 实体对象。</returns>
        public CertificationMemberInfo GetInfo(Int32 certificationMemberId)
        {
            CertificationMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = certificationMemberId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_CertificationMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CertificationMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDateTime(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10));
                    entity.UserName = rdr.GetString(11);
                    entity.Certification = rdr.GetString(12);
                    entity.CertType = rdr.GetString(13);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>CertificationMember 实体对象。</returns>
        public CertificationMemberInfo GetInfo(String fieldValue)
        {
            CertificationMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_CertificationMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new CertificationMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDateTime(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10));
                    entity.UserName = rdr.GetString(11);
                    entity.Certification = rdr.GetString(12);
                    entity.CertType = rdr.GetString(13);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 CertificationMember 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="certificationMemberCount">certificationMember 总数。</param>
        /// <returns>CertificationMember 列表。</returns>
        public List<CertificationMemberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<CertificationMemberInfo> list = new List<CertificationMemberInfo>();
            CertificationMemberInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwCertificationRecord", "CertificationMemberId",
                "[CertificationMemberId], [UserId], [CertificationId], [Expiration_Date], [Certification_Date], [Warning_Sent], [Remark], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy],[UserName],[Certification],[CertType],[CName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new CertificationMemberInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDateTime(3), rdr.GetDateTime(4), 
                        rdr.GetString(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                        rdr.GetString(10));
                    //转换ID值
                    //entity.Certification = GetCertification(rdr.GetInt32(2));
                    entity.UserName = rdr.GetString(11);
                    entity.Certification = rdr.GetString(12);
                    entity.CertType = rdr.GetString(13);
                    entity.CName = rdr.GetString(14);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 分配岗位认证给用户
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="roleIdString">角色</param>
        public void AssignCertsToUser(int UserID, string uCertIDString, string strCreator, string dtStart, string dtExpiration)
        {
            //Sperkey.Zhong 20180706 逐条插入改为一次性插入
            AssignCertificationToUser(uCertIDString, UserID, dtStart, dtExpiration, strCreator);
            //string[] strArray = uCertIDString.Split(new char[] { ',' });
            //for (int i = 0; i < strArray.Length; i++)
            //{
            //    AssignCertificationToUser(Convert.ToInt32(strArray[i]), UserID, dtStart, dtExpiration, strCreator);
            //}            
        }

        /// <summary>
        /// 分配岗位认证给用户
        /// </summary>
        /// <param name=""></param>
        /// <param name=""></param>
        public void AssignCertificationToUser(string uCertID, int userID, string dtStart, string dtExpiration, string strCreator)
        {
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@UserId", SqlDbType.Int), 
                new SqlParameter("@CertificationMemberId", SqlDbType.VarChar),
                new SqlParameter("@CertificationDate", SqlDbType.DateTime),
                new SqlParameter("@ExpirationDate", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20)
            };

            parameters[0].Value = userID;
            parameters[1].Value = uCertID;
            parameters[2].Value = DateTime.Parse(dtStart);
            parameters[3].Value = DateTime.Parse(dtExpiration);
            parameters[4].Value = strCreator;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Certification_AddData", parameters);
        }

        /// <summary>
        /// 移除指定用户的指定岗位认证
        /// </summary>
        /// <param name="userId">用户ID</param>
        /// <param name="roleIdString">角色ID字符串</param>
        /// <param name="userName">操作人员</param>
        public void RemoveCertsFromUser(string uCertIDString, string userName)
        {
            //Sperkey.Zhong 20180706 逐条插入改为一次性插入
            RemoveCertificationFromUser(uCertIDString, userName);
            //string[] strArray = uCertIDString.Split(new char[] { ',' });
            //for (int i = 0; i < strArray.Length; i++)
            //{
            //    RemoveCertificationFromUser(strArray[i].ToString(), userName);
            //}
        }

        /// <summary>
        /// 分配岗位认证给用户
        /// </summary>
        /// <param name=""></param>
        /// <param name=""></param>
        public void RemoveCertificationFromUser(string uCertID, string strCreator)
        {
            SqlParameter[] parameters = new SqlParameter[] {                
                new SqlParameter("@CertMemberIdString", SqlDbType.VarChar,20),               
                new SqlParameter("@Operator", SqlDbType.VarChar, 20)
                 };

            parameters[0].Value = uCertID;
            parameters[1].Value = strCreator;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Certification_RemoveData", parameters);
        }

        /// <summary>
        /// 得到认证名称通过认证ID
        /// </summary>
        /// <returns>认证名称</returns>
        private string GetCertification(int CertificationId)
        {
            string strCert = "";
            string strSQL = "Select certification from SYS_Certification where CertificationId=" + CertificationId;
            SqlConnection conn = new SqlConnection(SQLHelper.MESConnString);
            SqlCommand cmd = new SqlCommand(strSQL, conn);
            DataSet ds = new DataSet();
            SqlDataAdapter adapt = new SqlDataAdapter(cmd);
            adapt.Fill(ds);
            if (ds == null || ds.Tables[0].Rows.Count == 0)
            {
                return strCert;
            }
            else
            {
                strCert = ds.Tables[0].Rows[0][0].ToString();
                return strCert;
            }
        }

        //public bool CheckUserCertByResIdAndOpeId(int resId, int opeId, int userId)
        //{
        //    DataTable requiredCert = null;
        //    DataTable userCert = null;
        //    bool userCertIsValide = true;

        //    SqlParameter[] parameters1 = new SqlParameter[] { 
        //        new SqlParameter("@ResId",SqlDbType.Int),
        //        new SqlParameter("@OpeId",SqlDbType.Int)
        //    };

        //    parameters1[0].Value = resId;
        //    parameters1[1].Value = opeId;

        //    requiredCert = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "USER_CERT_GetCertByResIdAndOpeId", parameters1);

        //    SqlParameter[] parameters2 = new SqlParameter[] { 
        //        new SqlParameter("@UserId",SqlDbType.Int)
        //    };

        //    parameters2[0].Value = userId;

        //    userCert = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "USER_CERT_GetCertByUserId", parameters2);

        //    for (int i = 0; i < requiredCert.Rows.Count; i++)
        //    {
        //        int requiredCertId = Convert.ToInt32(requiredCert.Rows[i]["CertID"].ToString());

        //        if (requiredCertId != -1)
        //        {
        //            userCertIsValide = false;

        //            for (int j = 0; j < userCert.Rows.Count; j++)
        //            {
        //                int userCertId = Convert.ToInt32(userCert.Rows[j]["CertID"].ToString());

        //                if (requiredCertId == userCertId)
        //                {
        //                    userCertIsValide = true;
        //                    break;
        //                }
        //            }
        //        }
        //    }
        //    return userCertIsValide;
        //}

    }
}