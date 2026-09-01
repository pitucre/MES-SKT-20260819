using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ProductionCollection.Utility;

namespace SKT.LeanMES.ProductionCollection.Validation
{   ////Beck Ye 2016.09.18
    class PalletValidation
    {
        public  int ProcessValidate(ProductionCollectionInfo prodCollectionInfo)
        {
            //1、首先验证是否是合适的包装箱号，如果是的话则返回503:包装箱已关闭。
            //2、如果不是，验证是否是可用栈板号
            int result = SNProcessValidation.PackingSNValidation(prodCollectionInfo);
            if (result == 502)
            {
                result = SNProcessValidation.PalletSNValidation(prodCollectionInfo);
                if (result == 602)
                {
                    result = 502;
                }

            }
            if (result == 503) //可以成栈板的包装箱号
            {
                result = 0;
            }
            return result;

        }
    }
}
