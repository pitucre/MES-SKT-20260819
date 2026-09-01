using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ProductionCollection.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.ProductionCollection.Client
{
    public class ProdCollectionPickList
    {
        #region 手插上料

        /// <summary>
        /// 获取手插上料扣料工序信息
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public Dictionary<int, string> GetPickListStation(int prodOrderId)
        {
            Dictionary<int, string> dic = new Dictionary<int, string>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@ProdOrderId",SqlDbType.Int)
            };
            param[0].Value = prodOrderId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPickListStation", param))
            {
                while (rdr.Read())
                {
                    dic.Add(rdr.GetInt32(0), rdr.GetString(1));
                }
                rdr.Close();
            }
            return dic;
        }


        /// <summary>
        /// 获取手插上料状态信息
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        public PickListInfo GetPickListResource(int prodOrderId, int stationId, int resouceId)
        {
            List<PickListInfo> list = new List<PickListInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@ProdOrderId",SqlDbType.Int) ,
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int)
            };
            param[0].Value = prodOrderId;
            param[1].Value = stationId;
            param[2].Value = resouceId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPickListResource", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<PickListInfo>(rdr);
                rdr.Close();
            }
            return list[0];
        }

        /// <summary>
        /// 获取手插上料详情
        /// </summary>
        /// <param name="pickListId"></param>
        /// <returns></returns>
        public List<PickListDetailInfo> GetPickListDetail(int pickListId, int prodOrderId,int stationId, int resouceId,int flage)
        {
            List<PickListDetailInfo> list = new List<PickListDetailInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@PickListId",SqlDbType.Int) ,
                new SqlParameter("@ProdOrderId",SqlDbType.Int) ,
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@Flag",SqlDbType.Int),
            };
            param[0].Value = pickListId;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;
            param[3].Value = resouceId;
            param[4].Value = flage;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPickListDetail", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<PickListDetailInfo>(rdr);
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 没有GRN信息
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="flage"></param>
        /// <returns></returns>
        public List<PickListDetailInfo> GetPickListDetailNew(int pickListId, int prodOrderId, int stationId, int resouceId, int flage)
        {
            List<PickListDetailInfo> list = new List<PickListDetailInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@PickListId",SqlDbType.Int) ,
                new SqlParameter("@ProdOrderId",SqlDbType.Int) ,
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@ResourceId",SqlDbType.Int),
                new SqlParameter("@Flag",SqlDbType.Int),
            };
            param[0].Value = pickListId;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;
            param[3].Value = resouceId;
            param[4].Value = flage;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPickListDetailNew", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<PickListDetailInfo>(rdr);
                rdr.Close();
            }
            return list;
        }


        

        /// <summary>
        /// 采集手插上料信息
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="compentLocations"></param>
        /// <param name="grn"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        public void CollectPickListGRN(int pickListId, string grn, int prodOrderId, int stationId, int resouceId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@PickListId",SqlDbType.Int) ,
                new SqlParameter("@GRN",SqlDbType.NVarChar),
                new SqlParameter("@ProdOrderId",SqlDbType.Int) ,
                new SqlParameter("@StationId",SqlDbType.Int) ,
                new SqlParameter("@ResouceId",SqlDbType.Int) ,
                new SqlParameter("@UserId",SqlDbType.Int) ,
            };
            param[0].Value = pickListId;
            param[1].Value = grn;
            param[2].Value = prodOrderId;
            param[3].Value = stationId;
            param[4].Value = resouceId;
            param[5].Value = userId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCollectPickListGRN", param);

        }

        /// <summary>
        /// 手插上料开拉停拉操作
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="resouceId"></param>
        /// <param name="flage"></param>
        /// <param name="userId"></param>
        public void PickListPullAndStop(int pickListId, int prodOrderId,int stationId, int resouceId, int flage, int userId, int lineId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@PickListId",SqlDbType.Int) ,
                new SqlParameter("@ProdOrderId",SqlDbType.Int) ,
                new SqlParameter("@StationId",SqlDbType.Int) ,
                new SqlParameter("@ResouceId",SqlDbType.Int) ,
                new SqlParameter("@UserId",SqlDbType.Int) ,
                new SqlParameter("@Flage",SqlDbType.Int) ,
                new SqlParameter("@LineId",SqlDbType.Int) ,
            };
            param[0].Value = pickListId;
            param[1].Value = prodOrderId;
            param[2].Value = stationId;
            param[3].Value = resouceId;
            param[4].Value = userId;
            param[5].Value = flage;
            param[6].Value = lineId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPickListPullAndStop", param);
        }

        /// <summary>
        /// 该存储过程用于PickList的卸料
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        public void PickListUnLoadMaterial(int pickListId, int prodOrderId, int resouceId, int userId, int lineId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@PickListId",SqlDbType.Int) ,
                new SqlParameter("@ProdOrderId",SqlDbType.Int) ,
                new SqlParameter("@ResourceId",SqlDbType.Int) ,
                new SqlParameter("@UserId",SqlDbType.Int) ,
                new SqlParameter("@LineId",SqlDbType.Int) ,
            };
            param[0].Value = pickListId;
            param[1].Value = prodOrderId;
            param[2].Value = resouceId;
            param[3].Value = userId;
            param[4].Value = lineId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPickListUnLoadMaterial", param);
        }

        /// <summary>
        /// 手插续料
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="OldGRN"></param>
        /// <param name="newGRN"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        public void PickListAddMaterial(int pickListId, int prodOrderId, string oldGRN, string newGRN, int resouceId, int userId, int lineId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@PickListId",SqlDbType.Int) ,
                new SqlParameter("@ProdOrderId",SqlDbType.Int) ,
                 new SqlParameter("@OldGRN",SqlDbType.NVarChar) ,
                new SqlParameter("@NewGRN",SqlDbType.NVarChar) ,
                new SqlParameter("@ResourceId",SqlDbType.Int) ,
                new SqlParameter("@UserId",SqlDbType.Int) ,
                 new SqlParameter("@LineId",SqlDbType.Int) ,
            };
            param[0].Value = pickListId;
            param[1].Value = prodOrderId;
            param[2].Value = oldGRN;
            param[3].Value = newGRN;
            param[4].Value = resouceId;
            param[5].Value = userId;
            param[6].Value = lineId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPickListAddMaterial", param);
        }

        /// <summary>
        /// 修改手插上料不良数
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="grn"></param>
        /// <param name="ncQty"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        public void PickListNCMaterial(int pickListId, int prodOrderId, string grn, int ncQty, int stationId, int resouceId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@PickListId",SqlDbType.Int) ,
                new SqlParameter("@ProdOrderId",SqlDbType.Int) ,
                 new SqlParameter("@GRN",SqlDbType.NVarChar) ,
                new SqlParameter("@NCQty",SqlDbType.Int) ,
                new SqlParameter("@StationId",SqlDbType.Int) ,
                new SqlParameter("@ResourceId",SqlDbType.Int) ,
                new SqlParameter("@UserId",SqlDbType.Int) ,
            };
            param[0].Value = pickListId;
            param[1].Value = prodOrderId;
            param[2].Value = grn;
            param[3].Value = ncQty;
            param[4].Value = stationId;
            param[5].Value = resouceId;
            param[6].Value = userId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPickListNCMaterial", param);
        }

        /// <summary>
        /// 移除未开拉的GRN信息
        /// </summary>
        /// <param name="pickListId"></param>
        /// <param name="prodOrderId"></param>
        /// <param name="grn"></param>
        /// <param name="resouceId"></param>
        /// <param name="userId"></param>
        public void PickListRemoveMaterial(int pickListId, int prodOrderId, string grn,int stationId, int resouceId, int userId)
        {
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@PickListId",SqlDbType.Int) ,
                new SqlParameter("@ProdOrderId",SqlDbType.Int) ,                
                new SqlParameter("@GRN",SqlDbType.NVarChar) ,
                new SqlParameter("@StationId",SqlDbType.Int) ,
                new SqlParameter("@ResourceId",SqlDbType.Int) ,
                new SqlParameter("@UserId",SqlDbType.Int) ,
            };
            param[0].Value = pickListId;
            param[1].Value = prodOrderId;
            param[2].Value = grn;
            param[3].Value = stationId;
            param[4].Value = resouceId;
            param[5].Value = userId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPickListRemoveMaterial", param);
        }

        /// <summary>
        /// 获取手插上料详情
        /// </summary>
        /// <param name="pickListId"></param>
        /// <returns></returns>
        public List<PickListDetailInfo> GetPickListDetailPDA(int pickListId, int prodOrderId, int lineId, int flage)
        {
            List<PickListDetailInfo> list = new List<PickListDetailInfo>();

            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@PickListId",SqlDbType.Int) ,
                new SqlParameter("@ProdOrderId",SqlDbType.Int) ,
                new SqlParameter("@LineId",SqlDbType.Int) ,
                new SqlParameter("@Flage",SqlDbType.Int)
            };
            param[0].Value = pickListId;
            param[1].Value = prodOrderId;
            param[2].Value = lineId;
            param[3].Value = flage;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPickListDetailPDA", param))
            {
                list = Utility.Helper.SqlDataReaderConverToList<PickListDetailInfo>(rdr);
                rdr.Close();
            }
            return list;
        }
        #endregion
    }
}
