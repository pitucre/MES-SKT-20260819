using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using WebAPI.Models;
using WebAPI.Ult;
using Newtonsoft.Json;
using System.Text;
using System.Data.SqlClient;

namespace WebAPI.Dal
{
    /// <summary>
    /// 料塔
    /// </summary>
    public class ElectricLoction
    {
        /// <summary>
        /// 上架回调
        /// </summary>
        /// <param name="cBarCode"></param>
        /// <param name="shelfCode"></param>
        /// <param name="GRN"></param>
        public void MaterialOnlinePostback(string cBarCode, string shelfCode, string GRN)
        {
            DBHelper.Execute("uspWarehouseLocationDetailOperate", new
            {
                cBarCode = cBarCode,
                ShelfCode = shelfCode,
                GRN = GRN,
                OperateType = 1
            }, null, CommandType.StoredProcedure);
        }


        /// <summary>
        /// 下架出库
        /// </summary>
        /// <param name="grn"></param>
        public void MaterialTake(string  grn)
        {
            DBHelper.Execute("uspWarehouseLocationDetailOperate", new
            {
                GRN = grn,
                OperateType = 3
            }, null, CommandType.StoredProcedure);
        }
    }
}