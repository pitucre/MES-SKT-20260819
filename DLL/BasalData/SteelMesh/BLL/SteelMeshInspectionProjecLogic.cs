using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.SteelMesh.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SteelMesh.BLL
{
    public class SteelMeshInspectionProjecLogic
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 分页获取  检验项目 	 资料。
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SteelMeshInspectionProject> GetAllSteelMeshInspectionProject(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SteelMeshInspectionProject> list = new List<SteelMeshInspectionProject>();
            //表名或者视图
            string strTb = "vwProd_SteelMeshInspectionProject";
            //主键
            string strKey = "SMIPId";
            //查询栏位字串
            string strColumns = @"[SMIPId]
                              ,[SMIPType]
                              ,[SMIPCode]
                              ,[SMIPName]
                              ,[SMIPEntryMode]
                              ,[SMIPCriterion]
                              ,[SMIPUnit]
                              ,[SMIPStatus]
                              ,[SMIPUserName]
                              ,[SMIPDateTime]
                              ,[SMIPUpdateUserName]
                              ,[SMIPUpdateDateTime]
                              ,[SMIPRem],SMIPTypeName";
            list = ComMethod.GetComList<SteelMeshInspectionProject>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }
        /// <summary>
        /// 获取 检验项目  数量
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetSteelMeshInspectionProjectCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        /// <summary>
        /// 查询 检验项目 信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public SteelMeshInspectionProject GetSteelMeshInspectionProject(int id)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SMIPId", SqlDbType.Int)
                };
            parms[0].Value = id;
            var list = ComMethod.GetList<SteelMeshInspectionProject>("uspSelectSteelMeshInspectionProject", parms);
            if (list.Count > 0)
            {
                return list[0];
            }
            else
            {
                return new SteelMeshInspectionProject();
            }
        }
        /// <summary>
        /// 保存 检验项目 信息
        /// </summary>
        /// <param name="model"></param>
        public void SaveSteelMeshInspectionProject(SteelMeshInspectionProject model)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@SMIPId",SqlDbType.Int),
                new SqlParameter("@SMIPType",SqlDbType.Int),
                new SqlParameter("@SMIPCode",SqlDbType.NVarChar,80),
                new SqlParameter("@SMIPName",SqlDbType.NVarChar,80),
                new SqlParameter("@SMIPEntryMode",SqlDbType.NVarChar,80),
                new SqlParameter("@SMIPCriterion",SqlDbType.NVarChar,80),
                new SqlParameter("@SMIPUnit",SqlDbType.NVarChar,80),
                new SqlParameter("@SMIPUserName",SqlDbType.NVarChar,80),
                new SqlParameter("@SMIPRem",SqlDbType.NVarChar,80)
            };
            param[0].Value = model.SMIPId;
            param[1].Value = model.SMIPType;
            param[2].Value = model.SMIPCode;
            param[3].Value = model.SMIPName;
            param[4].Value = model.SMIPEntryMode;
            param[5].Value = model.SMIPCriterion;
            param[6].Value = model.SMIPUnit;
            param[7].Value = model.SMIPUserName;
            param[8].Value = model.SMIPRem;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAddEditSteelMeshInspectionProject", param);
        }
        /// <summary>
        /// 删除 检验项目 信息
        /// </summary>
        /// <param name="id"></param>
        public void DeleteSteelMeshInspectionProject(String id, String userName)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@SMIPId",SqlDbType.VarChar,500),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };
            param[0].Value = id;
            param[1].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteSteelMeshInspectionProject", param);
        }

    }
}
