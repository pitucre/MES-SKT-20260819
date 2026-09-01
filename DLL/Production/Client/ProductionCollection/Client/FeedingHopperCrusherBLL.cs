using Dapper;
using Newtonsoft.Json;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.ERP;
using System.Collections.Generic;
using System;
using System.Data;
using System.Data.SqlClient;
using static Dapper.SqlMapper;

namespace SKT.LeanMES.ProductionCollection.Client
{
    public class FeedingHopperCrusherBLL
    {
        public string GetCrusher(string CrusherCode, int Flag)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@CrusherCode", SqlDbType.NVarChar) { Value=CrusherCode},
                    new SqlParameter("@Flag", SqlDbType.Int) { Value=Flag}
            };

            return ComMethod.GetList("uspFeedingHopperCheckCrusher", parms);
        }

        public string GetSrapFeedingDtl(string CrusherCode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@EquipmentCode", SqlDbType.NVarChar) { Value=CrusherCode}
            };
            return ComMethod.GetList("uspGetSrapFeedingDtl", parms);
        }

        public void SrapFeedingDeleteBarCode(int SrapFeedingDtId, string CreateBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@SrapFeedingDtId", SqlDbType.Int) { Value=SrapFeedingDtId},
                    new SqlParameter("@CreateBy", SqlDbType.NVarChar) { Value=CreateBy}
            };
            ComMethod.Edit("uspSrapFeedingDeleteBarCode", parms);
        }

        public string FeedingHopperLoadCrusher(string CrusherCode, string BarCode, string CreateBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@CrusherCode", SqlDbType.VarChar) { Value=CrusherCode},
                    new SqlParameter("@BarCode", SqlDbType.VarChar) { Value=BarCode},
                    new SqlParameter("@CreateBy", SqlDbType.NVarChar) { Value=CreateBy}
            };
            return ComMethod.GetList("uspFeedingHopperLoadCrusher", parms);
        }

        public string FeedingHopperCompleteCrusher(string CrusherCode, string CreateBy)
        {
            //SqlParameter[] parms = new SqlParameter[]{
            //        new SqlParameter("@CrusherCode", SqlDbType.VarChar) { Value=CrusherCode},
            //        new SqlParameter("@CreateBy", SqlDbType.NVarChar) { Value=CreateBy}
            //};
            //return ComMethod.GetList("FeedingHopperCompleteCrusher", parms);

            var msg = string.Empty;
            string erpInstockNo = string.Empty;
            string ItemId = string.Empty;
            bool isWriteBack;
            IDataReader reader = null;
            WriteBackEnum em = WriteBackEnum.OtherWarehousing;
            DataTable dtWrite = new DataTable();    //需要回写的数据
            DateTime dtEnterTime = DateTime.Now;    //进入时间（执行MES存储过程前的时间）
            List<WriteBackLogInfo> logList = new List<WriteBackLogInfo>();
            using (var conn = DBHelper.GetConnection())
            {
                var tran = conn.BeginTransaction();
                try
                {
                    var dp = new DynamicParameters();
                    dp.Add("@CrusherCode", CrusherCode);
                    dp.Add("@CreateBy", CreateBy);
                    reader = conn.ExecuteReader("FeedingHopperCompleteCrusher", dp, tran, null, CommandType.StoredProcedure);
                    dtWrite.Load(reader);
                    if (reader != null)
                    {
                        reader.Close();
                        reader.Dispose();
                    }

                    DateTime dtAfterExecProcTime = DateTime.Now;    //执行完MES存储过程时间


                    if (dtWrite != null || dtWrite.Rows.Count > 0)
                    {
                        erpInstockNo = dtWrite.Rows[0]["billCode"].ToString();
                        ItemId = dtWrite.Rows[0]["ItemId"].ToString();
                    }

                    //移除ItemId列，避免回写接口调用失败
                    if (dtWrite.Columns.Contains("ItemId"))
                    {
                        dtWrite.Columns.Remove("ItemId");
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

                        //调用接口
                        var info = WriteBackERP.HttpPostU9Api<CreateSaleRcvResponse>(em, dtWrite, "", CreateBy, dtEnterTime, dtAfterExecProcTime);

                        if (info.ResCode != 0 || !info.Data[0].IsSucess)
                        {
                            //回写失败
                            throw new Exception(info.ResMsg ?? info.Data[0].ErrorMsg);
                        }
                        //ERPU9ReturnInfo infos = WriteBackERP.SendPostU9(conn, em, dtWrite, entity.ProdOrderId.ToString(), entity.UserName, dtEnterTime, dtAfterExecProcTime);
                    }
                    if (dtWrite != null || dtWrite.Rows.Count > 0)
                    {
                        erpInstockNo = dtWrite.Rows[0]["billCode"].ToString();
                    }
                    tran.Commit();
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    throw ex;
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
            //返回Josn格式，包含单号和物料ID
            return JsonConvert.SerializeObject(new { GRNString = erpInstockNo, ItemId = ItemId });


        }
    }
}
