using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.ESOP.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using System.Xml;
using System.IO;

namespace SKT.LeanMES.ESOP.BLL
{
   public class FtpServerConfig
    {
       // /// <summary>
       // /// 编辑（添加或更新） EmailServerConfig 信息。
       // /// </summary>
       // /// <param name="entity">EmailServerConfig 实体对象。</param>
       // public void Edit(FtpServerConfigInfo entity)
       // {
       //    ////写入xml文件 
       //    // XmlDocument xmlDoc = new XmlDocument();
       //    // xmlDoc.Load(System.Web.HttpContext.Current.Server.MapPath("../ESOP/") + "ESOPConfig.xml"); 
       //    // XmlNode root = xmlDoc.SelectSingleNode("ESOP");
       //     try
       //     {
       //         XmlDocument xmldoc = new XmlDocument(); //创建空的XML文档 
       //         //加入XML的声明段落 
       //         XmlNode xmlnode = xmldoc.CreateXmlDeclaration("1.0", "gb2312", null);
       //         xmldoc.AppendChild(xmlnode);

       //         //加入一个根元素 
       //         XmlElement xmlelem = xmldoc.CreateElement("", "ESOP", "");
       //         xmldoc.AppendChild(xmlelem);

       //         //加入一个子元素 
       //         XmlElement xmlelem1 = xmldoc.CreateElement("", "FtpServerName", "");
       //         xmlelem1.InnerText = entity.FtpServerName;
       //         xmlelem.AppendChild(xmlelem1);

       //         XmlElement xmlelem2 = xmldoc.CreateElement("", "UserName", "");
       //         xmlelem2.InnerText = entity.UserName;
       //         xmlelem.AppendChild(xmlelem2);

       //         XmlElement xmlelem3 = xmldoc.CreateElement("", "PWD", "");
       //         xmlelem3.InnerText = entity.PWD;
       //         xmlelem.AppendChild(xmlelem3);

       //         XmlElement xmlelem4 = xmldoc.CreateElement("", "FtpStoreLocation", "");
       //         xmlelem4.InnerText = entity.FtpStoreLocation;
       //         xmlelem.AppendChild(xmlelem4);

       //         string fileName = System.Web.HttpContext.Current.Server.MapPath("../ESOP/") + "ESOPConfig.xml";
       //         if (!File.Exists(fileName))
       //         {
       //             File.Create(fileName);
       //         }

       //         xmldoc.Save(fileName); //保存 
       //     }catch(Exception ex)
       //     {
       //         throw ex;
       //     }

       // }

       ///// <summary>
       ///// 
       ///// </summary>
       //public FtpServerConfigInfo GetInfo()
       // {
       //     try
       //     {
       //         XmlDocument xmlDoc = new XmlDocument();
       //         FtpServerConfigInfo ftpInfo = new FtpServerConfigInfo();

       //         xmlDoc = new XmlDocument();
       //         xmlDoc.Load(System.Web.HttpContext.Current.Server.MapPath("./") + "ESOPConfig.xml"); //加载xml文件
       //         XmlNode xn = xmlDoc.SelectSingleNode("ESOP");

       //         ftpInfo.FtpServerName = xn.SelectSingleNode("FtpServerName").InnerText;
       //         ftpInfo.UserName = xn.SelectSingleNode("UserName").InnerText;
       //         ftpInfo.PWD = xn.SelectSingleNode("PWD").InnerText;
       //         ftpInfo.FtpStoreLocation = xn.SelectSingleNode("FtpStoreLocation").InnerText;

       //         return ftpInfo;
       //     }catch(Exception ex)
       //     {
       //         return null;
       //         throw ex;
       //     }
       // }

       /// <summary>
       /// 保存到数据库
       /// </summary>
       /// <param name="entity"></param>
       public void Edit(FtpServerConfigInfo entity)
       {
           SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FtpServer", SqlDbType.VarChar,50),
                new SqlParameter("@UserName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Pwd", SqlDbType.VarChar, 50),
                new SqlParameter("@Dir",SqlDbType.NVarChar,50)

              };

           parms[0].Value = entity.FtpServerName;
           parms[1].Value = entity.UserName;
           parms[2].Value = entity.PWD;
           parms[3].Value = entity.FtpStoreLocation;

           SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "[Prod_ESOPFtpConfig_Edit]", parms);
       }


       /// <summary>
       /// 获取ESOP FTP之配置信息
       /// </summary>
       /// <returns></returns>
       public FtpServerConfigInfo GetInfo()
       {
           FtpServerConfigInfo entity = new FtpServerConfigInfo();

           using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "[Prod_ESOPFtpConfig_getInfo]", null))
           {
               if (rdr.Read())
               {
                   entity.FtpServerName = rdr.GetString(1);
                   entity.UserName = rdr.GetString(2);
                   entity.PWD = rdr.GetString(3);
                   entity.FtpStoreLocation = rdr.GetString(4);
               }
               rdr.Close();
           }

           return entity;
       }

    }
}
