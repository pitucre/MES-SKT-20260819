using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.AccessoryManagement.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.AccessoryManagement.BLL
{
    public class AccessoryItemRelation
    {
        private Int32 recordCount = 0;
        public int Edit(int Id,string ItemCode, string Machine, string username)
        {
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("@Id",SqlDbType.Int),
               new SqlParameter("@ItemCode",SqlDbType.VarChar,50),
               new SqlParameter("@Machine",SqlDbType.VarChar,50),
               new SqlParameter("@username",SqlDbType.VarChar,50),
            };
            param[0].Value = Id;
            param[1].Value = ItemCode;
            param[2].Value = Machine;
            param[3].Value = username;
            var list = ComMethod.GetList<AccessoryItemRelationInfo>("uspAccessoryItemRelationEdit", param);
            Id = list[0].Id;
            return Id;
        }
        /// <summary>
        /// 根据 AccessoryItemRelationId 字符串删除 AccessoryItemRelation 信息。
        /// </summary>
        /// <param name="idString">AccessoryItemRelationId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryItemRelation_Delete", parms);
        }

        /// <summary>
        /// 根据 AccessoryItemRelationId 获取实体信息。
        /// </summary>
        /// <param name="accessoryItemRelationId">AccessoryItemRelationId。</param>
        /// <returns>AccessoryItemRelation 实体对象。</returns>
        public AccessoryItemRelationInfo GetInfo(Int32 accessoryItemRelationId)
        {
            AccessoryItemRelationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = accessoryItemRelationId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryItemRelation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryItemRelationInfo();
                    entity.Id = rdr.GetInt32(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.MachineTypeId = rdr.GetString(2);
                    entity.CreateBy = rdr.GetString(3);
                    entity.CreateTime = rdr.GetDateTime(4);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AccessoryItemRelation 实体对象。</returns>
        public AccessoryItemRelationInfo GetInfo(String fieldValue)
        {
            AccessoryItemRelationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Prod_AccessoryItemRelation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AccessoryItemRelationInfo();
                    entity.Id = rdr.GetInt32(0);
                    entity.ItemCode = rdr.GetString(1);
                    entity.MachineTypeId = rdr.GetString(2);
                    entity.CreateBy = rdr.GetString(3);
                    entity.CreateTime = rdr.GetDateTime(4);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AccessoryItemRelation 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="accessoryItemRelationCount">accessoryItemRelation 总数。</param>
        /// <returns>AccessoryItemRelation 列表。</returns>
        public List<AccessoryItemRelationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string strTb = "";
            List<AccessoryItemRelationInfo> list = new List<AccessoryItemRelationInfo>();
            strTb = "vwItemAccessory";

            //主键
            string strKey = "Id";
            //查询栏位字串
            string strColumns = @"[Id], [ItemCode], [MachineTypeId], [CreateBy], [CreateTime],AccessoryCode,ItemName,ItemSpec,Value,UnitName,ModifyBy,ModifyTime";
            list = ComMethod.GetComList<AccessoryItemRelationInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        /// <summary>
        /// 导入产品辅料
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="username"></param>
        /// <returns></returns>
        public List<AccessoryItemRelationImportresRes> SaveAccessoryItemRelationImport(DataTable dt, string username)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AccessoryAndItemRelationImportData", SqlDbType.Structured),
                new SqlParameter("@username", SqlDbType.NVarChar, 50)
            };
            parms[0].Value = dt;
            parms[1].Value = username;
            var list = ComMethod.GetList<AccessoryItemRelationImportresRes>("uspSaveAccessoryItemRelationImport", parms);
            return list;
        }
    }
}