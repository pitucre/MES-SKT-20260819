using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentChild
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新） Equipment 信息。
        /// </summary>
        /// <param name="entity">Equipment 实体对象。</param>
        public int Edit(EquipmentChildInfo entity)
        {
            int equipmentChildId = -1;
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentChildId", SqlDbType.Int),
                new SqlParameter("@ParentEquipmentId", SqlDbType.Int),
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 20),
                new SqlParameter("@EquipmentName", SqlDbType.NVarChar, 50),
                new SqlParameter("@TypeSpec", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar,200)

                };

                parms[0].Value = entity.EquipmentChildId;
                parms[0].Direction = ParameterDirection.InputOutput;
                parms[1].Value = entity.ParentEquipmentId;
                parms[2].Value = entity.EquipmentCodeChild;
                parms[3].Value = entity.EquipmentNameChild;
                parms[4].Value = entity.TypeSpec;
                parms[5].Value = entity.CreateBy;
                parms[6].Value = entity.Remark;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentChild_Edit", parms);

                equipmentChildId = Convert.ToInt32(parms[0].Value);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return equipmentChildId;
        }

        /// <summary>
        /// /建立父设备与子设备关系
        /// </summary>
        /// <param name="parentEquimentId"></param>
        /// <param name="childEquimentId"></param>
        public void EquimentParentChild(int parentEquimentId, int childEquimentId)
        {

            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ParentEquimentId", SqlDbType.Int, 4),
                new SqlParameter("@ChildEquimentId", SqlDbType.Int, 4)

                };

                parms[0].Value = parentEquimentId;
                parms[1].Value = childEquimentId;



                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEquimentParentChild", parms);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 根据 EquipmentId 字符串删除 Equipment 信息。
        /// </summary>
        /// <param name="parentEquimentId">parentEquimentId 。</param>
        /// /// <param name="childEquimentId">childEquimentId 。</param>
        /// /// <param name="userName">userName 字符串。</param>
        /// <returns></returns>
        public void Delete(int parentEquimentId, int childEquimentId, String userName)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ParentEquimentId", SqlDbType.Int, 4),
                new SqlParameter("@ChildEquimentId", SqlDbType.Int, 4),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
                };

                parms[0].Value = parentEquimentId;
                parms[1].Value = childEquimentId;

                parms[2].Value = userName;

                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentChild_Delete", parms);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <param name="userName"></param>
        public void DeleteByID(string id, String userName)
        {
            try
            {
                SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IDString", SqlDbType.NVarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
                };

                parms[0].Value = id;
                parms[1].Value = userName;
                SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentChild_DeleteByID", parms);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 根据 EquipmentId 获取实体信息。
        /// </summary>
        /// <param name="eQUIPMENTId">EquipmentId。</param>
        /// <returns>Equipment 实体对象。</returns>
        public EquipmentChildInfo GetInfo(int equipmentId)
        {
            EquipmentChildInfo entity = new EquipmentChildInfo();
            SqlParameter[] parms = new SqlParameter[]{
            new SqlParameter("@EquipmentChildId", SqlDbType.Int, 4),
            };
            parms[0].Value = equipmentId;
            entity = ComMethod.Get<EquipmentChildInfo>("Basal_EquipmentChild_GetInfo", parms, SQLHelper.MESConnString);
            return entity;

            //EquipmentChildInfo entity = null;
            //SqlParameter[] parms = new SqlParameter[]{
            //    new SqlParameter("@EquipmentChildId", SqlDbType.Int, 4),

            //};
            //parms[0].Value = equipmentId;

            //using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentChild_GetInfo", parms))
            //{

            //    if (rdr.Read())
            //    {
            //        entity = new EquipmentChildInfo();

            //        entity.EquipmentChildId = Convert.ToInt32(rdr["EquipmentChildId"]);
            //        entity.ParentEquipmentId = Convert.ToInt32(rdr["ParentEquipmentId"]);
            //        entity.EquipmentNameChild = Convert.ToString(rdr["EquipmentNameChild"]);
            //        entity.EquipmentCodeChild = Convert.ToString(rdr["EquipmentCodeChild"]);
            //        entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
            //        entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
            //        entity.TypeSpec = Convert.ToString(rdr["TypeSpec"]);
            //        entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
            //        entity.Remark = Convert.ToString(rdr["Remark"]);
            //        entity.CreateDateTime = Convert.ToDateTime(rdr["CreateTime"]);

            //    }
            //    rdr.Close();
            //}

            //return entity;
        }



        /// <summary>
        /// 分页获取 Equipment 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eQUIPMENTCount">Equipment 总数。</param>
        /// <returns>Equipment 列表。</returns>
        public List<EquipmentChildInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentChildInfo> list = new List<EquipmentChildInfo>();
            EquipmentChildInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwEquipmentChildList", "Id", @"Id,ParentEquimentId,EquipmentCode,EquipmentName,EquipmentModel,CreateTime,EquipmentChildId,EquipmentCodeChild,EquipmentNameChild,ChildEquimentModel,CreateBy,IsDelete,ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentChildInfo();
                    entity.ParentEquipmentId = Convert.ToInt32(rdr["ParentEquimentId"]);
                    entity.EquipmentCode = Convert.ToString(rdr["EquipmentCode"]);
                    entity.EquipmentName = Convert.ToString(rdr["EquipmentName"]);
                    entity.EquipmentModel = Convert.ToString(rdr["EquipmentModel"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.EquipmentChildId = Convert.ToInt32(rdr["EquipmentChildId"]);
                    entity.EquipmentCodeChild = Convert.ToString(rdr["EquipmentCodeChild"]);
                    entity.EquipmentNameChild = Convert.ToString(rdr["EquipmentNameChild"]);
                    entity.ChildEquimentModel = Convert.ToString(rdr["ChildEquimentModel"]);
                    entity.IsDelete = Convert.ToBoolean(rdr["IsDelete"]);
                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime"))) {
                        entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                        entity.ModifyTime = Convert.ToDateTime(rdr["ModifyTime"]);
                    }

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}