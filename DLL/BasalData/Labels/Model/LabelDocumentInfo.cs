using System;

namespace SKT.LeanMES.Labels.Model
{
    [Serializable]
    public class LabelDocumentInfo
    {
        private Int32 labelDocumentId;
        private String documentName;
        private String description;
        private Int32 templateID;
        private String templateName;
        private Int32 print_Qty;
        private String print_By;
        private String print_Method;
        private String document_Type;
        private String status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private int printWayId;
        private string templatePath;
        private Int32 itemId;
        private Int32 prodOrderId;
        public Int32 TypeId { get; set; }
        public string SN { get; set; }
        public Int32 ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }

        public Int32 ProdOrderId
        {
            get { return prodOrderId; }
            set { prodOrderId = value; }
        }

        public int PrintWayId {
            get { return printWayId; }
            set { printWayId = value; }
        }

        public  string TemplatePath {
            get { return templatePath; }
            set { templatePath = value; }
        }

        private int plateQty;
        public int PlateQty
        {
            get { return plateQty; }
            set { plateQty = value; }
        }

        private string printerName;
        public string PrinterName
        {
            get { return printerName; }
            set { printerName = value; }
        }


        public string LabelValue { get; set; }
        /// <summary>
        /// 模板上面Key的名称，但是如果是存储过程显示多个SN,则这个名称会加编号
        /// </summary>
        public string LabelName { get; set; }
        /// <summary>
        /// 模板上面Key的名称
        /// </summary>
        public string OriginalName { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Labels.Model.LabelDocumentInfo 类的新实例。
        /// </summary>
        public LabelDocumentInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Labels.Model.LabelDocumentInfo 类的新实例。
        /// </summary>
        /// <param name="labelDocumentId">Document Unique Identifier</param>
        /// <param name="documentName">文档名称</param>
        /// <param name="description">文档描述</param>
        /// <param name="templateID">对应的模板ID（如果Document Type是Label，则需对应ZPL的名称ZPL.ZplID，否则需指定文档地址）</param>
        /// <param name="templateName">对应的模板名称（如果Document Type是Label，则需对应ZPL的名称ZPL.ZplName，否则需指定文档地址）</param>
        /// <param name="print_Qty">打印数量，是指每次打印自动打印的标签或者文档的数量</param>
        /// <param name="print_By">打印参数 Print By SFC Print By Shop Order Print By Container</param>
        /// <param name="print_Method">打印方式：Automatica Manual Reprint All</param>
        /// <param name="document_Type">文档类型 Label Document Travaler</param>
        /// <param name="status">文档状态 Enabled Disabled</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="createDateTime">创建时间。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="modifyDateTime">修改时间。</param>
        /// <param name="remark">备注。</param>
        public LabelDocumentInfo(Int32 labelDocumentId, String documentName, String description, Int32 templateID, 
            String templateName, string printerName, Int32 print_Qty, String print_By, String print_Method, 
            String document_Type, Int32 plateQty, String status, String createBy, DateTime createDateTime, 
            String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.labelDocumentId = labelDocumentId;
            this.documentName = documentName;
            this.description = description;
            this.templateID = templateID;
            this.templateName = templateName;
            this.printerName = printerName;
            this.print_Qty = print_Qty;
            this.print_By = print_By;
            this.print_Method = print_Method;
            this.document_Type = document_Type;
            this.plateQty = plateQty;
            this.status = status;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置Document Unique Identifier
        /// </summary>
        public Int32 LabelDocumentId
        {
            get { return this.labelDocumentId; }
            set { this.labelDocumentId = value; }
        }

        /// <summary>
        /// 获取或设置文档名称
        /// </summary>
        public String DocumentName
        {
            get { return this.documentName; }
            set { this.documentName = value; }
        }

        /// <summary>
        /// 获取或设置文档描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置对应的模板ID（如果Document Type是Label，则需对应ZPL的名称ZPL.ZplID，否则需指定文档地址）
        /// </summary>
        public Int32 TemplateID
        {
            get { return this.templateID; }
            set { this.templateID = value; }
        }

        /// <summary>
        /// 获取或设置对应的模板名称（如果Document Type是Label，则需对应ZPL的名称ZPL.ZplName，否则需指定文档地址）
        /// </summary>
        public String TemplateName
        {
            get { return this.templateName; }
            set { this.templateName = value; }
        }

        /// <summary>
        /// 获取或设置打印数量，是指每次打印自动打印的标签或者文档的数量
        /// </summary>
        public Int32 Print_Qty
        {
            get { return this.print_Qty; }
            set { this.print_Qty = value; }
        }

        /// <summary>
        /// 获取或设置打印参数 Print By SFC Print By Shop Order Print By Container

        /// </summary>
        public String Print_By
        {
            get { return this.print_By; }
            set { this.print_By = value; }
        }

        /// <summary>
        /// 获取或设置打印方式：Automatica Manual Reprint All

        /// </summary>
        public String Print_Method
        {
            get { return this.print_Method; }
            set { this.print_Method = value; }
        }

        /// <summary>
        /// 获取或设置文档类型 Label Document Travaler

        /// </summary>
        public String Document_Type
        {
            get { return this.document_Type; }
            set { this.document_Type = value; }
        }

        /// <summary>
        /// 获取或设置文档状态 Enabled Disabled
        /// </summary>
        public String Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置创建人。
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间。
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人。
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间。
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注。
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}