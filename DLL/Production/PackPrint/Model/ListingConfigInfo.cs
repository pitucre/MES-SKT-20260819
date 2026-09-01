using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.PackPrint.Model
{
    public class ListingConfigInfo
    {
        private Int32 listingFieldId;
        private Int32 listingTypeId;
        private string fieldName;
        private Int32 fieldType;
        private string fieldValue;
        private string fileldValueFormula;
        private int sequence;
        private string createBy;
        private DateTime createDateTime;
        private string modifyBy;
        private DateTime modifyDateTime;
        private string remark;
        private string detailFieldValue;
        private Int32 detailFieldType;
        private Int32 listingDetailId;





        public ListingConfigInfo()
        {
        }


        public ListingConfigInfo(Int32 listingFieldId, Int32 listingTypeId, string fieldName, Int32 fieldType, string fieldValue, string fileldValueFormula, int sequence, string createBy, DateTime createDateTime, string modifyBy, DateTime modifyDateTime, string remark, string detailFieldValue, Int32 detailFieldType,Int32 listingDetailId)
        {
            this.listingFieldId = listingFieldId;
            this.listingTypeId = listingTypeId;
            this.fieldName = fieldName;
            this.fieldType = fieldType;
            this.fieldValue = fieldValue;
            this.fileldValueFormula = fileldValueFormula;
            this.sequence = sequence;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.detailFieldValue = detailFieldValue;
            this.detailFieldType = detailFieldType;
            this.listingDetailId = listingDetailId;
            
        }


        public Int32 ListingFieldId
        {
            get { return listingFieldId; }
            set { listingFieldId = value; }
        }

        public Int32 ListingTypeId
        {
            get { return listingTypeId; }
            set { listingTypeId = value; }
        }

        public string FieldName
        {
            get { return fieldName; }
            set { fieldName = value; }
        }

        public Int32 FieldType
        {
            get { return fieldType; }
            set { fieldType = value; }
        }

        public string FieldValue
        {
            get { return fieldValue; }
            set { fieldValue = value; }
        }

        public string FileldValueFormula
        {
            get { return fileldValueFormula; }
            set { fileldValueFormula = value; }
        }

        public int Sequence
        {
            get { return sequence; }
            set { sequence = value; }
        }

        public DateTime CreateDateTime
        {
            get { return createDateTime; }
            set { createDateTime = value; }
        }

       public string CreateBy
        {
            get { return createBy; }
            set { createBy = value; }
        }

        public DateTime ModifyDateTime
        {
            get { return modifyDateTime; }
            set { modifyDateTime = value; }
        }


        public string ModifyBy
        {
            get { return modifyBy; }
            set { modifyBy = value; }
        }

        public string Remark
        {
            get { return remark; }
            set { remark = value; }
        }

        public string DetailFieldValue
        {
            get { return detailFieldValue; }
            set { detailFieldValue = value; }
        }

        public Int32 DetailFieldType
        {
            get { return detailFieldType; }
            set { detailFieldType = value; }
        }

        public Int32 ListingDetailId
        {
            get { return listingDetailId;}
            set { listingDetailId = value; }
        }

    }
}
