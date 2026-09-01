using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Labels.Model;

namespace SKT.LeanMES.Labels.BLL
{
    public class LabelPrint
    {
        /// <summary>
        /// 根据对应数据获取标签文档id,连板数量,打印机名称
        /// </summary>
        /// <returns></returns>
        public LabelDocumentInfo GetLabelDocumentInfo(Int32 itemId, Int32 stationId, Int32 typeId, Int32 sequence)
        {
            LabelDocumentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]
            {
                  new SqlParameter("@ItemId",SqlDbType.Int),
                  new SqlParameter("@StationId",SqlDbType.Int),
                  new SqlParameter("@TypeId",SqlDbType.Int),
                  new SqlParameter("@Sequence",SqlDbType.Int)
            };
            parms[0].Value = itemId;
            parms[1].Value = stationId;
            parms[2].Value = typeId;
            parms[3].Value = sequence;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspProdGetLableDocumentId", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelDocumentInfo();
                    entity.LabelDocumentId = rdr.GetInt32(0);
                    entity.PlateQty = rdr.GetInt32(1);
                    entity.PrinterName = rdr.GetString(2);
                    entity.PrintWayId = rdr.GetInt32(3);
                    entity.TemplatePath = rdr.GetString(4);
                    entity.Print_Qty = rdr.GetInt32(5);
                    entity.TemplateID = rdr.GetInt32(6);
                    entity.ItemId = itemId;
                    break;
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 根据对应数据获取标签文档id,连板数量,打印机名称
        /// </summary>
        /// <returns></returns>
        public List<LabelDocumentInfo> GetLabelDocumentInfo2(Int32 itemId, Int32 stationId, Int32 typeId, Int32 sequence)
        {
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            LabelDocumentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]
            {
                  new SqlParameter("@ItemId",SqlDbType.Int),
                  new SqlParameter("@StationId",SqlDbType.Int),
                  new SqlParameter("@TypeId",SqlDbType.Int),
                  new SqlParameter("@Sequence",SqlDbType.Int)
            };
            parms[0].Value = itemId;
            parms[1].Value = stationId;
            parms[2].Value = typeId;
            parms[3].Value = sequence;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspProdGetLableDocumentId", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelDocumentInfo();
                    entity.LabelDocumentId = rdr.GetInt32(0);
                    entity.PlateQty = rdr.GetInt32(1);
                    entity.PrinterName = rdr.GetString(2);
                    entity.PrintWayId = rdr.GetInt32(3);
                    entity.TemplatePath = rdr.GetString(4);
                    entity.Print_Qty = rdr.GetInt32(5);
                    entity.TemplateID = rdr.GetInt32(6);
                    entity.ItemId = itemId;
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据包装条码获取标签文档id,连板数量,打印机名称

        /// </summary>
        /// <returns></returns>
        public List<LabelDocumentInfo> GetLabelDocumentInfo(string packSN)
        {
            //zhiman.yuan 2017-8-1 修改获取多个标签文档信息
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            LabelDocumentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]
            {
                  new SqlParameter("@PackSN",SqlDbType.VarChar,50),
            };
            parms[0].Value = packSN;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspPackGetLableDocumentId", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelDocumentInfo();
                    entity.LabelDocumentId = rdr.GetInt32(0);
                    entity.PlateQty = rdr.GetInt32(1);
                    entity.PrinterName = rdr.GetString(2);
                    entity.PrintWayId = rdr.GetInt32(3);
                    entity.TemplatePath = rdr.GetString(4);
                    entity.Print_Qty = rdr.GetInt32(5);
                    entity.ItemId = rdr.GetInt32(6);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据对应数据返回ZPL标签
        /// </summary>
        /// <param name="idString">D字符串。</param>
        /// <returns>ZPL标签内容。</returns>
        public string[] returnLabelContent(Int32 lableDocumentId, String SN, Int32 stationId, Int32 resId, Int32 lineId, Int32 itemId, Int32 woId)
        {
            string[] rs = new string[2];
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LabelDocumentId", SqlDbType.Int),
                new SqlParameter("@SN", SqlDbType.NVarChar,1000),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@WOId", SqlDbType.Int)
            };

            parms[0].Value = lableDocumentId;
            parms[1].Value = SN;
            parms[2].Value = stationId;
            parms[3].Value = resId;
            parms[4].Value = lineId;
            parms[5].Value = itemId;
            parms[6].Value = woId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLabelContentWithValue", parms))
            {
                if (rdr.Read())
                {
                    rs[0] = rdr.GetString(0);
                    rs[1] = rdr.GetString(1);
                }
                rdr.Close();
            }
            return rs;
        }


        /// <summary>
        /// 根据对应数据返回 标签的Lab信息。
        /// </summary>
        /// <returns>ZPL标签内容和Lab文件路径。</returns>
        public List<LabelDocumentInfo> returnLabelInfoForLab(Int32 lableDocumentId, String SN, Int32 stationId, Int32 resId, Int32 lineId, Int32 itemId, Int32 woId)
        {
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            LabelDocumentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LabelDocumentId", SqlDbType.Int),
                new SqlParameter("@SN", SqlDbType.NVarChar),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@WOId", SqlDbType.Int)
            };

            parms[0].Value = lableDocumentId;
            parms[1].Value = SN;
            parms[2].Value = stationId;
            parms[3].Value = resId;
            parms[4].Value = lineId;
            parms[5].Value = itemId;
            parms[6].Value = woId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLabelContentForLabPrint", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelDocumentInfo();
                    entity.LabelName = rdr.GetString(0);
                    entity.LabelValue = rdr.GetString(1);
                    entity.OriginalName = rdr.GetString(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        public List<LabelDocumentInfo> returnLabelInfo(Int32 lableDocumentId, List<string> SN, Int32 stationId, Int32 resId, Int32 lineId, Int32 itemId, Int32 woId)
        {
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            LabelDocumentInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@LabelDocumentId", SqlDbType.Int),
                new SqlParameter("@SN", SqlDbType.NVarChar),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@WOId", SqlDbType.Int),
                new SqlParameter("@Count", SqlDbType.Int)
            };

            parms[0].Value = lableDocumentId;
            parms[1].Value = string.Join(",", SN);
            parms[2].Value = stationId;
            parms[3].Value = resId;
            parms[4].Value = lineId;
            parms[5].Value = itemId;
            parms[6].Value = woId;
            parms[7].Value = SN.Count;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetLabelContent", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelDocumentInfo();
                    entity.ProdOrderId = rdr.GetInt32(0);
                    entity.LabelName = rdr.GetString(1);
                    entity.LabelValue = rdr.GetString(2);
                    entity.OriginalName = rdr.GetString(3);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public int GetTempCount(int LabelDocumentId)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@LabelDocumentId", SqlDbType.Int)
            };
            parms[0].Value = LabelDocumentId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetTempParCount", parms))
            {
                while (rdr.Read())
                {
                    int count = rdr.GetInt32(0);
                    return count;
                }
                rdr.Close();
            }
            return 0;
        }

        public List<LabelDocumentInfo> GetLabelDocumentByContainerSN(string SN)
        {
            //获取包装箱产品SN打印模板配置信息
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            LabelDocumentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]
            {
                  new SqlParameter("@SN",SqlDbType.VarChar,50),
            };
            parms[0].Value = SN;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspLabelDocumentByContainerSN", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelDocumentInfo();
                    entity.LabelDocumentId = rdr.GetInt32(0);
                    entity.PlateQty = rdr.GetInt32(1);
                    entity.PrinterName = rdr.GetString(2);
                    entity.Print_Qty = rdr.GetInt32(3);
                    entity.PrintWayId = rdr.GetInt32(4);
                    entity.TemplatePath = rdr.GetString(5);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        #region 根据路由和工位获取是否需要自动打印条码
        /// <summary>
        /// 根据路由和工位获取是否需要自动打印条码
        /// </summary>
        /// <param name="stationId"></param>
        /// <param name="scanSN"></param>
        /// <param name="isCheckRouter"></param>
        /// <param name="labelType"></param>
        /// <returns></returns>
        public List<LabelDocumentInfo> GetPrintDocumentList(int stationId, string scanSN, bool isCheckRouter,int labelType)
        {
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            LabelDocumentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]
            {
                  new SqlParameter("@stationId",SqlDbType.Int),
                  new SqlParameter("@scanSN",SqlDbType.VarChar),
                  new SqlParameter("@isCheckRouter",SqlDbType.Bit),
                  new SqlParameter("@labelType",SqlDbType.Int)
            };
            parms[0].Value = stationId;
            parms[1].Value = scanSN;
            parms[2].Value = isCheckRouter;
            parms[3].Value = labelType;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetIfPrint", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelDocumentInfo();
                    entity.LabelDocumentId = rdr.GetInt32(0);
                    entity.PlateQty = rdr.GetInt32(1);
                    entity.PrinterName = rdr.GetString(2);
                    entity.PrintWayId = rdr.GetInt32(3);
                    entity.TemplatePath = rdr.GetString(4);
                    entity.Print_Qty = rdr.GetInt32(5);
                    entity.ItemId = rdr.GetInt32(6);
                    entity.ProdOrderId = rdr.GetInt32(7);
                    entity.TypeId = rdr.GetInt32(8);
                    entity.SN = rdr.GetString(9);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据SN获取已经打印过的记录
        /// </summary>
        /// <param name="scanSN"></param>
        /// <returns></returns>
        public List<LabelDocumentInfo> GetReprintSNInfo(string scanSN)
        {
            List<LabelDocumentInfo> list = new List<LabelDocumentInfo>();
            LabelDocumentInfo entity = null;
            SqlParameter[] parms = new SqlParameter[]
            {
                  new SqlParameter("@SN",SqlDbType.VarChar)
            };

            parms[0].Value = scanSN;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetReprintSNInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new LabelDocumentInfo();
                    entity.LabelDocumentId = rdr.GetInt32(0);
                    entity.PlateQty = rdr.GetInt32(1);
                    entity.PrinterName = rdr.GetString(2);
                    entity.PrintWayId = rdr.GetInt32(3);
                    entity.TemplatePath = rdr.GetString(4);
                    entity.Print_Qty = rdr.GetInt32(5);
                    entity.ItemId = rdr.GetInt32(6);
                    entity.ProdOrderId = rdr.GetInt32(7);
                    entity.TypeId = rdr.GetInt32(8);
                    entity.SN = rdr.GetString(9);
                    entity.Document_Type = rdr.GetString(10);
                    entity.DocumentName = rdr.GetString(11);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        #endregion
    }
}
