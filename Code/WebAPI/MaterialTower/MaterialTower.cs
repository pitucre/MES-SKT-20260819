using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using WebAPI.Models;
using WebAPI.Ult;
using Newtonsoft.Json;
using System.Text;

namespace WebAPI.MaterialTower
{
    /// <summary>
    /// 料塔
    /// </summary>
    public class MaterialTower
    {
        /// <summary>
        /// 料塔-料塔回调后保存数据
        /// </summary>
        /// <param name="entity"></param>
        public TowerGRNInfo MaterialTowerCallBack(TowerGRNInfo entity)
        {
            return DBHelper.Get<TowerGRNInfo>("uspMaterialTowerCallBack", new
            {
                EquipmentCode = entity.EquipmentCode,
                GRN = entity.GRN,
                LayerNo = entity.LayerNo,
                PositionNo = entity.PositionNo,
                TowerMsg = entity.Msg,
                ModifyBy = entity.ModifyBy
            }, null, CommandType.StoredProcedure);
        }


        /// <summary>
        /// 料塔-工单取料—取料
        /// </summary>
        /// <param name="entity"></param>
        public void MaterialTowerOutStorage(TowerGRNInfo entity)
        {
            DBHelper.Execute("uspMaterialTowerOutStorage", new
            {
                GRN = entity.GRN,
                ActionType = 0,
                ModifyBy = entity.ModifyBy
            }, null, CommandType.StoredProcedure);
        }
    }
}