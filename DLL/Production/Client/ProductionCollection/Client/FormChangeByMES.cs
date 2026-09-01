using Dapper;
using Newtonsoft.Json;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.ERP;
using SKT.LeanMES.ProductionCollection.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace SKT.LeanMES.ProductionCollection.Client
{
    public class FormChangeByMES
    {
        private Int32 recordCount = 0;

        public List<FromChangeByMESInfo> GetAllFormChangeMESList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<FromChangeByMESInfo> list = new List<FromChangeByMESInfo>();
            //表名或者视图
            string strTb = "vwFromChangeByMES";
            //主键
            string strKey = "FromChangeByMESDtId";
            //查询栏位字串
            string strColumns = @"[FromChangeByMESDtId],[FromChangeByMESNo],[StauesName],[PreConversionMaterial],[ConvertedMaterial],[ConvertedQty],[CreateBy],[CreateDateTime],[cBarCode],[CWhCode],[CWhName],ERPNo";
            list = ComMethod.GetComList<FromChangeByMESInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public string GetFromChangeNo(string Value)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@Value", SqlDbType.VarChar) { Value=Value}
            };
            return ComMethod.GetList("uspGetFromChangeNo", parms);
        }

        public string GetFromChangeByNo(string FromChangeByMESNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@FromChangeByMESNo", SqlDbType.VarChar) { Value=FromChangeByMESNo}
            };
            return ComMethod.GetList("uspGetFromChangeByNo", parms);
        }

        public void FromChangeByMESDeleteBarCode(int FromChangeByMESDtId, string CreateBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@FromChangeByMESDtId", SqlDbType.Int) { Value=FromChangeByMESDtId},
                    new SqlParameter("@CreateBy", SqlDbType.VarChar) { Value=CreateBy}
            };
            ComMethod.Edit("uspFromChangeMesDeleteBarCode", parms);
        }

        public string FromChangeMesScanGenerate(string FromChangeByMESNo, string BarCode,string ConvertedMaterial,decimal ConvertedQty,int Flag,string CreateBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@FromChangeByMESNo", SqlDbType.VarChar) { Value=FromChangeByMESNo},
                    new SqlParameter("@BarCode", SqlDbType.VarChar) { Value=BarCode},
                    new SqlParameter("@ConvertedMaterial", SqlDbType.VarChar) { Value=ConvertedMaterial},
                    new SqlParameter("@ConvertedQty", SqlDbType.Decimal) { Value=ConvertedQty},
                    new SqlParameter("@Flag", SqlDbType.Int) { Value=Flag},
                    new SqlParameter("@CreateBy", SqlDbType.VarChar) { Value=CreateBy}
            };
            return ComMethod.GetList("uspFromChangeMesScan", parms);
        }

        public string GetItem(string value)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@Value", SqlDbType.VarChar) { Value=value}
            };
            return ComMethod.GetList("uspGetItem", parms);
        }

        /// <summary>
        /// 形态转换-ERP回写
        /// </summary>
        public List<string> SaveFormChangeCheck(string strJson)
        {
            var msg = string.Empty;
            string erpReturnNo = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.FormChangeCheck;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            List<string> list = new List<string>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var entity = JsonConvert.DeserializeAnonymousType(strJson, new
                    {
                        FromChangeByMESNo = "",
                        cBarCode = "",
                        MiniPackQty = 0,
                        ModifyBy = "",
                    });

                    var dp = new DynamicParameters();
                    dp.Add("@FromChangeByMESNo", entity.FromChangeByMESNo);
                    dp.Add("@cBarCode", entity.cBarCode);
                    dp.Add("@MiniPackQty", entity.MiniPackQty);
                    dp.Add("@ModifyBy", entity.ModifyBy);
                    reader = conn.ExecuteReader("uspSaveFormChangeMes", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    if (dtWrite != null && dtWrite.Rows.Count > 0)
                    {
                        string GRNString = dtWrite.Rows[0]["GRNString"].ToString();
                        if (!string.IsNullOrEmpty(GRNString))
                        {
                            //逗号分隔的单据号字符串转换成列表
                            list = new List<string>(GRNString.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries));
                        }
                    }

                    //是否需要回写
                    isWriteBack = WriteBackERP.IsWriteBack(em);
                    if (isWriteBack)
                    {
                        if (dtWrite == null || dtWrite.Rows.Count <= 0)
                        {
                            msg = "未获取到需要回写ERP数据";
                            throw new Exception(msg);
                        }

                        DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间

                        //调用接口
                        var info = WriteBackERP.HttpPostU9Api<CreateSaleRcvResponse>(em, dtWrite, entity.FromChangeByMESNo, entity.ModifyBy, dtEnterTime, dtAfterExecProcTime);

                        if (info.ResCode != 0 || !info.Data[0].IsSucess)
                        {
                            //回写失败
                            throw new Exception(info.ResMsg ?? info.Data[0].ErrorMsg);
                        }

                        //更新ERP单据号
                        var obj = new { ERPNo = info.Data[0].Code, FromChangeByMESNo = entity.FromChangeByMESNo };
                        int i = conn.Execute(@"UPDATE ps SET ps.ERPNo = @ERPNo FROM dbo.Prod_FromChangeByMES ps WHERE ps.FromChangeByMESNo = @FromChangeByMESNo", obj, tran);


                        //ERPU9ReturnInfo info = WriteBackERP.SendPostU9(conn, em, dtWrite, entity.FromChangeByMESNo, entity.ModifyBy, dtEnterTime, dtAfterExecProcTime);

                        //logList.Add(new WriteBackLogInfo
                        //{
                        //    WriteBackCode = em.ToString(),
                        //    ERPMsg = info.Msg,
                        //    ERPResult = info.Result ? 1 : 0,
                        //    ERPNo = info.ERPNo,
                        //    MESBillNo = entity.FormChangeNo,
                        //    WriteBackData = info.SendInfo,
                        //    ReceiveData = info.ReceiveData,
                        //    EnterTime = dtEnterTime,
                        //    AfterExecProcTime = dtAfterExecProcTime,
                        //    AfterExecERPTime = info.dtAfterExecERPTime,
                        //    CreateDateTime = DateTime.Now
                        //});

                        //if (!info.Result)
                        //{
                        //    throw new Exception(info.Msg);
                        //}
                    }

                    tran.Commit();
                }
                catch (Exception ex)
                {
                    try
                    {
                        tran.Rollback();
                        throw new Exception("事务处理失败，已回滚。", ex);
                    }
                    catch (Exception rollbackEx)
                    {

                        throw ex;
                    }
                }
                finally
                {
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }
                    foreach (var log in logList)
                    {
                        WriteBackERP.AddWriteBackLog(conn, log);
                    }
                    conn.Close();
                }
            }
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}
