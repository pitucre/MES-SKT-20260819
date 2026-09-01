using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Warehouse.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace SKT.LeanMES.Warehouse.BLL
{
    public class WarehouseAGVMark
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 获取工位类型列表
        /// </summary>
        /// <param name="fieldValue"></param>
        /// <returns></returns>
        public WarehouseAGVMarkInfo GetInfo(string fieldValue)
        {
            return ComMethod.GetInfo<WarehouseAGVMarkInfo>(fieldValue, "WarehouseAGVMark_GetInfo");
        }

        /// <summary>
        /// 根据 LineId 获取实体信息。
        /// </summary>
        /// <param name="lineId">LineId。</param>
        /// <returns>Line 实体对象。</returns>
        public WarehouseAGVMarkInfo GetInfo(Int32 lineId)
        {

            SqlParameter[] parms = new SqlParameter[]{
                    new SqlParameter("@FieldValue", SqlDbType.NVarChar) { Value=lineId},
                    new SqlParameter("@IsByID", SqlDbType.Bit) { Value=true}
           };

            return ComMethod.GetList<WarehouseAGVMarkInfo>("WarehouseAGVMark_GetInfo", parms).FirstOrDefault();
        }
        public List<WarehouseAGVMarkInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseAGVMarkInfo> list = new List<WarehouseAGVMarkInfo>();
            //表名或者视图
            string strTb = "vw_Basal_WarehouseAGVMark";//"Prod_Apply";
                                                   //主键
            string strKey = "ID";//"ApplyId";
                                 //查询栏位字串         
            string strColumns = @"[ID],[AGVAreaName],[AGVLandMarkCode],[AGVLandMarkCodeSort],[Remark],[Statues],[StatueName],[CreateBy],[CreateDateTime],[ModifyBy],[ModifyDateTime],LaneSort";
            list = ComMethod.GetComList<WarehouseAGVMarkInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public List<WarehouseAGVAreaInfo> GetAGVAreaAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseAGVAreaInfo> list = new List<WarehouseAGVAreaInfo>();
            //表名或者视图
            string strTb = "vWAgvAreaCategory";
                                                       //主键
            string strKey = "ID";//"ApplyId";
                                 //查询栏位字串         
            string strColumns = @"[ID],[CategoryName],[Remark],[CreateBy],[CreateDateTime],[ModifyBy],[ModifyDateTime]";
            list = ComMethod.GetComList<WarehouseAGVAreaInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        /// <summary>
        /// 编辑（添加或更新） StationType 信息。
        /// </summary>
        /// <param name="entity">WarehouseAGVMarkInfo实体</param>

        public void Edit(WarehouseAGVMarkInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
               new SqlParameter("@Id", SqlDbType.Int){ Value = entity.ID, Direction = ParameterDirection.InputOutput },
               new SqlParameter("@AGVLandMarkCode", SqlDbType.NVarChar){ Value = entity.AGVLandMarkCode },
               new SqlParameter("@AGVAreaName", SqlDbType.NVarChar){ Value = entity.AGVAreaName },
               new SqlParameter("@LaneSort", SqlDbType.Int){ Value = entity.LaneSort },
               new SqlParameter("@AGVLandMarkCodeSort", SqlDbType.NVarChar){ Value = entity.AGVLandMarkCodeSort },
               new SqlParameter("@AGVDeliveryLocation", SqlDbType.Bit){ Value = entity.AGVDeliveryLocation },
               new SqlParameter("@AGVMaterialLocation", SqlDbType.Bit){ Value = entity.AGVMaterialLocation },
               new SqlParameter("@Statues", SqlDbType.Int){ Value = entity.Statues },
               new SqlParameter("@Remark", SqlDbType.NVarChar){ Value = entity.Remark },
               new SqlParameter("@CreateBy", SqlDbType.VarChar){ Value = entity.CreateBy }
            };

            ComMethod.Edit("uspEditWarehouseAGVMark", parms);
        }

        /// <summary>
        /// 解除占用
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        public void UpdateSatues(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar) { Value = idString},
                new SqlParameter("@UserName", SqlDbType.VarChar) { Value = userName}
            };
            ComMethod.Delete(idString, userName, "uspWarehouseAGVMarkUpdate");
        }

        /// <summary>
        /// 根据 StationTypeId 字符串删除 StationType 信息。
        /// </summary>
        /// <param name="idString">StationTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar) { Value = idString},
                new SqlParameter("@UserName", SqlDbType.VarChar) { Value = userName}
            };
            ComMethod.Delete(idString, userName, "uspWarehouseAGVMarkDelete");
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
