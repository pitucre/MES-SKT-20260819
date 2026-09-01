using System;
using System.Collections.Generic;
using System.Data;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.Http;
using WebAPI.Models.HWLicense;
using WebAPI.Ult;

namespace WebAPI.Dao
{
    public class HWLicenseDao
    {

        public HWAPIResult UpdateLicenseExpreTime(BaseLicenseInfo updateLicenseInfo)
        {
            HWAPIResult result = new HWAPIResult();
            try
            {
                DBHelper.Execute("uspUpdateLicenseExpreTime", new
                {
                    activity = updateLicenseInfo.activity,
                    expireTime = updateLicenseInfo.expireTime,
                    license = updateLicenseInfo.license,
                    orderId = updateLicenseInfo.orderId,
                    orderLineId = updateLicenseInfo.orderLineId,
                    productId = updateLicenseInfo.productId,
                    scene = updateLicenseInfo.scene,
                    testFlag = updateLicenseInfo.testFlag,
                }, null, CommandType.StoredProcedure);

                result.resultCode = "000000";
                result.resultMsg = "success.";
            }
            catch (Exception ex)
            {
                result.resultCode = "000005";
                result.resultMsg = ex.Message;
            }
            return result;
        }

        public HWAPIResult UpdateLicenseStatus(BaseLicenseInfo updateLicenseStatus)
        {
            HWAPIResult result = new HWAPIResult();
            try
            {
                DBHelper.Execute("uspUpdateLicenseStatus", new
                {
                    activity = updateLicenseStatus.activity,
                    license = updateLicenseStatus.license,
                    status = updateLicenseStatus.status,
                    testFlag = updateLicenseStatus.testFlag,
                }, null, CommandType.StoredProcedure);

                result.resultCode = "000000";
                result.resultMsg = "success.";
            }
            catch (Exception ex)
            {
                result.resultCode = "000005";
                result.resultMsg = ex.Message;
            }
            return result;

        }

        public HWAPIResult ReleaseLicense(BaseLicenseInfo releaseLicense)
        {
            HWAPIResult result = new HWAPIResult();
            try
            {
                DBHelper.Execute("uspReleaseLicense", new
                {
                    activity = releaseLicense.activity,
                    license = releaseLicense.license,
                    orderId = releaseLicense.orderId,
                    orderLineId = releaseLicense.orderLineId,
                    testFlag = releaseLicense.testFlag,
                }, null, CommandType.StoredProcedure); 

                result.resultCode = "000000";
                result.resultMsg = "success.";
            }
            catch (Exception ex)
            {
                result.resultCode = "000005";
                result.resultMsg = ex.Message;
            }
            return result;
        }
    }
}