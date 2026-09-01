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
    public class ProdCollectionPacking
    {
        #region SMT装箱

        /// <summary>
        /// 获取SMT包装箱信息
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public string[] GetSMTPackInfo(string sn)
        {
            string[] smtPackArr = new string[4];
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,300),

            };
            param[0].Value = sn;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetSMTPackInfo", param))
            {
                if (rdr.Read())
                {
                    smtPackArr[0] = rdr.GetString(0);
                    smtPackArr[1] = rdr.GetInt32(1).ToString();
                    smtPackArr[2] = rdr.GetInt32(2).ToString();
                    smtPackArr[3] = rdr.GetInt32(3).ToString();
                }
            }

            return smtPackArr;
        }

        /// <summary>
        /// 采集SMT包装箱信息
        ///以单个SN过站操作，有拼板的以拼板过站
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public string[] CollectSMTPackInfo(string sn, string packSN, int stationId, int resId, int userId)
        {
            string[] smtPackArr = new string[2];
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                 new SqlParameter("@PackSN",SqlDbType.NVarChar,300),
                 new SqlParameter("@StationId",SqlDbType.Int),
                 new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),

            };
            param[0].Value = sn;
            param[1].Value = packSN;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = userId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCollectSMTPackInfo", param))
            {
                if (rdr.Read())
                {
                    smtPackArr[0] = rdr.GetInt32(0).ToString();
                    smtPackArr[1] = rdr.GetInt32(1).ToString();
                }
            }

            return smtPackArr;
        }

        /// <summary>
        /// 修改SMT包装箱状态,解绑包装箱信息
        /// </summary>
        /// <param name="packSN"></param>
        /// <param name="opeType"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        public void ChangeSMTPackStatus(string packSN, int opeType, int stationId, int resId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@PackSN",SqlDbType.NVarChar,300),
                 new SqlParameter("@OpeType",SqlDbType.Int),
                 new SqlParameter("@StationId",SqlDbType.Int),
                 new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),

            };
            param[0].Value = packSN;
            param[1].Value = opeType;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspChangeSMTPackStatus", param);
        }

        /// <summary>
        /// 采集SMT包装箱的不良信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="nccode"></param>
        /// <param name="stationId"></param>
        /// <param name="resId"></param>
        /// <param name="userId"></param>
        public void CollectSMTPackNCCode(string sn, string nccode, int stationId, int resId, int userId, bool isPassStation)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@SN",SqlDbType.NVarChar,512),
                 new SqlParameter("@NCCode",SqlDbType.VarChar),
                 new SqlParameter("@StationId",SqlDbType.Int),
                 new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@IsPassStation",SqlDbType.Bit),
            };
            param[0].Value = sn;
            param[1].Value = nccode;
            param[2].Value = stationId;
            param[3].Value = resId;
            param[4].Value = userId;
            param[5].Value = isPassStation;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectSMTPackNCCode", param);
        }

        /// <summary>
        /// 查询拼板是否在当前工序已经采集过不良信息
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        public bool GetSMTPackPanelCollectNCCode(string sn, int stationId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@SN",SqlDbType.NVarChar,512),
                 new SqlParameter("@StationId",SqlDbType.Int),
                 new SqlParameter("@IsPassStation",SqlDbType.Bit),
            };
            param[0].Value = sn;
            param[1].Value = stationId;
            param[2].Value = 1;
            param[2].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetSMTPackPanelCollectNCCode", param);

            return Convert.ToBoolean(param[2].Value);
        }

        /// <summary>
        /// 查询当前包装箱内的产品是否都已完成生产路由，存在未完成的都不可以清空包装箱
        /// </summary>
        /// <param name="packSN"></param>
        public void CheckIsSMTPackUnBind(string packSN)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@PackSN",SqlDbType.NVarChar,512),
            };
            param[0].Value = packSN;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckIsSMTPackUnBind", param);
        }

        /// <summary>
        /// 清空包装箱
        /// </summary>
        /// <param name="packSN"></param>
        public void SMTPackUnBind(string packSN, int stationId, int resourceId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@PackSN",SqlDbType.VarChar),
                 new SqlParameter("@StationId",SqlDbType.Int),
                 new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
            };
            param[0].Value = packSN;
            param[1].Value = stationId;
            param[2].Value = resourceId;
            param[3].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSMTPackUnBind", param);
        }
        #endregion

        #region 包装中箱

        /// <summary>
        /// 检查是否需要包装中箱
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public bool GetIsBoxPack(string sn)
        {
            bool isBoxPack = false;
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@SerialNumber",SqlDbType.NVarChar),
                 new SqlParameter("@IsBoxPack",SqlDbType.Bit),
            };
            param[0].Value = sn;
            param[1].Value = isBoxPack;
            param[1].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckIsBoxPack", param);

            isBoxPack = Convert.ToBoolean(param[1].Value);

            return isBoxPack;

        }


        #region 在线打印包装

        /// <summary>
        /// 在线手工关箱
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public string[] GetHandBoxNumberBySN(string sn, string packSN, int stationId, int resourceId, int userId, string addPackSN)
        {
            string[] packArr = new string[5];
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@PackNumber",SqlDbType.NVarChar,300),
                 new SqlParameter("@PackQty",SqlDbType.Decimal),
                 new SqlParameter("@MaxQty",SqlDbType.Decimal),
                 new SqlParameter("@PackType",SqlDbType.NVarChar,20),
                 new SqlParameter("@PackSN",SqlDbType.NVarChar,20)
            };
            param[0].Value = sn;
            param[1].Value = stationId;
            param[2].Value = resourceId;
            param[3].Value = userId;
            param[4].Value = packSN;
            param[4].Direction = ParameterDirection.InputOutput;
            param[5].Value = 0.000;
            param[5].Precision = 18;
            param[5].Scale = 6;
            param[5].Direction = ParameterDirection.InputOutput;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;
            param[7].Value = "";
            param[7].Direction = ParameterDirection.InputOutput;
            param[8].Value = addPackSN;
            param[8].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspHandGetBoxNumberBySN", param);

            packArr[0] = Convert.ToString(param[4].Value);
            packArr[1] = Convert.ToString(param[5].Value);
            packArr[2] = Convert.ToString(param[6].Value);
            packArr[3] = Convert.ToString(param[7].Value);
            packArr[4] = Convert.ToString(param[8].Value);
            return packArr;
        }

        /// <summary>
        /// 通过扫描的SN获取包装箱号
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public string[] GetBoxNumberBySN(string sn, string packSN, int stationId, int resourceId, int userId)
        {
            string[] packArr = new string[4];
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@PackNumber",SqlDbType.NVarChar,300),
                 new SqlParameter("@PackQty",SqlDbType.Decimal),
                 new SqlParameter("@MaxQty",SqlDbType.Decimal),
                 new SqlParameter("@PackType",SqlDbType.NVarChar,20),
            };
            param[0].Value = sn;
            param[1].Value = stationId;
            param[2].Value = resourceId;
            param[3].Value = userId;
            param[4].Value = packSN;
            param[4].Direction = ParameterDirection.InputOutput;
            param[5].Value = 0.000;
            param[5].Precision = 18;
            param[5].Scale = 6;
            param[5].Direction = ParameterDirection.InputOutput;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;
            param[7].Value = "";
            param[7].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetBoxNumberBySN", param);

            packArr[0] = Convert.ToString(param[4].Value);
            packArr[1] = Convert.ToString(param[5].Value);
            packArr[2] = Convert.ToString(param[6].Value);
            packArr[3] = Convert.ToString(param[7].Value);
            return packArr;
        }

        /// <summary>
        /// 包装产品SN到包装箱内
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public string[] CollectBoxSN(string sn, string packSN, int stationId, int resourceId, int userId)
        {
            string[] packArr = new string[3];
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@SerialNumber",SqlDbType.NVarChar,300),
                 new SqlParameter("@PackNumber",SqlDbType.NVarChar,300),
                 new SqlParameter("@StationId",SqlDbType.Int),
                 new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@PackQty",SqlDbType.Decimal),
                 new SqlParameter("@MaxQty",SqlDbType.Decimal),
            };
            param[0].Value = sn;
            param[1].Value = packSN;
            param[1].Direction = ParameterDirection.InputOutput;
            param[2].Value = stationId;
            param[3].Value = resourceId;
            param[4].Value = userId;
            param[5].Value = 0.000;
            param[5].Precision = 18;
            param[5].Scale = 6;
            param[5].Direction = ParameterDirection.InputOutput;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectBoxSN", param);

            packArr[0] = Convert.ToString(param[1].Value);
            packArr[1] = Convert.ToString(param[5].Value);
            packArr[2] = Convert.ToString(param[6].Value);
            return packArr;
        }

        #endregion

        #region 离线条码包装（先打印后包装）

        /// <summary>
        /// 包装产品SN到包装箱内
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public string[] CollectOfflinePackSN(string sn, string boxSN, string packSN, int stationId, int resourceId, int userId)
        {
            string[] packArr = new string[3];
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@SerialNumber",SqlDbType.NVarChar,300),
                 new SqlParameter("@BoxSN",SqlDbType.NVarChar,300),
                 new SqlParameter("@PackNumber",SqlDbType.NVarChar,300),
                 new SqlParameter("@StationId",SqlDbType.Int),
                 new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@PackQty",SqlDbType.Decimal),
                 new SqlParameter("@MaxQty",SqlDbType.Decimal),
                 new SqlParameter("@PackType",SqlDbType.NVarChar,20),
            };
            param[0].Value = sn;
            param[1].Value = boxSN;
            param[2].Value = packSN;
            param[3].Value = stationId;
            param[4].Value = resourceId;
            param[5].Value = userId;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;
            param[7].Value = 0.000;
            param[7].Precision = 18;
            param[7].Scale = 6;
            param[7].Direction = ParameterDirection.InputOutput;
            param[8].Value = "";
            param[8].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectOfflinePackSN", param);

            packArr[0] = Convert.ToString(param[6].Value);
            packArr[1] = Convert.ToString(param[7].Value);
            packArr[2] = Convert.ToString(param[8].Value);

            return packArr;
        }

        #endregion

        #endregion

        #region 包装箱

        /// <summary>
        /// 检验扫描SN顺序
        /// </summary>
        /// <param name="lastSN"></param>
        /// <param name="currentSN"></param>
        public void CheckBoxSeq(string lastSN, string currentSN, string packSN)
        {
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@LastSN",SqlDbType.NVarChar),
                 new SqlParameter("@CurrentSN",SqlDbType.NVarChar),
                new SqlParameter("@PackSN",SqlDbType.NVarChar),
            };
            param[0].Value = lastSN;
            param[1].Value = currentSN;
            param[2].Value = packSN;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckBoxSeq", param);
        }

        /// <summary>
        /// 通过扫描的SN获取包装箱号
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public string[] GetPackNumberBySN(string sn, int stationId, int resourceId, int userId, int boxSeq)
        {
            string[] packArr = new string[5];
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@SerialNumber",SqlDbType.NVarChar),
                 new SqlParameter("@StationId",SqlDbType.Int),
                 new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@PackNumber",SqlDbType.NVarChar,200),
                 new SqlParameter("@PackQty",SqlDbType.Decimal),
                 new SqlParameter("@MaxQty",SqlDbType.Decimal),
                 new SqlParameter("@LastSN",SqlDbType.NVarChar,200),
                 new SqlParameter("@BoxSeq",SqlDbType.Int),
                 new SqlParameter("@IsPackBySeq",SqlDbType.Bit),
            };
            param[0].Value = sn;
            param[1].Value = stationId;
            param[2].Value = resourceId;
            param[3].Value = userId;
            param[4].Value = "";
            param[4].Direction = ParameterDirection.InputOutput;
            param[5].Value = 0.000;
            param[5].Precision = 18;
            param[5].Scale = 6;
            param[5].Direction = ParameterDirection.InputOutput;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;
            param[7].Value = "";
            param[7].Direction = ParameterDirection.InputOutput;
            param[8].Value = boxSeq;
            param[9].Value = 0;
            param[9].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetPackNumberBySN", param);

            packArr[0] = Convert.ToString(param[4].Value);
            packArr[1] = Convert.ToString(param[5].Value);
            packArr[2] = Convert.ToString(param[6].Value);
            packArr[3] = Convert.ToString(param[7].Value);
            packArr[4] = Convert.ToString(param[9].Value);
            return packArr;
        }

        /// <summary>
        /// 包装产品SN到包装箱内
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public decimal[] CollectPackSN(string sn, string packSN, int stationId, int resourceId, int userId, int boxSeq)
        {
            decimal[] packArr = new decimal[2];
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                 new SqlParameter("@PackNumber",SqlDbType.NVarChar,300),
                 new SqlParameter("@StationId",SqlDbType.Int),
                 new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@PackQty",SqlDbType.Decimal),
                 new SqlParameter("@MaxQty",SqlDbType.Decimal),
                 new SqlParameter("@BoxSeq",SqlDbType.Int),
            };
            param[0].Value = sn;
            param[1].Value = packSN;
            param[2].Value = stationId;
            param[3].Value = resourceId;
            param[4].Value = userId;
            param[5].Value = 0.000;
            param[5].Precision = 18;
            param[5].Scale = 6;
            param[5].Direction = ParameterDirection.InputOutput;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;
            param[7].Value = boxSeq;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectPackSN", param);

            packArr[0] = Convert.ToDecimal(param[5].Value);
            packArr[1] = Convert.ToDecimal(param[6].Value);

            return packArr;
        }

        /// <summary>
        /// 关闭容器(包装箱,栈板) 
        /// </summary>
        /// <param name="ContainerSN">容器条码</param>
        /// <param name="UserId">用户ID</param>
        /// <param name="OpeId">工序ID</param>
        /// <param name="ResId">资源ID</param>
        /// <returns></returns>
        public void ClosePackPalletContainer(string containerSN, int userId, int opeId, int resId)
        {
            //关闭容器(包装箱,栈板)
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ContainerSN",SqlDbType.VarChar,200),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@OpeId",SqlDbType.Int),
                new SqlParameter("@ResId",SqlDbType.Int)
            };
            parms[0].Value = containerSN;
            parms[1].Value = userId;
            parms[2].Value = opeId;
            parms[3].Value = resId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPackPalletCloseContainer", parms);

        }

        /// <summary>
        /// 根据包装箱号(栈板号)带出包装(栈板)内容//Beck Ye 2016.09.18
        /// </summary>
        /// <param name="SN">条码</param>
        /// <param name="ContainerType">包装条码Level,1:Packing.2:Pallet</param>
        /// <returns></returns>
        public DataTable GetPackIngPalletDetailByContainerSN(string sn, int containerType)
        {
            //根据包装箱号(栈板号)带出包装(栈板)内容
            DataTable dt = null;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@ContainerType",SqlDbType.Int)
            };
            parms[0].Value = sn;
            parms[1].Value = containerType;

            dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetPackIngPalletDetailByContainerSN", parms);

            return dt;
        }

        /// <summary>
        /// 根据条码获取包装箱号
        /// </summary>
        /// <param name="SN"></param>
        /// <returns></returns>
        public string GetPackSNBySN(String SN)
        {
            //根据SN带出序列号信息
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                 new SqlParameter("@PackSN",SqlDbType.NVarChar,200)
            };
            parms[0].Value = SN;
            parms[1].Value = "";
            parms[1].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetPackSNBySN", parms);
            return parms[1].Value.ToString();
        }

        /// <summary>
        /// 移除包装箱与产品，栈板与包装箱关系
        /// </summary>
        /// <param name="unitPackDataIds"></param>        
        /// <param name="ContainerType">1:包装箱,2:栈板</param>
        /// <param name="sn"></param>
        /// <param name="userId"></param>
        /// <param name="opeId"></param>
        /// <param name="resId"></param>
        public void RemovePackData(string unitPackDataIds, int containerType, string sn, int userId, int opeId, int resId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@unitPackDataIds",SqlDbType.VarChar),
                new SqlParameter("@ContainerType",SqlDbType.Int),
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int)
            };
            param[0].Value = unitPackDataIds;
            param[1].Value = containerType;
            param[2].Value = sn;
            param[3].Value = userId;
            param[4].Value = opeId;
            param[5].Value = resId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRemovePackData", param);
        }

        /// <summary>
        /// 获取箱序号信息
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public List<string> GetBoxSeq(int prodOrderId)
        {
            List<string> boxSeqArr = new List<string>();
            //根据SN带出序列号信息
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
            };
            parms[0].Value = prodOrderId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetBoxSeq", parms))
            {
                while (rdr.Read())
                {
                    boxSeqArr.Add(rdr.GetInt32(0).ToString());
                }
                rdr.Close();
            }
            return boxSeqArr;
        }

        #endregion

        #region 栈板

        /// <summary>
        /// 通过扫描的SN获取栈板号码
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public string[] GetPalletNumberBySN(string packSN, int stationId, int resourceId, int userId)
        {
            string[] palletArr = new string[3];
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@PackSN",SqlDbType.NVarChar,512),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@PalletSN",SqlDbType.NVarChar,300),
                 new SqlParameter("@PackQty",SqlDbType.Decimal),
                 new SqlParameter("@MaxQty",SqlDbType.Decimal),
            };
            param[0].Value = packSN;
            param[1].Value = stationId;
            param[2].Value = resourceId;
            param[3].Value = userId;
            param[4].Value = "";
            param[4].Direction = ParameterDirection.InputOutput;
            param[5].Value = 0.000;
            param[5].Precision = 18;
            param[5].Scale = 6;
            param[5].Direction = ParameterDirection.InputOutput;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetPalletNumberBySN", param);

            palletArr[0] = Convert.ToString(param[4].Value);
            palletArr[1] = Convert.ToString(param[5].Value);
            palletArr[2] = Convert.ToString(param[6].Value);

            return palletArr;
        }

        /// <summary>
        /// 保存包装箱与栈板之间的关系
        /// </summary>
        /// <param name="packSN"></param>
        /// <param name="palletSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public decimal[] CollectPalletSN(string packSN, string palletSN, int stationId, int resourceId, int userId)
        {
            decimal[] palletArr = new decimal[2];
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@PackSN",SqlDbType.NVarChar,512),
                 new SqlParameter("@PalletSN",SqlDbType.NVarChar,300),
                 new SqlParameter("@StationId",SqlDbType.Int),
                 new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@PackQty",SqlDbType.Decimal),
                 new SqlParameter("@MaxQty",SqlDbType.Decimal),
            };
            param[0].Value = packSN;
            param[1].Value = palletSN;
            param[2].Value = stationId;
            param[3].Value = resourceId;
            param[4].Value = userId;
            param[5].Value = 0.000;
            param[5].Precision = 18;
            param[5].Scale = 6;
            param[5].Direction = ParameterDirection.InputOutput;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectPalletSN", param);

            palletArr[0] = Convert.ToDecimal(param[5].Value);
            palletArr[1] = Convert.ToDecimal(param[6].Value);

            return palletArr;
        }

        /// <summary>
        /// 获取包装内的第一个产品SN 2017-10-16
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public string GetPackingSN(string packSn)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@PackSN",SqlDbType.NVarChar,512),
            };
            parms[0].Value = packSn;
            string sn = "";
            string sql = "select top 1 SerialNumber FROM dbo.fn_GetContainerSN(@PackSN) WHERE ContainerLevel = 0";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                if (rdr.Read())
                {
                    sn = rdr.GetString(0);
                }
            }

            return sn;
        }

        #endregion

        #region 包装附件采集

        /// <summary>
        /// 获取包装附件采集配置信息
        /// </summary>
        /// <param name="mainSN"></param>
        /// <param name="stationId"></param>
        /// <returns></returns>
        public List<PackingAccessoriesConfigInfo> GetPackingAccessoriesConfig(string mainSN, int stationId)
        {
            List<PackingAccessoriesConfigInfo> list = new List<PackingAccessoriesConfigInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512) ,
                new SqlParameter("@StationId",SqlDbType.Int),
            };
            param[0].Value = mainSN;
            param[1].Value = stationId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPackingAccessoriesConfig", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<PackingAccessoriesConfigInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 添加包装附件条码信息
        /// </summary>
        /// <param name="packingAccessoriesConfigId"></param>
        /// <param name="sn"></param>
        /// <param name="accessoriesSN"></param>
        /// <param name="resId"></param>
        /// <param name="user"></param>
        /// <param name="userId"></param>
        /// <param name="stationId"></param>
        public void PackingAccessoriesDetailEdit(string packingAccessoriesConfigId, string sn, string accessoriesSN, int resId, string user, int userId, int stationId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@PackingAccessoriesConfigId",SqlDbType.VarChar),
                  new SqlParameter("@SN",SqlDbType.VarChar,50),
                  new SqlParameter("@AccessoriesSN",SqlDbType.VarChar),
                  new SqlParameter("@CreateBy",SqlDbType.VarChar,20),
                  new SqlParameter("@ResId",SqlDbType.Int),
                  new SqlParameter("@UserId",SqlDbType.Int),
                  new SqlParameter("@StationId",SqlDbType.Int),

            };
            parms[0].Value = packingAccessoriesConfigId;
            parms[1].Value = sn;
            parms[2].Value = accessoriesSN;
            parms[3].Value = user;
            parms[4].Value = resId;
            parms[5].Value = userId;
            parms[6].Value = stationId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPackingAccessoriesDetailEdit", parms);
        }

        /// <summary>
        /// 检查是否已采集包装附件
        /// </summary>
        /// <param name="offlineSN"></param>
        /// <returns></returns>
        public bool CheckIsCollectAccessoriesSN(string accessoriesSN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@AccessoriesSN",SqlDbType.NVarChar,512),
            };
            parms[0].Value = accessoriesSN;
            int packingAccessoriesDetailId = -1;
            string sql = "select PackingAccessoriesDetailId from Prod_PackingAccessoriesDetail where AccessoriesSN=@AccessoriesSN";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                if (rdr.Read())
                {
                    packingAccessoriesDetailId = rdr.GetInt32(0);
                }
            }

            return packingAccessoriesDetailId > 0 ? true : false;
        }

        /// <summary>
        /// 包装附件UI离线条码SN检查验证
        /// </summary>
        /// <param name="scanSN">主条码</param>
        /// <param name="assySN">离线条码</param>
        /// <param name="itemId"></param>
        /// <param name="checkType">检查类型（1为掩码检查；2为SN检查）</param>
        /// <param name="maskId">掩码id（包括主条码"0"，客户条码"10"，客户条码2"11"</param>
        public void offlineCheck(string scanSN, string assySN, int itemId, int checkType, int maskId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@scanSN",SqlDbType.VarChar),
                  new SqlParameter("@assySN",SqlDbType.VarChar,50),
                  new SqlParameter("@itemId",SqlDbType.Int),
                  new SqlParameter("@checkType",SqlDbType.Int),
                  new SqlParameter("@maskId",SqlDbType.Int)
            };
            parms[0].Value = scanSN;
            parms[1].Value = assySN;
            parms[2].Value = itemId;
            parms[3].Value = checkType;
            parms[4].Value = maskId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetSnOfflineCheck", parms);

        }


        /// <summary>
        /// 包装附件UI离线条码部件检查验证
        /// </summary>
        /// <param name="scanSN">主条码</param>
        /// <param name="assySN">离线条码</param>
        /// <param name="itemId"></param>
        /// <param name="checkType">检查类型（1为掩码检查；2为SN检查）</param>
        /// <param name="maskId">掩码id（包括主条码"0"，客户条码"10"，客户条码2"11"</param>
        public void PartsOfflineSNCheck(string scanSN, string assySN, int maskId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@scanSN",SqlDbType.VarChar),
                  new SqlParameter("@assySN",SqlDbType.VarChar,50),
                  new SqlParameter("@maskId",SqlDbType.Int)
            };
            parms[0].Value = scanSN;
            parms[1].Value = assySN;
            parms[2].Value = maskId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetPartsOfflineSnCheck", parms);

        }
        #endregion


        #region Repacking

        /// <summary>
        /// 根据栈板号获取‘重新包装-栈板’界面数据（产品信息、外箱列表）
        /// </summary>
        /// <param name="palletNo">栈板号</param>
        /// <param name="userId">用户ID</param>
        /// <returns></returns>
        public DataSet GetRepackingPalletInfo(string palletNo, int userId)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@PalletNo",SqlDbType.VarChar,50),
                new SqlParameter("@UserId",SqlDbType.Int)
            };

            param[0].Value = palletNo;
            param[1].Value = userId;

            return ComMethod.GetListDataSet("uspGetRepackingPalletInfo", param);
        }

        /// <summary>
        /// Repacking-栈板
        /// </summary>
        /// <param name="model">栈板与包装箱关联、产品序列号与包装箱关联 对象</param>
        /// <param name="opereateType">操作类型（0：只做校验 1：保存）</param>
        /// <returns></returns>
        public DataTable RepackingPallet(PackingData model, int opereateType)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@PalletNo",SqlDbType.VarChar,50),
                new SqlParameter("@BoxNo",SqlDbType.VarChar),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@OpereateType",SqlDbType.Int)
            };

            param[0].Value = model.ContainerSN;//栈板号
            param[1].Value = model.SerialNumber;//包装箱号
            param[2].Value = model.UserId;
            param[3].Value = opereateType;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspRepackingPallet", param);
        }


        /// <summary>
        /// 根据外箱号码获取‘重新包装-外箱’UI中的产品信息
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public DataTable GetItemInfoByBoxNo(PackingData model)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@BoxNo",SqlDbType.VarChar,50),
                new SqlParameter("@UserId",SqlDbType.Int)
            };

            param[0].Value = model.ContainerSN;
            param[1].Value = model.UserId;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspGetItemInfoByOutBoxNo", param);
        }

        /// <summary>
        /// 扫描外箱号码及产品号码，将产品重新包装到扫描的外箱中
        /// </summary>
        /// <param name="model">栈板与包装箱关联、产品序列号与包装箱关联 对象</param>
        /// <param name="opereateType">操作类型（0：只做校验 1：保存）</param>
        /// <returns></returns>
        public DataTable RepackingOutBox(PackingData model, int opereateType)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@BoxNo",SqlDbType.VarChar,50),
                new SqlParameter("@ItemNo",SqlDbType.VarChar),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@OpereateType",SqlDbType.Int)
            };

            param[0].Value = model.ContainerSN;//包装箱号
            param[1].Value = model.SerialNumber;//产品号码，多个用逗号隔开
            param[2].Value = model.UserId;
            param[3].Value = opereateType;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspRepackingOutBoxNo", param);
        }

        #endregion

        #region 离线条码手工关箱包装

        /// <summary>
        /// 包装产品SN到包装箱内
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="packSN"></param>
        /// <param name="stationId"></param>
        /// <param name="resourceId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public string[] CollectHandOfflinePackSN(string sn, string boxSN, string packSN, int stationId, int resourceId, int userId)
        {
            string[] packArr = new string[3];
            SqlParameter[] param = new SqlParameter[]
            {
                 new SqlParameter("@SerialNumber",SqlDbType.NVarChar,300),
                 new SqlParameter("@BoxSN",SqlDbType.NVarChar,300),
                 new SqlParameter("@PackNumber",SqlDbType.NVarChar,300),
                 new SqlParameter("@StationId",SqlDbType.Int),
                 new SqlParameter("@ResourceId",SqlDbType.Int),
                 new SqlParameter("@UserId",SqlDbType.Int),
                 new SqlParameter("@PackQty",SqlDbType.Decimal),
                 new SqlParameter("@MaxQty",SqlDbType.Decimal),
                 new SqlParameter("@PackType",SqlDbType.NVarChar,20),
            };
            param[0].Value = sn;
            param[1].Value = boxSN;
            param[2].Value = packSN;
            param[3].Value = stationId;
            param[4].Value = resourceId;
            param[5].Value = userId;
            param[6].Value = 0.000;
            param[6].Precision = 18;
            param[6].Scale = 6;
            param[6].Direction = ParameterDirection.InputOutput;
            param[7].Value = 0.000;
            param[7].Precision = 18;
            param[7].Scale = 6;
            param[7].Direction = ParameterDirection.InputOutput;
            param[8].Value = "";
            param[8].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspHandCollectOfflinePackSN", param);

            packArr[0] = Convert.ToString(param[6].Value);
            packArr[1] = Convert.ToString(param[7].Value);
            packArr[2] = Convert.ToString(param[8].Value);

            return packArr;
        }

        #endregion

        #region 根据包装箱号获取产品信息
        /// <summary>
        /// 根据包装箱号获取产品信息
        /// </summary>
        /// <param name="PackSN"></param>
        /// <returns></returns>
        public DataTable GetPackSNItemInfo(string PackSN)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@PackSN",SqlDbType.VarChar,50)
            };
            param[0].Value = PackSN;
            return ComMethod.GetDataTableList("uspGetPackSNItemInfo", param);
        }
        #endregion

        #region 生成栈板条码，建立包装箱与栈板关系
        /// <summary>
        /// 生成栈板条码，建立包装箱与栈板关系
        /// </summary>
        /// <param name="ArrPackSN"></param>
        /// <returns></returns>
        public string SavePackPalletRelation(String ArrPackSN, int ItemId, int ProdOrderId, int UserId, string UserName, string palletSN)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ArrPackSN",SqlDbType.NVarChar,-1),
                new SqlParameter("@ItemId",SqlDbType.Int),
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@PalletNo",SqlDbType.VarChar,50)
            };

            parms[0].Value = ArrPackSN;
            parms[1].Value = ItemId;
            parms[2].Value = ProdOrderId;
            parms[3].Value = UserId;
            parms[4].Value = UserName;
            parms[5].Value = palletSN;
            parms[5].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSavePackPalletRelation", parms);
            return Convert.ToString(parms[5].Value);
        }
        #endregion

        #region 检验包装箱是否有内容
        public int CheckPackSNEmpty(string packSN)
        {
            var result = 0;
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@packSN",SqlDbType.NVarChar) {Value=packSN }
            };
            string sql = @"SELECT COUNT(1) FROM dbo.Prod_PackingData WHERE ContainerSN=@packSN";

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                if (rdr.Read())
                {
                    result = rdr.GetInt32(0);
                }
            }
            return result;
        }
        #endregion
    }
}
