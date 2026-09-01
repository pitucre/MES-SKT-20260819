using SKT.LeanMES.ProductionCollection.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace SKT.LeanMES.Web.WebService
{
    /// <summary>
    /// AGVService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class AGVService : System.Web.Services.WebService
    {

        [WebMethod(Description = @"
        [AGV任务状态更新接口]<br/>
        [处理逻辑]：依据输入的任务编号，任务状态<br/>
        [功能]：更新AGV任务状态，验证任务号是否正确<br/>
        [输入-参数]：taskNo-AGV任务编号  status-任务状态 0=进行中  1=暂停  2=完成<br/>
        [输出-返回]：字符串，成功 【OK】; 失败 【NG:返回错误信息】<br/> 
        ")]
        public string UpdateAgvTaskStatus(string taskNo, string status)
        {
            string msg = "OK;";
            LaserCarvingOrderInfo model = new LaserCarvingOrderInfo();
            try
            {
                if (taskNo == "")
                {
                    return string.Format("NG;任务编号不能传空！");
                }

                SqlParameter[] parms = new SqlParameter[]{
                        new SqlParameter("@TaskNo", SqlDbType.VarChar),
                        new SqlParameter("@Status", SqlDbType.VarChar,50)
                    };
                parms[0].Value = taskNo;
                parms[1].Value = status;
                CommonHelper.BLL.ComMethod.Edit("uspUpdateAgvTask", parms); 

            }
            catch (Exception ex)
            {
                msg ="NG;"+ ex.Message;
            }

            return string.Format(msg);
        }
    }
}
