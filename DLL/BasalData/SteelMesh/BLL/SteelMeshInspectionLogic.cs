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
using System.Text.RegularExpressions;

namespace SKT.LeanMES.SteelMesh.BLL
{
    public class SteelMeshInspectionLogic
    {
        private Int32 recordCount = 0;
        private Int32 recordDtlCount = 0;
        /// <summary>
        /// 分页获取  检验报告 	 资料。
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SteelMeshInspection> GetAllSteelMeshInspection(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SteelMeshInspection> list = new List<SteelMeshInspection>();
            //表名或者视图
            string strTb = "vw_SteelMeshInspection";
            //主键
            string strKey = "SMIId";
            //查询栏位字串
            string strColumns = @"*";
            list = ComMethod.GetComList<SteelMeshInspection>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }
        /// <summary>
        /// 获取 检验报告  数量
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetSteelMeshInspectionCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        /// <summary>
        /// 分页获取  检验报告详细 	 资料。
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<SteelMeshInspectionDtl> GetAllSteelMeshInspectionDtl(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SteelMeshInspectionDtl> list = new List<SteelMeshInspectionDtl>();
            //表名或者视图
            string strTb = "vw_SteelMeshInspectionDtl";
            //主键
            string strKey = "SMIDId";
            //查询栏位字串
            string strColumns = @"*";
            list = ComMethod.GetComList<SteelMeshInspectionDtl>(ref recordDtlCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }
        /// <summary>
        /// 获取 检验报告详细  数量
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetSteelMeshInspectionDtlCount(SearchSettings searchSettings)
        {
            return this.recordDtlCount;
        }

        /// <summary>
        /// 生成检验项目信息
        /// </summary>
        /// <param name="EquipmentId"></param>
        /// <param name="username"></param>
        /// <returns></returns>
        public int SaveSteelMeshInspection(int EquipmentId, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@EquipmentId",SqlDbType.Int),
                    new SqlParameter("@UserName", SqlDbType.NVarChar,50),
                    new SqlParameter("@SMIId",SqlDbType.Int)
                };
            parms[0].Value = EquipmentId;
            parms[1].Value = username;
            parms[2].Value = 0;
            parms[2].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveSteelMeshInspection", parms);
            return Convert.ToInt32(parms[2].Value);
        }
        /// <summary>
        /// 查询 检验信息
        /// </summary>
        /// <param name="SMIId"></param>
        /// <returns></returns>
        public SteelMeshInspection SelectSteelMeshInspection(int SMIId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SMIId", SqlDbType.Int)
                };
            parms[0].Value = SMIId;
            var list = ComMethod.GetList<SteelMeshInspection>("uspSelectSteelMeshInspection", parms);
            if (list.Count > 0)
            {
                return list[0];
            }
            else
            {
                return new SteelMeshInspection();
            }
        }
        /// <summary>
        /// 查询检验项目
        /// </summary>
        /// <param name="SMIDSMIId"></param>
        /// <returns></returns>
        public List<SteelMeshInspectionDtl> SelectSteelMeshInspectionDtl(int SMIDSMIId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SMIDSMIId", SqlDbType.Int)
                };
            parms[0].Value = SMIDSMIId;
            var list = ComMethod.GetList<SteelMeshInspectionDtl>("uspSelectSteelMeshInspectionDtl", parms);
            return list;
        }
        /// <summary>
        /// 增加检验项目
        /// </summary>
        /// <param name="mid"></param>
        /// <param name="mpid"></param>
        public void AddSteelMeshInspectionDtl(int mid,int mpid)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@SMIDSMIId",SqlDbType.Int),
                new SqlParameter("@SMIDSMIPId",SqlDbType.Int)

            };
            param[0].Value = mid;
            param[1].Value = mpid;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspAddSteelMeshInspectionDtl", param);
        }
        /// <summary>
        /// 删除检验项目
        /// </summary>
        /// <param name="mdid"></param>
        public void DeleteSteelMeshInspectionDtl(int mdid)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@SMIDId",SqlDbType.Int)
            };
            param[0].Value = mdid;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteSteelMeshInspectionDtl", param);
        }
        /// <summary>
        /// 检验开始
        /// </summary>
        /// <param name="eid"></param>
        /// <param name="mid"></param>
        /// <param name="username"></param>
        public void StartSteelMeshInspection(int eid, int mid, string username)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@EquipmentId",SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.NVarChar,50),
                new SqlParameter("@SMIId",SqlDbType.Int)

            };
            param[0].Value = eid;
            param[1].Value = username;
            param[2].Value = mid;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspStartSteelMeshInspection", param);
        }
        /// <summary>
        /// 检验完成
        /// </summary>
        /// <param name="EquipmentId"></param>
        /// <param name="UserName"></param>
        /// <param name="SMIId"></param>
        /// <param name="InspectionResult"></param>
        /// <param name="SMIInspectionRem"></param>
        /// <param name="Dtlinfo"></param>
        public void StopSteelMeshInspection(int EquipmentId,string UserName,int SMIId,int InspectionResult,string SMIInspectionRem,string Dtlinfo)
        {
            DataTable DtlinfoDT = JsonToDataTable(Dtlinfo);
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@EquipmentId",SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.NVarChar,50),
                new SqlParameter("@SMIId",SqlDbType.Int),
                new SqlParameter("@InspectionResult",SqlDbType.Int),
                new SqlParameter("@SMIInspectionRem", SqlDbType.NVarChar,200),
                new SqlParameter("@Dtlinfo", SqlDbType.Structured)

            };
            param[0].Value = EquipmentId;
            param[1].Value = UserName;
            param[2].Value = SMIId;
            param[3].Value = InspectionResult;
            param[4].Value = SMIInspectionRem;
            param[5].Value = DtlinfoDT;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspStopSteelMeshInspection", param);
        }






        public static DataTable JsonToDataTable(string strJson)
        {
            // 取出表名    
            var rg = new Regex(@"(?<={)[^:]+(?=:\[)", RegexOptions.IgnoreCase);
            string strName = rg.Match(strJson).Value;
            DataTable tb = null;
            // 去除表名    
            strJson = strJson.Substring(strJson.IndexOf("[") + 1);
            strJson = strJson.Substring(0, strJson.IndexOf("]"));
            // 获取数据    
            rg = new Regex(@"(?<={)[^}]+(?=})");
            MatchCollection mc = rg.Matches(strJson);
            for (int i = 0; i < mc.Count; i++)
            {
                string strRow = mc[i].Value;
                string[] strRows = strRow.Split(',');
                // 创建表    
                if (tb == null)
                {
                    tb = new DataTable();
                    tb.TableName = strName;
                    foreach (string str in strRows)
                    {
                        var dc = new DataColumn();
                        string[] strCell = str.Split(':');
                        dc.ColumnName = strCell[0].Replace("\"", "");
                        tb.Columns.Add(dc);
                    }
                    tb.AcceptChanges();
                }
                // 增加内容    
                DataRow dr = tb.NewRow();
                for (int j = 0; j < strRows.Length; j++)
                {
                    dr[j] = strRows[j].Split(':')[1].Replace("\"", "");
                }
                tb.Rows.Add(dr);
                tb.AcceptChanges();
            }
            return tb;
        }
    }
}
