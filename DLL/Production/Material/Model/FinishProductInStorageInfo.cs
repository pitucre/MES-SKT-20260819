using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
   public class FinishProductInStorageInfo
    {
       private int id;
       private int uID;
       private int status;
       private string status_cn;
       private string modifyBy;
       private DateTime modifyDate;
       private string createBy;
       private DateTime createDate;
       private string sN;


       public FinishProductInStorageInfo()
       {
       }

       public FinishProductInStorageInfo(int id,int uID, string status_cn,string createBy,DateTime createDate,string sN)
       {
           this.id = id;
           this.uID = uID;
           this.status_cn = status_cn;
           this.createBy = createBy;
           this.createDate = createDate;
           this.sN = sN;
       }
       /// <summary>
       /// Id
       /// </summary>
       public int Id
       {
           set { this.id = value; }
           get { return this.id; }
       }

       /// <summary>
       /// UID
       /// </summary>
       public int UID
       {
           set { this.uID = value; }
           get { return this.uID; }
       }

       /// <summary>
       /// status字符串
       /// </summary>
       public string Status_cn
       {
           set { this.status_cn = value; }
           get { return this.status_cn; }
       }

       /// <summary>
       /// ModifyBy
       /// </summary>
       public string ModifyBy
       {
           set { this.modifyBy = value; }
           get { return this.modifyBy; }
       }
       /// <summary>
       /// ModifyDate
       /// </summary>
       public DateTime ModifyDate
       {
           set { this.modifyDate = value; }
           get { return this.modifyDate; }
       }


       /// <summary>
       /// CreateBy
       /// </summary>
       public string CreateBy
       {
           set { this.createBy = value; }
           get { return this.createBy; }
       }


       /// <summary>
       /// CreateDate
       /// </summary>
       public DateTime CreateDate
       {
           set { this.createDate = value; }
           get { return this.createDate; }
       }

       /// <summary>
       /// 产品序列号
       /// </summary>
       public string SN
       {
           set { this.sN = value; }
           get { return this.sN; }
       }

    }
}
