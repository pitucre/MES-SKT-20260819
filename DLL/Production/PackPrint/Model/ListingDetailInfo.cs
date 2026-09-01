using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;



namespace SKT.LeanMES.PackPrint.Model
{
   public class ListingDetailInfo
    {
        private Int32 listingDetailId;
        private Int32 itemId;
        private Int32 listingFieldId;
        private string fieldValue;
        private Int32 fieldType;
        private string fileldValueFormula;
        private string createBy;
        private DateTime createDateTime;
        private string modifyBy;
        private DateTime modifyDateTime;
        private string remark;



       public ListingDetailInfo()
       {
       }

       public ListingDetailInfo(Int32 listingDetailId, Int32 itemId, Int32 listingFieldId,  string fieldValue,  Int32 fieldType,string fileldValueFormula,  string createBy, DateTime createDateTime, string modifyBy, DateTime modifyDateTime, string remark)
        {
            this.listingFieldId = listingFieldId;
            this.fieldType = fieldType;
            this.fieldValue = fieldValue;
            this.fileldValueFormula = fileldValueFormula;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;          
      }


        public Int32 ListingDetailId
        {
            get { return listingDetailId; }
            set { listingDetailId = value; }
        }

        public Int32 ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }

        public Int32 ListingFieldId
        {
            get { return listingFieldId; }
            set { listingFieldId = value; }
        }

        public string FieldValue
        {
            get { return fieldValue; }
            set { fieldValue = value; }
        }
        public Int32 FieldType
        {
            get { return fieldType; }
            set { fieldType = value; }
        }
 
        public string FileldValueFormula
        {
            get { return fileldValueFormula; }
            set { fileldValueFormula = value; }
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

        public  DateTime ModifyDateTime
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
    }
}
