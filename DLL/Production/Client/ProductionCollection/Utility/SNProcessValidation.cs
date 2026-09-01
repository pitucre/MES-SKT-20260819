/*-------------------------------------------------
// Copyright(C)2016 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:SNProcessValidation.cs
// 文件功能描述：用于生产采集模块中的序列号流程验证
// 
// 创建标识：Larry.Lin 2016/07/28
// 
// 
//--------------------------------------------------*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.ProductionCollection.Utility
{
    public class SNProcessValidation
    {
        /// <summary>
        /// 验证改序号流程是否正常
        /// </summary>
        /// <param name="prodCollectionInfo">产品采集信息</param>
        /// <returns>
        ///     0：正常；
        ///     1: 无工位操作资格；
        ///     2：无资源使用资格；
        ///     3：序号不存在；
        ///     4：Unit状态不正确；
        ///     5：关联的路由状态不正常；
        ///     6：所选工位不正确；
        ///     7：产品状态不正常；
        ///     8：工单状态不正常；
        ///     9：无产品操作资格
        /// </returns>
        public static int Start(ProductionCollectionInfo prodCollectionInfo)
        {
            int blResult = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@Result",SqlDbType.Int)
            };

            parms[0].Value = prodCollectionInfo.SerialNumber;
            parms[1].Value = prodCollectionInfo.UserId;
            parms[2].Value = prodCollectionInfo.StationId;
            parms[3].Value = prodCollectionInfo.ResourceId;
            parms[4].Value = blResult;
            parms[4].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUnitProcessValidation", parms);
            return (int)parms[4].Value;  //2016.09.09 Beck Ye修改返回值.
        }
        /// <summary>
        /// 验证包装箱号是否正常
        /// </summary>
        /// <param name="prodCollectionInfo">产品采集信息</param>
        /// <returns>
        ///     0：正常；
        ///     1: 包装箱号未找到；
        /// </returns>
        public static int PackingSNValidation(ProductionCollectionInfo prodCollectionInfo)
        {  //Beck Ye 2016.09.18
            int blResult = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@Result",SqlDbType.Int)
            };

            parms[0].Value = prodCollectionInfo.SerialNumber;
            parms[1].Value = prodCollectionInfo.UserId;
            parms[2].Value = prodCollectionInfo.StationId;
            parms[3].Value = prodCollectionInfo.ResourceId;
            parms[4].Value = blResult;
            parms[4].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPackingValidation", parms);
            return (int)parms[4].Value;  
        }
        /// <summary>
        /// 验证工单产品是否维护包装规则
        /// Beck Ye 2016.09.18
        /// </summary>
        /// <param name="prodCollectionInfo">产品采集信息</param>
        /// <returns>
        ///     0：正常；
        ///     1: 未维护包装规则；
        /// </returns>
        public static int PackingSettingValidation(ProductionCollectionInfo prodCollectionInfo)
        {  
            int blResult = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@Result",SqlDbType.Int)
            };

            parms[0].Value = prodCollectionInfo.SerialNumber;
            parms[1].Value = prodCollectionInfo.UserId;
            parms[2].Value = prodCollectionInfo.StationId;
            parms[3].Value = prodCollectionInfo.ResourceId;
            parms[4].Value = blResult;
            parms[4].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPackingSettingValidation", parms);
            return (int)parms[4].Value;
        }
        /// <summary>
        /// 检查条码是否在这个或其他包装箱(栈板里面)里面.
        /// Beck Ye 2016.09.18
        /// </summary>
        /// <param name="ProductionCollectionInfo">条码</param>
        /// <returns></returns>
        public static int uspSNPackIngPalletValidation(ProductionCollectionInfo prodCollectionInfo)
        {
            //检查条码是否在这个或其他包装箱(栈板里面)里面.
            //暂没有启用,看以后是否需要再做处理
            int blResult = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumber",SqlDbType.NVarChar,512),
                new SqlParameter("@Result",SqlDbType.Int)
            };
            parms[0].Value = prodCollectionInfo.SerialNumber;
            parms[1].Value = blResult;
            parms[1].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSNPackIngPalletValidation", parms);

            return (int)parms[1].Value;

        }
        /// <summary>
        /// 验证栈板号是否正常
        /// </summary>
        /// <param name="prodCollectionInfo">产品采集信息</param>
        /// <returns>
        ///601:栈板号正常
	    ///602:未找到栈板号
	    ///603:栈板已关闭
	    ///604:栈板已报废
	    ///605:栈板已满
        /// </returns>
        public static int PalletSNValidation(ProductionCollectionInfo prodCollectionInfo)
        {  //Beck Ye 2016.09.22
            int blResult = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN",SqlDbType.NVarChar,512),
                new SqlParameter("@UserID",SqlDbType.Int),
                new SqlParameter("@OpeID",SqlDbType.Int),
                new SqlParameter("@ResID",SqlDbType.Int),
                new SqlParameter("@Result",SqlDbType.Int)
            };

            parms[0].Value = prodCollectionInfo.SerialNumber;
            parms[1].Value = prodCollectionInfo.UserId;
            parms[2].Value = prodCollectionInfo.StationId;
            parms[3].Value = prodCollectionInfo.ResourceId;
            parms[4].Value = blResult;
            parms[4].Direction = ParameterDirection.InputOutput;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPalletValidation", parms);
            return (int)parms[4].Value;
        }
    }
}
