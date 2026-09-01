using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ProductionCollection.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.ProductionCollection.Client
{
    public class ProdCollectionInput
    {
        #region 拼版绑定

        /// <summary>
        /// 检测拼版SN信息返回拼版规格
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public ProdCollectionInputInfo CheckPanelBindSN(string sn, int prodOrderId)
        {
            List<ProdCollectionInputInfo> list = new List<ProdCollectionInputInfo>();

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int)
            };

            param[0].Value = sn;
            param[1].Value = prodOrderId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckPanelBindSN", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<ProdCollectionInputInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        /// <summary>
        /// 检测拼版SN信息返回拼版规格 add by weixia on 2018.3.29
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public ProdCollectionInputInfo CheckScanPanelSN(string sn, int prodOrderId)
        {
            List<ProdCollectionInputInfo> list = new List<ProdCollectionInputInfo>();

            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int)
            };

            param[0].Value = sn;
            param[1].Value = prodOrderId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckScanPanelSN", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<ProdCollectionInputInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        public void  checkScanSNBiandPanel(string panelSN,int prodOrderId,string  sn)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@PanelSN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@SN",SqlDbType.NVarChar,512)
            };
            param[0].Value = panelSN;
            param[1].Value = prodOrderId;
            param[2].Value = sn;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckBindScanSN", param);
        }


        public void  savePanelBindSN(string panelScanStr, string  panelSN,int stationId,int resourceId ,int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@PanelScanStr",SqlDbType.NVarChar),
                new SqlParameter("@PanelSN",SqlDbType.NVarChar),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int)
            };
            param[0].Value = panelScanStr;
            param[1].Value = panelSN;
            param[2].Value = stationId;
            param[3].Value = resourceId;
            param[4].Value = userId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSavePanelBindSN", param);
        }


        /// <summary>
        /// 拼版投入过站
        /// </summary>
        /// <param name="panelUnitIdArr">拼版集合</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="resId">资源ID</param>
        /// <param name="userId">用户ID</param>
        public void CollectPanelBindSN(string panelUnitIdArr, int stationId, int resId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@PanelUnitIdArr",SqlDbType.VarChar),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserID",SqlDbType.Int),
            };
            param[0].Value = panelUnitIdArr;
            param[1].Value = stationId;
            param[2].Value = resId;
            param[3].Value = userId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectPanelBindSN", param);
        }

        /// <summary>
        /// 验证产线是否开拉
        ///验证GRN信息
        ///返回GRN数量 物料信息
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public decimal[] CheckPanelBindGRN(string grn, int prodOrderId, int stationId)
        {
            decimal[] grnArr = new decimal[3];
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@GRN",SqlDbType.NVarChar,300),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int)
            };
            param[0].Value = grn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckPanelBindGRN", param))
            {
                if (rdr.Read())
                {
                    grnArr[0] = rdr.GetDecimal(0);
                    grnArr[1] = Convert.ToDecimal(rdr.GetInt32(1));
                    grnArr[2] = rdr.GetDecimal(2);
                }
            }

            return grnArr;
        }

        /// <summary>
        /// 验证SN
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="sacnCount"></param>
        /// <returns></returns>
        public ProdCollectionInputInfo CheckMatPanelBindSN(string sn, int prodOrderId, int stationId, int resId, int userId)
        {
            List<ProdCollectionInputInfo> list = new List<ProdCollectionInputInfo>();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserID",SqlDbType.Int)                         
            };
            param[0].Value = sn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = userId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckMatPanelBindSN", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<ProdCollectionInputInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        /// <summary>
        /// 拼版上料投入过站
        /// </summary>
        /// <param name="panelUnitIdArr"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        /// <param name="grn"></param>
        /// <returns></returns>
        public decimal CollectMatPanelBindSN(string panelUnitIdArr, int stationId, int resId, int userId, string userName, string grn)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@PanelUnitIdArr",SqlDbType.VarChar),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
                new SqlParameter("@GRN",SqlDbType.NVarChar),
                new SqlParameter("@BalanceQty",SqlDbType.Decimal)
            };
            param[0].Value = panelUnitIdArr;
            param[1].Value = stationId;
            param[2].Value = resId;
            param[3].Value = userId;
            param[4].Value = userName;
            param[5].Value = grn;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectMatPanelBindSN", param);

            return Convert.ToDecimal(param[6].Value);
        }
        #endregion

        #region 上料投入采集UI

        /// <summary>
        /// 验证产线是否开拉
        ///验证GRN信息
        ///返回GRN数量 物料信息
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public decimal[] CheckInputGRN(string grn, int prodOrderId, int stationId)
        {
            decimal[] grnArr = new decimal[3];
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@GRN",SqlDbType.NVarChar,300),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int)
            };
            param[0].Value = grn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckInputGRN", param))
            {
                if (rdr.Read())
                {
                    grnArr[0] = rdr.GetDecimal(0);
                    grnArr[1] = Convert.ToDecimal(rdr.GetInt32(1));
                    grnArr[2] = rdr.GetDecimal(2);
                }
            }

            return grnArr;
        }

        /// <summary>
        /// 验证SN
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="sacnCount"></param>
        /// <returns></returns>
        public ProdCollectionInputInfo CheckMatInputSN(string sn, int prodOrderId, int stationId, int resId, int userId, int sacnCount)
        {
            List<ProdCollectionInputInfo> list = new List<ProdCollectionInputInfo>();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@ScanCount",SqlDbType.Int),                
            };
            param[0].Value = sn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = userId;
            param[5].Value = sacnCount;           

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckMatInputSN", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<ProdCollectionInputInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        /// <summary>
        /// 拼版上料投入过站
        /// </summary>
        /// <param name="panelUnitIdArr"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        /// <param name="grn"></param>
        /// <returns></returns>
        public decimal CollectMatInputSN(string panelUnitIdArr, int stationId, int resId, int userId,string userName,string grn)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@PanelUnitIdArr",SqlDbType.VarChar),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
                new SqlParameter("@GRN",SqlDbType.NVarChar),
                new SqlParameter("@BalanceQty",SqlDbType.Decimal)
            };
            param[0].Value = panelUnitIdArr;
            param[1].Value = stationId;
            param[2].Value = resId;
            param[3].Value = userId;
            param[4].Value = userName;
            param[5].Value = grn;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectMatInputSN", param);

            return Convert.ToDecimal(param[6].Value);
        }

        #endregion

        #region 投入采集UI

        /// <summary>
        /// 检查投入SN，返回掩码规则
        /// </summary>
        /// <param name="sn">产品序号</param>
        /// <param name="prodOrderId">工单ID</param>
        /// <param name="stationId">工序ID</param>
        /// <returns></returns>
        public ProdCollectionInputInfo CheckInputSN(string sn, int prodOrderId, int stationId, int resId, int userId)
        {
            List<ProdCollectionInputInfo> list = new List<ProdCollectionInputInfo>();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@UserID",SqlDbType.Int),
            };
            param[0].Value = sn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = userId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckInputSN", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<ProdCollectionInputInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        /// <summary>
        /// 投入过站
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="resId"></param>
        /// <param name="stationId"></param>
        /// <param name="userId"></param>
        public void CollectOrderInput(string sn, int resId, int stationId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),    
                new SqlParameter("@UserId",SqlDbType.Int)  
            };

            param[0].Value = sn;
            param[1].Value = stationId;
            param[2].Value = resId;
            param[3].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectOrderInput", param);
        }

        /// <summary>
        /// 进行离线条码投入过站
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="routerId"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        public void OffLineSNInput(string sn, int prodOrderId, int routerId, int stationId, int resId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),    
                new SqlParameter("@RouterId",SqlDbType.Int), 
                new SqlParameter("@UserId",SqlDbType.Int)  
            };

            param[0].Value = sn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = routerId;
            param[5].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspOffLineSNInput", param);
        }
        #endregion

        #region 转工单采集UI

        /// <summary>
        /// 转工单
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="opeId"></param>
        public void ChangeOrder(int prodOrderId, string sn, int stationId, int resId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int),               
                new SqlParameter("@UserId",SqlDbType.Int)  
            };

            param[0].Value = sn;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspChangeOrder", param);
        }

        #endregion

        #region 整机投入【聚电】

        #region 判断该条码是否存在未打散的客户条码
        /// <summary>
        /// 判断该条码是否存在未打散的客户条码
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="checkType"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        public string CheckSNAnew(string sn, int prodOrderId, int checkType, int stationId, int resouceId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@CheckType",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResouceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@strResult",SqlDbType.VarChar,10)
            };

            param[0].Value = sn;
            param[1].Value = prodOrderId;
            param[2].Value = checkType;
            param[3].Value = stationId;
            param[4].Value = resouceId;
            param[5].Value = userId;
            param[6].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckSNAnew", param);
            return param[6].Value.ToString();
        }
        #endregion

        /// <summary>
        /// 验证采集整机投入信息
        /// </summary>
        /// <param name="sn">--扫描的SN信息[DIP段完工的条码]</param>
        /// <param name="prodOrderId"></param>
        /// <param name="checkType">-- 1、验证升级工单逻辑 2、验证SN（客户条码1） 3、验证Mac(客户条码2)</param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        public void CheckFinishedGoodsInput(string sn ,int prodOrderId, int checkType, int stationId, int resouceId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@CheckType",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResouceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int)
            };

            param[0].Value = sn;
            param[1].Value = prodOrderId;
            param[2].Value = checkType;
            param[3].Value = stationId;
            param[4].Value = resouceId;
            param[5].Value = userId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckFinishedGoodsInput", param);
        }

        /// <summary>
        /// 采集整机投入信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="cusSN1"></param>
        /// <param name="cusSN2"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        /// <param name="userName"></param>
        public void FinishedGoodsInput(string sn, int prodOrderId, string cusSN1,string cusSN2, int stationId, int resouceId, int userId,string userName)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@CusSN1",SqlDbType.NVarChar),
                new SqlParameter("@CusSN2",SqlDbType.NVarChar),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResouceId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.NVarChar),
            };

            param[0].Value = sn;
            param[1].Value = prodOrderId;
            param[2].Value = cusSN1;
            param[3].Value = cusSN2;
            param[4].Value = stationId;
            param[5].Value = resouceId;
            param[6].Value = userId;
            param[7].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspFinishedGoodsInput", param);
        }
        #endregion

        #region 彩盒扫描验证

        /// <summary>
        /// 彩盒扫描工序验证
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="macSN"></param>
        public void ColorBoxValidation(string sn ,string macSN)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar),
                new SqlParameter("@MacSN",SqlDbType.NVarChar), 
            };

            param[0].Value = sn;
            param[1].Value = macSN;
            
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspColorBoxValidation", param);
        }

        #endregion


        /// <summary>
        /// 根据工单Id获取拼板信息
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public ProdCollectionInputInfo GetPanelInfoByOrderId(int prodOrderId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@ProdOrderId",SqlDbType.Int)
            };
            param[0].Value = prodOrderId;

            string sql = @"SELECT 
                                b.ParentNumber PanelRow,b.ChildrenNumber PanelCol
                            FROM dbo.Basal_Item a
                            INNER JOIN dbo.Basal_ItemPanelType b ON a.PanelTypeId = b.ItemPanelTypeId
                            INNER JOIN dbo.Prod_Order po ON a.ItemID = po.ItemId
                            WHERE po.ProdOrderID = @ProdOrderId";

            return ComMethod.GetBySql<ProdCollectionInputInfo>(sql, param);
        }

    }
}
