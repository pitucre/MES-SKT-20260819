using System;

namespace SKT.LeanMES.Molding.Model
{
    [Serializable]
    public class MaterialBurnInfoDetail : CommEntity
    {
        /// <summary>
        /// 烧录ID
        /// </summary>
        public int BurnId { get; set; }

        /// <summary>
        /// 软件名称
        /// </summary>
        public string SoftName { get; set; }

        /// <summary>
        /// 测试仪器
        /// </summary>
        public string TestMachine { get; set; }

        /// <summary>
        /// 客户
        /// </summary>
        public string Customer { get; set; }

        /// <summary>
        /// 文件名
        /// </summary>
        public string Filename { get; set; }

        /// <summary>
        /// 接收日期
        /// </summary>
        public DateTime ReceiveDate { get; set; }

        /// <summary>
        /// 更新内容
        /// </summary>
        public string UpdateContent { get; set; }

        /// <summary>
        /// 软件地址
        /// </summary>
        public string SoftPath { get; set; }

        /// <summary>
        /// 校验码
        /// </summary>
        public string VerifyCode { get; set; }

        /// <summary>
        /// 下载目录(客户端)
        /// </summary>
        public string DownloadDir { get; set; }

        /// <summary>
        /// 软件作者
        /// </summary>
        public string SoftCreator { set; get; }
        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get; set; }
        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }
        /// <summary>
        /// 物料编码
        /// </summary>
        public string MItemCode { get; set; }
        /// <summary>
        /// 物料名称
        /// </summary>
        public string MItemName { get; set; }


        public MaterialBurnInfoDetail() { }

        public MaterialBurnInfoDetail(Int32 burnId, String softName, string softCreator, String testMachine, String customer,
            String filename, String verifyCode, DateTime receiveDate, String updateContent, String softPath,
            String downloadDir, String remark, string createBy, DateTime createTime, string modifyBy,
            DateTime modifyTime,string ItemCode,string ItemName,string MItemCode,string MItemName)
        {
            this.BurnId = burnId;
            this.SoftName = softName;
            this.SoftCreator = softCreator;
            this.TestMachine = testMachine;
            this.Customer = customer;
            this.Filename = filename;
            this.VerifyCode = verifyCode;
            this.ReceiveDate = receiveDate;
            this.UpdateContent = updateContent;
            this.SoftPath = softPath;
            this.DownloadDir = downloadDir;
            this.Remark = remark;
            this.CreateByName = createBy;
            this.CreateTime = createTime;
            this.ModifyByName = modifyBy;
            this.ModifyTime = modifyTime;
            this.ItemCode = ItemCode;
            this.ItemName = ItemName;
            this.MItemCode = MItemCode;
            this.MItemName = MItemName;
        }
    }
}
