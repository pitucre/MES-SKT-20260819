using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SKT.LeanMES.CropWeChat.Model;
namespace SKT.LeanMES.CropWeChat.BLL
{
    public class CorpUserApi
    {
        /// <summary>
        /// 创建用户信息
        /// </summary>
        /// <param name="accessToken">调用接口凭证</param>
        /// <param name="json">用户信息JSON</param>
        /// <returns></returns>
        public CommonResultInfo CreateUser(string accessToken, string json)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/user/create?access_token={0}",accessToken);
            try
            {
               return  CommonHelper<CommonResultInfo>.SendMessage(url, json);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <param name="accessToken">调用接口凭证</param>
        /// <param name="userId">成员UserID。对应管理端的帐号，企业内必须唯一。不区分大小写，长度为1~64个字节</param>
        /// <returns></returns>
        public CorpUserInfo GetUser(string accessToken, string userId)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/user/get?access_token={0}&userid={1}", accessToken,userId);
            try
            {
               return  CommonHelper<CorpUserInfo>.SendMessage(url);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 更新用户信息
        /// </summary>
        /// <param name="accessToken">调用接口凭证</param>
        /// <param name="json">用户信息JSON</param>
        /// <returns></returns>
        public CommonResultInfo UpdateUser(string accessToken, string json)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/user/update?access_token={0}", accessToken);
            try
            {
               return  CommonHelper<CommonResultInfo>.SendMessage(url, json);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 删除用户信息
        /// </summary>
        /// <param name="accessToken">调用接口凭证</param>
        /// <param name="userId">用户ID</param>
        /// <returns></returns>
        public CommonResultInfo DeleteUser(string accessToken, string userId)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/user/delete?access_token={0}&userid={1}", accessToken,userId);
            try
            {
               return  CommonHelper<CommonResultInfo>.SendMessage(url);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 批量删除用户
        /// </summary>
        /// <param name="accessToken">调用接口凭证</param>
        /// <param name="json">成员UserID列表。对应管理端的帐号。最多支持200个。若存在无效UserID，直接返回错误</param>
        /// <returns></returns>
        public CommonResultInfo BatchDeleteUser(string accessToken, string json)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/user/batchdelete?access_token={0}", accessToken);
            try
            {
               return  CommonHelper<CommonResultInfo>.SendMessage(url,json);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 获取部门成员
        /// </summary>
        /// <param name="accessToken">调用接口凭证</param>
        /// <param name="departmentId">获取的部门id</param>
        /// <param name="fetchChild">1/0：是否递归获取子部门下面的成员</param>
        /// <returns></returns>
        public List<CorpUserSimpleListInfo> GetUserList(string accessToken, string departmentId, int fetchChild = 0)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/user/simplelist?access_token={0}&department_id={1}&fetch_child={2}", accessToken, departmentId, fetchChild);
            try
            {
                CorpUserSimpleInfo entity = CommonHelper<CorpUserSimpleInfo>.SendMessage(url);
                return entity.userlist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 获取部门成员详情
        /// </summary>
        /// <param name="accessToken">调用接口凭证</param>
        /// <param name="departmentId">获取的部门id</param>
        /// <param name="fetchChild">1/0：是否递归获取子部门下面的成员</param>
        /// <returns></returns>
        public List<CorpUserInfo> GetUserDetailList(string accessToken, string departmentId, int fetchChild = 0)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/user/list?access_token={0}&department_id={1}&fetch_child={2}", accessToken, departmentId, fetchChild);
            try
            {
                CorpUserDetailInfo entity = CommonHelper<CorpUserDetailInfo>.SendMessage(url);
                return entity.userlist;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}
