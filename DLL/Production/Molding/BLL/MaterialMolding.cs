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
using SKT.LeanMES.Molding.Model;

namespace SKT.LeanMES.Molding.BLL
{
    /// <summary>
    /// Des:成型管理
    /// Author:Hanson.Lei
    /// Date:2017.8.14
    /// </summary>
    public class MaterialMolding
    {
        private int recordCount = 0;

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        public MaterialMoldingInfo Get(int moldingId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@MoldingId", SqlDbType.Int) 
            };
            parms[0].Value = moldingId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialMolding_Get", parms))
            {
                if (rdr.Read())
                {
                    return new MaterialMoldingInfo()
                    {
                        MoldingId = rdr.GetInt32(0),
                        ItemId = rdr.GetInt32(1),
                        ItemCode = rdr.GetString(2),
                        ItemName = rdr.GetString(3),
                        Member = GetMembers(moldingId)
                    };
                }
            }
            return null;
        }

        public List<MaterialMoldingInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            return ComMethod.GetComList<MaterialMoldingInfo>
                (ref recordCount,
                startRow,
                maxRows,
                "vwProdMaterialMolding",
                "MoldingId",
                @"MoldingId,ItemID,ItemCode,ItemName,CreateByName,CreateTime,ModifyByName,ModifyTime",
                sortExpression,
                searchSettings);
        }
        
        public MaterialMoldingMemberInfo GetMember(int moldingMemberId,int ProdOrderId)
        {
            SearchSettings setting = new SearchSettings() { ExtensionCondition = " MoldingMemberId=" + moldingMemberId.ToString() };
            if (ProdOrderId != -1)
            {
                setting.ExtensionCondition = setting.ExtensionCondition + " and (ProdOrderId=" + ProdOrderId.ToString() + " OR ProdOrderId=-1)";
            }

            var list = GetAllMember(0, 1, "", setting);

            if (list != null && list.Count >= 1)
            {
                var member = list.Where(k => k.ProdOrderID.Equals(ProdOrderId)).FirstOrDefault();
                return member == null ? list[0] : member;
            }

            return null;
        }

        public List<MaterialMoldingMemberInfo> GetAllMember(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            return ComMethod.GetComList<MaterialMoldingMemberInfo>
                (ref recordCount,
                startRow,
                maxRows,
                "vwProdMaterialMoldingMember",
                "MoldingMemberId",
                @"MoldingMemberId,MoldingId,MachineTypeName,SourceItemName,TargetItemName,TargetItemCode,Usage,Location,Specification,IsProgrammer,SourceItemCode,SourceItemSpec,UseQty,StationName,Remark,SoftPath,IsDownload,Filename,DownloadDir,ProdOrderID",
                sortExpression,
                searchSettings);
        }

        /// <summary>
        /// 获取工单查询的前加工数据
        /// </summary>
        /// <returns></returns>
        public List<WOMoldingSearch> GetWOMolding(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            return ComMethod.GetComList<WOMoldingSearch>
                (ref recordCount,
                startRow,
                maxRows,
                "vwMoldingSearchByWO",
                "RowIndex",
                @"RowIndex,OrderNO,SourceItemCode,Station,TargetItemCode,TargetItemSpec,TargetItemName,Qty_to_Build,Usage,MustWorkQty,AlreadyQty,NeedWorkQty",
                sortExpression,
                searchSettings);
        }
        public DataTable GetWOMoldingExcle()
        {
            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, @"select OrderNO as 工单号,SourceItemCode as 产品编码,Station as 工位,TargetItemCode as 加工后物料编码,
TargetItemSpec as 物料规格,TargetItemName as 物料名称,Qty_to_Build as 工单数量,MustWorkQty as 应加工数量,AlreadyQty as 已生产数量,NeedWorkQty as 未加工数量 from
vwMoldingSearchByWO order by RowIndex desc");
        }
        /// <summary>
        /// 获取前加工明细数据
        /// </summary>
        /// <returns></returns>
        public List<MoldingDetailSearch> GetMoldingDetail(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            return ComMethod.GetComList<MoldingDetailSearch>
                (ref recordCount,
                startRow,
                maxRows,
                "vwMoldingDetailSearch",
                "ProcessNo",
                @"ProcessNo,OrderNO,ProdItemCode,UseGRN,CreateTime,[Group],Station,TargetItemCode,LotCode,SourceItemCode,UseQty,EquipmentNo,Weight,Location,Remark,CName,MoldingType",
                sortExpression,
                searchSettings);
        }
        public DataTable GetMoldingDetailExcle()
        {
            return SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, @"select OrderNO as 工单号,ProdItemCode as 产品编码,UseGRN as Grn,CreateTime as 加工日期,[Group] as班组,
Station as 工位,TargetItemCode as 物料编码,LotCode as 批次号,SourceItemCode as 加工前物料编码,UseQty as 合格数量,
EquipmentNo as 设备编码,Weight as 重量,Location as 库位,Remark 描述,CName as 操作员,MoldingType as 类型 from vwMoldingDetailSearch order by ProcessNo desc");
        }
        public List<MaterialMoldingMemberInfo> GetMembers(int moldingId)
        {
            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@MoldingId", SqlDbType.Int) 
            };
            parms[0].Value = moldingId;

            var list = new List<MaterialMoldingMemberInfo>();
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialMoldingMember_Get", parms))
            {
                while (rdr.Read())
                {
                    list.Add(new MaterialMoldingMemberInfo()
                    {
                        MoldingMemberId = rdr.GetInt32(0),
                        MoldingId = rdr.GetInt32(1),
                        MachineType = rdr.GetInt32(2),
                        StationId = rdr.GetInt32(3),
                        StationName = rdr.GetString(4),
                        SourceItemId = rdr.GetInt32(5),
                        SourceItemCode = rdr.GetString(6),
                        TargetItemId = rdr.GetInt32(7),
                        TargetItemCode = rdr.GetString(8),
                        Usage = rdr.GetDecimal(9),
                        Location = rdr.GetString(10),
                        Specification = rdr.GetString(11),
                        IsProgrammer = rdr.GetBoolean(12),
                        Remark = rdr.GetString(13)
                    });
                }
                rdr.Close();
            }
            return list;
        }

        public void Save(MaterialMoldingInfo entity)
        {
            DataTable table = null;
            if (entity.Member != null && entity.Member.Count > 0)
            {
                table = new DataTable();
                //table.Columns.Add(new DataColumn("MoldingId", typeof(int)));
                table.Columns.Add(new DataColumn("MoldingMemberId", typeof(int)));
                table.Columns.Add(new DataColumn("Operate", typeof(int)));
                table.Columns.Add(new DataColumn("MachineType", typeof(int)));
                table.Columns.Add(new DataColumn("StationId", typeof(int)));
                table.Columns.Add(new DataColumn("StationName", typeof(string)));
                table.Columns.Add(new DataColumn("SourceItemId", typeof(int)));
                table.Columns.Add(new DataColumn("SourceItemCode", typeof(string)));
                table.Columns.Add(new DataColumn("TargetItemId", typeof(int)));
                table.Columns.Add(new DataColumn("TargetItemCode", typeof(string)));
                table.Columns.Add(new DataColumn("Usage", typeof(decimal)));
                table.Columns.Add(new DataColumn("Location", typeof(string)));
                table.Columns.Add(new DataColumn("Specification", typeof(string)));
                table.Columns.Add(new DataColumn("IsProgrammer", typeof(int)));
                table.Columns.Add(new DataColumn("Remark", typeof(string)));

                //table 不知是否需要主键
                foreach (var t in entity.Member)
                {
                    if (t.Operate == 0)
                        continue;

                    DataRow row = table.NewRow();
                    //row["MoldingId"] = t.MoldingId;
                    row["MoldingMemberId"] = t.MoldingMemberId;
                    row["Operate"] = t.Operate;
                    row["MachineType"] = t.MachineType;
                    row["StationId"] = t.StationId;
                    row["StationName"] = t.StationName;
                    row["SourceItemId"] = t.SourceItemId;
                    row["SourceItemCode"] = t.SourceItemCode;
                    row["TargetItemId"] = t.TargetItemId;
                    row["TargetItemCode"] = t.TargetItemCode;
                    row["Usage"] = t.Usage;
                    row["Location"] = t.Location;
                    row["Specification"] = t.Specification;
                    row["IsProgrammer"] = t.IsProgrammer;
                    row["Remark"] = t.Remark;
                    table.Rows.Add(row);
                }
            }

            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@MoldingId",SqlDbType.Int), 
                new SqlParameter("@ItemId",SqlDbType.Int),                 
                new SqlParameter("@UserId",SqlDbType.Int),
                new SqlParameter("@IsImport",SqlDbType.Int),
                new SqlParameter("@MoldingMember",SqlDbType.Structured)
            };
            parms[0].Value = entity.MoldingId;
            parms[1].Value = entity.ItemId;
            parms[2].Value = entity.ModifyBy;
            parms[3].Value = entity.IsImport;
            parms[4].Value = table;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialMolding_Save", parms);
        }

        public void Delete(string ids)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ids",SqlDbType.VarChar)
            };
            parms[0].Value = ids.Trim(',');
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialMolding_Delete", parms);
        }

        public void DeleteMember(string ids)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ids",SqlDbType.VarChar)
            };
            parms[0].Value = ids.Trim(',');
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialMoldingMember_Delete", parms);
        }

        public void AddBurnSoftDownLoad(int moldingMemberId,string userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@MemberId",SqlDbType.Int),
                new SqlParameter("@userName",SqlDbType.NVarChar,40)
            };
            parms[0].Value = moldingMemberId;
            parms[1].Value = userName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_BurnSoftDownLoad_Add", parms);
        }
    }
}
