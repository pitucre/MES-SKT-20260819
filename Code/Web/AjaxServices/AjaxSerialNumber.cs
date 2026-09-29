using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.SerialNumber.BLL;
using SKT.LeanMES.SerialNumber.Model;


using AjaxPro;
using System.Data;
using SKT.LeanMES.DataType.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.Common.DAL.Marshal;
using System.Data.SqlClient;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxSerialNumber
    {
        [AjaxMethod]
        public void SerialNumberTypeEdit(SerialNumberTypeInfo entity)
        {
            try
            {
                SerialNumberType bll = new SerialNumberType();
                if(entity.SerialNumberTypeId ==-1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 转化为十进制
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public Int64 ChangeToDeciaml(int SeqBase, string strNumberSeq, string strSource)
        {
            try
            {
                SKT.LeanMES.SerialNumber.BLL.SerialNumber sampleSN = new LeanMES.SerialNumber.BLL.SerialNumber();
                string strDefaultDigitSet = "";
                Int64 intResult = 0;
                if (SeqBase > 0)
                {
                    strDefaultDigitSet = sampleSN.getDefaultDigitSet(SeqBase);
                }
                else
                {
                    strDefaultDigitSet = strNumberSeq;
                }
                //进制数转化成十进制保存
                intResult = sampleSN.formatToLong(strSource.ToUpper(), strDefaultDigitSet);
                return intResult;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return -1;
            }
        }
        /// <summary>
        /// 根据掩码数据信息更新或新增数据
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public int EditSerialNumber(SerialNumberInfo entity, SerialNumberSeedInfo entityS)
        {
            try
            {
                entityS.Number_Sequence = entityS.Number_Sequence.ToUpper();
                SKT.LeanMES.SerialNumber.BLL.SerialNumber bllData = new LeanMES.SerialNumber.BLL.SerialNumber();
                return bllData.Edit(entity, entityS);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }

        /// <summary>
        /// 新增/编辑单据维护
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void EditVouchType(MesVouchTypeInfo entity)
        {

            try
            {
                MesVouchType bll = new MesVouchType();
                if (entity.MesVouchTypeId == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
        /// <summary>
        /// 生成序号实例
        /// </summary>
        /// <param name="pageName"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GenerateSNSample(int NextID, string currentSequence)
        {
            try
            {
                SKT.LeanMES.SerialNumber.BLL.SerialNumber bllData = new LeanMES.SerialNumber.BLL.SerialNumber();
                return bllData.GetSampleSFC(NextID,currentSequence);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }

        /// <summary>
        /// 保存序列号样例
        /// </summary>
        /// <param name="serialNumberId">序列号规则ID</param>
        /// <param name="sampleSerialNumber">序列号样例</param>
        [AjaxMethod]
        public void EditSampleSerialNumber(int serialNumberId, string sampleSerialNumber)
        {
            try
            {
                SKT.LeanMES.SerialNumber.BLL.SerialNumber bllData = new LeanMES.SerialNumber.BLL.SerialNumber();
                SerialNumberInfo entity = bllData.GetInfo(serialNumberId);
                entity.SampleSerialNumber = sampleSerialNumber;
                bllData.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 保存打印记录
        /// </summary>
        /// <param name="entity">打印记录</param>
        [AjaxMethod]
        public void RecodePrint(PrintRecordInfo entity)
        {
            try
            {
                PrintRecord bll = new PrintRecord();
                entity.PrintUser = AccountController.GetCurrentUser().UserName;
                entity.PrintTime = DateTime.Now;
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        [AjaxMethod]
        public void ResetWayEdit(ResetWayInfo entity)
        {
            try
            {
                ResetWay bll = new ResetWay();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(entity.CreateBy, ex);
            }
        }

        /// <summary>
        /// 规则函数编辑
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void PerfixSufEdit(DictionaryInfo entity)
        {
            try
            {
                SerialNumberPerfixSuf bll = new SerialNumberPerfixSuf();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(entity.CreateBy, ex);
            }
        }

        /// <summary>
        /// 根据ID集合获取SN集合
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<string> GetListSNByIds(string ids)
        {
            List<string> listSN = new List<string>();
            try
            {
                string sql = @"SELECT  a.[Value] AS SN   
                    FROM    Prod_SerialNumber AS a  WITH (NOLOCK) 
	                    INNER JOIN fn_SplitStringToStrTable('{0}',',') T ON T.Value = A.UID
                    WHERE   a.SNTypeID = 0   ";
                using (SqlDataReader dr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, string.Format(sql, ids)))
                {
                    while (dr.Read())
                    {
                        listSN.Add(dr.GetString(0));
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return listSN;
        }

        /// <summary>
        /// 根据SN集合获取UID集合（GetListSNByIds 的反向换算）
        /// 用途：补打标签列表页用的视图 udfvw_printSN_more 只有 SN，没有 UID，
        ///       而补打窗口 ShopOrderDetailRePrint.aspx 按 UID 取数，故在页面里先做 SN→UID 换算。
        /// </summary>
        /// <param name="sns">SN 字符串，逗号分隔</param>
        /// <returns>UID 字符串集合（主条码 SNTypeID=0）</returns>
        [AjaxMethod]
        public List<string> GetUIDListBySN(string sns)
        {
            List<string> listUID = new List<string>();
            try
            {
                if (string.IsNullOrEmpty(sns))
                {
                    return listUID;
                }
                string sql = @"SELECT  a.[UID]
                    FROM    Prod_SerialNumber AS a  WITH (NOLOCK)
                            INNER JOIN fn_SplitStringToStrTable(@SNs,',') T ON T.Value = a.[Value]
                    WHERE   a.SNTypeID = 0   ";
                SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SNs", SqlDbType.NVarChar, 4000)
                };
                parms[0].Value = sns;
                using (SqlDataReader dr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
                {
                    while (dr.Read())
                    {
                        listUID.Add(dr[0].ToString());
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return listUID;
        }

    }
}