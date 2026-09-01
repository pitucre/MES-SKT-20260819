
using Newtonsoft.Json;
using Swashbuckle.Swagger.Annotations;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;
using WebAPI.Dal;
using WebAPI.Models;
using WebAPI.Ult;

namespace WebAPI.Controllers
{
    /// <summary>
    /// 瑞微电子料架
    /// </summary>
    public class ElectricLoctionController : ApiController
    {

        /// <summary>
        /// 上架回调
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        [Route("ElectricLoction/MaterialOnlinePostback")]
        public ElectricLoctionResponse MaterialOnlinePostback([FromBody]ElectricLoctionRequest  param)
        {            

            ElectricLoctionResponse result = new ElectricLoctionResponse();
            result.status = 0;
            result.msg = "OK";
            try
            {
                new ElectricLoction().MaterialOnlinePostback(param.position_info, param.shelf_id, param.reel_id);

                return result;
            }
            catch (Exception ex)
            {
                result.status = 1;
                result.msg = ex.Message;
                WriteTextLog("瑞微上架回调",ex.Message);
            }

            return result;
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        [Route("ElectricLoction/MaterialTakeOut")]
        public ElectricLoctionResponse MaterialTakeOut([FromBody]ElectricLoctionRequest param)
        {

            ElectricLoctionResponse result = new ElectricLoctionResponse();
            result.status = 0;
            result.msg = "OK";
            try
            {
                new ElectricLoction().MaterialTake(param.reel_id);

                return result;
            }
            catch (Exception ex)
            {
                result.status = 1;
                result.msg = ex.Message;
                WriteTextLog("瑞微下架回调", ex.Message);
            }
            return result;
        }        


        private void WriteTextLog(string action, string strMessage)
        {
            DateTime time = DateTime.Now;
            string path = AppDomain.CurrentDomain.BaseDirectory + @"\Log\";
            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);

            string fileFullPath = path + time.ToString("yyyy-MM-dd") + ".txt";
            StringBuilder str = new StringBuilder();
            str.Append("Time:    " + time.ToString() + "\r\n");
            str.Append("Action:  " + action + "\r\n");
            str.Append("Message: " + strMessage + "\r\n");
            str.Append("-----------------------------------------------------------\r\n\r\n");
            StreamWriter sw;
            if (!File.Exists(fileFullPath))
            {
                sw = File.CreateText(fileFullPath);
            }
            else
            {
                sw = File.AppendText(fileFullPath);
            }
            sw.WriteLine(str.ToString());
            sw.Close();
        }
    }
}
