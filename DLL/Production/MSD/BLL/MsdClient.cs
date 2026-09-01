using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.MSD.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.MSD.BLL
{
    public class MsdClient
    {
        #region MSD物料基本信息、操作历史记录
        
        /// <summary>
        /// 获取MSD物料的操作历史
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public List<MsdClientInfo> GetMSDOperateHistory(string grn)
        {
            List<MsdClientInfo> list = new List<MsdClientInfo>();
            
            SqlParameter[] paras = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,300)
            };
            paras[0].Value = grn;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetMSDOperateHistory", paras))
            {
                while (rdr.Read())
                {
                    var entity = new MsdClientInfo();
                    entity.GRN = rdr.GetString(0);
                    entity.ResName = rdr.GetString(1);
                    entity.Station = rdr.GetString(2);
                    entity.ContainerCode = rdr.GetString(3);
                    entity.CreateBy = rdr.GetString(4);
                    entity.CreateDateTime = rdr.GetString(5);
                    entity.ActionDesc = rdr.GetString(6);
                    list.Add(entity);
                }
            }
            return list;
        }

        /// <summary>
        /// 获取MSD物料的基本信息
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public MSDProductInfo GetMSDProductInfo(string grn)
        {
            SqlParameter[] paras = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,300)
            };
            paras[0].Value = grn;
            return ComMethod.Get<MSDProductInfo>("uspGetMSDProductInfo", paras);
        }

        #endregion

        #region MSD开包、封装信息
                
        /// <summary>
        /// 采集MSD物料的开包信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userName"></param>
        public void MSDUnPack(string grn, int stationId, int resId, string userName)
        {
            SqlParameter[] paras = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,300),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,30)
            };
            paras[0].Value = grn;
            paras[1].Value = stationId;
            paras[2].Value = resId;
            paras[3].Value = userName;

            ComMethod.Edit("uspMSDUnPack", paras);
        }

        /// <summary>
        /// 采集MSD物料的封装信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="containerCode"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userName"></param>
        public void MSDPack(string grn,string containerCode, int stationId, int resId, string userName)
        {
            SqlParameter[] paras = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,300), 
                new SqlParameter("@ContainerCode",SqlDbType.VarChar,50),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,30)
            };
            paras[0].Value = grn;
            paras[1].Value = containerCode;
            paras[2].Value = stationId;
            paras[3].Value = resId;
            paras[4].Value = userName;

            ComMethod.Edit("uspMSDPack", paras);
        }

        #endregion

        #region MSD入炉、出炉信息

        /// <summary>
        /// 采集MSD物料的入炉信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="containerCode"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userName"></param>
        public void MSDBake(string grn, string containerCode,decimal bakeTemp, int stationId, int resId, string userName)
        {
            SqlParameter[] paras = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,300), 
                new SqlParameter("@ContainerCode",SqlDbType.VarChar,50),
                new SqlParameter("@BakeTemp",SqlDbType.Decimal),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,30)
            };

            paras[0].Value = grn;
            paras[1].Value = containerCode;
            paras[2].Value = bakeTemp;
            paras[3].Value = stationId;
            paras[4].Value = resId;
            paras[5].Value = userName;

            ComMethod.Edit("uspMSDBake", paras);
        }

        /// <summary>
        /// 采集MSD物料的出炉信息
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userName"></param>
        public void MSDUnBake(string grn, int stationId, int resId, string userName)
        {
            SqlParameter[] paras = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar,300),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,30)
            };
            paras[0].Value = grn;
            paras[1].Value = stationId;
            paras[2].Value = resId;
            paras[3].Value = userName;

            ComMethod.Edit("uspMSDUnBake", paras);
        }

        #endregion

    }
}
