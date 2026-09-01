using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using System.Xml;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxPlugins
    {
        [AjaxMethod]
        public List<PluginModel> GetPluginList()
        {
            List<PluginModel> list = new List<PluginModel>();
            PluginModel entity = null;
            if (AccountController.GetCurrentUser(true) == null)
            {
                throw new Exception("timeout");
            }
            else
            {
                try
                {
                    string xmlPath = HttpContext.Current.Server.MapPath("~/Content/Component/PluginInfo.xml");
                    XmlNodeList nodeList = LeanMES.Web.Utility.XmlHelper.GetXmlNodeListByXpath(xmlPath, "//plugins//plugin");

                    foreach (XmlNode node in nodeList)
                    {
                        entity = new PluginModel();
                        entity.PlnId = Convert.ToInt32(node.Attributes["plnId"].Value);
                        entity.PlnName = node.SelectSingleNode("name").InnerText;
                        entity.Ext = node.SelectSingleNode("ext").InnerText;
                        entity.Ver = node.SelectSingleNode("version").InnerText;
                        entity.PlnPath = node.SelectSingleNode("plnpath").InnerText;
                        entity.PublishDate = node.SelectSingleNode("publishdate").InnerText;
                        entity.UpdateDate = node.SelectSingleNode("updatedate").InnerText;
                        entity.UpdateLog = node.SelectSingleNode("updatelog").InnerText;
                        entity.Description = node.SelectSingleNode("description").InnerText;

                        list.Add(entity);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
            }

            return list;
        }

        [AjaxMethod]
        public PluginModel GetPluginById(Int32 plnId)
        {
            PluginModel entity = null;
            if (AccountController.GetCurrentUser(true) == null)
            {
                throw new Exception("timeout");
            }
            else
            {
                try
                {
                    string xmlPath = HttpContext.Current.Server.MapPath("~/Content/Component/PluginInfo.xml");
                    XmlNodeList nodeList = LeanMES.Web.Utility.XmlHelper.GetXmlNodeListByXpath(xmlPath, "//plugins//plugin");
                    XmlNode node = LeanMES.Web.Utility.XmlHelper.GetXmlNodeByXpath(xmlPath, "//plugins//plugin [@plnId='" + plnId + "']");

                    entity = new PluginModel();
                    entity.PlnId = Convert.ToInt32(node.Attributes["plnId"].Value);
                    entity.PlnName = node.SelectSingleNode("name").InnerText;
                    entity.Ext = node.SelectSingleNode("ext").InnerText;
                    entity.Ver = node.SelectSingleNode("version").InnerText;
                    entity.PlnPath = node.SelectSingleNode("plnpath").InnerText;
                    entity.PublishDate = node.SelectSingleNode("publishdate").InnerText;
                    entity.UpdateDate = node.SelectSingleNode("updatedate").InnerText;
                    entity.UpdateLog = node.SelectSingleNode("updatelog").InnerText;
                    entity.Description = node.SelectSingleNode("description").InnerText;
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
            }

            return entity;
        }
    }

    #region 插件信息实体类
    [Serializable]
    public class PluginModel
    {
        private int plnId;
        private string plnName;
        private string ext;
        private string plnPath;
        private string ver;
        private string publishDate;
        private string updateDate;
        private string updateLog;
        private string description;

        public Int32 PlnId
        {
            get { return this.plnId; }
            set { this.plnId = value; }
        }

        public String PlnName
        {
            get { return this.plnName; }
            set { this.plnName = value; }
        }

        public String Ext
        {
            get { return this.ext; }
            set { this.ext = value; }
        }

        public String PlnPath
        {
            get { return this.plnPath; }
            set { this.plnPath = value; }
        }

        public String Ver
        {
            get { return this.ver; }
            set { this.ver = value; }
        }

        public String PublishDate
        {
            get { return this.publishDate; }
            set { this.publishDate = value; }
        }

        public String UpdateDate
        {
            get { return this.updateDate; }
            set { this.updateDate = value; }
        }

        public String UpdateLog
        {
            get { return this.updateLog; }
            set { this.updateLog = value; }
        }

        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }
    }
    #endregion
}