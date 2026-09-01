using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.SteelMesh.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SteelMesh.BLL
{
    public class SteelMeshUseHistory
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 分页获取  操作历史 	 资料。
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<EquipmentSteelMeshUseHistory> GetAllSteelMeshUseHistory(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentSteelMeshUseHistory> list = new List<EquipmentSteelMeshUseHistory>();
            //表名或者视图
            string strTb = "vw_EquipmentSteelMeshUseHistory";
            //主键
            string strKey = "EquipmentUseHistoryId";
            //查询栏位字串
            string strColumns = @"*";
            list = ComMethod.GetComList<EquipmentSteelMeshUseHistory>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }
        /// <summary>
        /// 获取 操作历史 数量
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public Int32 GetSteelMeshUseHistoryCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
