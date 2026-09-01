using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using Newtonsoft.Json;

namespace SKT.LeanMES.Product.BLL
{
    public class ItemBom
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ItemBom 信息。
        /// </summary>
        /// <param name="entity">ItemBom 实体对象。</param>
        public Int32 Edit(ItemBomInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemBomId", SqlDbType.Int),
                new SqlParameter("@OrganizationCode", SqlDbType.VarChar, 50),
                new SqlParameter("@BomName", SqlDbType.VarChar, 100),
                new SqlParameter("@Version", SqlDbType.VarChar, 20),
                new SqlParameter("@IsCurrentVer", SqlDbType.Bit),               
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 100),
                new SqlParameter("@ItemName", SqlDbType.VarChar, 120),               
                new SqlParameter("@Description", SqlDbType.NVarChar, 200),               
                new SqlParameter("@Source", SqlDbType.Int),               
                new SqlParameter("@State", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)               
            };

            parms[0].Value = entity.ItemBomId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.OrganizationCode;
            parms[2].Value = entity.BomName;
            parms[3].Value = entity.Version;
            parms[4].Value = entity.IsCurrentVer;
            parms[5].Value = entity.ItemId;
            parms[6].Value = entity.ItemCode;
            parms[7].Value = entity.ItemName;
            parms[8].Value = entity.Description;
            parms[9].Value = entity.Source;
            parms[10].Value = entity.State;
            parms[11].Value = entity.CreateBy;
            parms[12].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemBom_Edit", parms);

            return (Int32)parms[0].Value;
        }

        public Int32 Import(ItemBomInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemBomId", SqlDbType.Int),
                new SqlParameter("@OrganizationCode", SqlDbType.VarChar, 50),
                new SqlParameter("@BomName", SqlDbType.VarChar, 100),
                new SqlParameter("@Version", SqlDbType.VarChar, 20),
                new SqlParameter("@IsCurrentVer", SqlDbType.Bit),               
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 100),
                new SqlParameter("@ItemName", SqlDbType.VarChar, 120),               
                new SqlParameter("@Description", SqlDbType.NVarChar, 200),               
                new SqlParameter("@Source", SqlDbType.Int),               
                new SqlParameter("@State", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@BomChildJson", SqlDbType.Structured),
            };

            parms[0].Value = entity.ItemBomId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.OrganizationCode;
            parms[2].Value = entity.BomName;
            parms[3].Value = entity.Version;
            parms[4].Value = entity.IsCurrentVer;
            parms[5].Value = entity.ItemId;
            parms[6].Value = entity.ItemCode;
            parms[7].Value = entity.ItemName;
            parms[8].Value = entity.Description;
            parms[9].Value = entity.Source;
            parms[10].Value = entity.State;
            parms[11].Value = entity.CreateBy;
            parms[12].Value = entity.ModifyBy;
            DataTable dt = entity.Default_4 == "" ? new DataTable() : JsonConvert.DeserializeObject<DataTable>(entity.Default_4);
            parms[13].Value = dt;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemBom_Import", parms);

            return (Int32)parms[0].Value;
        }
        /// <summary>
        /// 根据 ItemBomId 字符串删除 ItemBom 信息。
        /// </summary>
        /// <param name="idString">ItemBomId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemBom_Delete", parms);
        }

        /// <summary>
        /// 根据 ItemBomId 获取实体信息。
        /// </summary>
        /// <param name="itemBomId">ItemBomId。</param>
        /// <returns>ItemBom 实体对象。</returns>
        public ItemBomInfo GetInfo(Int32 itemBomId)
        {
            return ComMethod.GetInfo<ItemBomInfo>(itemBomId, "Basal_ItemBom_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ItemBom 实体对象。</returns>
        public ItemBomInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<ItemBomInfo>(fieldValue, "Basal_ItemBom_GetInfo");
        }

        /// <summary>
        /// 分页获取 ItemBom 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemBomCount">itemBom 总数。</param>
        /// <returns>ItemBom 列表。</returns>
        public List<ItemBomInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemBomInfo> list = new List<ItemBomInfo>();
            //表名或者视图
            string strTb = "vwBasal_ItemBom";////Basal_ItemBom
            //主键
            string strKey = "ItemBomId";
            //查询栏位字串
            string strColumns = @"[ItemBomId], [OrganizationCode], [BomName], [Version], [IsCurrentVer], [ItemId], [ItemCode], [ItemName], [CreateDate], [Description], [Source], [Site], [State], [CreateBy], [CreateDateTime], [ModifyBy],[ModifyDateTime] ";

            return ComMethod.GetComList<ItemBomInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 查询具体产品BOM结构信息
        /// </summary>
        /// <param name="itemCode"></param>
        /// <param name="ver"></param>
        /// <param name="itemBomId"></param>
        /// <returns></returns>
        public List<ItemBomInfo> GetBomStructInfo(string itemCode,string ver,int itemBomId)
        {
            List<ItemBomInfo> list = new List<ItemBomInfo>();
            SqlParameter[] paras = new SqlParameter[]{
               new SqlParameter("@ItemCode",SqlDbType.VarChar,30),
               new SqlParameter("@Version",SqlDbType.VarChar,30),
               new SqlParameter("@ItemBomId",SqlDbType.Int)
            };
            paras[0].Value=itemCode;
            paras[1].Value=ver;
            paras[2].Value=itemBomId;

            list = ComMethod.GetList<ItemBomInfo>("uspGetItemBomStruct", paras);

            return list;
        }

        /// <summary>
        /// 获取产品信息
        /// </summary>
        /// <param name="itemBomId"></param>
        /// <returns></returns>
        public ItemBomInfo GetItemByBomID(int itemBomId)
        {
             SqlParameter[] paras = new SqlParameter[]{              
               new SqlParameter("@ItemBomId",SqlDbType.Int)
            };
            paras[0].Value=itemBomId;
           
            string sql = "select ItemCode,ItemName from Basal_ItemBom where ItemBomId=@ItemBomId ";
            return ComMethod.GetBySql<ItemBomInfo>(sql, paras);
        }

        /// <summary>
        /// 从MES中间表同步单个产品信息
        /// </summary>
        public void SynchroItemBom(string itemCode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50)                
            };

            parms[0].Value = itemCode;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "ERP_SyncItemBomByItemID", parms);
        }

        /// <summary>
        /// 复制产品BOM主表子表信息
        /// </summary>
        /// <param name="bomId"></param>
        /// <returns></returns>
        public Int32 ItemBomCopy(int bomId,int itemId,string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemBomId", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar,50),
                new SqlParameter("@ItemId", SqlDbType.Int),
            };


            parms[0].Value = bomId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = UserName;
            parms[2].Value = itemId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspItemBomCopy", parms);
            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 判断物料清单表是否存在该产品
        /// </summary>
   
        /// <param name="itemId"></param>
        /// <returns></returns>
        public int IsItemBomExists(Int32 itemId)
        {
            //不存在重复的
            var  result = 0;
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@Result", SqlDbType.Int),
            };
            parms[0].Value = itemId;
            parms[1].Direction = ParameterDirection.Output;
            DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString,
                "uspIsItemBomExists", parms);
            result = Convert.ToInt32(parms[1].Value);
            return result;
        }
    }
}