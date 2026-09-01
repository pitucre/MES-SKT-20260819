using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    public class InspectionFileManageInfo
    {
        public int Id { get; set; }
        public string Number { get; set; }
        public string ItemCode { get; set; }
        public string SupplierCode { get; set; }
        public string SupplierName { get; set; }
        public string FileType { get; set; }
        public string FileName { get; set; }
        public string CreateBy { get; set; }
        public string CreateDateTime { get; set; }

        public string FileSaveName
        {
            get; set;
        }

        /// <summary>
        /// 数据源 0：Prod_InspectionInputGRNFileManage表数据（检验文档管理—载入时保存的数据） 1：SYS_UpLoadFile表数据（IQC来料检查中上传的数据）
        /// </summary>
        public int DataSource { get; set; }
        /// <summary>
        /// 文件类型
        /// </summary>
        public string FileVersion { set; get; }
    }
}
