using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using WebAPI.Code.Attributes;
using WebAPI.Dao;
using WebAPI.Models.HWLicense;

namespace WebAPI.Controllers
{
    public class HWLicenseController : ApiController
    {
        [Route("HWLicenseOperate")]
        [HttpPost]
        public HWAPIResult HWLicenseOperate([FromBody] BaseLicenseInfo baseInfo)
        {
            if(baseInfo.activity == "refreshLicenseCode")
            {
                return UpdateLicenseExpreTime(baseInfo);
            }
            else if (baseInfo.activity == "updateLicenseCodeStatus")
            {
                return UpdateLicenseStatus(baseInfo);
            }
            else if (baseInfo.activity == "releaseLicenseCode")
            {
                return ReleaseLicense(baseInfo);
            }
            return new HWAPIResult() { resultCode = "000002", resultMsg = "接口请求标识错误" };
        }

        /// <summary>
        /// 更新授权码有效期
        /// </summary>       
        public HWAPIResult UpdateLicenseExpreTime(BaseLicenseInfo updateLicenseInfo)
        {
            HWLicenseDao dao = new HWLicenseDao();
            return dao.UpdateLicenseExpreTime(updateLicenseInfo);
        }

        /// <summary>
        /// 变更授权码状态
        /// </summary>     
        public HWAPIResult UpdateLicenseStatus(BaseLicenseInfo updateLicenseStatus)
        {
            HWLicenseDao dao = new HWLicenseDao();
            return dao.UpdateLicenseStatus(updateLicenseStatus);
        }

        /// <summary>
        /// 变更授权码状态
        /// </summary>
        public HWAPIResult ReleaseLicense(BaseLicenseInfo releaseLicense)
        {
            HWLicenseDao dao = new HWLicenseDao();
            return dao.ReleaseLicense(releaseLicense);
        }
    }
}