using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web;
using AjaxPro;
using SKT.LeanMES.Plan.Model;
using SKT.LeanMES.Product.BLL;
using SKT.LeanMES.Web.AppCode.Utility;

namespace SKT.LeanMES.Web.AjaxServices
{    
    public class AjaxStandardLaborTime
    {
        /// <summary>
        /// 标准工时维护推送：钉钉群自定义机器人Webhook的access_token（优先使用）
        /// </summary>
        private const string DingTalkRobotTokenKey = "DingTalkStandardLaborTimeGroupRobotToken";

        /// <summary>
        /// 标准工时维护推送：钉钉群会话chatId（未配置机器人Token时使用）
        /// </summary>
        private const string DingTalkGroupChatIdKey = "DingTalkStandardLaborTimeGroupChatId";

        /// <summary>
        /// 标准工时维护推送：消息标题
        /// </summary>
        private const string DingTalkNoticeTitle = "标准工时维护通知";

        /// <summary>
        /// 标准工时维护推送：群机器人自定义关键词（钉钉机器人安全设置要求消息包含该关键词）
        /// </summary>
        private const string DingTalkKeywordKey = "DingTalkStandardLaborTimeKeyword";

        /// <summary>
        /// 保存标准工时，并在保存成功后把本次修改内容推送到钉钉群。
        /// 返回：OK=保存并推送成功；FAIL:原因=保存成功但推送失败（不影响保存结果）。
        /// </summary>
        [AjaxMethod]
        public string StandardLaborTimeEdit(StandardLaborTimeInfo entity)
        {
            StandardLaborTimeInfo oldEntity = null;
            var isAdd = entity == null || entity.StandardLaborTimeId <= 0;
            var userName = string.Empty;

            try
            {
                if (entity == null)
                {
                    throw new Exception("保存参数为空");
                }

                SKT.LeanMES.Plan.BLL.StandardLaborTime standarLabor = new LeanMES.Plan.BLL.StandardLaborTime();
                userName = AccountController.GetCurrentUser().UserName;
                if (isAdd)//add new one record
                {
                    entity.CreateBy = userName;
                    entity.ModifyBy = "";
                }
                else// update selected record
                {
                    //先取修改前的数据，用于生成变更内容
                    oldEntity = standarLabor.GetInfo(entity.StandardLaborTimeId);
                    entity.ModifyBy = userName;
                    entity.CreateBy = "";
                }
                var newId = standarLabor.Edit(entity);
                if (isAdd)
                {
                    entity.StandardLaborTimeId = newId;
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }

            //推送钉钉群消息：推送失败不能影响保存结果
            try
            {
                var msg = BuildNoticeMessage(oldEntity, entity, userName);
                return SendDingTalkNotice(msg);
            }
            catch (Exception ex)
            {
                return "FAIL:" + ex.Message;
            }
        }

        /// <summary>
        /// 组装钉钉群通知内容（修改时列出变更项，新增时列出全部内容）
        /// </summary>
        private static string BuildNoticeMessage(StandardLaborTimeInfo oldEntity, StandardLaborTimeInfo entity, string operatorName)
        {
            var sb = new StringBuilder();
            var isAdd = oldEntity == null;
            var itemCode = GetText(entity.ItemCode, isAdd ? "" : oldEntity.ItemCode);
            var itemName = GetItemName(entity.ItemId);
            var laborTimeTypeName = GetText(entity.LaborTimeTypeName, isAdd ? "" : oldEntity.LaborTimeTypeName);
            var equipmentLineName = GetText(entity.EquipmentLineName, isAdd ? "" : oldEntity.EquipmentLineName);
            var tableDesc = GetText(entity.TableDesc, entity.TableName);

            sb.AppendLine("【" + DingTalkNoticeTitle + "】" + GetDingTalkKeyword());
            sb.AppendLine("操作类型：" + (isAdd ? "新增" : "修改"));
            sb.AppendLine("操作人：" + operatorName);
            sb.AppendLine("操作时间：" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            sb.AppendLine();
            sb.AppendLine("产品编码：" + itemCode);
            if (!string.IsNullOrWhiteSpace(itemName))
            {
                sb.AppendLine("产品名称：" + itemName);
            }
            sb.AppendLine("标准工时类型：" + laborTimeTypeName);
            if (!string.IsNullOrWhiteSpace(equipmentLineName))
            {
                sb.AppendLine("线别设备类型：" + equipmentLineName);
            }
            if (!string.IsNullOrWhiteSpace(tableDesc))
            {
                sb.AppendLine("面别：" + tableDesc);
            }
            sb.AppendLine("标准工时(秒)：" + FormatNumber(entity.StandardLaborTime));
            sb.AppendLine("标准产能：" + FormatNumber(entity.StandardCapacity));
            if (!string.IsNullOrWhiteSpace(entity.Remark))
            {
                sb.AppendLine("备注：" + entity.Remark);
            }

            if (isAdd)
            {
                return sb.ToString();
            }

            //修改：列出变更项
            var changes = new List<string>();
            AddChange(changes, "标准工时类型", oldEntity.LaborTimeTypeName, laborTimeTypeName);
            AddChange(changes, "线别设备类型", oldEntity.EquipmentLineName, equipmentLineName);
            AddChange(changes, "产品编码", oldEntity.ItemCode, itemCode);
            AddChange(changes, "面别", oldEntity.TableName, entity.TableName);
            AddChange(changes, "标准工时(秒)", FormatNumber(oldEntity.StandardLaborTime), FormatNumber(entity.StandardLaborTime));
            AddChange(changes, "标准产能", FormatNumber(oldEntity.StandardCapacity), FormatNumber(entity.StandardCapacity));
            AddChange(changes, "备注", oldEntity.Remark, entity.Remark);

            sb.AppendLine();
            sb.AppendLine("变更内容：");
            if (changes.Count == 0)
            {
                sb.AppendLine("无字段变更");
            }
            else
            {
                foreach (var change in changes)
                {
                    sb.AppendLine("· " + change);
                }
            }
            return sb.ToString();
        }

        /// <summary>
        /// 追加一条变更内容（新旧值一致时不追加）
        /// </summary>
        private static void AddChange(List<string> changes, string fieldName, string oldValue, string newValue)
        {
            oldValue = oldValue ?? string.Empty;
            newValue = newValue ?? string.Empty;
            if (oldValue.Trim() == newValue.Trim())
            {
                return;
            }
            changes.Add(fieldName + "：" + (oldValue.Trim() == "" ? "（空）" : oldValue.Trim())
                + " → " + (newValue.Trim() == "" ? "（空）" : newValue.Trim()));
        }

        /// <summary>
        /// 获取产品名称（取不到不影响推送）
        /// </summary>
        private static string GetItemName(int itemId)
        {
            if (itemId <= 0)
            {
                return string.Empty;
            }
            try
            {
                var item = new Item().GetInfo(itemId);
                return item == null ? string.Empty : item.ItemName;
            }
            catch (Exception)
            {
                return string.Empty;
            }
        }

        /// <summary>
        /// 推送钉钉群消息：已配置群机器人Token时走Webhook，否则按群chatId发送会话消息
        /// </summary>
        private static string SendDingTalkNotice(string msg)
        {
            var dingTalk = new DingTalkHelper();

            var robotToken = ConfigurationManager.AppSettings[DingTalkRobotTokenKey];
            if (!string.IsNullOrWhiteSpace(robotToken))
            {
                dingTalk.SendDingTalkRobotMsg(robotToken, msg, DingTalkMsgType.text, DingTalkNoticeTitle);
                return "OK";
            }

            var chatId = ConfigurationManager.AppSettings[DingTalkGroupChatIdKey];
            if (!string.IsNullOrWhiteSpace(chatId))
            {
                dingTalk.SendDingTalkGroupMsg(chatId, msg, DingTalkMsgType.text, DingTalkNoticeTitle);
                return "OK";
            }

            return "FAIL:未配置钉钉群推送参数[" + DingTalkRobotTokenKey + "]或[" + DingTalkGroupChatIdKey + "]";
        }

        /// <summary>
        /// 取显示文本（优先取页面传入值，为空时取默认值）
        /// </summary>
        private static string GetText(string value, string defaultValue)
        {
            return string.IsNullOrWhiteSpace(value) ? (defaultValue ?? string.Empty) : value;
        }

        /// <summary>
        /// 取群机器人自定义关键词（未配置时返回空字符串）
        /// </summary>
        private static string GetDingTalkKeyword()
        {
            var keyword = ConfigurationManager.AppSettings[DingTalkKeywordKey];
            return string.IsNullOrWhiteSpace(keyword) ? string.Empty : keyword.Trim();
        }

        /// <summary>
        /// 数值显示格式（去掉多余的小数0）
        /// </summary>
        private static string FormatNumber(decimal value)
        {
            return value.ToString("0.####");
        }
    }
}
