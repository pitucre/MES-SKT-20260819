using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ProdUnit.Model;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.ProdUnit.BLL
{
    public class PrepSerialNumber
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 获取条码列表信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PrepSerialNumberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PrepSerialNumberInfo> list = new List<PrepSerialNumberInfo>();
            //表名或者视图
            string strTb = "vwGetPreSNList";
            //主键
            string strKey = "PrepSNId";
            //查询栏位字串
            string strColumns = @" PrepSNId,PSNTypeId,PSNType,ProdOrderId,OrderNO,ItemId,ItemCode,PSN,Status,CreateBy,CreateDateTime";

            return ComMethod.GetComList<PrepSerialNumberInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);           
        }

        /// <summary>
        /// 根据 PrepSerialNumberId 字符串删除 PrepSerialNumber 信息。
        /// </summary>
        /// <param name="idString">PrepSerialNumberId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PrepSerialNumber_Delete", parms);
        }

        /// <summary>
        /// 根据 PrepSerialNumberId 获取实体信息。
        /// </summary>
        /// <param name="prepSerialNumberId">PrepSerialNumberId。</param>
        /// <returns>PrepSerialNumber 实体对象。</returns>
        public PrepSerialNumberInfo GetInfo(Int32 prepSerialNumberId)
        {
            return ComMethod.GetInfo<PrepSerialNumberInfo>(prepSerialNumberId, "Prod_PrepSerialNumber_GetInfo");  
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PrepSerialNumber 实体对象。</returns>
        public PrepSerialNumberInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<PrepSerialNumberInfo>(fieldValue, "Prod_PrepSerialNumber_GetInfo");  
        }

        /// <summary>
        /// 获取剩余打印数量,产品Id 
        /// </summary>
        /// <param name="psnTypeId"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public string[] GetPrintQty(int psnTypeId,int prodOrderId)
        {
            string[] arr = new string[2];

            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@PSNTypeId",DbType.Int32),
                new SqlParameter("@ProdOrderId",DbType.Int32),
                new SqlParameter("@PrintQty",DbType.Int32),
                new SqlParameter("@ItemId",DbType.Int32),
            };
            paras[0].Value = psnTypeId;
            paras[1].Value = prodOrderId;
            paras[2].Value = 0;
            paras[2].Direction = ParameterDirection.InputOutput;
            paras[3].Value = 0;
            paras[3].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetPSNPrintQty", paras);

            arr[0] = Convert.ToString(paras[2].Value);
            arr[1] = Convert.ToString(paras[3].Value);

            return arr;
        }
        
        /// <summary>
        /// 释放离线条码信息
        /// </summary>
        /// <param name="psnTypeId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="itemId"></param>
        /// <param name="printQty"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public List<String> RelesePSN(int psnTypeId, int prodOrderId, int itemId, int printQty, int userId)
        {
            List<String> list = new List<string>();

            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@PSNTypeId",DbType.Int32),
                new SqlParameter("@ProdOrderId",DbType.Int32),
                new SqlParameter("@ItemId",DbType.Int32),
                new SqlParameter("@PrintQty",DbType.Int32),
                new SqlParameter("@UserId",DbType.Int32),
            };
            paras[0].Value = psnTypeId;
            paras[1].Value = prodOrderId;
            paras[2].Value = itemId;
            paras[3].Value = printQty;
            paras[4].Value = userId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspRelesePSN", paras))
            {
                while (rdr.Read())
                {
                    list.Add(rdr.GetString(0));
                }
                rdr.Close();
            }

            return list;
        }

        /// <summary>
        /// 获取离线条码补打所需要的信息	   
        /// </summary>
        /// <param name="prepSNIdStr"></param>
        /// <returns></returns>
        public int[] GetPrepSNReprintInfo(string prepSNIdStr)
        {
            int[] psnArr = new int[3];

            SqlParameter[] paras = new SqlParameter[]{
                new SqlParameter("@PrepSNIdStr",SqlDbType.VarChar),
            };

            paras[0].Value = prepSNIdStr;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPrepSNReprintInfo", paras))
            {
                while (rdr.Read())
                {
                    psnArr[0] = rdr.GetInt32(0);
                    psnArr[1] = rdr.GetInt32(1);
                    psnArr[2] = rdr.GetInt32(2);
                }
                rdr.Close();
            }
            return psnArr;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 栈板打散
        /// </summary>
        /// <param name="palletSN"></param>
        /// <param name="modifyBy"></param>
        public void PalletScatter(string palletSN, string modifyBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PalletNo",SqlDbType.VarChar,50),
                new SqlParameter("@ModifyBy",SqlDbType.VarChar,20)
            };

            parms[0].Value = palletSN;
            parms[1].Value = modifyBy;

            ComMethod.Edit("uspPalletScatter", parms);
        }

        /// <summary>
        /// 验证栈板号是否已经存在
        /// </summary>
        /// <param name="palletSN"></param>
        public void ValidatePalletExists(string palletSN)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PalletSN",SqlDbType.NVarChar,50)
            };

            parms[0].Value = palletSN;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidatePalletExists", parms);
        }


        /// <summary>
        /// 栈板注册
        /// </summary>
        /// <param name="palletSNs"></param>
        /// <param name="itemId"></param>
        /// <param name="userId"></param>
        public void PalletRegister(string palletSNs, int itemId, int userId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PalletSNs",SqlDbType.NVarChar,4000),
                new SqlParameter("@ItemId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int)
            };

            parms[0].Value = palletSNs;
            parms[1].Value = itemId;
            parms[2].Value = userId;

            ComMethod.Edit("uspPalletRegister", parms);
        }

        /// <summary>
        /// 获取PrepSerialNumberInfo信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public PrepSerialNumberInfo GetPrepSerialNumberInfo(PrepSerialNumberInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PSN", SqlDbType.NVarChar, 100)
            };
            parms[0].Value = entity.PSN;
            return ComMethod.Get<PrepSerialNumberInfo>("uspGetPrepSerialNumberInfo", parms);
        }

    }
}
