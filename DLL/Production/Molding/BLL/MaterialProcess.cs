using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Molding.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Molding.BLL
{
    /// <summary>
    /// Des:物料加工
    /// Author:Hanson.Lei
    /// Date:2017.8.14
    /// </summary>
    public class MaterialProcess
    {
        public List<MaterialProcessInfo> Get(int orderId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@ProdOrderId", SqlDbType.Int) 
            };
            parms[0].Value = orderId;

            var list = new List<MaterialProcessInfo>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialProcess_Get", parms))
            {
                while (rdr.Read())
                {
                    list.Add(new MaterialProcessInfo()
                    {
                        ProcessNo = rdr.GetInt32(0),
                        ProdDate = rdr.GetDateTime(1),
                        Group = rdr.GetString(2),
                        SourceMoldingMember = new MaterialMoldingMemberInfo()
                        {
                            StationName = rdr.GetString(3),
                            SourceItemCode = rdr.GetString(5),
                            SourceMaterialUnit = new MaterialUnitInfo()
                            {
                                LotCode = rdr.GetString(4),
                                BalanceQty = rdr.GetDecimal(6)
                            }
                        },
                        Status = rdr.GetString(7),
                        EquipmentNo = rdr.GetString(8),
                        FixtureNo = rdr.GetString(9),
                        Weight = rdr.GetDecimal(10),
                        StorageLocation = rdr.GetString(11),
                        Remark = rdr.GetString(12),
                        UseGRN = rdr.GetString(13),
                        CName = rdr.GetString(14)
                    });
                }
                rdr.Close();
            }
            return list;

        }

        public MaterialMoldingMemberInfo CheckMemberSourceGRN(int orderId, int moldingMemberId, string grn, int StationId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
                new SqlParameter("@GRN",SqlDbType.VarChar),
                new SqlParameter("@RCount",SqlDbType.Int),
                new SqlParameter("@MoldingId",SqlDbType.Int),
                new SqlParameter("@MoldingMemberId",SqlDbType.Int),
                new SqlParameter("@SourceItemCode",SqlDbType.VarChar,100),
                new SqlParameter("@SourceItemName",SqlDbType.VarChar,100),
                new SqlParameter("@TargetItemCode",SqlDbType.VarChar,100),
                new SqlParameter("@BalanceQty",SqlDbType.Decimal),
                new SqlParameter("@VendorName",SqlDbType.VarChar,200),
                new SqlParameter("@DataCode",SqlDbType.VarChar,100),
                new SqlParameter("@SourceItemID",SqlDbType.Int),
                new SqlParameter("@StationId",SqlDbType.Int),
                new SqlParameter("@TargetItemId",SqlDbType.Int)
            };
            parms[0].Value = orderId;
            parms[1].Value = grn;
            parms[2].Value = 0;
            parms[3].Value = 0;
            parms[4].Value = moldingMemberId;
            parms[5].Value = "";
            parms[6].Value = "";
            parms[7].Value = "";
            parms[8].Value = 0;
            parms[9].Value = "";
            parms[10].Value = "";
            parms[11].Value = 0;
            parms[12].Value = StationId;
            parms[13].Value = 0;
            parms[2].Direction = ParameterDirection.Output;
            parms[3].Direction = ParameterDirection.Output;
            parms[4].Direction = ParameterDirection.InputOutput;
            parms[5].Direction = ParameterDirection.Output;
            parms[6].Direction = ParameterDirection.Output;
            parms[7].Direction = ParameterDirection.Output;
            parms[8].Direction = ParameterDirection.Output;
            parms[9].Direction = ParameterDirection.Output;
            parms[10].Direction = ParameterDirection.Output;
            parms[11].Direction = ParameterDirection.Output;
            parms[13].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialProcess_CheckGRN", parms);

            return new MaterialMoldingMemberInfo()
            {
                RowCount = Convert.ToInt32(parms[2].Value),
                MoldingId = Convert.ToInt32(parms[3].Value),
                MoldingMemberId = Convert.ToInt32(parms[4].Value),
                SourceItemCode = parms[5].Value.ToString(),
                SourceItemName = parms[6].Value.ToString(),
                TargetItemCode = parms[7].Value.ToString(),
                DateCode = parms[10].Value.ToString(),
                SourceItemId = Convert.ToInt32(parms[11].Value),
                TargetItemId = Convert.ToInt32(parms[13].Value),
                SourceMaterialUnit = new MaterialUnitInfo()
                {
                    BalanceQty = Convert.ToDecimal(parms[8].Value),
                    VendorName = parms[9].Value.ToString()
                }
            };
        }

        //public MaterialMoldingMemberInfo GetMemberInfo(int moldingMemberId)
        //{
        //    var list = GetAllMember(0, 1, "", new SearchSettings() { ExtensionCondition = " MoldingMemberId=" + moldingMemberId });

        //    if (list != null && list.Count == 1)
        //        return list[0];

        //    return null;
        //}

        public MaterialUnitInfo Add(MaterialProcessInfo t)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@GRN",SqlDbType.VarChar),
                new SqlParameter("@ProdOrderID",SqlDbType.Int),
                new SqlParameter("@MoldingId",SqlDbType.Int),
                new SqlParameter("@MoldingMemberId",SqlDbType.Int),  
                new SqlParameter("@Group",SqlDbType.VarChar),
                new SqlParameter("@EquipmentNo",SqlDbType.VarChar),
                new SqlParameter("@FixtureNo",SqlDbType.VarChar),
                new SqlParameter("@ProdDate",SqlDbType.Date),
                new SqlParameter("@Weight",SqlDbType.Decimal),
                new SqlParameter("@StorageLocation",SqlDbType.VarChar),
                new SqlParameter("@PrintNum",SqlDbType.Int),
                new SqlParameter("@CreateBy",SqlDbType.Int),
                new SqlParameter("@Remark",SqlDbType.VarChar)
            };
            parms[0].Value = t.SourceMoldingMember.SourceMaterialUnit.SerialNumber;
            parms[1].Value = t.ProdOrderID;
            parms[2].Value = t.MoldingId;
            parms[3].Value = t.MoldingMemberId;
            parms[4].Value = t.Group;
            parms[5].Value = t.EquipmentNo;
            parms[6].Value = t.FixtureNo;
            parms[7].Value = t.ProdDate;
            parms[8].Value = t.Weight;
            parms[9].Value = t.StorageLocation;
            parms[10].Value = t.SourceMoldingMember.SourceMaterialUnit.BalanceQty;
            parms[11].Value = t.CreateBy;
            parms[12].Value = t.Remark;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialProcess_Add", parms))
            {
                if (rdr.Read())
                {
                    return new MaterialUnitInfo()
                    {
                        SerialNumber = rdr.GetString(0),
                        BalanceQty = rdr.GetDecimal(1),
                        GRNStr = rdr.GetDecimal(1).ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' }),
                        VendorCode = rdr.GetString(2),
                        ItemName = rdr.GetString(3),
                        MPN = rdr.GetString(4),
                        SplitTime = SKT.Common.Utility.TypeHelper.ToShortDateString(rdr.GetDateTime(5)) + " " + SKT.Common.Utility.TypeHelper.ToTimeString(rdr.GetDateTime(5)),
                        DateCode = rdr.GetString(6),
                        LotCode = rdr.GetString(7),
                        ItemId = rdr.GetInt32(8)
                    };
                }
            }
            return null;
        }
    }
}
