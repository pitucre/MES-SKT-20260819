using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Product.BLL
{
    public class ItemIQCParam
    {

        /// <summary>
        /// 编辑（添加或更新） ItemIQCParam 信息。
        /// </summary>
        /// <param name="entity">ItemIQCParam 实体对象。</param>
        public void Edit(ItemIQCParamInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ParamXML", SqlDbType.Xml),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
            };

            parms[0].Value = entity.ItemId;
            parms[1].Value = entity.ParamName;
            parms[2].Value = entity.CreateBy;
            parms[3].Value = entity.ModifyBy;
            parms[4].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemIQCParam_Edit", parms);

        }

        /// <summary>
        /// 根据 ItemIQCParamId 字符串删除 ItemIQCParam 信息。
        /// </summary>
        /// <param name="idString">ItemIQCParamId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemIQCParam_Delete", parms);
        }


        /// <summary>
        /// 根据ItemId获取该物料已配置的IQC检验参数列表
        /// </summary>
        /// <param name="ItemId">物料Id</param>
        /// <returns>IQC检验参数列表</returns>
        public List<ItemIQCParamInfo> GetItemIQCParamList(Int32 ItemId)
        {
            List<ItemIQCParamInfo> list = new List<ItemIQCParamInfo>();
            ItemIQCParamInfo entity = null;

            SearchSettings searchSettings = new SearchSettings();
            searchSettings.AddCondition("ItemId", ItemId.ToString());

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, 99, "Basal_ItemIQCParam", "ItemIQCParamId",
                "[ItemIQCParamId], [ParamName], [ParamStandard]", searchSettings, "ParamName");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ItemIQCParamInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2));

                    list.Add(entity);
                }
                rdr.Close();
            }

            return list;
        }

    }
}