using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.SPC
{
    public partial class XBar_RGraph : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSPC));
            //var temp = NormDistFunc(3);
            //var tp = NormDistributionQuantile(3);
        }
        /// <summary>
        /// 标准正态分布函数Phi(x)
        /// </summary>
        /// <param name="x">随机变量</param>
        /// <returns>标准正态分布概率</returns>
        static double NormDistFunc(double x)
        {
            double x0 = (x >= 0 ? x : -x);
            double[] b = { 0.196854, 0.115194, 0.000344, 0.019527 };
            double erf = 0;
            for (int i = 1; i <= 4; i++)
            {
                erf += b[i - 1] * Math.Pow(x0, i);
            }
            erf = 1 - Math.Pow(1.0 + erf, -4);
            double phi = (x >= 0 ? 0.5 * (1 + erf) : 0.5 * (1 - erf));
            return phi;
        }
        /// <summary>
        /// 标准正态分布函数分位数函数
        /// </summary>
        /// <param name="p">概率</param>
        /// <returns>分位数</returns>
        static double NormDistributionQuantile(double p)
        {
            System.Diagnostics.Debug.Assert((0 < p) && (p < 1));
            if (p == 0.5)
                return 0;
            double[] b ={0.1570796288E1,   0.3706987906E-1,
              -0.8364353589E-3, -0.2250947176E-3,
                0.6841218299E-5,  0.5824238515E-5,
              -0.1045274970E-5,  0.8360937017E-7,
              -0.3231081277E-8,  0.3657763036E-10,
                0.6936233982E-12};
            double alpha = 0;
            if ((0 < p) && (p < 0.5))
                alpha = p;
            else if ((0.5 < p) && (p < 1))
                alpha = 1 - p;
            double y = -Math.Log(4 * alpha * (1 - alpha));
            double u = 0;
#if USE_TODA_FORMULA
              //Toda近似公式，最大误差1.2e-8
              for (int i = 0; i < b.Length; i++)
              {
                u += b[i] * Math.Pow(y, i);
              }
              u = Math.Sqrt(y * u);
#else
            //山内近似公式，最大误差4.9e-4
            u = Math.Sqrt(y * (2.0611786 - 5.7262204 / (y + 11.640595)));
#endif
            double up = 0;
            if ((0 < p) && (p < 0.5))
                up = -u;
            else if ((0.5 < p) && (p < 1))
                up = u;
            return up;
        }
        /// <summary>
        /// 标准正态分布概率密度函数
        /// </summary>
        /// <param name="x">随机变量</param>
        /// <returns>概率密度</returns>
        static double NormDensityFunc(double x)
        {
            return Math.Exp(-x * x * 0.5) / Math.Sqrt(2 * Math.PI);
        }

   
    }
}