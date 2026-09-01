using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Wave.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Wave.BLL
{
    public class DeviceInterfaceTestPosition
    {
        /// <summary>
        /// 获取测试结果位置数据
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="furnaceTemperatureCollctionCount">furnaceTemperatureCollction 总数。</param>
        /// <returns></returns>
        public IList<DeviceInterfaceTestPositionInfo> GetAll(DeviceInterfaceTestPositionInfo entity)
        {
            string sql = "SELECT DeviceTestPosId,DeviceInterfaceId,AnalysisType,PonitType,TestResult FROM Prod_DeviceInterfaceTestPosition WHERE DeviceInterfaceId = @DeviceInterfaceId";
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@DeviceInterfaceId",SqlDbType.Int)
            };
            parms[0].Value = entity.DeviceInterfaceId;
            return ComMethod.GetListBySql<DeviceInterfaceTestPositionInfo>(sql, parms);
        }
    }
}
