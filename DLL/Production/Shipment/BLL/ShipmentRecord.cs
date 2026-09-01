using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Shipment.Model;
using System.Data.SqlClient;
using System.Data;

namespace SKT.LeanMES.Shipment.BLL
{
    public class ShipmentRecord
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 MsdContainer 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="msdContainerCount">msdContainer 总数。</param>
        /// <returns>MsdContainer 列表。</returns>
        public List<ShipmentRecordInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShipmentRecordInfo> list = new List<ShipmentRecordInfo>();
            //表名或者视图
            string strTb = "vwGetShipRecordList";
            //主键
            string strKey = "AutoID";
            //查询栏位字串
            string strColumns = @"[AutoID],[Code],[SOCode], [PlanQty], [OutStorageQty], [ShipDate], [WhCode], [VenCode], [CusCode], [PersonCode], [ChkPerson], [Wherson]";

            return ComMethod.GetComList<ShipmentRecordInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 分页获取 MsdContainer 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="msdContainerCount">msdContainer 总数。</param>
        /// <returns>MsdContainer 列表。</returns>
        public List<ShipmentRecordInfo> GetAllDetail(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShipmentRecordInfo> list = new List<ShipmentRecordInfo>();
            //表名或者视图
            string strTb = "vwGetShipRecordDetailList";
            //主键
            string strKey = "AutoID";
            //查询栏位字串
            string strColumns = @"[AutoID],[Code], [PlanQty], [OutStorageQty], [ShipDate], [OrderNo], [ItemCode], [ItemName],[SOCode]";

            return ComMethod.GetComList<ShipmentRecordInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 获取出货单基本信息
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public ShipmentRecordInfo GetInfo(string code)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Code", SqlDbType.VarChar)
            };
            parms[0].Value = code;
            string sql = "select SOCode,PlanQty,ShipDate,CusCode,OutStorageQty from vwGetShipRecordList where Code=@Code";
            return ComMethod.GetBySql<ShipmentRecordInfo>(sql, parms);
        }

        /// <summary>
        /// 获取出货单扫描条码信息
        /// </summary>
        /// <param name="code"></param>
        /// <returns></returns>
        public List<ShipmentRecordInfo> GetAllSNInfo(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ShipmentRecordInfo> list = new List<ShipmentRecordInfo>();
            //表名或者视图
            string strTb = "Prod_OutStorageDetail";
            //主键
            string strKey = "OutStorageDetailID";
            //查询栏位字串
            string strColumns = @"[OutStorageDetailID],[SerialNumber]";

            return ComMethod.GetComList<ShipmentRecordInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
                       
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
