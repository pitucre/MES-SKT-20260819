using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Material.Model;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Utility;

namespace SKT.LeanMES.Material.BLL
{
    public class backupsMaterialUnit
    {
        private Int32 recordCount = 0;
        private Int32 recordCountGRNCarton = 0;
        private Int32 recordVendorItemCount = 0;
        private Int32 recordPickingListCount = 0;
        private Int32 recordGRNCartonCount = 0;
        private Int32 recordDelPckCount = 0;

        /// <summary>
        /// 保存发料
        /// </summary>
        /// <param name="ItemStr"></param>
        /// <param name="Grn"></param>
        /// <returns></returns>
        public void  CheckSendMaterial(Int32 RequestId,Int32 selLocation,String grnStr,String userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@RequestId",SqlDbType.Int),
                  new SqlParameter("@selLocation",SqlDbType.Int),
                  new SqlParameter("@GrnStr",SqlDbType.NVarChar,500),
                  new SqlParameter("@userName",SqlDbType.NVarChar,20)

            };
            parms[0].Value = RequestId;
            parms[1].Value = selLocation;
            parms[2].Value = grnStr;
            parms[3].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveSendMaterial", parms);
        }
        /// <summary>
        /// 查看发料信息
        /// </summary>
        /// <param name="formId"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> CheckSendMaterial(String ItemStr,String  Grn)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@ItemStr",SqlDbType.NVarChar,500),
                  new SqlParameter("@Grn",SqlDbType.NVarChar,100)
            };
            parms[0].Value = ItemStr;
            parms[1].Value = Grn;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckSendMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.PartId = rdr.GetInt32(2);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 查看领料单信息
        /// </summary>
        /// <param name="formId"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> sendMaterialInfo(String  fromNumber)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@RequestNo",SqlDbType.NVarChar,100)
            };
            parms[0].Value = fromNumber;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSendMaterialInfo", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialRequestId = rdr.GetInt32(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.RequestQty = rdr.GetDecimal(2);
                    entity.ResponseQty = rdr.GetDecimal(3);
                    entity.ItemId = rdr.GetInt32(4);
                    entity.DepartName = rdr.GetString(5);
                    entity.UserName = rdr.GetString(6);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 保存物料合并
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> SaveCombineMaterial(String grn, String waitGRN, String userName)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@waitCombineSN",SqlDbType.NVarChar,500),
                  new SqlParameter("@userName",SqlDbType.NVarChar,20)

            };
            parms[0].Value = grn;
            parms[1].Value = waitGRN;
            parms[2].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSaveCombineMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 验证物料合并
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> CheckMaterialCombine(String grn)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100)
            };
            parms[0].Value = grn;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckCombineMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.PartId = rdr.GetInt32(2);
                    entity.Status = rdr.GetInt32(3);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// add by weixia on 2015/4/28 
        /// 验证物料入库
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="wareCode"></param>
        public List<MaterialUnitInfo> InStorageMaterial(String grn, String wareCode, String userName)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@WareCode",SqlDbType.VarChar,100),
                  new SqlParameter("@UserName",SqlDbType.NVarChar,50),
            };
            parms[0].Value = grn;
            parms[1].Value = wareCode;
            parms[2].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckMaterialInStorage", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.CBarCode = rdr.GetString(2);
                    entity.Quantity = rdr.GetDecimal(3);
                    entity.ModifyBy = rdr.GetString(4);
                    entity.PackTime = rdr.GetDateTime(5).ToString("yyyy-MM-dd HH:mm:ss");

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 物料退料
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="wareCode"></param>
        /// <param name="qty"></param>
        /// <param name="userName"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> ReturnMaterial(String grn, String wareCode, Decimal qty, String userName) {

            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@GRN",SqlDbType.VarChar,100),
                  new SqlParameter("@WareCode",SqlDbType.VarChar,100),
                  new SqlParameter("@Qty",SqlDbType.Decimal),
                  new SqlParameter("@UserName",SqlDbType.NVarChar,50),
            };
            parms[0].Value = grn;
            parms[1].Value = wareCode;
            parms[2].Value = qty;
            parms[3].Value = userName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspCheckReturnMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.CBarCode = rdr.GetString(2);
                    entity.BalanceQty = rdr.GetDecimal(3);
                    entity.ModifyBy = rdr.GetString(4);
                    entity.PackTime = rdr.GetDateTime(5).ToString("yyyy-MM-dd HH:mm:ss");

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }


        /// <summary>
        /// 编辑（添加或更新） MaterialUnit 信息。
        /// </summary>
        /// <param name="entity">MaterialUnit 实体对象。</param>
        public void Edit(MaterialUnitInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MaterialUnitId", SqlDbType.Int),
                new SqlParameter("@LotCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@DateCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy",SqlDbType.VarChar,20),
                new SqlParameter("@ModifyBy",SqlDbType.VarChar,20)
            };

            parms[0].Value = entity.MaterialUnitId;
            parms[1].Value = entity.LotCode;
            parms[2].Value = entity.DateCode;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialUnit_Edit", parms);
        }

        /// <summary>
        /// 根据 MaterialUnitId 字符串删除 MaterialUnit 信息。
        /// </summary>
        /// <param name="idString">MaterialUnitId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialUnit_Delete", parms);
        }

        /// <summary>
        /// 根据 MaterialUnitId 获取实体信息。
        /// </summary>
        /// <param name="uNITId">MaterialUnitId。</param>
        /// <returns>MaterialUnit 实体对象。</returns>
        public MaterialUnitInfo GetInfo(Int32 uNITId)
        {
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = uNITId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialUnit_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialUnitInfo(rdr.GetInt64(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetByte(3), rdr.GetByte(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetInt32(14),
                        rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetInt32(17), rdr.GetDateTime(18), rdr.GetInt32(19), rdr.GetInt32(20));
                }
                rdr.Close();
            }

            return entity;

        }

        /// <summary>
        /// 根据 字段值 获取实体MaterialUnit信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MaterialUnit 实体对象。</returns>
        public MaterialUnitInfo GetInfo(String fieldValue)
        {
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialUnit_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new MaterialUnitInfo(rdr.GetInt64(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetByte(3), rdr.GetByte(4),
                         rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                         rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetInt32(14),
                         rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetInt32(17), rdr.GetDateTime(18), rdr.GetInt32(19), rdr.GetInt32(20));
                    entity.ItemName = rdr.GetString(21);
                    entity.ItemDesc = rdr.GetString(22);
                    entity.SplitTime = TypeHelper.ToShortDateString(rdr.GetDateTime(15)) + " " + TypeHelper.ToTimeString(rdr.GetDateTime(15));
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 分页获取 MaterialUnit 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="MaterialUnitCount">MaterialUnit 总数。</param>
        /// <returns>MaterialUnit 列表。</returns>
        public List<MaterialUnitInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaterialUnitItem", "MaterialUnitId",
                "[MaterialUnitId], [SerialNumber], [PartId], [MaterialUnitStatusId], [MaterialTypeId], [StationId], [EmployeeId], [LotCode], [DateCode], [TraceCode], [MPN], [VendorCode],  [Quantity] ,  [BalanceQty], [LooperCount], [CreationTime], [FinishTime], [LineId], [LastUpdate], [ProcessNameId], [ItemName], [CreateBy], [Status],[PID],[ItemDesc],[ItemSpec],[StorageDate]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo(rdr.GetInt64(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetByte(3), rdr.GetByte(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11), rdr.GetDecimal(12), rdr.GetDecimal(13), rdr.GetInt32(14),
                        rdr.GetDateTime(15), rdr.GetDateTime(16), rdr.GetInt32(17), rdr.GetDateTime(18), rdr.GetInt32(19), rdr.GetInt32(22));

                    entity.ItemName = rdr.GetString(20);
                    entity.CreateBy = rdr.GetString(21);
                    entity.PID = rdr.GetInt32(23);
                    entity.ItemDesc = rdr.GetString(24);
                    entity.ItemSpec = rdr.GetString(25);
                    entity.PackTime = rdr.GetDateTime(26).ToString("yyyy-MM-dd HH:mm:ss"); //针对入库日期

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取物料数量
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 生成物料条码
        /// </summary>
        /// <param name="ItemId"></param>
        /// <param name="GRNQty"></param>
        /// <param name="MinQty"></param>
        /// <param name="LotCode"></param>
        /// <param name="DateCode"></param>
        /// <param name="TraceCode"></param>
        /// <param name="MPN"></param>
        /// <param name="VendorCode"></param>
        /// <param name="UserName"></param>        
        public string[] GenerateGRN(int ItemId, int GRNQty, decimal MinQty, string LotCode, string DateCode, string VendorCode, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ItemID",SqlDbType.Int),
                new SqlParameter("@GRNQty",SqlDbType.Int),
                new SqlParameter("@MinQty",SqlDbType.Decimal),
                new SqlParameter("@LotCode",SqlDbType.NVarChar,50),
                new SqlParameter("@DateCode",SqlDbType.NVarChar,50),
                new SqlParameter("@TraceCode",SqlDbType.NVarChar,50),
                new SqlParameter("@MPN",SqlDbType.NVarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@GRNString",SqlDbType.VarChar,8000),
                new SqlParameter("@ItemInfo",SqlDbType.NVarChar,500),
                new SqlParameter("@VendorSort",SqlDbType.NVarChar,50)  //add by watson 得到供应商简称
            };

            parms[0].Value = ItemId;
            parms[1].Value = GRNQty;
            parms[2].Value = MinQty;
            parms[3].Value = LotCode;
            parms[4].Value = DateCode;
            parms[5].Value = "";
            parms[6].Value = "";
            parms[7].Value = VendorCode;
            parms[8].Value = UserName;
            parms[9].Direction = ParameterDirection.Output;
            parms[10].Direction = ParameterDirection.Output;
            parms[11].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateGRN", parms);

            string[] str = new string[3];
            str[0] = Convert.ToString(parms[9].Value);
            str[1] = Convert.ToString(parms[10].Value);
            str[2] = Convert.ToString(parms[11].Value);
            return str;
        }

        /// <summary>
        /// 发料
        /// </summary>
        /// <param name="location"></param>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        public List<MaterialUnitInfo> StoreIssue(int location, string grn, string pickingNo, string username)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();

            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@Location",SqlDbType.Int),
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@Pkd_pk",SqlDbType.VarChar,20)
            };

            parms[0].Value = location;
            parms[1].Value = grn;
            parms[2].Value = username;
            parms[3].Value = pickingNo;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspIssueMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.ItemName = rdr.GetString(0);
                    entity.GRNStr = rdr.GetDecimal(1).ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
                    entity.SerialNumber = rdr.GetString(2);
                    entity.GRNQty = rdr.GetInt32(3);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 退料
        /// </summary>
        /// <param name="qty"></param>
        /// <param name="grn"></param>
        /// <param name="loc"></param>
        /// <param name="username"></param>
        public void ReturnMaterial(decimal qty, string grn, int loc, string wonumber, string username)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@Quantity",SqlDbType.Decimal),
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@Location",SqlDbType.Int),
                new SqlParameter("@WONumber",SqlDbType.VarChar,50)
            };

            parms[0].Value = qty;
            parms[1].Value = grn;
            parms[2].Value = username;
            parms[3].Value = loc;
            parms[4].Value = wonumber;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReturnMaterial", parms);
        }

        /// <summary>
        /// 分料、截料
        /// </summary>
        /// <param name="qty"></param>
        /// <param name="batch"></param>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        public List<MaterialUnitInfo> SplitMaterial(decimal qty, string grn, string username)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@Quantity",SqlDbType.Decimal),               
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = qty;
            parms[1].Value = grn;
            parms[2].Value = username;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspSplitMaterial", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.GRNStr = rdr.GetDecimal(1).ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
                    entity.VendorCode = rdr.GetString(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.MPN = rdr.GetString(4);
                    entity.SplitTime = TypeHelper.ToShortDateString(rdr.GetDateTime(5)) + " " + TypeHelper.ToTimeString(rdr.GetDateTime(5));
                    entity.DateCode = rdr.GetString(6);
                    list.Add(entity);
                }

                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 获取GRN最小包装数量
        /// </summary>
        /// <param name="grn"></param>
        /// <returns></returns>
        public object[] GetGRNQuantity(string grn)
        {
            object[] obj = new object[2];
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@ReturnValue",SqlDbType.Float)
            };

            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetGRNQuantity", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);
                    entity.GRNStr = rdr.GetDecimal(1).ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
                    entity.BalanceQty = rdr.GetDecimal(1);
                    entity.VendorCode = rdr.GetString(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.MPN = rdr.GetString(4);
                    entity.SplitTime = TypeHelper.ToShortDateString(rdr.GetDateTime(5)) + " " + TypeHelper.ToTimeString(rdr.GetDateTime(5));

                    list.Add(entity);
                }
                rdr.Close();
            }
            obj[0] = (parms[1].Value.ToString().IndexOf(".") > -1) ? parms[1].Value.ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' }) : parms[1].Value.ToString();
            obj[1] = list;
            return obj;
        }

        /// <summary>
        /// 用于退料时获取GRN剩余数量
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="flag"></param>
        /// <returns></returns>
        public int GetGrnQuantity(string grn, int flag)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@GrnQty",SqlDbType.Decimal),
                new SqlParameter("@Flag",SqlDbType.Int)
            };

            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;
            parms[2].Value = flag;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetGrnQuantityToReturnVendor", parms);
            return Convert.ToInt32(parms[1].Value);
        }


        /// <summary>
        /// 物料是否和工单匹配，以及是否在相应工位使用
        /// </summary>
        /// <returns></returns>
        public int MaterialMatchOrder(string strOrder, string strGRN, Int32 intOpeID)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@Result",SqlDbType.Int),
                new SqlParameter("@OrderNO",SqlDbType.VarChar,50),
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@OpeID",SqlDbType.Int)
            };
            parms[0].Value = 0;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = strOrder;
            parms[2].Value = strGRN;
            parms[3].Value = intOpeID;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaterialMatchOrder", parms);

            return Convert.ToInt32(parms[0].Value.ToString());
        }

        /// <summary>
        /// 通过GRN得到PCB板序号
        /// </summary>       
        /// <param name="grnID">物料GRNID</param>        
        public DataTable ReturnPCBSNByGRN(Int64 grnID)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRNID",SqlDbType.BigInt)                
            };

            parms[0].Value = grnID;
            string strCMD = "Select PanelID,s.[UID],s.[Value] From [Unit] u with (nolock) Inner Join Serial_number s with (nolock) on u.[uid]=s.[uid] and s.SNTypeID=0 " +
                            "Where u.[uid] in(select uid from unit_component where materialunitid=@GRNID) order by u.[uid]";
            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, strCMD, parms);
        }

        /// <summary>
        /// 验证包装的GRN条码是否合法
        /// </summary>
        /// <param name="grn"></param>
        /// <returns>
        /// 数组，str[0]: 错误类型：
        /// -1 - 有错误信息，
        ///  0 - 数据库中没有未关闭的包装箱，系统生成carton箱条码并成功包装GRN，
        ///  1 - 数据库中还有未关闭的包装箱，用户需在前台页面弹出窗口中选择carton箱进行包装GRN
        /// </returns>
        public string[] ValidateGRN(string grn, string cartonsn, string vendorCode, string username,string firstGrn="")
        {
            string[] str = new string[2];

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@ErrorType",SqlDbType.Int),
                new SqlParameter("@ErrorMessage",SqlDbType.NVarChar,200),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@VendorCode",SqlDbType.VarChar,50),
                new SqlParameter("@FirstGrn",SqlDbType.VarChar,50)
            };

            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;
            parms[2].Direction = ParameterDirection.Output;
            parms[3].Value = username;
            parms[4].Value = cartonsn;
            parms[5].Value = vendorCode;
            parms[6].Value = firstGrn;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspValidatePackingGRN", parms);

            str[0] = parms[1].Value.ToString();
            str[1] = parms[2].Value.ToString();

            return str;
        }

        /// <summary>
        /// 获取某一供应商对应的所有没有关闭的GRN包装箱
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetAllOpenGRNCarton(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwOpenedGRNCartonSN", "ID",
                "ID, SerialNumber, PartId, ItemName, Vendor, CreateDateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt64(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.PartId = rdr.GetInt32(2);
                    entity.ItemName = rdr.GetString(3);
                    entity.VendorCode = rdr.GetString(4);
                    entity.CreateDateTime = rdr.GetDateTime(5);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCountGRNCarton = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 取得记录数
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetGRNCartonCount(SearchSettings searchSettings)
        {
            return this.recordCountGRNCarton;
        }

        /// <summary>
        /// 包装GRN到数据库中未关闭的包装箱内
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="cartonsn"></param>
        /// <param name="username"></param>
        public void PackIntoOldCarton(string grn, string cartonsn, string username)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = grn;
            parms[1].Value = cartonsn;
            parms[2].Value = username;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPackGRNIntoOpenedCarton", parms);
        }

        /// <summary>
        /// 生成新的物料包装箱条码并包装
        /// </summary>
        /// <param name="grn"></param>
        /// <param name="username"></param>
        /// <returns></returns>
        public string GenerateNewCartonSNAndPack(string grn, string username)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@GRN",SqlDbType.VarChar,50),
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = grn;
            parms[1].Direction = ParameterDirection.Output;
            parms[2].Value = username;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateNewCartonSNAndPack", parms);
            return Convert.ToString(parms[1].Value);
        }

        /// <summary>
        /// 收料 Add   zhibin.Chen  2015-04-28  按订单收料
        /// </summary>
        /// <param name="entity">物料收料信息的实体entity</param>
        /// <returns>生成的GRN信息对象列表</returns>
        public List<GRNLabelsInfo> ReceiveMaterial(MaterialReceiveInfo entity)
        {
            List<GRNLabelsInfo> list = new List<GRNLabelsInfo>();
            GRNLabelsInfo model = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@OrderFormNO",SqlDbType.VarChar,50),
                new SqlParameter("@ReceiveQty",SqlDbType.Decimal),
                new SqlParameter("@AutoIQCForm",SqlDbType.Int),
                new SqlParameter("@IQCType",SqlDbType.Int),
                new SqlParameter("@ReceiveDate",SqlDbType.VarChar,30),
                new SqlParameter("@ReceivePerson",SqlDbType.VarChar,20),
                new SqlParameter("@BatchNO",SqlDbType.NVarChar,50),
                new SqlParameter("@Supplier",SqlDbType.NVarChar,60),
                new SqlParameter("@SupplierCode",SqlDbType.NVarChar,50),
                new SqlParameter("@DateCode",SqlDbType.NVarChar,50),
                new SqlParameter("@MPN",SqlDbType.NVarChar,50),
            };

            parms[0].Value = entity.OrderFormNO;
            parms[1].Value = entity.ReceiveQty;
            parms[2].Value = entity.AutoIQCForm;
            parms[3].Value = entity.IQCType;
            parms[4].Value = entity.ReceiveDate;
            parms[5].Value = entity.ReceivePerson;
            parms[6].Value = entity.BatchNO;
            parms[7].Value = entity.Supplier;
            parms[8].Value = entity.SupplierCode;
            parms[9].Value = entity.DateCode;
            parms[10].Value = entity.MPN;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspReceiveMaterial", parms))
            {
                while (rdr.Read())
                {
                    model = new GRNLabelsInfo(rdr.GetString(0), rdr.GetString(1), rdr.GetDecimal(2), rdr.GetDateTime(3), rdr.GetDateTime(4), rdr.GetString(5));
                    list.Add(model);
                }
            }

            return list;
        }

        /// <summary>
        /// 订单选择后，获取订单的订购数量，已收数量，订购物料以及物料的相应信息。
        /// add by zhibin.chen  2015-04-29
        /// </summary>
        /// <param name="orderFormNO"></param>
        /// <returns></returns>
        public MaterialReceiveInfo OrderFormSelect(string orderFormNO)
        {
            MaterialReceiveInfo model = new MaterialReceiveInfo();

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@OrderFormNO",SqlDbType.VarChar,50)
            };

            parms[0].Value = orderFormNO;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetOrderFormInfoForRecMaterial", parms))
            {
                if (rdr.HasRows)
                {
                    rdr.Read();
                    model.MaterialName = rdr.GetString(0);
                    model.Qty = rdr.GetDecimal(1);
                    model.ReceivedQty = rdr.GetDecimal(2);
                    model.Supplier = rdr.GetString(3);
                    model.IQCType = rdr.GetInt32(4);

                }
                rdr.Close();
            }

            return model;
        }


        /// <summary>
        /// 获取可收料的订单列表。
        /// add by zhibin.chen  2015-04-29
        /// </summary>
        /// <returns>可收料的订单信息列表</returns>
        public List<MaterialReceiveInfo> GetOrderFormList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialReceiveInfo> list = new List<MaterialReceiveInfo>();
            MaterialReceiveInfo model = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwOrderFormList", "ERPOrderFormId",
                "[ERPOrderFormId], [OrderFormNO], [MaterialName], [Supplier], [Qty]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    model = new MaterialReceiveInfo();
                    model.ERPOrderFormId = rdr.GetInt32(0);
                    model.OrderFormNO = rdr.GetString(1);
                    model.MaterialName = rdr.GetString(2);
                    model.Supplier = rdr.GetString(3);
                    model.Qty = rdr.GetDecimal(4);

                    list.Add(model);

                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取可收料订单的数量 add by zhibin.chen  2015-04-29
        /// </summary>
        /// <returns></returns>
        public Int32 GetOrderFormCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }


        /// <summary>
        /// 获取供应商对应的物料列表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetAllItemByVendor(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwVendorPart", "ID",
                "ID, ItemName, po_vend, itemspec", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt32(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.VendorCode = rdr.GetString(2);
                    entity.ItemDesc = rdr.GetString(3);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordVendorItemCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取客供物料
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetAllItemByKVendor(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "erp_item", "ID",
                "ID, ItemName, itemspec", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt32(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.VendorCode = "";
                    entity.ItemDesc = rdr.GetString(2);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordVendorItemCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 供应商物料数量
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetVendorItemCount(SearchSettings searchSettings)
        {
            return this.recordVendorItemCount;
        }

        /// <summary>
        /// 根据供应商用户的ID获取供应商代码
        /// </summary>
        /// <param name="userId"></param>
        /// <returns>返回供应商代码</returns>
        public string GetVendorCode(int userId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@VendorCode",SqlDbType.VarChar,20)
            };

            parms[0].Value = userId;
            parms[1].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetVendorCodeByUserId", parms);

            return parms[1].Value.ToString();
        }

        public List<MaterialUnitInfo> GetPickingList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwPkdDet", "PkdId",
                "distinct PkdId, pkd_pk, pkd_wo_nbr,wo_status", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt32(0);
                    entity.PkdPK = rdr.GetString(1);
                    entity.PkdWoNbr = rdr.GetString(2);
                    entity.WOStatus = rdr.GetString(3);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordPickingListCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetPickingListCount(SearchSettings searchSettings)
        {
            return this.recordPickingListCount;
        }

        /// <summary>
        /// 获取工单物料
        /// </summary>
        /// <param name="pickingListNO"></param>
        /// <returns></returns>
        public List<MaterialUnitInfo> GetPickingListLine(string wo)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@WO",SqlDbType.VarChar,50)
            };

            parms[0].Value = wo;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPickingListLine", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.PkdWoNbr = rdr.GetString(0);
                    entity.ItemName = rdr.GetString(1);
                    entity.ItemDesc = rdr.GetString(2);
                    entity.GRNStr = rdr.GetString(3);
                    entity.PkdQtyIss = rdr.GetDecimal(4).ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' });
                    entity.MaterialUnitId = rdr.GetInt32(5);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public List<MaterialUnitInfo> GetPackedItemList(string cartonsn)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50)
            };

            parms[0].Value = cartonsn;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPackedGRNByCartonSN", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.SerialNumber = rdr.GetString(0);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public List<MaterialUnitInfo> GetAllGRNCarton(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGRNPackList", "cartonid",
                "cartonid, cartonsn, grnid, grnsn, partid, status, vendorcode, quantity, balanceqty, itemname, flag, lastupdate,cartoncreatetime,CreateBy", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.PIDID = rdr.GetInt64(0);
                    entity.GRNStr = rdr.GetString(1);
                    entity.MaterialUnitId = rdr.GetInt64(2);
                    entity.SerialNumber = rdr.GetString(3);
                    entity.PartId = rdr.GetInt32(4);
                    entity.Status = rdr.GetInt32(5);
                    entity.VendorCode = rdr.GetString(6);
                    entity.Quantity = rdr.GetDecimal(7);
                    entity.BalanceQty = rdr.GetDecimal(8);
                    entity.ItemName = rdr.GetString(9);
                    entity.PkdLoc = rdr.GetInt32(10).ToString();
                    entity.PackTime = TypeHelper.ToShortDateString(rdr.GetDateTime(11)) + " " + TypeHelper.ToTimeString(rdr.GetDateTime(11));
                    entity.CreateDateTime = rdr.GetDateTime(12);
                    entity.CreateBy = rdr.GetString(13);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordGRNCartonCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public List<MaterialUnitInfo> GetAllEmptyCarton(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwEmptyCartonList", "id",
                "id, serialnumber, partid, status, vendorcode, itemname, createdatetime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.MaterialUnitId = rdr.GetInt64(0);
                    entity.SerialNumber = rdr.GetString(1);
                    entity.PartId = rdr.GetInt32(2);
                    entity.Status = rdr.GetInt32(3);
                    entity.VendorCode = rdr.GetString(4);
                    entity.ItemName = rdr.GetString(5);
                    entity.CreateDateTime = rdr.GetDateTime(6);

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordGRNCartonCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetPackedGRNCartonCount(SearchSettings searchSettings)
        {
            return this.recordGRNCartonCount;
        }

        public void ClosePack(string cartonsn, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CartonSN",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = cartonsn;
            parms[1].Value = username;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCloseGrnPack", parms);
        }

        public void UnPack(string cartonsn, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CartonSN",SqlDbType.NVarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = cartonsn;
            parms[1].Value = username;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspUnPackGRNCarton", parms);
        }

        public void RemoveGRN(string cartonsn, string grnsn, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@GRNSN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = cartonsn;
            parms[1].Value = grnsn;
            parms[2].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRemoveGRNFromCarton", parms);
        }

        public int GetCartonStatus(string cartonsn, string username)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@CartonSN",SqlDbType.VarChar,50),
                new SqlParameter("@UserName",SqlDbType.VarChar,20),
                new SqlParameter("@CartonStatus",SqlDbType.Int)
            };

            parms[0].Value = cartonsn;
            parms[1].Value = username;
            parms[2].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetGrnCartonStatus", parms);

            return Convert.ToInt32(parms[2].Value);
        }

        public void DeleteCarton(int cartonId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@CartonID",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = cartonId;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteGrnCartonById", parms);
        }

        public List<MaterialUnitInfo> GetDeletePckList(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwDeletePickingList", "ID",
                "distinct Pkd_pk, pkd_wo_nbr, CreateDateTime, ID", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.PkdPK = rdr.GetString(0);
                    entity.PkdWoNbr = rdr.GetString(1);
                    entity.CreateDateTime = rdr.GetDateTime(2);
                    entity.MaterialUnitId = rdr.GetInt32(3);
                    list.Add(entity);
                }
                rdr.Close();
            }
            recordDelPckCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetDeletePckListCount(SearchSettings searchSettings)
        {
            return this.recordDelPckCount;
        }

        public void ReUsePickingList(string idStr, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@IdStr",SqlDbType.VarChar,200),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = idStr;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspReUsePickingList", parms);
        }

        public void DeletePkdGrn(int id, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ID",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = id;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeletePickingListGrn", parms);

        }

        public List<MaterialUnitInfo> GetRecHistory(int startRow, int maxRows, string sortExpression, SearchSettings searchSettings)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Material_Unit_RecHistory", "ID",
                "ItemName, Grn, Qty, CreateBy, CreateDateTime", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.ItemName = rdr.GetString(0);
                    entity.GRNStr = rdr.GetString(1);
                    entity.Quantity = rdr.GetDecimal(2);
                    entity.CreateBy = rdr.GetString(3);
                    entity.PackTime = rdr.GetDateTime(4).ToString("yyyy-MM-dd HH:mm:ss");

                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public List<MaterialUnitInfo> GetWOMaterialList(string wo)
        {
            List<MaterialUnitInfo> list = new List<MaterialUnitInfo>();
            MaterialUnitInfo entity = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@WO",SqlDbType.VarChar,50)
            };

            parms[0].Value = wo;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetWOMaterialList", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialUnitInfo();
                    entity.ItemName = rdr.GetString(0);
                    entity.ItemDesc = rdr.GetString(1);
                    entity.PkdQtyIss = rdr.GetInt32(2).ToString();

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
    }
}
