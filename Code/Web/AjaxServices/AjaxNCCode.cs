using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.NCCode.Model;
using SKT.LeanMES.NCCode.BLL;
using SKT.Common.Model;
using System.Data.SqlClient;
using System.Data;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxNCCode
    {
        /// <summary>
        /// 更新或者增加不良代码信息
        /// </summary>
        /// <param name="entity">不良代码实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void EditNCCode(SKT.LeanMES.NCCode.Model.NCCodeInfo entity)
        {
            try
            {
                new SKT.LeanMES.NCCode.BLL.NCCode().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 更新或者增加不良代码组信息
        /// </summary>
        /// <param name="entity">不良代码组实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void EditNCGroup(SKT.LeanMES.NCCode.Model.NCGroupInfo entity, string ncodeStr, string operationStr)
        {
            try
            {
                new SKT.LeanMES.NCCode.BLL.NCGroup().Edit(entity, ncodeStr, operationStr);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 验证id是否存在
        /// </summary>
        /// <param name="entity">不良代码实体类</param>
        /// <returns>1 存在 0 不存在</returns>
        [AjaxMethod]
        public int isAvail(int id)
        {
            try
            {
                SKT.LeanMES.NCCode.BLL.NCCode code = new LeanMES.NCCode.BLL.NCCode();
                NCCodeInfo model = code.GetInfo(id);
                if (model == null)
                {
                    return 0;
                }
                else
                {
                    return 1;
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }


        /// <summary>
        /// 获取不良信息
        /// </summary>
        /// <param name="entity">不良代码组实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public IList<NCCodeInfo> GetNCCodeInfo(NCCodeInfo entity)
        {
            try
            {
                SearchSettings ss = new SearchSettings();
                ss.ExtensionCondition = "Status = 'Enabled' AND StationId = " + entity.StationId + " AND NCCode = '" + entity.NCCode + "' ";
                return new SKT.LeanMES.NCCode.BLL.NCCode().GetAllNCCode(0, int.MaxValue, string.Empty, ss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        /// <summary>
        /// 初始化用户信息
        /// </summary>
        /// <param name="userXml"></param>
        [AjaxMethod]
        public void NCCodeImport(string userXml, string IsGroup = "")
        {
            int userId = 0;
            SqlParameter[] parms = new SqlParameter[]{
                            new SqlParameter("@UserID", SqlDbType.Int,4),
                            new SqlParameter("@DataXml", SqlDbType.NVarChar)
                            };
            userId = AccountController.GetCurrentUser().UserId;
            try
            {
                parms[0].Value = userId;
                parms[1].Value = userXml;

                string ConnStr = "";
                if (IsGroup == "1")
                {
                    ConnStr = System.Web.HttpContext.Current.Session["ConnStr"].ToString();
                }
                if (!string.IsNullOrEmpty(ConnStr))
                {
                    SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(ConnStr, "uspImportDataNccode", parms);
                }
                else
                {
                    SKT.Common.DAL.Marshal.SQLHelper.ExecuteNonQueryStoredProcedure(SKT.Common.DAL.Marshal.SQLHelper.MESConnString, "uspImportDataNccode", parms);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }
    }
}