using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ProductionCollection.Utility;

namespace SKT.LeanMES.ProductionCollection.Validation
{
    class PackingValidation
    {
        public  int ProcessValidate(ProductionCollectionInfo prodCollectionInfo)
        {
            //1、首先验证是否是合适的序列号，如果是的话则返回0。
            //3、如果不是，验证是否是可用包装箱号。
            int result = SNProcessValidation.Start(prodCollectionInfo);
            int resultCarton = 0;
            if (result == 0)//序列号
            {
                //判断SN是否已包装.
                return result = SNProcessValidation.uspSNPackIngPalletValidation(prodCollectionInfo);

            }
            else
            {   //验证是否是可用包装箱号。
                resultCarton = SNProcessValidation.PackingSNValidation(prodCollectionInfo);
            }

            if (resultCarton==502)//501为包装箱号未找到.
            {
                return result;
            }
            else
            {
                return resultCarton;
            }
            

        }
    }
}
