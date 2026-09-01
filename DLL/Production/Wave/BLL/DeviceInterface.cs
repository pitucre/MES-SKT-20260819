using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

using SKT.LeanMES.Wave.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Wave.BLL
{
    public class DeviceInterface
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 接口设备 列表数据
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="furnaceTemperatureCollctionCount">furnaceTemperatureCollction 总数。</param>
        /// <returns></returns>
        public List<DeviceInterfaceInfo> GetAll(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            string queryColumns = "DeviceInterfaceId, DeviceInterfaceTypeId, TargetFileDir, FileType, TitleSplitChar, TxtSplitChar, DefaultUserName, NCCodeId, LineId, IsCouplet,IsCoupletName, FileNewPath, CreateDateTime, CreateBy, ModifyDateTime, ModifyBy, DeviceType, Brand, NCCode, LineName";
            return ComMethod.GetComList<DeviceInterfaceInfo>(ref recordCount, startRow, maxRows, "vwDeviceInterfaceList", "DeviceInterfaceId", queryColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 得到一个对象实体
        /// </summary>
        /// <param name="deviceInterfaceId"></param>
        /// <returns></returns>
        public DeviceInterfaceInfo Get(int deviceInterfaceId)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT");
            sb.Append(" DeviceInterfaceId, DeviceInterfaceTypeId, TargetFileDir, FileType, TitleSplitChar, TxtSplitChar, DefaultUserName, NCCodeId, LineId, IsCouplet,IsCoupletName, FileNewPath, CreateDateTime, CreateBy, ModifyDateTime, ModifyBy, DeviceType, Brand, NCCode, LineName");
            sb.Append(" FROM vwDeviceInterfaceList");
            sb.Append(" WHERE DeviceInterfaceId = @DeviceInterfaceId");
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@DeviceInterfaceId", SqlDbType.VarChar,40)
            };
            parms[0].Value = deviceInterfaceId;
            return ComMethod.GetBySql<DeviceInterfaceInfo>(sb.ToString(), parms);
        }

        /// <summary>
        /// 新增、编辑数据
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
		public int Edit(DeviceInterfaceInfo model)
        {
            SqlParameter[] parameters = {
                        new SqlParameter("@DeviceInterfaceId", SqlDbType.VarChar,40) ,
                        new SqlParameter("@DeviceInterfaceTypeId", SqlDbType.Int) ,
                        new SqlParameter("@TargetFileDir", SqlDbType.NVarChar,100) ,
                        new SqlParameter("@FileType", SqlDbType.VarChar,10) ,
                        new SqlParameter("@TitleSplitChar", SqlDbType.VarChar,50) ,
                        new SqlParameter("@TxtSplitChar", SqlDbType.VarChar,50) ,
                        new SqlParameter("@DefaultUserName", SqlDbType.VarChar,20) ,
                        new SqlParameter("@NCCodeId", SqlDbType.Int) ,
                        new SqlParameter("@LineId", SqlDbType.Int) ,
                        new SqlParameter("@IsCouplet", SqlDbType.Int) ,
                        new SqlParameter("@FileNewPath", SqlDbType.VarChar,2000) ,
                        new SqlParameter("@OperateUserName", SqlDbType.NVarChar,20),
                        new SqlParameter("@TestResultPosition", SqlDbType.Xml)
            };
            parameters[0].Value = model.DeviceInterfaceId;
            parameters[1].Value = model.DeviceInterfaceTypeId;
            parameters[2].Value = model.TargetFileDir;
            parameters[3].Value = model.FileType;
            parameters[4].Value = model.TitleSplitChar;
            parameters[5].Value = model.TxtSplitChar;
            parameters[6].Value = model.DefaultUserName;
            parameters[7].Value = model.NCCodeId;
            parameters[8].Value = model.LineId;
            parameters[9].Value = model.IsCouplet;
            parameters[10].Value = model.FileNewPath;
            parameters[11].Value = model.ModifyBy;
            parameters[12].Value = model.TestResultPosition;
            return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeviceInterfaceEdit", parameters);
        }

        /// <summary>
        /// 删除设备类型
        /// </summary>
        /// <param name="ids">要删除的id，多个用逗号隔开</param>
        /// <param name="userName">操作人</param>
        public void Delete(string ids, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Ids", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = ids;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeviceInterfaceDelete", parms);
        }

    }
}
