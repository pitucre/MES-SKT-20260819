using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SKT.LeanMES.CropWeChat.Model;

namespace SKT.LeanMES.CropWeChat.BLL
{
    /// <summary>
    /// 部门操作类
    /// </summary>
    public class CorpDepartmentApi
    {
        /// <summary>
        /// 获取部门列表信息
        /// </summary>
        /// <param name="url"></param>
        /// ACCESS_TOKEN:调用接口凭证
        /// ID :部门id。获取指定部门及其下的子部门。 如果不填，默认获取全量组织架构
        ///       
        /// <returns></returns>
        public DepartmentResultInfo GetDepartmentList(string contactsToken,int departmentId)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/department/list?access_token={0}&id={1}", contactsToken, departmentId);
            try
            {
                return CommonHelper<DepartmentResultInfo>.SendMessage(url);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 创建部门
        /// </summary>
        /// <param name="url"></param>
        /// <param name="json"></param>
        /// <returns></returns>
        public DepartmentResultInfo CreateDepartment(string contactsToken, string json)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/department/create?access_token={0}", contactsToken);
            try
            {
                return CommonHelper<DepartmentResultInfo>.SendMessage(url,json);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 更新部门
        /// </summary>
        /// <param name="url"></param>
        /// <param name="json"></param>
        /// <returns></returns>
        public CommonResultInfo UpdateDepartment(string contactsToken, string json)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/department/update?access_token={0}", contactsToken);
            try
            {
                return CommonHelper<DepartmentResultInfo>.SendMessage(url, json);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// 删除部门
        /// </summary>
        /// <param name="url"></param>
        /// ACCESS_TOKEN:调用接口凭证
        /// id：部门id。（注：不能删除根部门；不能删除含有子部门、成员的部门）
        /// <param name="json"></param>
        /// <returns></returns>
        public CommonResultInfo DeleteDepartment(string contactsToken, int departmentId)
        {
            string url = string.Format("https://qyapi.weixin.qq.com/cgi-bin/department/delete?access_token={0}&id={1}", contactsToken, departmentId);
            try
            {
                return CommonHelper<DepartmentResultInfo>.SendMessage(url);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
