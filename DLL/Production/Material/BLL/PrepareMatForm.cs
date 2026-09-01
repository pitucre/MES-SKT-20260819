using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using SKT.LeanMES.Material.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Material.BLL
{
    public class PrepareMatForm
    {
        private Int32 recordCount = 0;

        public void updatePrepareStatus(Int32 prepareMatId, Int32 flage)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PrepareMatId", SqlDbType.Int),
                new SqlParameter("@flage", SqlDbType.Int)
            };

            parms[0].Value = prepareMatId;
            parms[1].Value = flage;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUpdatePrapareStatus", parms);
        }

        public void DeletePrepareList(String sourceCode, Int32 prepareMatFormId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SourceCode", SqlDbType.NVarChar,20),
                new SqlParameter("@PrepareMatFormId", SqlDbType.Int)
            };

            parms[0].Value = sourceCode;
            parms[1].Value = prepareMatFormId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeletePrepareList", parms);
        }
        /// <summary>
        /// 根据条件查询对应的信息
        /// </summary>
        /// <param name="sourceCode"></param>
        /// <param name="prepareMatId"></param>
        /// <returns></returns>
        public PrepareMatFormInfo ShowPrepareMatFormInfo(Int32 prepareMatId)
        {
            PrepareMatFormInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@prepareMatId",SqlDbType.Int)
            };
            parms[0].Value = prepareMatId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspShowPrepareMatFormInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrepareMatFormInfo();
                    entity.PMCode = rdr.GetString(0);
                    entity.MOCode = rdr.GetString(1);
                    entity.DepCode = rdr.GetString(2);
                    entity.WhCode = rdr.GetString(3);
                    entity.PMDate = rdr.GetDateTime(4);
                    entity.Remark = rdr.GetString(5);
                    entity.CreateBy = rdr.GetString(6);
                    entity.CreateDateTime = rdr.GetDateTime(7);
                    entity.StatusName = rdr.GetString(8);
                    entity.POCode = rdr.GetString(9);
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 保存生成备料单
        /// </summary>
        /// <param name="sourceCode"></param>
        /// <param name="prepareMatFormId"></param>
        /// <param name="deptCode"></param>
        /// <param name="whCode"></param>
        /// <param name="userDate"></param>
        /// <param name="userName"></param>
        /// <param name="moIdStr"></param>
        /// <param name="moDIdStr"></param>
        /// <param name="allocateIdStr"></param>
        /// <param name="itemCodeStr"></param>
        /// <param name="QtyStr"> 工单基本数量  </param>
        /// <param name="RequisitingQtyStr">已备料数量</param>
        /// <param name="prepareQtyStr">可备料数量</param>
        /// <param name="remakrStr"></param>
        /// <param name="remark"></param>
        public void SavePrepareFormList(string MOCode,String sourceCode, Int32 prepareMatFormId, String deptCode, String whCode,
            String userName, String moIdStr, String moDIdStr, String allocateIdStr, String itemIdStr, String QtyStr,
            String RequisitingQtyStr, String prepareQtyStr, String remakrStr, String remark)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                   new SqlParameter("@MoCode",SqlDbType.VarChar,50),
                   new SqlParameter("@SourceCode",SqlDbType.VarChar,20),
                   new SqlParameter("@PrepareMatFormId",SqlDbType.Int),
                   new SqlParameter("@DeptCode",SqlDbType.VarChar,20),
                   new SqlParameter("@WhCode",SqlDbType.VarChar,20),
                   new SqlParameter("@UserDate",SqlDbType.DateTime),
                   new SqlParameter("@UserName",SqlDbType.VarChar,20),
                   new SqlParameter("@MoIdStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@MoDIdStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@AllocateIdStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@itemIdStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@QtyStr",SqlDbType.NVarChar,8000),             //工单标准数量   
                   new SqlParameter("@RequisitionQtyStr",SqlDbType.NVarChar,8000),  //已备料数量
                   new SqlParameter("@PrepareQtyStr",SqlDbType.NVarChar,8000),      //可备料数量
                   new SqlParameter("@RemarkStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@Remark",SqlDbType.NVarChar,100),                   
            };
            parms[0].Value = MOCode;
            parms[1].Value = sourceCode;
            parms[2].Value = prepareMatFormId;
            parms[3].Value = deptCode;
            parms[4].Value = whCode;
            parms[5].Value = System.DateTime.Now;
            parms[6].Value = userName;
            parms[7].Value = moIdStr;
            parms[8].Value = moDIdStr;
            parms[9].Value = allocateIdStr;
            parms[10].Value = itemIdStr;
            parms[11].Value = QtyStr;
            parms[12].Value = RequisitingQtyStr;
            parms[13].Value = prepareQtyStr;
            parms[14].Value = remakrStr;
            parms[15].Value = remark;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCreateMaterialPrepareList", parms);
        }

        /// <summary>
        /// 保存其他方式生成备料单
        /// add by hongqing.wang 2015-11-27
        /// </summary>
        /// <param name="sourceCode"></param>
        /// <param name="prepareMatFormId"></param>
        /// <param name="deptCode"></param>
        /// <param name="whCode"></param>
        /// <param name="userDate"></param>
        /// <param name="userName"></param>
        /// <param name="ItemIdStr"></param>
        /// <param name="itemCodeStr"></param>
        /// <param name="QtyStr"></param>
        /// <param name="requisQtyStr"></param>
        /// <param name="canAppQtyStr"></param>
        /// <param name="remakrStr"></param>
        /// <param name="remark"></param>
        public void SaveOhterPrepareFormList(String sourceCode, Int32 prepareMatFormId, String deptCode, String whCode, DateTime userDate,
         String userName, String ItemIdStr, String itemCodeStr, String QtyStr,
         String requisQtyStr, String canAppQtyStr, String remakrStr, String remark)
        {

            SqlParameter[] parms = new SqlParameter[] { 
                   new SqlParameter("@SourceCode",SqlDbType.VarChar,20),
                   new SqlParameter("@PrepareMatFormId",SqlDbType.Int),
                   new SqlParameter("@DeptCode",SqlDbType.VarChar,20),
                   new SqlParameter("@WhCode",SqlDbType.VarChar,20),
                   new SqlParameter("@UserDate",SqlDbType.DateTime),
                   new SqlParameter("@UserName",SqlDbType.VarChar,20),
                   new SqlParameter("@ItemIdStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@ItemCodeStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@QtyStr",SqlDbType.NVarChar,8000),          // 领料数量（工单标准数量）
                   new SqlParameter("@RequisQtyStr",SqlDbType.NVarChar,8000),    // 已备料数量
                   new SqlParameter("@CanAppQtyStr",SqlDbType.NVarChar,8000),    // 可备料数量
                   new SqlParameter("@RemarkStr",SqlDbType.NVarChar,8000),
                   new SqlParameter("@Remark",SqlDbType.NVarChar,100),
                   
            };
            parms[0].Value = sourceCode;
            parms[1].Value = prepareMatFormId;
            parms[2].Value = deptCode;
            parms[3].Value = whCode;
            parms[4].Value = userDate;
            parms[5].Value = userName;
            parms[6].Value = ItemIdStr;
            parms[7].Value = itemCodeStr;
            parms[8].Value = QtyStr;
            parms[9].Value = requisQtyStr;
            parms[10].Value = canAppQtyStr;
            parms[11].Value = remakrStr;
            parms[12].Value = remark;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveOhterPrepareFormList", parms);
        }

        /// <summary>
        /// 显示备料单列表明细（取ERP表里面的数据）
        /// </summary>
        /// <param name="sourceCode"></param>
        /// <param name="allocateIdStr"></param>
        /// <returns></returns>
        public List<PrepareMatFormInfo> ShowMoallocateDetail(int PMID)
        {
            List<PrepareMatFormInfo> list = new List<PrepareMatFormInfo>();
            PrepareMatFormInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@PMID",SqlDbType.Int)
            };
            parms[0].Value =PMID;
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspShowMoallocateDetail", parms))
            {
                for (int i = 0; i < dt.Rows.Count;i++ )
                {
                    entity = new PrepareMatFormInfo();
                    entity.MOCode = dt.Rows[i]["mocode"].ToString();
                    entity.ItemCode = dt.Rows[i]["ItemCode"].ToString();
                    entity.ItemName = dt.Rows[i]["ItemName"].ToString();
                    entity.SourceQty = Convert.ToInt32(dt.Rows[i]["auxqtypick"]);
                    entity.Qty = Convert.ToInt32(dt.Rows[i]["stockqty"]);
                    entity.ModtlId = Convert.ToInt32(dt.Rows[i]["ModtlId"]);
                    entity.ModtlNo = Convert.ToInt32(dt.Rows[i]["ModtlNo"]);
                    entity.ItemId = Convert.ToInt32(dt.Rows[i]["ItemId"]);
                    entity.Remark = dt.Rows[i]["Remarks"].ToString();
                    list.Add(entity);
                }
            }
            return list;
        }

        /// <summary>
        /// 通过备料单Id找到对应的数据
        ///  add by hongqing.wang 2015-11-27
        /// </summary>
        /// <param name="prepareListId"></param>
        /// <returns></returns>
        public List<PrepareMatFormInfo> MaterialRequestGetListByID(Int32 prepareListId)
        {
            List<PrepareMatFormInfo> list = new List<PrepareMatFormInfo>();
            PrepareMatFormInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@PrepareListId",SqlDbType.Int),
            };
            parms[0].Value = prepareListId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspShowMoallocateByIDList", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrepareMatFormInfo();
                    entity.PMID = rdr.GetInt32(0);
                    entity.Org = rdr.GetString(1);
                    entity.PMType = rdr.GetInt32(2);
                    entity.State = rdr.GetInt32(3);
                    entity.PMCode = rdr.GetString(4); ;
                    entity.PMDate = rdr.GetDateTime(5);
                    entity.MOType = rdr.GetInt32(6);
                    entity.MOID = rdr.GetInt32(7);
                    entity.MOCode = rdr.GetString(8);
                    entity.PersonCode = rdr.GetString(9);
                    entity.PersonName = rdr.GetString(10);
                    entity.DepCode = rdr.GetString(11);
                    entity.DepName = rdr.GetString(12);
                    entity.WhID = rdr.GetInt32(13);
                    entity.WhCode = rdr.GetString(14);
                    entity.WhName = rdr.GetString(15);
                    entity.POCode = rdr.GetString(16);
                    entity.VenID = rdr.GetInt32(17);
                    entity.VenCode = rdr.GetString(18);
                    entity.VenName = rdr.GetString(19);
                    entity.SOCode = rdr.GetString(20);
                    entity.CusID = rdr.GetInt32(21);
                    entity.CusCode = rdr.GetString(22);
                    entity.CusName = rdr.GetString(23);
                    entity.Remark = rdr.GetString(24);
                    entity.CreateBy = rdr.GetString(25);
                    entity.CreateDateTime = rdr.GetDateTime(26);
                    entity.ModifyBy = rdr.GetString(27);
                    entity.ModifyDateTime = rdr.GetDateTime(28);
                    entity.ApprovedBy = rdr.GetString(29);
                    entity.ApprovedDateTime = rdr.GetDateTime(30);
                    entity.UnApprovedBy = rdr.GetString(31);
                    entity.UnApprovedDateTime = rdr.GetDateTime(32);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }


        /// <summary>
        /// 获取产品列表信息
        /// add by hongqing.wang 2015-11-27
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PrepareMatFormInfo> GetItemList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PrepareMatFormInfo> list = new List<PrepareMatFormInfo>();
            PrepareMatFormInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwItemInfo", "ItemID", "[ItemID],[ProductItemCode],[ProductInvName],[cInvStd],[Unit],[WhName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrepareMatFormInfo();
                    entity.PMID = rdr.GetInt32(0);
                    entity.Org = rdr.GetString(1);
                    entity.PMType = rdr.GetInt32(2);
                    entity.State = rdr.GetInt32(3);
                    entity.PMCode = rdr.GetString(4); ;
                    entity.PMDate = rdr.GetDateTime(5);
                    entity.MOType = rdr.GetInt32(6);
                    entity.MOID = rdr.GetInt32(7);
                    entity.MOCode = rdr.GetString(8);
                    entity.PersonCode = rdr.GetString(9);
                    entity.PersonName = rdr.GetString(10);
                    entity.DepCode = rdr.GetString(11);
                    entity.DepName = rdr.GetString(12);
                    entity.WhID = rdr.GetInt32(13);
                    entity.WhCode = rdr.GetString(14);
                    entity.WhName = rdr.GetString(15);
                    entity.POCode = rdr.GetString(16);
                    entity.VenID = rdr.GetInt32(17);
                    entity.VenCode = rdr.GetString(18);
                    entity.VenName = rdr.GetString(19);
                    entity.SOCode = rdr.GetString(20);
                    entity.CusID = rdr.GetInt32(21);
                    entity.CusCode = rdr.GetString(22);
                    entity.CusName = rdr.GetString(23);
                    entity.Remark = rdr.GetString(24);
                    entity.CreateBy = rdr.GetString(25);
                    entity.CreateDateTime = rdr.GetDateTime(26);
                    entity.ModifyBy = rdr.GetString(27);
                    entity.ModifyDateTime = rdr.GetDateTime(28);
                    entity.ApprovedBy = rdr.GetString(29);
                    entity.ApprovedDateTime = rdr.GetDateTime(30);
                    entity.UnApprovedBy = rdr.GetString(31);
                    entity.UnApprovedDateTime = rdr.GetDateTime(32);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// add by weixia on 2015.8.28 获取符合条件的物料编码
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PrepareMatFormInfo> GetMoallocateSZInvCodeList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PrepareMatFormInfo> list = new List<PrepareMatFormInfo>();
            PrepareMatFormInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwMoallocateSZcInvCode", "RowId", "[RowId],[FbilSource],[InvCode],[ItemName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrepareMatFormInfo();
                    entity.PMID = rdr.GetInt32(0);
                    entity.Org = rdr.GetString(1);
                    entity.PMType = rdr.GetInt32(2);
                    entity.State = rdr.GetInt32(3);
                    entity.PMCode = rdr.GetString(4); ;
                    entity.PMDate = rdr.GetDateTime(5);
                    entity.MOType = rdr.GetInt32(6);
                    entity.MOID = rdr.GetInt32(7);
                    entity.MOCode = rdr.GetString(8);
                    entity.PersonCode = rdr.GetString(9);
                    entity.PersonName = rdr.GetString(10);
                    entity.DepCode = rdr.GetString(11);
                    entity.DepName = rdr.GetString(12);
                    entity.WhID = rdr.GetInt32(13);
                    entity.WhCode = rdr.GetString(14);
                    entity.WhName = rdr.GetString(15);
                    entity.POCode = rdr.GetString(16);
                    entity.VenID = rdr.GetInt32(17);
                    entity.VenCode = rdr.GetString(18);
                    entity.VenName = rdr.GetString(19);
                    entity.SOCode = rdr.GetString(20);
                    entity.CusID = rdr.GetInt32(21);
                    entity.CusCode = rdr.GetString(22);
                    entity.CusName = rdr.GetString(23);
                    entity.Remark = rdr.GetString(24);
                    entity.CreateBy = rdr.GetString(25);
                    entity.CreateDateTime = rdr.GetDateTime(26);
                    entity.ModifyBy = rdr.GetString(27);
                    entity.ModifyDateTime = rdr.GetDateTime(28);
                    entity.ApprovedBy = rdr.GetString(29);
                    entity.ApprovedDateTime = rdr.GetDateTime(30);
                    entity.UnApprovedBy = rdr.GetString(31);
                    entity.UnApprovedDateTime = rdr.GetDateTime(32);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        public List<PrepareMatFormInfo> GetMoallocateGZInvCodeList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PrepareMatFormInfo> list = new List<PrepareMatFormInfo>();
            PrepareMatFormInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwMoallocateGZcInvCode", "RowId", "[RowId],[FbilSource],[SourceCode],[InvCode],[ItemName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrepareMatFormInfo();
                    entity.PMID = rdr.GetInt32(0);
                    entity.Org = rdr.GetString(1);
                    entity.PMType = rdr.GetInt32(2);
                    entity.State = rdr.GetInt32(3);
                    entity.PMCode = rdr.GetString(4); ;
                    entity.PMDate = rdr.GetDateTime(5);
                    entity.MOType = rdr.GetInt32(6);
                    entity.MOID = rdr.GetInt32(7);
                    entity.MOCode = rdr.GetString(8);
                    entity.PersonCode = rdr.GetString(9);
                    entity.PersonName = rdr.GetString(10);
                    entity.DepCode = rdr.GetString(11);
                    entity.DepName = rdr.GetString(12);
                    entity.WhID = rdr.GetInt32(13);
                    entity.WhCode = rdr.GetString(14);
                    entity.WhName = rdr.GetString(15);
                    entity.POCode = rdr.GetString(16);
                    entity.VenID = rdr.GetInt32(17);
                    entity.VenCode = rdr.GetString(18);
                    entity.VenName = rdr.GetString(19);
                    entity.SOCode = rdr.GetString(20);
                    entity.CusID = rdr.GetInt32(21);
                    entity.CusCode = rdr.GetString(22);
                    entity.CusName = rdr.GetString(23);
                    entity.Remark = rdr.GetString(24);
                    entity.CreateBy = rdr.GetString(25);
                    entity.CreateDateTime = rdr.GetDateTime(26);
                    entity.ModifyBy = rdr.GetString(27);
                    entity.ModifyDateTime = rdr.GetDateTime(28);
                    entity.ApprovedBy = rdr.GetString(29);
                    entity.ApprovedDateTime = rdr.GetDateTime(30);
                    entity.UnApprovedBy = rdr.GetString(31);
                    entity.UnApprovedDateTime = rdr.GetDateTime(32);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 获取子件用料列表信息
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PrepareMatFormInfo> GetMoallocateList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PrepareMatFormInfo> list = new List<PrepareMatFormInfo>();
            PrepareMatFormInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwMoallocateList", "AllocateId", "[AllocateId],[MoCode],[MDeptCode],[ProductItemCode],[ProductInvName],[cInvStd],[unit],[WhName],[ProductQuantity]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrepareMatFormInfo();
                    entity.PMID = rdr.GetInt32(0);
                    entity.Org = rdr.GetString(1);
                    entity.PMType = rdr.GetInt32(2);
                    entity.State = rdr.GetInt32(3);
                    entity.PMCode = rdr.GetString(4); ;
                    entity.PMDate = rdr.GetDateTime(5);
                    entity.MOType = rdr.GetInt32(6);
                    entity.MOID = rdr.GetInt32(7);
                    entity.MOCode = rdr.GetString(8);
                    entity.PersonCode = rdr.GetString(9);
                    entity.PersonName = rdr.GetString(10);
                    entity.DepCode = rdr.GetString(11);
                    entity.DepName = rdr.GetString(12);
                    entity.WhID = rdr.GetInt32(13);
                    entity.WhCode = rdr.GetString(14);
                    entity.WhName = rdr.GetString(15);
                    entity.POCode = rdr.GetString(16);
                    entity.VenID = rdr.GetInt32(17);
                    entity.VenCode = rdr.GetString(18);
                    entity.VenName = rdr.GetString(19);
                    entity.SOCode = rdr.GetString(20);
                    entity.CusID = rdr.GetInt32(21);
                    entity.CusCode = rdr.GetString(22);
                    entity.CusName = rdr.GetString(23);
                    entity.Remark = rdr.GetString(24);
                    entity.CreateBy = rdr.GetString(25);
                    entity.CreateDateTime = rdr.GetDateTime(26);
                    entity.ModifyBy = rdr.GetString(27);
                    entity.ModifyDateTime = rdr.GetDateTime(28);
                    entity.ApprovedBy = rdr.GetString(29);
                    entity.ApprovedDateTime = rdr.GetDateTime(30);
                    entity.UnApprovedBy = rdr.GetString(31);
                    entity.UnApprovedDateTime = rdr.GetDateTime(32);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 生成订单列表
        /// add hongqing.wang
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PrepareMatFormInfo> GetProdOrderList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PrepareMatFormInfo> list = new List<PrepareMatFormInfo>();
            PrepareMatFormInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwErpProdOrderList", "MoId", "[MoId],[MoCode],[CreateDate]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrepareMatFormInfo();
                    entity.PMID = rdr.GetInt32(0);
                    entity.Org = rdr.GetString(1);
                    entity.PMType = rdr.GetInt32(2);
                    entity.State = rdr.GetInt32(3);
                    entity.PMCode = rdr.GetString(4); ;
                    entity.PMDate = rdr.GetDateTime(5);
                    entity.MOType = rdr.GetInt32(6);
                    entity.MOID = rdr.GetInt32(7);
                    entity.MOCode = rdr.GetString(8);
                    entity.PersonCode = rdr.GetString(9);
                    entity.PersonName = rdr.GetString(10);
                    entity.DepCode = rdr.GetString(11);
                    entity.DepName = rdr.GetString(12);
                    entity.WhID = rdr.GetInt32(13);
                    entity.WhCode = rdr.GetString(14);
                    entity.WhName = rdr.GetString(15);
                    entity.POCode = rdr.GetString(16);
                    entity.VenID = rdr.GetInt32(17);
                    entity.VenCode = rdr.GetString(18);
                    entity.VenName = rdr.GetString(19);
                    entity.SOCode = rdr.GetString(20);
                    entity.CusID = rdr.GetInt32(21);
                    entity.CusCode = rdr.GetString(22);
                    entity.CusName = rdr.GetString(23);
                    entity.Remark = rdr.GetString(24);
                    entity.CreateBy = rdr.GetString(25);
                    entity.CreateDateTime = rdr.GetDateTime(26);
                    entity.ModifyBy = rdr.GetString(27);
                    entity.ModifyDateTime = rdr.GetDateTime(28);
                    entity.ApprovedBy = rdr.GetString(29);
                    entity.ApprovedDateTime = rdr.GetDateTime(30);
                    entity.UnApprovedBy = rdr.GetString(31);
                    entity.UnApprovedDateTime = rdr.GetDateTime(32);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 查询调拨列表的记录
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<PrepareMatFormInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PrepareMatFormInfo> list = new List<PrepareMatFormInfo>();
            PrepareMatFormInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwShowPrapareList", "PMID", "PMID,PMCode,MOCode,DepName,WhName,CreateBy,CreateDateTime", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrepareMatFormInfo();
                    entity.PMID=rdr.GetInt64(0);
                    entity.PMCode = rdr.GetString(1);
                    entity.MOCode=rdr.GetString(2);
                    entity.DepName=rdr.GetString(3);
                    entity.WhName=rdr.GetString(4);
                    entity.CreateBy=rdr.GetString(5);
                    entity.CreateDateTime=rdr.GetDateTime(6);
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取备料单详细设计
        /// add  by  weixia on 2015.9.18
        /// </summary>
        /// <param name="formNo"></param>
        /// <returns></returns>
        public PrepareMatFormInfo GetSearchPrepareDetail(String formNo)
        {
            PrepareMatFormInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@FormNo",SqlDbType.NVarChar,60)
            };
            parms[0].Value = formNo;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSearchPrepareDetail", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrepareMatFormInfo();
                    entity.PMID = rdr.GetInt32(0);
                    entity.Org = rdr.GetString(1);
                    entity.PMType = rdr.GetInt32(2);
                    entity.State = rdr.GetInt32(3);
                    entity.PMCode = rdr.GetString(4); ;
                    entity.PMDate = rdr.GetDateTime(5);
                    entity.MOType = rdr.GetInt32(6);
                    entity.MOID = rdr.GetInt32(7);
                    entity.MOCode = rdr.GetString(8);
                    entity.PersonCode = rdr.GetString(9);
                    entity.PersonName = rdr.GetString(10);
                    entity.DepCode = rdr.GetString(11);
                    entity.DepName = rdr.GetString(12);
                    entity.WhID = rdr.GetInt32(13);
                    entity.WhCode = rdr.GetString(14);
                    entity.WhName = rdr.GetString(15);
                    entity.POCode = rdr.GetString(16);
                    entity.VenID = rdr.GetInt32(17);
                    entity.VenCode = rdr.GetString(18);
                    entity.VenName = rdr.GetString(19);
                    entity.SOCode = rdr.GetString(20);
                    entity.CusID = rdr.GetInt32(21);
                    entity.CusCode = rdr.GetString(22);
                    entity.CusName = rdr.GetString(23);
                    entity.Remark = rdr.GetString(24);
                    entity.CreateBy = rdr.GetString(25);
                    entity.CreateDateTime = rdr.GetDateTime(26);
                    entity.ModifyBy = rdr.GetString(27);
                    entity.ModifyDateTime = rdr.GetDateTime(28);
                    entity.ApprovedBy = rdr.GetString(29);
                    entity.ApprovedDateTime = rdr.GetDateTime(30);
                    entity.UnApprovedBy = rdr.GetString(31);
                    entity.UnApprovedDateTime = rdr.GetDateTime(32);
                }
                rdr.Close();
            }
            return entity;
        }

        /// <summary>
        /// 验证该备料单是否已经审核
        /// add by time 2016-2-18
        /// </summary>
        /// <param name="prepareFormNo"></param>
        public void GetVerifyCheck(String prepareFormNo)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PrepareFormNo", SqlDbType.NVarChar,50)
                
            };
            parms[0].Value = prepareFormNo;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetVerifyCheck", parms);
        }

        /// <summary>
        /// 通过备料单显示材料出库单信息
        /// add by hongqing.wang 2016-2-24
        /// </summary>
        /// <param name="prepareListId"></param>
        /// <returns></returns>
        public List<PrepareMatFormInfo> ShowMaterialOutOrderInfo(String forNumber)
        {
            List<PrepareMatFormInfo> list = new List<PrepareMatFormInfo>();
            PrepareMatFormInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@ForNumber",SqlDbType.NVarChar,100),
            };
            parms[0].Value = forNumber;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspShowMaterialOutOrderInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new PrepareMatFormInfo();
                    entity.PMID = rdr.GetInt32(0);
                    entity.Org = rdr.GetString(1);
                    entity.PMType = rdr.GetInt32(2);
                    entity.State = rdr.GetInt32(3);
                    entity.PMCode = rdr.GetString(4); ;
                    entity.PMDate = rdr.GetDateTime(5);
                    entity.MOType = rdr.GetInt32(6);
                    entity.MOID = rdr.GetInt32(7);
                    entity.MOCode = rdr.GetString(8);
                    entity.PersonCode = rdr.GetString(9);
                    entity.PersonName = rdr.GetString(10);
                    entity.DepCode = rdr.GetString(11);
                    entity.DepName = rdr.GetString(12);
                    entity.WhID = rdr.GetInt32(13);
                    entity.WhCode = rdr.GetString(14);
                    entity.WhName = rdr.GetString(15);
                    entity.POCode = rdr.GetString(16);
                    entity.VenID = rdr.GetInt32(17);
                    entity.VenCode = rdr.GetString(18);
                    entity.VenName = rdr.GetString(19);
                    entity.SOCode = rdr.GetString(20);
                    entity.CusID = rdr.GetInt32(21);
                    entity.CusCode = rdr.GetString(22);
                    entity.CusName = rdr.GetString(23);
                    entity.Remark = rdr.GetString(24);
                    entity.CreateBy = rdr.GetString(25);
                    entity.CreateDateTime = rdr.GetDateTime(26);
                    entity.ModifyBy = rdr.GetString(27);
                    entity.ModifyDateTime = rdr.GetDateTime(28);
                    entity.ApprovedBy = rdr.GetString(29);
                    entity.ApprovedDateTime = rdr.GetDateTime(30);
                    entity.UnApprovedBy = rdr.GetString(31);
                    entity.UnApprovedDateTime = rdr.GetDateTime(32);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }


        //add by zhuxi on 2017/09/25
        public byte[] GetApplyPreparePDF(string strPrepareListId, string strXmlFilePath, string strImgPath)
        {
            DataSet dsReuslt = null;

            DataTable dtPreMember = MaterialRequestResult(strPrepareListId);

            if (dtPreMember != null && dtPreMember.Rows.Count > 0)
            {
                var prepareQuery = from t in dtPreMember.AsEnumerable()
                                   group t by new
                                   {
                                       t1 = t.Field<string>("PMCode"),
                                       t2 = t.Field<string>("DepCode"),
                                       t3 = t.Field<string>("WhCode"),
                                       t4 = t.Field<string>("Remark"),
                                       t5 = t.Field<DateTime>("PMDate"),
                                       t6 = t.Field<DateTime>("CreateDateTime")
                                   } into m
                                   select new
                                   {
                                       PMCode = m.Key.t1,
                                       DepCode = m.Key.t2,
                                       WhCode = m.Key.t3,
                                       Remark = m.Key.t4,
                                       PMDate = m.Key.t5.ToString("yyyy-MM-dd"),
                                       CreateDateTime = m.Key.t6.ToString("yyyy-MM-dd")
                                   };

                DataTable dtPre = ConvertToDataTable(prepareQuery);

                dtPre.TableName = "Prepare";
                dtPreMember.TableName = "PrepareMember";

                dsReuslt = new DataSet();
                dsReuslt.Tables.Add(dtPre);
                dsReuslt.Tables.Add(dtPreMember);
            }
            return SKT.LeanMES.CommonHelper.BLL.PDFHelper.getPDFByte(SKT.LeanMES.CommonHelper.BLL.PDFHelper.Language.Simplified, strXmlFilePath, dsReuslt, strImgPath);
        }


        //add by zhuxi on 2017/09/25
        private DataTable MaterialRequestResult(string strPrepareListId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@PrepareListId",SqlDbType.VarChar),
            };
            parms[0].Value = strPrepareListId;
            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Uspshowmoallocatebyidlist", parms);
        }

        //add by zhuxi on 2017/09/25
        public DataTable ConvertToDataTable<T>(IEnumerable<T> array)
        {
            var ret = new DataTable();
            foreach (PropertyDescriptor pd in TypeDescriptor.GetProperties(typeof(T)))
            {
                ret.Columns.Add(pd.Name, pd.PropertyType);
            }
            foreach (T item in array)
            {
                var Row = ret.NewRow();
                foreach (PropertyDescriptor pd in TypeDescriptor.GetProperties(typeof(T)))
                {
                    Row[pd.Name] = pd.GetValue(item);
                }
                ret.Rows.Add(Row);
            }
            return ret;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
