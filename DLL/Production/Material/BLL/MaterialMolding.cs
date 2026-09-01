using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Material.Model;
using SKT.Common.Model;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data;

namespace SKT.LeanMES.Material.BLL
{
    /// <summary>
    /// 成型管理。
    /// add by Hanson.Lei on 2017.8.3
    /// </summary>
    public class MaterialMolding
    {
        //private int recordCount = 0;

        //public Int32 GetCount(SearchSettings searchSettings)
        //{
        //    return this.recordCount;
        //}

        //public List<MaterialMoldingInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        //{
        //    return ComMethod.GetComList<MaterialMoldingInfo>
        //        (ref recordCount,
        //        startRow,
        //        maxRows,
        //        "vwProdMaterialMolding",
        //        "MoldingId",
        //        @"MoldingId,ItemID,ItemCode,ItemName,CreateByName,CreateTime,ModifyByName,ModifyTime",
        //        sortExpression,
        //        searchSettings);
        //}

        //public MaterialMoldingInfo Get(int moldingId)
        //{
        //    MaterialMoldingInfo entity = null;

        //    SqlParameter[] parms = new SqlParameter[] { 
        //        new SqlParameter("@MoldingId", SqlDbType.Int) 
        //    };
        //    parms[0].Value = moldingId;

        //    using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialMolding_Get", parms))
        //    {
        //        if (rdr.Read())
        //        {
        //            entity = new MaterialMoldingInfo()
        //            {
        //                MoldingId = rdr.GetInt32(0),
        //                ItemId = rdr.GetInt32(1),
        //                ItemCode = rdr.GetString(2),
        //                ItemName = rdr.GetString(3),
        //                Member = GetMembers(moldingId)
        //            };
        //        }
        //        rdr.Close();
        //    }
        //    return entity;
        //}

        //public List<MaterialMoldingMemberInfo> GetAllMember(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        //{
        //    return ComMethod.GetComList<MaterialMoldingMemberInfo>
        //        (ref recordCount,
        //        startRow,
        //        maxRows,
        //        "vwProdMaterialMoldingMember",
        //        "MoldingMemberId",
        //        @"MoldingMemberId,MoldingId,MachineTypeName,SourceItemName,TargetItemName,Usage,Location,Specification,IsProgrammer",
        //        sortExpression,
        //        searchSettings);
        //}

        //public List<MaterialMoldingMemberInfo> GetMembers(int moldingId)
        //{
        //    var list = new List<MaterialMoldingMemberInfo>();

        //    SqlParameter[] parms = new SqlParameter[] { 
        //        new SqlParameter("@MoldingId", SqlDbType.Int) 
        //    };
        //    parms[0].Value = moldingId;

        //    using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialMoldingMember_Get", parms))
        //    {
        //        while (rdr.Read())
        //        {
        //            list.Add(new MaterialMoldingMemberInfo()
        //            {
        //                MoldingMemberId = rdr.GetInt32(0),
        //                MoldingId = rdr.GetInt32(1),
        //                MachineType = rdr.GetInt32(2),
        //                StationId = rdr.GetInt32(3),
        //                StationName = rdr.GetString(4),
        //                SourceItemId = rdr.GetInt32(5),
        //                SourceItemCode = rdr.GetString(6),
        //                TargetItemId = rdr.GetInt32(7),
        //                TargetItemCode = rdr.GetString(8),
        //                Usage = rdr.GetInt32(9),
        //                Location = rdr.GetString(10),
        //                Specification = rdr.GetString(11),
        //                IsProgrammer = rdr.GetBoolean(12),
        //                Remark = rdr.GetString(13)
        //            });
        //        }
        //        rdr.Close();
        //    }
        //    return list;
        //}

        //public void Save(MaterialMoldingInfo entity)
        //{
        //    DataTable table = null;
        //    if (entity.Member != null && entity.Member.Count > 0)
        //    {
        //        table = new DataTable();
        //        //table.Columns.Add(new DataColumn("MoldingId", typeof(int)));
        //        table.Columns.Add(new DataColumn("MoldingMemberId", typeof(int)));
        //        table.Columns.Add(new DataColumn("Operate", typeof(int)));
        //        table.Columns.Add(new DataColumn("MachineType", typeof(int)));
        //        table.Columns.Add(new DataColumn("StationId", typeof(int)));
        //        table.Columns.Add(new DataColumn("StationName", typeof(string)));
        //        table.Columns.Add(new DataColumn("SourceItemId", typeof(int)));
        //        table.Columns.Add(new DataColumn("SourceItemCode", typeof(string)));
        //        table.Columns.Add(new DataColumn("TargetItemId", typeof(int)));
        //        table.Columns.Add(new DataColumn("TargetItemCode", typeof(string)));
        //        table.Columns.Add(new DataColumn("Usage", typeof(int)));
        //        table.Columns.Add(new DataColumn("Location", typeof(string)));
        //        table.Columns.Add(new DataColumn("Specification", typeof(string)));
        //        table.Columns.Add(new DataColumn("IsProgrammer", typeof(int)));
        //        table.Columns.Add(new DataColumn("Remark", typeof(string)));

        //        //table 不知是否需要主键
        //        foreach (var t in entity.Member)
        //        {
        //            if (t.Operate == 0)
        //                continue;

        //            DataRow row = table.NewRow();
        //            //row["MoldingId"] = t.MoldingId;
        //            row["MoldingMemberId"] = t.MoldingMemberId;
        //            row["Operate"] = t.Operate;
        //            row["MachineType"] = t.MachineType;
        //            row["StationId"] = t.StationId;
        //            row["StationName"] = t.StationName;
        //            row["SourceItemId"] = t.SourceItemId;
        //            row["SourceItemCode"] = t.SourceItemCode;
        //            row["TargetItemId"] = t.TargetItemId;
        //            row["TargetItemCode"] = t.TargetItemCode;
        //            row["Usage"] = t.Usage;
        //            row["Location"] = t.Location;
        //            row["Specification"] = t.Specification;
        //            row["IsProgrammer"] = t.IsProgrammer;
        //            row["Remark"] = t.Remark;
        //            table.Rows.Add(row);
        //        }
        //    }

        //    SqlParameter[] parms = new SqlParameter[] {
        //        new SqlParameter("@MoldingId",SqlDbType.Int), 
        //        new SqlParameter("@ItemId",SqlDbType.Int),                 
        //        new SqlParameter("@UserId",SqlDbType.Int),
        //        new SqlParameter("@IsImport",SqlDbType.Int),
        //        new SqlParameter("@MoldingMember",SqlDbType.Structured)
        //    };
        //    parms[0].Value = entity.MoldingId;
        //    parms[1].Value = entity.ItemId;
        //    parms[2].Value = entity.ModifyBy;
        //    parms[3].Value = entity.IsImport;
        //    parms[4].Value = table;
        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialMolding_Save", parms);
        //}

        //public void Delete(string ids)
        //{
        //    SqlParameter[] parms = new SqlParameter[] {
        //        new SqlParameter("@ids",SqlDbType.VarChar)
        //    };
        //    parms[0].Value = ids.Trim(',');
        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialMolding_Delete", parms);
        //}

        //public void DeleteMember(string ids)
        //{
        //    SqlParameter[] parms = new SqlParameter[] {
        //        new SqlParameter("@ids",SqlDbType.VarChar)
        //    };
        //    parms[0].Value = ids.Trim(',');
        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialMoldingMember_Delete", parms);
        //}

        //public List<MaterialProcessInfo> GetMaterialProcess(int orderId)
        //{
        //    var list = new List<MaterialProcessInfo>();

        //    SqlParameter[] parms = new SqlParameter[] { 
        //        new SqlParameter("@ProdOrderId", SqlDbType.Int) 
        //    };
        //    parms[0].Value = orderId;

        //    using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspMaterialProcess_Load", parms))
        //    {
        //        while (rdr.Read())
        //        {
        //            list.Add(new MaterialProcessInfo()
        //            {
        //                ProcessNo = rdr.GetInt32(0),
        //                ProdDate = rdr.GetDateTime(1),
        //                Group = rdr.GetString(2),
        //                SourceMoldingMember = new MaterialMoldingMemberInfo()
        //                {
        //                    StationName = rdr.GetString(3),
        //                    SourceItemCode = rdr.GetString(5),
        //                    SourceMaterialUnit = new MaterialUnitInfo()
        //                    {
        //                        LotCode = rdr.GetString(4),
        //                        BalanceQty = rdr.GetDecimal(6)
        //                    }
        //                },
        //                Status = rdr.GetString(7),
        //                EquipmentNo = rdr.GetString(8),
        //                FixtureNo = rdr.GetString(9),
        //                Weight = rdr.GetDecimal(10),
        //                StorageLocation = rdr.GetString(11),
        //                Remark = rdr.GetString(12)
        //            });
        //        }
        //        rdr.Close();
        //    }
        //    return list;
        //}

        //public MaterialMoldingMemberInfo CheckMemberSourceGRN(int orderId, int moldingMemberId, string grn)
        //{
        //    SqlParameter[] parms = new SqlParameter[] { 
        //        new SqlParameter("@ProdOrderId", SqlDbType.Int),
        //        new SqlParameter("@GRN",SqlDbType.VarChar),
        //        new SqlParameter("@RCount",SqlDbType.Int),
        //        new SqlParameter("@MoldingId",SqlDbType.Int),
        //        new SqlParameter("@MoldingMemberId",SqlDbType.Int),         
        //        new SqlParameter("@SourceItemCode",SqlDbType.VarChar,100),
        //        new SqlParameter("@SourceItemName",SqlDbType.VarChar,100),
        //        new SqlParameter("@TargetItemCode",SqlDbType.VarChar,100),
        //        new SqlParameter("@BalanceQty",SqlDbType.Decimal),
        //        new SqlParameter("@VendorName",SqlDbType.VarChar,200)
        //    };
        //    parms[0].Value = orderId;
        //    parms[1].Value = grn;
        //    parms[2].Value = 0;
        //    parms[3].Value = 0;
        //    parms[4].Value = moldingMemberId;
        //    parms[5].Value = "";
        //    parms[6].Value = "";
        //    parms[7].Value = "";
        //    parms[8].Value = 0;
        //    parms[9].Value = "";
        //    parms[2].Direction = ParameterDirection.Output;
        //    parms[3].Direction = ParameterDirection.Output;
        //    parms[4].Direction = ParameterDirection.InputOutput;
        //    parms[5].Direction = ParameterDirection.Output;
        //    parms[6].Direction = ParameterDirection.Output;
        //    parms[7].Direction = ParameterDirection.Output;
        //    parms[8].Direction = ParameterDirection.Output;
        //    parms[9].Direction = ParameterDirection.Output;

        //    SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaterialProcess_CheckGRN", parms);

        //    return new MaterialMoldingMemberInfo()
        //    {
        //        RowCount = Convert.ToInt32(parms[2].Value),
        //        MoldingId = Convert.ToInt32(parms[3].Value),
        //        MoldingMemberId = Convert.ToInt32(parms[4].Value),
        //        SourceItemCode = parms[5].Value.ToString(),
        //        SourceItemName = parms[6].Value.ToString(),
        //        TargetItemCode = parms[7].Value.ToString(),
        //        SourceMaterialUnit = new MaterialUnitInfo()
        //        {
        //            BalanceQty = Convert.ToDecimal(parms[8].Value),
        //            VendorName = parms[9].Value.ToString()
        //        }
        //    };
        //}

        //public MaterialMoldingMemberInfo GetMemberInfo(int moldingMemberId)
        //{
        //    var list = GetAllMember(0, 1, "", new SearchSettings() { ExtensionCondition = " MoldingMemberId=" + moldingMemberId });

        //    if (list != null && list.Count == 1)
        //        return list[0];

        //    return null;
        //}

        //public MaterialUnitInfo AddMaterialProcess(MaterialProcessInfo t)
        //{
        //    SqlParameter[] parms = new SqlParameter[] {
        //        new SqlParameter("@GRN",SqlDbType.VarChar),
        //        new SqlParameter("@MoldingId",SqlDbType.Int),
        //        new SqlParameter("@MoldingMemberId",SqlDbType.Int),  
        //        new SqlParameter("@Group",SqlDbType.VarChar),
        //        new SqlParameter("@EquipmentNo",SqlDbType.VarChar),
        //        new SqlParameter("@FixtureNo",SqlDbType.VarChar),
        //        new SqlParameter("@ProdDate",SqlDbType.Date),
        //        new SqlParameter("@Weight",SqlDbType.Decimal),
        //        new SqlParameter("@StorageLocation",SqlDbType.VarChar),
        //        new SqlParameter("@PrintNum",SqlDbType.Int),
        //        new SqlParameter("@CreateBy",SqlDbType.Int),
        //        new SqlParameter("@Remark",SqlDbType.VarChar)
        //    };
        //    parms[0].Value = t.SourceMoldingMember.SourceMaterialUnit.SerialNumber;
        //    parms[1].Value = t.MoldingId;
        //    parms[2].Value = t.MoldingMemberId;
        //    parms[3].Value = t.Group;
        //    parms[4].Value = t.EquipmentNo;
        //    parms[5].Value = t.FixtureNo;
        //    parms[6].Value = t.ProdDate;
        //    parms[7].Value = t.Weight;
        //    parms[8].Value = t.StorageLocation;
        //    parms[9].Value = t.SourceMoldingMember.SourceMaterialUnit.BalanceQty;
        //    parms[10].Value = t.CreateBy;
        //    parms[11].Value = t.Remark;

        //    using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspMaterialProcess_Add", parms))
        //    {
        //        if (rdr.Read())
        //        {
        //            return new MaterialUnitInfo()
        //            {
        //                SerialNumber = rdr.GetString(0),
        //                BalanceQty = rdr.GetDecimal(1),
        //                GRNStr = rdr.GetDecimal(1).ToString().TrimEnd(new char[] { '0' }).TrimEnd(new char[] { '.' }),
        //                VendorCode = rdr.GetString(2),
        //                ItemName = rdr.GetString(3),
        //                MPN = rdr.GetString(4),
        //                SplitTime = SKT.Common.Utility.TypeHelper.ToShortDateString(rdr.GetDateTime(5)) + " " + SKT.Common.Utility.TypeHelper.ToTimeString(rdr.GetDateTime(5)),
        //                DateCode = rdr.GetString(6),
        //                LotCode = rdr.GetString(7),
        //                ItemId = rdr.GetInt32(8)
        //            };
        //        }
        //    }
        //    return null;
        //    //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaterialProcess_Add", parms);
        //}
    }
}
