using System;
namespace SKT.LeanMES.Molding.Model
{
    [Serializable]
    public class MaterialMoldingMemberInfo : CommEntity
    {
        /// <summary>
        /// 前加工物料ID
        /// </summary>
        public int MoldingMemberId { get; set; }

        /// <summary>
        /// 主表ID
        /// </summary>
        public int MoldingId { get; set; }

        /// <summary>
        /// 加工类型
        /// </summary>
        public int MachineType { get; set; }

        /// <summary>
        /// 工序ID
        /// </summary>
        public int StationId { get; set; }

        /// <summary>
        /// 加工前物料ID
        /// </summary>
        public int SourceItemId { get; set; }

        /// <summary>
        /// 加工后物料
        /// </summary>
        public int TargetItemId { get; set; }

        /// <summary>
        /// 用量
        /// </summary>
        public decimal Usage { get; set; }

        /// <summary>
        /// 区域
        /// </summary>
        public string Location { get; set; }

        /// <summary>
        /// 规格
        /// </summary>
        public string Specification { get; set; }

        /// <summary>
        /// 是否烧录
        /// </summary>
        public bool IsProgrammer { get; set; }

        /*=========注意：以下的实体属性不属于数据表中的物理字段=========↓↓↓*/

        /// <summary>
        /// 加工类型名称
        /// </summary>
        public string MachineTypeName { get; set; }
        
        /// <summary>
        /// 工序名称
        /// </summary>
        public string StationName { get; set; }

        /// <summary>
        /// 加工前物料编码
        /// </summary>
        public string SourceItemCode { get; set; }

        /// <summary>
        /// 加工前物料规格
        /// </summary>
        public string SourceItemName { get; set; }

        /// <summary>
        /// 加工前物料编码
        /// </summary>
        public string TargetItemCode { get; set; }

        /// <summary>
        /// 加工后物料规格
        /// </summary>
        public string TargetItemName { get; set; }

        /// <summary>
        /// 原物料
        /// </summary>
        public SKT.LeanMES.Material.Model.MaterialUnitInfo SourceMaterialUnit { get; set; }

        /// <summary>
        /// 行数(明细配置的行数)
        /// </summary>
        public int RowCount { get; set; }

        /// <summary>
        /// 操作方式，与数据字段无关联。
        /// 0:默认;
        /// 1:添加;
        /// 2:修改;
        /// </summary>
        public int Operate { get; set; }

        /// <summary>
        /// 源物料规格
        /// </summary>
        public string SourceItemSpec { set; get; }

        /// <summary>
        /// 已入数量
        /// </summary>
        public int UseQty { set; get; }

        /// <summary>
        /// 日期编码
        /// </summary>
        public string DateCode { set; get; }

        /// <summary>
        /// 是否下载
        /// </summary>
        public int IsDownload { set; get; }

        /// <summary>
        /// 软件名称
        /// </summary>
        public string Filename { set; get; }

        /// <summary>
        /// 软件地址
        /// </summary>
        public string SoftPath { set; get; }

        /// <summary>
        /// 指定目录
        /// </summary>
        public string DownloadDir { set; get; }

        /// <summary>
        /// 工单ID
        /// </summary>
        public int ProdOrderID { set; get; }
    }
}
