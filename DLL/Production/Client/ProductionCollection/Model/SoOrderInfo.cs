using System;
 

namespace SKT.LeanMES.ProductionCollection.Model
{
    /// 走货单号
    /// </summary>
    public class SoOrderInfo
    {
        private int id;
        private string code;

        public Int32 ID
        {
            get { return this.id; }
            set { this.id = value; }
        }

        public String Code
        {
            get { return this.code; }
            set { this.code = value; }
        }
    }
}
