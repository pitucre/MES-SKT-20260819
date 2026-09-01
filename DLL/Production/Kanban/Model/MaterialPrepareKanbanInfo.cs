using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Kanban.Model
{
    public class MaterialPrepareKanbanInfo
    {
        private Int64 id;
        private String formNO;
        private String prioritys;
        private String itemName;
        private String description;
        private Decimal responseQty;
        private String units;
        private DateTime userDate;
        private String prepareState;
        private Int32 materialRequestId;



        public MaterialPrepareKanbanInfo() { }

        public MaterialPrepareKanbanInfo(Int64 id,string formNO, string prioritys, string itemName, string description, decimal responseQty,
            string units, DateTime userDate, string prepareState,Int32 materialRequestId) 
        {
            this.id = id;
            this.formNO = formNO;
            this.prioritys = prioritys;
            this.itemName = itemName;
            this.description = description;
            this.responseQty = responseQty;
            this.units = units;
            this.userDate = userDate;
            this.prepareState = prepareState;
            this.materialRequestId = materialRequestId;
        }
        /// <summary>
        /// 序号
        /// </summary>
        public Int64 Id
        {
            get { return id; }
            set { id = value; }
        }
        /// <summary>
        /// 领料单
        /// </summary>
        public String FormNO
        {
            get { return formNO; }
            set { formNO = value; }
        }
        /// <summary>
        /// 优先级
        /// </summary>
        public String Prioritys
        {
            get { return prioritys; }
            set { prioritys = value; }
        }
        /// <summary>
        /// 物料编号
        /// </summary>
        public String ItemName
        {
            get { return itemName; }
            set { itemName = value; }
        }
        /// <summary>
        /// 物料描述
        /// </summary>
        public String Description
        {
            get { return description; }
            set { description = value; }
        }
        /// <summary>
        ///领料数量
        /// </summary>
        public Decimal ResponseQty
        {
            get { return responseQty; }
            set { responseQty = value; }
        }
        /// <summary>
        /// 单位
        /// </summary>
        public String Units
        {
            get { return units; }
            set { units = value; }
        }
        /// <summary>
        /// 预计使用时间
        /// </summary>
        public DateTime UserDate
        {
            get { return userDate; }
            set { userDate = value; }
        }
        /// <summary>
        /// 备料状态
        /// </summary>
        public String PrepareState
        {
            get { return prepareState; }
            set { prepareState = value; }
        }
        /// <summary>
        /// 表头id
        /// </summary>
        public Int32 MaterialRequestId
        {
            get { return materialRequestId; }
            set { materialRequestId = value; }
        }
    }
}
