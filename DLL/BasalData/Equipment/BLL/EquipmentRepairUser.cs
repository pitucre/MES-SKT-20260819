using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentRepairUser
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 EquipmentRepairUser 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eQUIPMENTCount">Equipment 总数。</param>
        /// <returns>Equipment 列表。</returns>
        public List<EquipmentRepairUserInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string tbOrView = "vwGetEquipmentRepairUser";
            string columns = "Id,EquipmentRepairUserId,UserId,WorkShift,Email,DepartId,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,WorkShiftName,UserName,CName,EmployeeNo,DepartNo,DepartName,StationId,Station";
            return ComMethod.GetComList<EquipmentRepairUserInfo>(ref this.recordCount, startRow, maxRows, tbOrView, "EquipmentRepairUserId", columns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 根据EquipmentRepairUserId获取维修设备人员信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public EquipmentRepairUserInfo GetInfo(EquipmentRepairUserInfo entity)
        {
            string sql = @"SELECT
                                pru.EquipmentRepairUserId,pru.UserId,pru.WorkShift,pru.Email,pru.DepartId,pru.CreateBy,pru.CreateDateTime,pru.ModifyBy,pru.ModifyDateTime,pru.Phone,
                                CASE pru.WorkShift WHEN 1 THEN '甲班' WHEN 2 THEN '乙班' ELSE '' END WorkShiftName,
		                        su.UserName,sm.CName,sm.EmployeeNo,
		                        ISNULL(so.DepartNo,'') DepartNo,ISNULL(so.DepartName,'') DepartName
                            FROM dbo.Prod_EquipmentRepairUser pru
                            INNER JOIN dbo.SYS_Users su ON pru.UserId = su.UserId
                            INNER JOIN dbo.SYS_Membership sm ON su.UserId = sm.UserId
                            LEFT JOIN dbo.SYS_Organization so ON pru.DepartId = so.OrganizationId
                            WHERE pru.EquipmentRepairUserId = @EquipmentRepairUserId";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@EquipmentRepairUserId", SqlDbType.Int) { Value = entity.EquipmentRepairUserId },
            };
            var model = ComMethod.GetBySql<EquipmentRepairUserInfo>(sql, parms);
            return model;
        }

        ///// <summary>
        ///// 根据EquipmentRepairUserId获取维修设备人员信息
        ///// </summary>
        ///// <param name="entity"></param>
        ///// <returns></returns>
        //public List<EquipmentRepairUserAnormalTypeInfo> GetEquipmentRepairUserAnormalTypeList(EquipmentRepairUserAnormalTypeInfo entity)
        //{
        //    string sql = @"SELECT 
        //                    pat.EquipmentRepairAnormalTypeId,pat.AnormalTypeId,
        //                       bat.AnormalTypeCode,bat.AnormalTypeName,
        //                    bag.AnormalGroupName
        //                   FROM dbo.Prod_EquipmentRepairUserAnormalType pat
        //                   INNER JOIN dbo.Basal_Anormal_Type bat ON pat.AnormalTypeId = bat.AnormalTypeId
        //                   INNER JOIN dbo.Basal_Anormal_Group bag ON bat.AnormalGroupId = bag.AnormalGroupId
        //                   WHERE pat.EquipmentRepairUserId = @EquipmentRepairUserId";
        //    SqlParameter[] parms = new SqlParameter[]
        //    {
        //        new SqlParameter("@EquipmentRepairUserId", SqlDbType.Int) { Value = entity.EquipmentRepairUserId },
        //    };
        //    return ComMethod.GetListBySql<EquipmentRepairUserAnormalTypeInfo>(sql, parms);
        //}

        /// <summary>
        /// 根据EquipmentRepairUserId获取工序信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<EquipmentRepairUserStationInfo> GetEquipmentRepairUserStationList(EquipmentRepairUserStationInfo entity)
        {
            string sql = @"SELECT 
	                           pas.EquipmentRepairStationId,pas.EquipmentRepairUserId,pas.StationId,
	                           bs.Station,bs.StationDesc,
	                           bst.StationType
                            FROM dbo.Prod_EquipmentRepairUserStation pas
                            INNER JOIN dbo.Basal_Station bs ON pas.StationId = bs.StationId
                            LEFT JOIN dbo.Basal_StationType bst ON bs.StationTypeId = bst.StationTypeId
                            WHERE pas.EquipmentRepairUserId = @EquipmentRepairUserId";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@EquipmentRepairUserId", SqlDbType.Int) { Value = entity.EquipmentRepairUserId },
            };
            return ComMethod.GetListBySql<EquipmentRepairUserStationInfo>(sql, parms);
        }


        /// <summary>
        /// 设备维修人员—新增/编辑
        /// </summary>
        /// <param name="entity"></param>
        public void Edit(EquipmentRepairUserInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@EquipmentRepairUserId", SqlDbType.Int) { Value = entity.EquipmentRepairUserId },
                new SqlParameter("@UserId", SqlDbType.Int) { Value = entity.UserId },
                //new SqlParameter("@AnormalTypeIds", SqlDbType.VarChar, 4000) { Value = entity.AnormalTypeIds },
                new SqlParameter("@StationIds", SqlDbType.VarChar, 4000) { Value = entity.StationIds },
              //  new SqlParameter("@WorkShift", SqlDbType.Int) { Value = entity.WorkShift },
                new SqlParameter("@Phone", SqlDbType.VarChar, 20) { Value = entity.Phone },
                new SqlParameter("@Email", SqlDbType.VarChar, 50) { Value = entity.Email },
                new SqlParameter("@DepartId", SqlDbType.Int) { Value = entity.DepartId },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentRepairUserEdit", parms);
        }


        /// <summary>
        /// 删除设备维修人员
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="entity"></param>
        public void Delete(String idString, EquipmentRepairUserInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@EquipmentRepairUserIds", SqlDbType.VarChar, 4000) { Value = idString },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquipmentRepairUserDelete", parms);
        }



        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}
