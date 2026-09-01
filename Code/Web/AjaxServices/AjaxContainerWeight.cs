using AjaxPro;
using SKT.Common.Account.BLL;
using SKT.Common.Account.Model;
using SKT.Common.Model;
using SKT.LeanMES.Container.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxContainerWeight
    {
        [AjaxMethod]
        public void EditContainerWeight(ContainerWeightInfo entity)
        {
            try
            {
                SKT.LeanMES.Container.BLL.ContainerWeight bllContainerWeight = new SKT.LeanMES.Container.BLL.ContainerWeight();

                if (entity.ContainerWeightId == -1)//add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else// update selected record
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";

                }
                bllContainerWeight.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        /// <summary>
        /// 获取包装想列表信息
        /// </summary>
        /// <param name="ContainerWeightId"></param>
        /// <returns></returns>
        [AjaxMethod]
        public ContainerWeightInfo GetContainerWeightById(int ContainerWeightId)
        {
            try
            {
                SKT.LeanMES.Container.BLL.ContainerWeight bllContainerWeight = new SKT.LeanMES.Container.BLL.ContainerWeight();

                ContainerWeightInfo Listentity = bllContainerWeight.GetInfo(ContainerWeightId);
                return Listentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 获取SN设置的重量范围
        /// </summary>
        /// <param name="scanSN"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<ContainerWeightInfo> GetSnWeightRange(string scanSN)
        {
            try
            {
                SKT.LeanMES.Container.BLL.ContainerWeight bllContainerWeight = new SKT.LeanMES.Container.BLL.ContainerWeight();

                List<ContainerWeightInfo> Listentity = bllContainerWeight.GetSN(scanSN);
                return Listentity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }


        /// <summary>
        /// SN重量验证
        /// </summary>
        /// <param name="scanSN"></param>
        /// <param name="weightValue"></param>
        /// <param name="Isflag"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string[] GetSNWeightVerification(string scanSN, string weightValue,int stationId, int Isflag)
        {
            string[] Listentity = new string[1];
            try
            {
               string userName=AccountController.GetCurrentUser().UserName;
                SKT.LeanMES.Container.BLL.ContainerWeight bllContainerWeight = new SKT.LeanMES.Container.BLL.ContainerWeight();

                Listentity = bllContainerWeight.GetWeighBySN(scanSN, weightValue, stationId, userName, Isflag);
               
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return Listentity;
        }

        [AjaxMethod]
        public void GetWeightByPacking(string scanSN, string weightValue)
        {

            try
            {
                string userName = AccountController.GetCurrentUser().UserName;
                SKT.LeanMES.Container.BLL.ContainerWeight bllContainerWeight = new SKT.LeanMES.Container.BLL.ContainerWeight();

                bllContainerWeight.WeightByPacking(scanSN, weightValue, userName);

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        [AjaxMethod]
        public void updateEquipment(string selComList)
        {
            try
            {

                string xmlPath = HttpContext.Current.Server.MapPath("~/Content/XmlFile/ElectronicCallSet.xml");
                XmlDocument doc = new XmlDocument();
                doc.Load(xmlPath);
                XmlNode root = doc.DocumentElement;
                XmlNode Com = root.SelectSingleNode("PortName");
                Com.InnerText = selComList;
                doc.Save(xmlPath);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

        }

        [AjaxMethod]
        public DynamicClass loadElectronicCallSetXML() {
            DynamicClass entity = new DynamicClass();
            try
            {
                string xmlPath = HttpContext.Current.Server.MapPath("~/Content/XmlFile/ElectronicCallSet.xml");
                XmlNode node = LeanMES.Web.Utility.XmlHelper.GetXmlNodeByXpath(xmlPath, "//root");                     
                entity.PortName = node.SelectSingleNode("PortName").InnerText;
                entity.BoundRate = node.SelectSingleNode("BoundRate").InnerText;
                    
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        #region 称重管理
        /// <summary>
        /// 检验扫描条码的重量范围
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="weight"></param>
        /// <param name="stationId"></param>
        [AjaxMethod]
        public void CheckSNWeight(string sn, decimal weight, int stationId,int resouceId,int weightType)
        {
            SKT.LeanMES.Container.BLL.ContainerWeight bllContainerWeight = new SKT.LeanMES.Container.BLL.ContainerWeight();
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            try
            {
                bllContainerWeight.CheckSNWeight(sn, weight, stationId,resouceId, userName, userId,weightType);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 产品称重不在标准范围时强制过站
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="weight"></param>
        /// <param name="stationId"></param>
        /// <param name="resouceId"></param>
        /// <param name="userName"></param>
        /// <param name="userId"></param>
        /// <param name="byPassUserName"></param>
        [AjaxMethod]
        public void ByPassSNWeight(string sn, decimal weight, int stationId, int resouceId, string byPassUserName,string password)
        {
            Users bll = new Users();
            SKT.LeanMES.Container.BLL.ContainerWeight bllContainerWeight = new SKT.LeanMES.Container.BLL.ContainerWeight();

            int byPassUserId = 0;
            string userName = AccountController.GetCurrentUser().UserName;
            int userId = AccountController.GetCurrentUser().UserId;
            
            try
            {
                #region 验证用户是否有强制称重过站权限

                MembershipInfo entity = bll.GetByName(byPassUserName);
                if (entity == null)
                {
                    throw new Exception("无效的用户[" + byPassUserName + "]！");
                }
                byPassUserId = entity.UserId;

                LoginResult result = bll.ValidatePassword(byPassUserId, SKT.Common.Utility.EncryptHelper.Encrypt(password));

                if (!(result == LoginResult.Success))
                {
                    throw new Exception("用户[" + byPassUserName + "]登录失败，请确认密码是否正确且用户是否正常使用状态！");
                }
                else if (!Users.CheckUserIsWarrantted(byPassUserId, 80010003))
                {
                    throw new Exception("用户[" + byPassUserName + "]没有强制过站的权限！");
                }

                #endregion
                
                bllContainerWeight.ByPassSNWeight(sn, weight, stationId, resouceId, userName, userId,byPassUserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
            #endregion
        }


    public class DynamicClass
    {
        public string PortName { get; set; }
        public string BoundRate { get; set; }
    }


    

}