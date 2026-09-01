using SKT.Common.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Wave.Model;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Data;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Wave.BLL
{
    public class DeviceInterfaceType
    {
        private Int32 recordCount = 0;
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        public List<DeviceInterfaceTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string queryColumns = "DeviceInterfaceTypeId,DeviceType,Brand,CreateBy,CreateTime,ModifyBy,ModifyDateTime";
            return ComMethod.GetComList<DeviceInterfaceTypeInfo>(ref this.recordCount, startRow, maxRows, "vwProd_DeviceInterfaceType", "DeviceInterfaceTypeId", queryColumns, sortExpression, searchSettings);////Prod_DeviceInterfaceType
        }

        /// <summary>
        /// 获取所有的设备类型
        /// </summary>
        /// <returns></returns>
        public List<DeviceInterfaceTypeInfo> GetDeviceType()
        {
            string cmdTxt = string.Format("SELECT DeviceType FROM dbo.Prod_DeviceInterfaceType GROUP BY DeviceType");
            return ComMethod.GetListBySql<DeviceInterfaceTypeInfo>(cmdTxt, null);
        }

        /// <summary>
        /// 根据设备类型获取品牌型号
        /// </summary>
        /// <returns></returns>
        public List<DeviceInterfaceTypeInfo> GetBrandType(DeviceInterfaceTypeInfo entity)
        {

            string cmdTxt = string.Format("SELECT DeviceInterfaceTypeId,DeviceType,Brand,CreateBy,CreateTime,ModifyBy,ModifyDateTime FROM dbo.Prod_DeviceInterfaceType WHERE DeviceType = @DeviceType");
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@DeviceType",SqlDbType.NVarChar,50)
            };
            parms[0].Value = entity.DeviceType;
            return ComMethod.GetListBySql<DeviceInterfaceTypeInfo>(cmdTxt, parms);
        }

        /// <summary>
        /// 获取设备接口类型型号实体
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public DeviceInterfaceTypeInfo GetDeviceInterfaceTypeInfo(DeviceInterfaceTypeInfo entity)
        {
            string sql = "SELECT DeviceInterfaceTypeId,DeviceType,Brand,CreateBy,CreateTime,ModifyBy,ModifyDateTime FROM Prod_DeviceInterfaceType WHERE DeviceInterfaceTypeId = @DeviceInterfaceTypeId";
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@DeviceInterfaceTypeId",SqlDbType.Int)
            };
            parms[0].Value = entity.DeviceInterfaceTypeId;
            return ComMethod.GetBySql<DeviceInterfaceTypeInfo>(sql, parms);
        }

        public Int32 Edit(DeviceInterfaceTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@DeviceInterfaceTypeId",SqlDbType.Int),
                new SqlParameter("@DeviceType",SqlDbType.NVarChar,50),
                new SqlParameter("@Brand",SqlDbType.NVarChar,50),
                new SqlParameter("@ModifyBy",SqlDbType.NVarChar,50)
            };
            parms[0].Value = entity.DeviceInterfaceTypeId;
            parms[1].Value = entity.DeviceType;
            parms[2].Value = entity.Brand;
            parms[3].Value = entity.ModifyBy;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeviceInterfaceTypeEdit", parms);
            return (Int32)parms[0].Value;
        }

        /// <summary>
        ///  设备接口类型型号维护 - 删除
        /// </summary>
        /// <param name="ids">要删除的记录ID，多个用逗号隔开</param>
        /// <param name="userName">操作人</param>
        public void Delete(string ids, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = ids;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeviceInterfaceTypeDelete", parms);
        }
    }
}
