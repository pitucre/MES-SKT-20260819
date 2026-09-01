using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// Summary description for AjaxServiceMachine
    /// </summary>
    public class AjaxServiceFeeder
    {
        /// <summary>
        ///增加feedergroup信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void AddFeederGroup(FeederGroupInfo entity)
        {
            try
            {
                FeederGroup bllFeederGroup = new FeederGroup();
                bllFeederGroup.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        ///增加feedertype信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void AddFeederType(FeederTypeInfo entity)
        {
            try
            {
                if (entity.ID == -1)
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = "";
                }
                else
                {
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = "";
                }
                FeederType bllFeederType = new FeederType();
                bllFeederType.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        ///增加feedertype信息
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void AddFeeder(FeederInfo entity)
        {
            try
            {
                Feeder bllFeeder = new Feeder();
                entity.UserID = AccountController.GetCurrentUser().UserId;
                bllFeeder.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 增加Feeder信息
        /// </summary>
        /// <param name="feederXml"></param>
        [AjaxMethod]
        public void UserImport(string feederXml)
        {
            var userId = AccountController.GetCurrentUser().UserId;
            SqlParameter[] parms = new SqlParameter[]{
                            new SqlParameter("@UserID", SqlDbType.Int,4),
                            new SqlParameter("@FeederXml", SqlDbType.NVarChar)
                            };

            try
            {
                parms[0].Value = userId;
                parms[1].Value = feederXml;

                SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, "uspImportFeeder", parms);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}