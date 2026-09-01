using AjaxPro;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// 飞达绑定grn
    /// </summary>
    public class AjaxFeedBindMaterial
    {
        [AjaxMethod]
        public void Save(string feeder, string materialid)
        {
            try
            {
                var userName = AccountController.GetCurrentUser().UserName;
                new Feeder().FeederBindMaterial(feeder, materialid, userName);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 换绑飞达
        /// </summary>
        /// <param name="feeder"></param>
        /// <param name="newfeeder"></param>
        [AjaxMethod]
        public void ChangeBindSave(string feeder, string newfeeder,string bindType)
        {
            try
            {
                var userName = AccountController.GetCurrentUser().UserName;
                new Feeder().ChangeBindSave(feeder, newfeeder, userName, bindType=="1"?1:2);
            }
            catch (Exception)
            {

                throw;
            }
        }
        [AjaxMethod]
        public List<LoadinglistInfo> GetInfo()
        {
            try
            {
                return new Feeder().GetFeederAndMaterial();
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 飞达换绑日志
        /// </summary>
        /// <param name="feeder"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<FeederChangeLog> GetFeederLog(string feeder)
        {
            try
            {
                return new Feeder().GetFeederLog(feeder);
            }
            catch (Exception)
            {

                throw;
            }
        }
        /// <summary>
        /// 飞达是否绑定grn
        /// </summary>
        /// <param name="feeder"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool IsBindMarterial(string feeder)
        {
            var list= new Feeder().GetFeederAndMaterial();
            return list.Any(x => x.FeedStr == feeder);
        }
        /// <summary>
        /// 飞达是否存在
        /// </summary>
        /// <param name="feeder"></param>
        /// <returns></returns>
        [AjaxMethod]
        public bool IsFeeder(string feeder)
        {
            var entity = new Feeder().GetInfo(feeder);
            return entity != null;
        }
        /// <summary>
        /// 飞达是否使用中
        /// </summary>
        /// <param name="feeder"></param>
        /// <returns></returns>
        [AjaxMethod]
        public void IsFeederToUse(string feeder)
        {

            try
            {
                new Feeder().IsFeederToUse(feeder);

            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}