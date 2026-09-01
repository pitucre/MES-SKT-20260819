using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.BLL
{
    public class MouldOperateRecord
    {
        public Int64 Edit(MouldOperateRecordInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MouldOperateRecordId", SqlDbType.BigInt),
                new SqlParameter("@MouldId", SqlDbType.Int),
                new SqlParameter("@OperateType", SqlDbType.NVarChar),
                new SqlParameter("@Operator", SqlDbType.NVarChar),
                new SqlParameter("@Item1", SqlDbType.NVarChar),
                new SqlParameter("@Item2", SqlDbType.NVarChar),
                new SqlParameter("@Item3", SqlDbType.NVarChar),
                new SqlParameter("@Remark", SqlDbType.NVarChar),
                new SqlParameter("@UserName", SqlDbType.NVarChar)
            };
            parms[0].Value = entity.MouldOperateRecordId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MouldId;
            parms[2].Value = entity.OperateType;
            parms[3].Value = entity.Operator;
            parms[4].Value = entity.Item1;
            parms[5].Value = entity.Item2;
            parms[6].Value = entity.Item3;
            parms[7].Value = entity.Remark;
            parms[8].Value = entity.CreateBy;

            CommonHelper.BLL.ComMethod.Edit("uspMouldOperateRecordEdit", parms);

            return (Int64)parms[0].Value;

        }
        public List<MouldOperateRecordInfo> GetMouldOperateRecord(int id)
        {
            SqlParameter[] parm = new SqlParameter[]
            {
                 new SqlParameter("@MouldId", SqlDbType.Int),
            };
            parm[0].Value = id;

            var list = CommonHelper.BLL.ComMethod.GetList<MouldOperateRecordInfo>("uspGetMouldOperateRecord", parm);
            return list;
        }


        public void MouldMaintenanceUploadFile(int mouldOperateRecordId, string fileUpName, string fFileType, string fileSaveName, string filePath, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MouldOperateRecordId", SqlDbType.Int){ Value = mouldOperateRecordId},
                new SqlParameter("@FileUpName", SqlDbType.NVarChar){ Value = fileUpName},
                new SqlParameter("@FileType", SqlDbType.NVarChar){ Value = fFileType},
                new SqlParameter("@FileSaveName", SqlDbType.NVarChar){ Value = fileSaveName},
                new SqlParameter("@FilePath", SqlDbType.NVarChar){ Value = filePath},
                new SqlParameter("@UserName", SqlDbType.NVarChar){ Value = userName}
            };

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMouldMaintenanceUploadFile", parms);
        }


        public void MouldMaintenanceUploadFile_PDA(string mouldCode,string Remark,string OperaType,string file,string Opera)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MouldCode", SqlDbType.NVarChar){ Value = mouldCode},
                new SqlParameter("@OperateType", SqlDbType.NVarChar){ Value = OperaType},
                new SqlParameter("@Remark", SqlDbType.NVarChar){ Value = Remark},
                new SqlParameter("@CreateBy", SqlDbType.NVarChar){ Value = Opera},
                new SqlParameter("@ServerImageNames", SqlDbType.NVarChar){ Value = file}
            };

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMouldOperateRecord_PDA", parms);
        }

        public void MouldMaintenanceCheck_PDA(string mouldCode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MouldCode", SqlDbType.NVarChar){ Value = mouldCode}
            };

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMouldMaintenanceCheck_PDA", parms);
        }

    }
}
