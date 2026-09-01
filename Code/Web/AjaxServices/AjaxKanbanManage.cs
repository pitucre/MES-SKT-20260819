using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.AccessoryManagement.BLL;
using SKT.LeanMES.Kanban.BLL;
using SKT.LeanMES.Kanban.Model;
using SKT.Common.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxKanbanManage
    {
        [AjaxMethod]
        public int TagEdit(TagInfo entity)
        {
            int result = 0;
            try
            {
                result = new Tag().Edit(entity);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return result;
        }

        [AjaxMethod]
        public void Delete(string idString, string userName)
        {
            try
            {
                new Tag().Delete(idString, userName);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public TagInfo GetInfo(int tagId)
        {
            TagInfo entity = new TagInfo();
            try
            {
                entity = new Tag().GetInfo(tagId);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return entity;
        }
        [AjaxMethod]
        public List<TagInfo> GetAll()
        {
            List<TagInfo> list = null;
            try
            {
                list = new Tag().GetAll(0, -1, "", null);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return list;
        }

        //查询看板终端明细
        [AjaxMethod]
        public SendInfo GetSendInfo(string fieldValue, int typeId)
        {
            SendInfo entity = new SendInfo();
            try
            {
                entity = new Send().GetInfo(fieldValue, typeId);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return entity;
        }
        //查询所有看版列表信息
        [AjaxMethod]
        public List<SendInfo> GetSendAll(string sql)
        {
            List<SendInfo> list = null;
            try
            {
                if (sql == "")
                {
                    list = new Send().GetAll(0, -1, "", null);
                }
                else
                {
                    SearchSettings searchSettings = new SearchSettings();
                    searchSettings.ExtensionCondition = sql;
                    list = new Send().GetAll(0, -1, "", searchSettings);

                }
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public int SendEdit(SendInfo entity)
        {
            int result = 0;
            try
            {
                result = new Send().Edit(entity);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return result;
        }

        [AjaxMethod]
        public void DeleteSend(string idString, string userName)
        {
            try
            {
                new Send().Delete(idString, userName);
            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
        }

        //查询所有看版列表信息
        [AjaxMethod]
        public List<SendInfo> GetKanbanMACById(int kanbanId)
        {
            List<SendInfo> list = null;
            try
            {
                list = new Send().GetKanbanMACById(kanbanId);

            }
            catch (Exception ex)
            {

                WebHelper.HandleException(ex);
            }
            return list;
        }
    }
}