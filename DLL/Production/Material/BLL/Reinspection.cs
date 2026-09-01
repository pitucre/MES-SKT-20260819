using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.BLL
{
    /// <summary>
    /// 重检
    /// </summary>
    public class Reinspection 
    {
        int recordCount = 0;
        /// <summary>
        /// choosepage
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ReinspectionInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<ReinspectionInfo> list = new List<ReinspectionInfo>();
            //表名或者视图
            strTb = "Prod_Reinspection";

            //主键
            string strKey = "ReinspectionId";
            //查询栏位字串
            string strColumns = @"ReinspectionId ,ReinspectionNo ,Status ,Remark ,CreateBy ,CreateDateTime ,DeliverBy ,DeliverDateTime ,FinishBy ,FinishDateTime";
            list = ComMethod.GetComList<ReinspectionInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }


        /// <summary>
        /// choosepage
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ReinspectionInfo> GetReinspections(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<ReinspectionInfo> list = new List<ReinspectionInfo>();
            //表名或者视图
            strTb = "vwReinspection";

            //主键
            string strKey = "ReinspectionDtlId";
            //查询栏位字串
            string strColumns = @"ReinspectionDtlId ,ReinspectionNo ,SerialNumber ,ItemCode ,Quantity ,CWhCode ,CBarCode ,CheckResultName ,UserName ,CreateDateTime,CheckNumber,VendorName,Remark,ModifyBy,ModifyTime";
            list = ComMethod.GetComList<ReinspectionInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// choosepage
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ReinspectionInfo> GetCPReinspections(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<ReinspectionInfo> list = new List<ReinspectionInfo>();
            //表名或者视图
            strTb = "vwCPReinspection";

            //主键
            string strKey = "ReinspectionDtlId";
            //查询栏位字串
            string strColumns = @"ReinspectionDtlId ,ReinspectionNo ,SerialNumber ,ItemName,ItemCode ,Quantity ,CWhCode ,CBarCode ,CheckResultName ,UserName ,CreateDateTime,CheckNumber,Remark";
            list = ComMethod.GetComList<ReinspectionInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 重检查询
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ReinspectionInfo> GetAllByList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<ReinspectionInfo> list = new List<ReinspectionInfo>();
            //表名或者视图
            strTb = "vwReinspectionList";

            //主键
            string strKey = "MaterialUnitId";
            //查询栏位字串
            string strColumns = @"ItemCode,ItemName,SerialNumber,BalanceQty,LotCode,ExpiredDate,CheckNumber,MaterialUnitId,SurplusExpiredDate,ItemSpec,CWhName,CBarCode,DateCode,VendorName,CWhCode,RemainingShelfLife";
            list = ComMethod.GetComList<ReinspectionInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 重检查询
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ReinspectionInfo> GetAllByListCP(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<ReinspectionInfo> list = new List<ReinspectionInfo>();
            //表名或者视图
            strTb = "vwCPReinspectionList";

            //主键
            string strKey = "ProdOrderID";
            //查询栏位字串
            string strColumns = @"ProdOrderID,OrderNO,ItemCode,ItemName,BalanceQty,CWhCode,CBarCode,DateCode,ExpiredDate,SurplusExpiredDate,CheckNumber";
            list = ComMethod.GetComList<ReinspectionInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        /// <summary>
        /// 调拨超期不良的重检单号
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ReinspectionInfo> GetAllTransfersCq(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<ReinspectionInfo> list = new List<ReinspectionInfo>();
            //表名或者视图
            strTb = "vwTransfersApplyCqMateWarning";

            //主键
            string strKey = "ReinspectionId";
            //查询栏位字串
            string strColumns = @"ReinspectionId ,ReinspectionNo ,NgQty,OkQty,CWhName,CWhCode";
            list = ComMethod.GetComList<ReinspectionInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public List<ReinspectionInfo> GetAllReturnMaterial(string  orderNo) {
            List<ReinspectionInfo> list = new List<ReinspectionInfo>();
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ProdOrderNo",SqlDbType.VarChar,100)
            };
            parms[0].Value = orderNo;
            list = ComMethod.GetList<ReinspectionInfo>("uspGetReturnMaterialList", parms, SQLHelper.MESConnString);
            return list;
        }

        public List<ReinspectionInfo> GetAllReturnGRN(string orderNo)
        {
            List<ReinspectionInfo> list = new List<ReinspectionInfo>();
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ProdOrderNo",SqlDbType.VarChar,100)
            };
            parms[0].Value = orderNo;
            list = ComMethod.GetList<ReinspectionInfo>("uspGetReturnGRNList", parms, SQLHelper.MESConnString);
            return list;
        }

        //验证GRN信息
        public void CheckReturnApplyGRN(string prodOrder,string GRN,int GRNQty,string userName) {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ProdOrderNo",SqlDbType.VarChar,100),
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@GRNQty",SqlDbType.Int),
                  new SqlParameter("@CreateBy",SqlDbType.VarChar,20)

            };
            parms[0].Value = prodOrder;
            parms[1].Value = GRN;
            parms[2].Value = GRNQty;
            parms[3].Value = userName;
            ComMethod.Edit("uspCheckReturnApplyGRN",parms, SQLHelper.MESConnString);

        }

        //验证仓库确认的退料信息
        public void  CheckConfrimGRN(string prodOrder, string GRN, int GRNQty, string userName,string cBarCode)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ProdOrderNo",SqlDbType.VarChar,100),
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@GRNQty",SqlDbType.Int),
                  new SqlParameter("@CreateBy",SqlDbType.VarChar,20),
                  new SqlParameter("@cBarCode",SqlDbType.VarChar,20),
                
            };
            parms[0].Value = prodOrder;
            parms[1].Value = GRN;
            parms[2].Value = GRNQty;
            parms[3].Value = userName;
            parms[4].Value = cBarCode;
            ComMethod.Edit("uspCheckConfrimGRN", parms, SQLHelper.MESConnString);

        }
        //保存生产退料数据
        public void  SaveReturnApplyGRN(string  strJson)
        {

            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ProdOrderNo",SqlDbType.VarChar,100),
                  new SqlParameter("@DeptId",SqlDbType.Int),
                  new SqlParameter("@WhId",SqlDbType.Int),
                  new SqlParameter("@Remark",SqlDbType.VarChar,100),
                  new SqlParameter("@UserName",SqlDbType.VarChar,20),
                  new SqlParameter("@TbDtl",SqlDbType.Structured)
            };
            ComMethod.Edit<ReinspectionInfo>(strJson, "uspSaveReturnMaterial", parms);
        }

        //仓库确认生产退料
        public void  SaveConfrimMaterial(string strJson)
        {

            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@ProdOrderNo",SqlDbType.VarChar,100),
                  new SqlParameter("@UserName",SqlDbType.VarChar,20),
                  new SqlParameter("@TbDtl",SqlDbType.Structured)
            };
            ComMethod.Edit<ReinspectionInfo>(strJson, "uspSaveConfrimMaterial", parms);
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 查GRN信息  包装箱转GRN
        /// </summary>
        public List<MaterialUnitInfo> GetGRNIsBoxIsGRN(string grn)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@GRN", SqlDbType.VarChar, 100)
            };
            parms[0].Value = grn;
            return ComMethod.GetList<MaterialUnitInfo>("uspGetGRNIsBoxIsGRN", parms, null);
        }



    }
}
