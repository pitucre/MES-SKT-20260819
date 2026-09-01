using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.PackPrint.Model
{
   public class PackingDetailInfo
    {
       private int itemId;
       private string partName;
       private string sN;
       private int sequence;


       public PackingDetailInfo()
       {
       }

       public PackingDetailInfo(int itemId,string partName,string sN,int sequence)
       {
           this.itemId = itemId;
           this.partName = partName;
           this.sN = sN;
           this.sequence = sequence;
       }

       public int ItemId
       {
           set { this.itemId = value; }
           get { return this.itemId; }
       }
       public string PartName
       {
           set { this.partName = value; }
           get {return this.partName;}
       }
       public string SN
       {
           set { this.sN = SN; }
           get { return this.sN; }
       }
       public int Sequence
       {
           set { this.sequence=value;}
           get { return this.sequence; }
       }

    }
}
