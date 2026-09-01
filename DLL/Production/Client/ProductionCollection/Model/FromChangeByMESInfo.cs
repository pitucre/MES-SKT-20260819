using System;

namespace SKT.LeanMES.ProductionCollection.Model
{
    public class FromChangeByMESInfo
    {
        /// <summary>
        /// ConvertedMaterial
        /// </summary>
        public string ConvertedMaterial { get; set; }

        /// <summary>
        /// FromChangeByMESNo
        /// </summary>
        public string FromChangeByMESNo { get; set; }

        /// <summary>
        /// CWhName
        /// </summary>
        public string CWhName { get; set; }

        /// <summary>
        /// CreateDateTime
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// CreateBy
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// CWhCode
        /// </summary>
        public string CWhCode { get; set; }

        /// <summary>
        /// FromChangeByMESDtId
        /// </summary>
        public int FromChangeByMESDtId { get; set; }

        /// <summary>
        /// PreConversionMaterial
        /// </summary>
        public string PreConversionMaterial { get; set; }

        /// <summary>
        /// StauesName
        /// </summary>
        public string StauesName { get; set; }

        /// <summary>
        /// cBarCode
        /// </summary>
        public string cBarCode { get; set; }

        /// <summary>
        /// ConvertedQty
        /// </summary>
        public decimal? ConvertedQty { get; set; }

        public string ERPNo {  get; set; }
    }
}
