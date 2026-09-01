using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.Common.Model;
using System.Xml;
using System.IO;
using System.Collections;

namespace SKT.LeanMES.Web.Utility
{
    public class ErrorHelper
    {
        public List<ErrorModel> GetAllError(string BegTime, string EndTime)
        {
            List<ErrorModel> list = new List<ErrorModel>();
            ErrorModel entity = null;

            string StartTime = DateTime.Parse(BegTime).ToString("yyyy-MM");
            DateTime d1 = DateTime.Parse(StartTime);
            DateTime d2 = DateTime.Parse(EndTime);
            for (DateTime dt = d1; dt <= d2; dt = dt.AddMonths(1))
            {
                string errorFilePath = HttpContext.Current.Server.MapPath("~/Logs/" + (dt.Year.ToString() + dt.Month.ToString().PadLeft(2, '0')) + ".xml");
                if (File.Exists(errorFilePath))
                {
                    //throw new Exception("选定日期没有错误日志文件。");
                    XmlNodeList nodeList = SKT.LeanMES.Web.Utility.XmlHelper.GetXmlNodeListByXpath(errorFilePath, "//exceptions//exception");
                    foreach (XmlNode node in nodeList)
                    {
                        if (DateTime.Parse(node.SelectSingleNode("time").InnerText) >= DateTime.Parse(BegTime) && DateTime.Parse(node.SelectSingleNode("time").InnerText) <= DateTime.Parse(EndTime))
                        {
                            entity = new ErrorModel();
                            entity.OperateUser = node.SelectSingleNode("user").InnerText;
                            entity.OccurTime = node.SelectSingleNode("time").InnerText;
                            entity.ErrorMessage = node.SelectSingleNode("message").InnerText;
                            entity.ErrorStackTrace = node.SelectSingleNode("stackTrace").InnerText;

                            list.Add(entity);
                        }
                    }
                }
                
            }

            return list.OrderByDescending(p=>p.OccurTime).ToList();
        }

        public ErrorModel GetErrorDetail(string yearMonth, string occrTime)
        {
            ErrorModel entity = null;
            string errorFilePath = HttpContext.Current.Server.MapPath("~/Logs/" + yearMonth + ".xml");
            if (!File.Exists(errorFilePath))
            {
                throw new Exception("选定日期没有错误日志文件。");
            }
            XmlNodeList nodeList = SKT.LeanMES.Web.Utility.XmlHelper.GetXmlNodeListByXpath(errorFilePath, "//exceptions//exception");
            foreach (XmlNode node in nodeList)
            {
                if (node.SelectSingleNode("time").InnerText == occrTime)
                {
                    entity = new ErrorModel();
                    entity.OperateUser = node.SelectSingleNode("user").InnerText;
                    entity.OccurTime = node.SelectSingleNode("time").InnerText;
                    entity.ErrorMessage = node.SelectSingleNode("message").InnerText;
                    entity.ErrorStackTrace = node.SelectSingleNode("stackTrace").InnerText;
                    break;
                }
            }

            return entity;
        }
    }
}