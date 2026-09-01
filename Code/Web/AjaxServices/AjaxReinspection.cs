using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Material.BLL;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// 重检操作
    /// </summary>
    public class AjaxReinspection
    {
        [AjaxMethod]
        public List<ReinspectionInfo> GetAll()
        {
            try
            {
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.AddCondition("Status", "0");
                var list= new Reinspection().GetAll(0, 1000, "", searchSettings);
                return list;
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [AjaxMethod]
        public List<ReinspectionInfo> GetAllReinspection(string ReinspectionNo)
        {
            try
            {
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.AddCondition("Status", "0");
                searchSettings.ExtensionCondition = " ReinspectionNo like '%" + ReinspectionNo + "%'";
                var list = new Reinspection().GetAll(0, 20, "", searchSettings);
                return list;
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        //送检
        [AjaxMethod]
        public void ReinspectionSj(string ListNo, string UserName)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@ListNo",SqlDbType.NVarChar),
                    new SqlParameter("@UserName",SqlDbType.NVarChar),
                    };
                param[0].Value = ListNo;
                param[1].Value = UserName;
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReinspectionSj", param);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        [AjaxMethod]
        //生成重检单据
        public void Edit(string CJNo, string GrnStr, int CheckResult, string Remark, string UserName)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@CJNo",SqlDbType.NVarChar),
                    new SqlParameter("@GrnStr",SqlDbType.NVarChar,int.MaxValue),
                    new SqlParameter("@CheckResult",SqlDbType.Int),
                    new SqlParameter("@Remark",SqlDbType.VarChar,int.MaxValue),
                    new SqlParameter("@UserName",SqlDbType.VarChar),
                    };
                param[0].Value = CJNo;
                param[1].Value = GrnStr;
                param[2].Value = CheckResult;
                param[3].Value = Remark;
                param[4].Value = UserName;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReinspectionCreate", param);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        [AjaxMethod]
        //生成重检单据
        public void CPEdit(string CJNo, string GrnStr, int CheckResult, string Remark, int CheckQty, string UserName)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@CJNo",SqlDbType.NVarChar),
                    new SqlParameter("@GrnStr",SqlDbType.NVarChar,int.MaxValue),
                    new SqlParameter("@CheckResult",SqlDbType.Int),
                    new SqlParameter("@Remark",SqlDbType.NVarChar,int.MaxValue),
                    new SqlParameter("@CheckQty",SqlDbType.Int),
                    new SqlParameter("@UserName",SqlDbType.VarChar),
                    };
                param[0].Value = CJNo;
                param[1].Value = GrnStr;
                param[2].Value = CheckResult;
                param[3].Value = Remark;
                param[4].Value = CheckQty;
                param[5].Value = UserName;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCPReinspectionCreate", param);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        [AjaxMethod]
        //结果变更
        public void UpdateCheckResult(string GrnStr, int CheckResult, string Remark, string UserName)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@GrnStr",SqlDbType.NVarChar,int.MaxValue),
                    new SqlParameter("@CheckResult",SqlDbType.Int),
                    new SqlParameter("@Remark",SqlDbType.VarChar,int.MaxValue),
                    new SqlParameter("@UserName",SqlDbType.VarChar),
                    };
                param[0].Value = GrnStr;
                param[1].Value = CheckResult;
                param[2].Value = Remark;
                param[3].Value = UserName;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReinspectionDtlUpdate", param);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        [AjaxMethod]
        //结果变更
        public void CPUpdateCheckResult(string GrnStr, int CheckResult, string Remark, string UserName)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@GrnStr",SqlDbType.NVarChar,int.MaxValue),
                    new SqlParameter("@CheckResult",SqlDbType.Int),
                    new SqlParameter("@Remark",SqlDbType.NVarChar,int.MaxValue),
                    new SqlParameter("@UserName",SqlDbType.VarChar),
                    };
                param[0].Value = GrnStr;
                param[1].Value = CheckResult;
                param[2].Value = Remark;
                param[3].Value = UserName;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCPReinspectionDtlUpdate", param);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        //获取重检单数据
        [AjaxMethod]
        public string GetReinspectionList(string ListNo)
        {
            try
            {
                string strsql = @"SELECT * FROM dbo.Prod_Reinspection t JOIN dbo.Prod_ReinspectionDtl t1 ON t1.Pid=t.ReinspectionId INNER JOIN  prod_materialunit a ON  t1.SerialNumber=a.SerialNumber 
INNER JOIN dbo.basal_item AS b ON a.partid = b.itemid where t.ReinspectionNo='" + ListNo + "'";
                var list = CommonHelper.BLL.ComMethod.GetListBySql(strsql, null);
                return list;
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        [AjaxMethod]
        public List<ReinspectionInfo> GetReinspectionListByPDA(string ListNo)
        {
            try
            {
                string strsql = "SELECT cBarCode as CBarCode,* FROM dbo.Prod_Reinspection t  JOIN dbo.Prod_ReinspectionDtl t1 ON t1.Pid=t.ReinspectionId  JOIN dbo.Prod_MaterialUnit t2 ON t2.SerialNumber=t1.SerialNumber JOIN dbo.Basal_Item t3 ON t3.ItemID=t2.PartId  where t.ReinspectionNo='" + ListNo + "' AND t.Status=0 ";
                var list = CommonHelper.BLL.ComMethod.GetListBySql<ReinspectionInfo>(strsql, null);
                return list;
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        /// <summary>
        /// 根据GSN获取对应单据的所有信息
        /// </summary>
        /// <param name="SerialNumber">GSN条码</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ReinspectionInfo> GetReinspectionListByGSNPDA(string SerialNumber)
        {
            try
            {
                string strsql = "SELECT cBarCode as CBarCode,* FROM dbo.Prod_Reinspection t  JOIN dbo.Prod_ReinspectionDtl t1 ON t1.Pid=t.ReinspectionId  JOIN dbo.Prod_MaterialUnit t2 ON t2.SerialNumber=t1.SerialNumber JOIN dbo.Basal_Item t3 ON t3.ItemID=t2.PartId  where t.ReinspectionId in( select Pid from dbo.Prod_ReinspectionDtl where SerialNumber='" + SerialNumber + "') AND t.Status=0 ";
                var list = CommonHelper.BLL.ComMethod.GetListBySql<ReinspectionInfo>(strsql, null);
                return list;
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        //扫描操作
        [AjaxMethod]
        public void ScanGrn(string Grn, string UserName, string ListNo)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@Grn",SqlDbType.VarChar),
                    new SqlParameter("@UserName",SqlDbType.VarChar),
                    new SqlParameter("@ListNo",SqlDbType.VarChar),
                    };
                param[0].Value = Grn;
                param[1].Value = UserName;
                param[2].Value = ListNo;
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReinspectionsScanGrn", param);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        //重检操作
        [AjaxMethod]
        public void ReinspectionCheck(string GrnStr, string UserName)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@GrnStr",SqlDbType.NVarChar,int.MaxValue),
                    new SqlParameter("@UserName",SqlDbType.VarChar),
                    };
                param[0].Value = GrnStr;
                param[1].Value = UserName;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReinspectionCreate", param);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        //重检完成
        [AjaxMethod]
        public void ReinspectionFinish(string ListNo, string UserName)
        {
            try
            {
                SqlParameter[] param = new SqlParameter[] {
                    new SqlParameter("@ListNo",SqlDbType.NVarChar),
                    new SqlParameter("@UserName",SqlDbType.VarChar),
                    };
                param[0].Value = ListNo;
                param[1].Value = UserName;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReinspectionFinish", param);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}