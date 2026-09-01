using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Kanban.Model
{
   public class ProdEfficiencyKanbanInfo
    {
       
       private int itemId;
       private string itemCode;
       private string itemName;

       private int lineId;
       private string lineName;

       private int putNum;
       private int yieldNum;
       private string productRate;

       public ProdEfficiencyKanbanInfo()
       {
       }
 

       public ProdEfficiencyKanbanInfo(int itemId, string itemCode, string itemName, int lineId, string lineName, int putNum, int yieldNum, string productRate)
       {
           this.itemId = itemId;
           this.itemCode = itemCode;
           this.itemName = itemName;
           this.lineId = lineId;
           this.lineName = lineName;
           this.putNum = putNum;
           this.yieldNum = yieldNum;
           this.productRate = productRate;
       }

  
       /// <summary>
       /// ItemId
       /// </summary>
       public int ItemId
       {
           get { return this.itemId; }
           set { this.itemId = value; }
       }

       /// <summary>
       /// ItemCode
       /// </summary>
       public string ItemCode
       {
           get { return this.itemCode; }
           set { this.itemCode = value; }
       }

       /// <summary>
       /// ItemCode
       /// </summary>
       public string ItemName
       {
           get { return this.itemName; }
           set { this.itemName = value; }
       }

       /// <summary>
       /// LineId
       /// </summary>
       public int LineId
       {
           get { return this.lineId; }
           set { this.lineId = value; }
       }

       /// <summary>
       /// LineName
       /// </summary>
       public string LineName
       {
           get { return this.lineName; }
           set { this.lineName = value; }
       }

       /// <summary>
       /// PutNum
       /// </summary>
       public int PutNum
       {
           get { return this.putNum; }
           set { this.putNum = value; }
       }

       /// <summary>
       /// yieldNum
       /// </summary>
       public int YieldNum
       {
           get { return this.yieldNum; }
           set { this.yieldNum = value; }
       }


       /// <summary>
       /// LineName
       /// </summary>
       public string ProductRate
       {
           get { return this.productRate; }
           set { this.productRate = value; }
       }

    }
}
