using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.SMT.BLL;
using System.Net;
using System.Web.Script.Serialization;
using System.Text;

namespace SKT.LeanMES.Web.SMT
{
    public partial class PickListEdit : BasePage
    {
        // 私有字段保存当前页面数据，便于后续调用 OrderNo 等字段
        private PickListInfo _pageData;

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPickList));
            int pickListId = Convert.ToInt32(Request.QueryString["ID"]);
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "DetailID";
            this.Master.DefaultSortDirection = SortDirection.Ascending;

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "ListID =" + pickListId + "";
            this.Master.SearchSettings = searchSettings;
            //if (!this.IsPostBack)
            //{
            GetLoadStatus();
            if (pickListId > 0)
            {
                SKT.LeanMES.SMT.BLL.PickList bll = new LeanMES.SMT.BLL.PickList();
                var entity = bll.GetInfo(pickListId);
                if (entity != null)
                {
                    PageData = entity;
                }
            }
            //}
            if (this.IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    // SKT.LeanMES.SMT.BLL.PreAssemblySetting bll = new SKT.LeanMES.SMT.BLL.PreAssemblySetting();
                    SKT.LeanMES.SMT.BLL.PickListDetail bll = new PickListDetail();
                    try
                    {
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName, pickListId);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
                if (Request.Form["hdnOperate"].ToLower() == "usecrush")
                {
                    try
                    {
                        string orderNo = this.PageData != null ? this.PageData.ListName : null;
                        if (string.IsNullOrEmpty(orderNo))
                        {
                            WebHelper.ShowMessage("未找到工单号，无法调用接口。");
                        }
                        else
                        {
                            // 如果 orderNo 以 "_1" 结尾，则移除该后缀
                            if (orderNo.EndsWith("_1", StringComparison.Ordinal))
                            {
                                orderNo = orderNo.Substring(0, orderNo.Length - 2);
                            }

                            string url = "http://172.16.5.166:8088/api/PDA/ReplaceYuanLiaoWithFenSuiLaio";

                            CallApiAndHandleResponse(url, orderNo);
                          
                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
                if (Request.Form["hdnOperate"].ToLower() == "useraw")
                {

                    // 计划（伪代码）：
                    // 1. 从 PageData 获取 orderNo，若为 null/空 则提示并返回。
                    // 2. 如果 orderNo 以 "_1" 结尾则去掉该后缀。
                    // 3. 构造要发送的 JSON payload 并调用外部接口 POST 请求。
                    // 4. 解析接口响应 JSON 为 Dictionary<string, object>。
                    // 5. 按规则判断是否失败：只要能够从响应中读取到非空的 ErrorMsg（优先）则视为失败；
                    //    若 ErrorMsg 为空或不存在则视为成功（不再以 Success 字段为最终判定）。
                    // 6. 失败时尝试从不同层级提取更详细的错误信息并显示；成功时调用 BLL 做数据合并并提示成功。
                    //SKT.LeanMES.SMT.BLL.PickListDetail bll = new PickListDetail();
                    try
                    {
                        string orderNo = this.PageData != null ? this.PageData.ListName : null;
                        if (string.IsNullOrEmpty(orderNo))
                        {
                            WebHelper.ShowMessage("未找到工单号，无法调用接口。");
                        }
                        else
                        {
                            // 如果 orderNo 以 "_1" 结尾，则移除该后缀
                            if (orderNo.EndsWith("_1", StringComparison.Ordinal))
                            {
                                orderNo = orderNo.Substring(0, orderNo.Length - 2);
                            }

                            string url = "http://172.16.5.166:8088/api/PDA/ReplaceFenSuiLiaoWithYuanLiao";

                            CallApiAndHandleResponse(url, orderNo);
                            //var payload = new[] { new { orderNo = orderNo } };
                            //var serializer = new JavaScriptSerializer();
                            //string requestJson = serializer.Serialize(payload);

                            //using (var client = new WebClient())
                            //{
                            //    client.Headers[HttpRequestHeader.ContentType] = "application/json";
                            //    // 显式指定编码为 UTF-8，避免服务端返回中文时出现乱码导致 JSON 格式错误
                            //    client.Encoding = Encoding.UTF8;
                            //    string responseJson = client.UploadString(url, "POST", requestJson);

                            //    Dictionary<string, object> result = null;
                            //    try
                            //    {
                            //        result = serializer.Deserialize<Dictionary<string, object>>(responseJson);
                            //    }
                            //    catch (ArgumentException exDeserialize)
                            //    {
                            //        // 记录原始响应并提示运维/开发排查编码或接口返回格式问题
                            //        WebHelper.HandleException("JSON 解析失败，原始响应：" + (responseJson ?? "<null>"), exDeserialize, true);
                            //        WebHelper.ShowMessage("接口返回不可解析的 JSON，请联系管理员。");
                            //        return;
                            //    }

                            //    // 优先判断 ErrorMsg：只要 ErrorMsg 有非空信息就视为失败；为空或不存在则视为成功。
                            //    string errorMsg = null;

                            //    // 检查顶层 ErrorMsg 字段
                            //    if (result.ContainsKey("ErrorMsg") && result["ErrorMsg"] != null)
                            //    {
                            //        errorMsg = result["ErrorMsg"].ToString().Trim();
                            //    }

                            //    // 替换之前针对 Data 的判断和解析
                            //    if (string.IsNullOrEmpty(errorMsg) && result.ContainsKey("Data") && result["Data"] != null)
                            //    {
                            //        errorMsg = ExtractErrorFromData(result["Data"]);
                            //        // 如果仍未找到，可以把原始响应记录或显示（可选）
                            //        // if (string.IsNullOrEmpty(errorMsg)) WebHelper.HandleException("未能解析 Data 中的错误信息，原始响应: " + responseJson, null, false);
                            //    }

                            //    // 最终判定：只要 errorMsg 非空 -> 失败；否则认为成功
                            //    if (!string.IsNullOrEmpty(errorMsg))
                            //    {
                            //        WebHelper.ShowMessage("接口调用失败：" + errorMsg);
                            //    }
                            //    else
                            //    {
                            //        // 接口认为成功，执行后台合并逻辑
                            //        //bll.UsedCrushRawMat(1, AccountController.GetCurrentUser().UserName, pickListId);
                            //        WebHelper.ShowMessage("接口调用成功，数据合并完成");
                            //    }
                            //}
                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException("", ex, true);
                    }
                }
            }
        }

        private PickListInfo PageData
        {
            get
            {
                return _pageData;
            }
            set
            {
                _pageData = value;
                if (value == null) return;

                this.cbFullSet.Checked = value.IsFullSet;
                this.hdnItemId.Value = value.ItemID.ToString();
                this.txtModelName.Text = value.ItemCode; //产品名称                 
                this.txtRev.Text = value.Revision.ToString();
                this.ddlStatus.SelectedValue = value.StatusID.ToString();
                this.ddlStatus.Text = value.StatusStr.ToString();
                this.txtPickListName.Text = value.ListName;
                this.txtRemark.Text = value.Remark;
            }
        }

        /***获取状态***/
        public void GetLoadStatus()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            SKT.LeanMES.SMT.BLL.LIST_Status status = new SKT.LeanMES.SMT.BLL.LIST_Status();
            List<SKT.LeanMES.SMT.Model.LIST_StatusInfo> statusInfo = status.GetAll(0, 100, "id", searchSettings);

            statusInfo = statusInfo.Where(a => a.Id == 1 || a.Id == 0).ToList();

            ddlStatus.DataSource = statusInfo;
            ddlStatus.DataTextField = "Description";
            ddlStatus.DataValueField = "id";

            ddlStatus.DataBind();
        }

        // 用此更健壮的辅助方法替换或覆盖原有的 ExtractErrorFromData（放在 PickListEdit 类内）
        private string ExtractErrorFromData(object data)
        {
            if (data == null) return null;

            // 如果 Data 是字符串，尝试解析成 JSON 再处理（防护）
            if (data is string dataStr && !string.IsNullOrWhiteSpace(dataStr))
            {
                try
                {
                    var serializer = new JavaScriptSerializer();
                    var parsed = serializer.DeserializeObject(dataStr);
                    return ExtractErrorFromData(parsed);
                }
                catch
                {
                    // 不强制失败，继续后续检查原始字符串（通常不会是错误信息）
                }
            }

            // 处理数组（object[]）或其它 IEnumerable（ArrayList, List<object> 等），但排除 string
            if (data is System.Collections.IEnumerable enumerable && !(data is string))
            {
                foreach (var item in enumerable)
                {
                    var msg = ExtractErrorFromData(item);
                    if (!string.IsNullOrEmpty(msg)) return msg;
                }
            }

            // 处理字典/映射（包含 Dictionary<string, object> 和非泛型 IDictionary）
            // 使用不区分大小写的键匹配
            if (data is System.Collections.IDictionary dict)
            {
                // 先尝试直接从字典中按优先级取值（不区分大小写）
                string[] keysPriority = new[] { "ErrorMsg", "Error", "Message", "Msg", "SuccessMsg", "msg" };
                foreach (var key in keysPriority)
                {
                    foreach (var k in dict.Keys)
                    {
                        if (k == null) continue;
                        if (string.Equals(k.ToString(), key, StringComparison.OrdinalIgnoreCase))
                        {
                            var val = dict[k];
                            if (val != null)
                            {
                                var s = val.ToString().Trim();
                                if (!string.IsNullOrEmpty(s)) return s;
                            }
                        }
                    }
                }

                // 若当前字典没有直接匹配的字段，递归检查其所有值
                foreach (var k in dict.Keys)
                {
                    var val = dict[k];
                    var msg = ExtractErrorFromData(val);
                    if (!string.IsNullOrEmpty(msg)) return msg;
                }
            }

            // 其它标量类型（无错误信息）
            return null;
        }


        public void CallApiAndHandleResponse(string url, string orderNo)
        {
            var payload = new[] { new { orderNo = orderNo } };
            var serializer = new JavaScriptSerializer();
            string requestJson = serializer.Serialize(payload);

            using (var client = new WebClient())
            {
                client.Headers[HttpRequestHeader.ContentType] = "application/json";
                // 显式指定编码为 UTF-8，避免服务端返回中文时出现乱码导致 JSON 格式错误
                client.Encoding = Encoding.UTF8;
                string responseJson = client.UploadString(url, "POST", requestJson);

                Dictionary<string, object> result = null;
                try
                {
                    result = serializer.Deserialize<Dictionary<string, object>>(responseJson);
                }
                catch (ArgumentException exDeserialize)
                {
                    // 记录原始响应并提示运维/开发排查编码或接口返回格式问题
                    WebHelper.HandleException("JSON 解析失败，原始响应：" + (responseJson ?? "<null>"), exDeserialize, true);
                    WebHelper.ShowMessage("接口返回不可解析的 JSON，请联系管理员。");
                    return;
                }

                // 优先判断 ErrorMsg：只要 ErrorMsg 有非空信息就视为失败；为空或不存在则视为成功。
                string errorMsg = null;

                // 检查顶层 ErrorMsg 字段
                if (result.ContainsKey("ErrorMsg") && result["ErrorMsg"] != null)
                {
                    errorMsg = result["ErrorMsg"].ToString().Trim();
                }

                // 替换之前针对 Data 的判断和解析
                if (string.IsNullOrEmpty(errorMsg) && result.ContainsKey("Data") && result["Data"] != null)
                {
                    errorMsg = ExtractErrorFromData(result["Data"]);
                    // 如果仍未找到，可以把原始响应记录或显示（可选）
                    // if (string.IsNullOrEmpty(errorMsg)) WebHelper.HandleException("未能解析 Data 中的错误信息，原始响应: " + responseJson, null, false);
                }

                // 最终判定：只要 errorMsg 非空 -> 失败；否则认为成功
                if (!string.IsNullOrEmpty(errorMsg))
                {
                    WebHelper.ShowMessage("接口调用失败：" + errorMsg);
                }
                else
                {
                    // 接口认为成功，执行后台合并逻辑
                    //bll.UsedCrushRawMat(1, AccountController.GetCurrentUser().UserName, pickListId);
                    WebHelper.ShowMessage("接口调用成功，数据合并完成");
                }
            }
        }

    }
}