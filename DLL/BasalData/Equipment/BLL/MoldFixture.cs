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
    public class MoldFixture
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 模治具上线
        /// </summary>
        /// <param name="strJson"></param>
        public void UpLine(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@EquipmentCode",SqlDbType.VarChar, 100),
                new SqlParameter("@MouldCode",SqlDbType.VarChar, 100),
                new SqlParameter("@ProdOrderCode",SqlDbType.VarChar, 100),
                //new SqlParameter("@LineId",SqlDbType.VarChar, 100),
                new SqlParameter("@UserName",SqlDbType.VarChar, 100),
            };

            ComMethod.Edit(strJson, "uspMoldFixtureUpLineSave", parms);
        }


        /// <summary>
        /// 模治具下线
        /// </summary>
        public void DownLine(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@EquipmentCode",SqlDbType.VarChar, 100),
                new SqlParameter("@UserName",SqlDbType.VarChar, 100),
            };

            ComMethod.Edit(strJson, "uspMoldFixtureDownLineSave", parms);
        }

        /// <summary>
        /// 获取以上线数据
        /// </summary>
        /// <param name="prodOrderId"></param>
        /// <param name="lineId"></param>
        /// <returns></returns>
        public string GetUpLineList (int prodOrderId, int lineId )
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@ProdOrderId",SqlDbType.Int),
                new SqlParameter("@LineId",SqlDbType.Int),
            };

            parms[0].Value= prodOrderId;
            parms[1].Value= lineId;

            return ComMethod.GetList("uspGetMoldFixtureUpLineList", parms);
        }

        public string GetUpLineListByMoudle(int EquipmentMoudleId)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@EquipmentMoudleId",SqlDbType.Int){ Value = EquipmentMoudleId}
            };

            return ComMethod.GetList("uspGetMoldFixtureUpLineListByMoulde", parms);
        }

        public List<EquipmentMoldFixtureUseHistoryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentMoldFixtureUseHistoryInfo> list = new List<EquipmentMoldFixtureUseHistoryInfo>();
            //表名或者视图
            string strTb = "vwEquipmentMoldFixtureUseHistory";
            //主键
            string strKey = "EquipmentUseHistoryId";
            //查询栏位字串
            string strColumns = @"*";
            list = ComMethod.GetComList<EquipmentMoldFixtureUseHistoryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        public int GetCount(SearchSettings searchSettings)
        {
            return recordCount;
        }

        /// <summary>
        /// 分页获取模具管理文档f
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<MoldFixtureFileInfo> GetMoldFixtureFileList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MoldFixtureFileInfo> list = new List<MoldFixtureFileInfo>();
            //表名或者视图
            string strTb = "vwBasal_MoldFixtureFileManage";
            //主键
            string strKey = "MoldFixtureId";
            //查询栏位字串
            string strColumns = @"*";
            list = ComMethod.GetComList<MoldFixtureFileInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }


        /// <summary>
        /// 获取模具管理文档详情
        /// </summary>
        /// <param name="fieldValue"></param>
        /// <returns></returns>
        public MoldFixtureFileInfo GetMoldFixture(string fieldValue)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@FieldValue",SqlDbType.VarChar),
                new SqlParameter("@IsByID",SqlDbType.Bit),
            };

            parms[0].Value = fieldValue;
            parms[1].Value = 1;

            return ComMethod.Get<MoldFixtureFileInfo>("Basal_MoldFixtureFileManage_GetInfo", parms);
        }

        /// <summary>
        /// 新增或编辑模具管理文档
        /// </summary>
        /// <param name="strJson"></param>
        public void MoldFixtureEdit(string strJson)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@MoldFixtureId",SqlDbType.Int),
                new SqlParameter("@EqCode",SqlDbType.VarChar, 100),
                new SqlParameter("@FileName",SqlDbType.NVarChar, 1000),
                new SqlParameter("@CreateBy",SqlDbType.VarChar, 100),
            };

            ComMethod.Edit(strJson, "Basal_MoldFixtureFileManage_Edit", parms);
        }

        /// <summary>
        /// 新增或编辑模具管理文档
        /// </summary>
        /// <param name="strJson"></param>
        public void MoldFixtureDelete(string strId, string userName)
        {
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@IdString",SqlDbType.VarChar, 2000),
                new SqlParameter("@UserName",SqlDbType.VarChar, 100),
            };
            parms[0].Value = strId;
            parms[1].Value = userName;

            ComMethod.Edit("Basal_MoldFixtureFileManage_Delete", parms);
        }
    }
}
