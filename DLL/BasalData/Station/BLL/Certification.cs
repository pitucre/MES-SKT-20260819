using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Station.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Station.BLL
{
    public class Certification
    {
        private Int32 recordCount = 0;
        public List<CertificationInfo> GetInfoByResId(Int32 flage, Int32 resId)
        {
            List<CertificationInfo> list = new List<CertificationInfo>();
            CertificationInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@flage",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int)
            };
            parms[0].Value = flage;
            parms[1].Value = resId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspResCertiMember", parms))
            {
                while (rdr.Read())
                {
                    entity = new CertificationInfo();
                    entity.CertificationId = rdr.GetInt32(0);
                    entity.Certification = rdr.GetString(1);
                    entity.Type = rdr.GetString(2);//Add By Alen 2016-06-20 增加资源类型
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 根据id返回对应的数据
        /// </summary>
        /// <param name="flage"></param>
        /// <param name="resId"></param>
        /// <returns></returns>
        public List<CertificationInfo> GetStationCertMember(Int32 flage, Int32 opeId)
        {
            List<CertificationInfo> list = new List<CertificationInfo>();
            CertificationInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@flage",SqlDbType.Int),
                new SqlParameter("@OpeId",SqlDbType.Int)
            };
            parms[0].Value = flage;
            parms[1].Value = opeId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspStationCertMember", parms))
            {
                while (rdr.Read())
                {
                    entity = new CertificationInfo();
                    entity.CertificationId = rdr.GetInt32(0);
                    entity.Certification = rdr.GetString(1);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 根据ItemID返回对应的证书信息
        /// </summary>
        /// <returns></returns>
        public  List<CertificationInfo>  GetListCertByItemId(Int32  flage,Int32 itemId)
        {
            List<CertificationInfo> list = new List<CertificationInfo>();
            CertificationInfo entity = null;
            SqlParameter[]  parms = new SqlParameter[]{
                  new SqlParameter("@flage",SqlDbType.Int),
                  new SqlParameter("@ItemId",SqlDbType.Int)
            };
            parms[0].Value = flage;
            parms[1].Value = itemId;
             using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetListCertByItemId", parms))
             {
                 while(rdr.Read())
                 {
                     entity = new CertificationInfo();
                     entity.CertificationId = rdr.GetInt32(0);
                     entity.Certification = rdr.GetString(1);
                     list.Add(entity);
                 }
                 rdr.Close();
             }
             return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}