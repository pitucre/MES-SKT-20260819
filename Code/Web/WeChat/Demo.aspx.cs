using Newtonsoft.Json;
using SKT.LeanMES.CropWeChat.BLL;
using SKT.LeanMES.CropWeChat.Model;
using System;
using System.Collections.Generic;
using System.Web;

namespace SKT.LeanMES.Web.WeChat
{
    public partial class Demo : System.Web.UI.Page
    {
        string accessToken = "";
        string CorpID = "";
        string Agentid = "";
        string Secret = "";
        public string deparmentList = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            CorpID = System.Configuration.ConfigurationManager.AppSettings["CorpID"];
            Agentid = System.Configuration.ConfigurationManager.AppSettings["AgentId"];
            Secret = System.Configuration.ConfigurationManager.AppSettings["Secret"];

            accessToken = Request.Cookies["AccessToken"] == null ? "" : Request.Cookies["AccessToken"].Value;
            if (accessToken == null || accessToken == "")
            {
                accessToken = CommonHelper<object>.GetAccessToken(CorpID, Secret);
                HttpCookie cookie = new HttpCookie("AccessToken");
                cookie.Value = accessToken;
                cookie.Expires = DateTime.Now.AddSeconds(7000);
                Response.Cookies.Add(cookie);
            }

            List<DepartmentInfo> list = GetDepartmentList(1);//获取所有部门信息
            deparmentList = JsonConvert.SerializeObject(list);
        }


        #region 企业消息发送

        /// <summary>
        /// 发送文本信息
        /// </summary>
        public void SendText()
        {
            string text = txtTextMsg.Value;
            string departmentId = (hdnMsgDepartmentId.Value);
            string userId = "";
            if (departmentId == "0")
            {
                lblErorrMsg.Text = "请选择接收消息部门！";
                return;
            }
            if (text == "")
            {
                lblErorrMsg.Text = "请输入需要发送的消息！";
                return;
            }


            SubCorpSendTextInfo subEntity = new SubCorpSendTextInfo();

            subEntity.content = text;

            CorpSendTextInfo entity = new CorpSendTextInfo();
            entity.touser = userId;// UserID列表（消息接收者，多个接收者用‘|’分隔）。特殊情况：指定为@all，则向关注该企业应用的全部成员发送
            entity.toparty = departmentId;//PartyID列表，多个接受者用‘|’分隔。当touser为@all时忽略本参数
            entity.totag = "";//TagID列表，多个接受者用‘|’分隔。当touser为@all时忽略本参数
            entity.msgtype = "text";//消息类型
            entity.agentid = Agentid;//企业应用的id，整型。可在应用的设置页面查看
            entity.text = subEntity;

            string json = JsonConvert.SerializeObject(entity);

            Send(json);
        }

        /// <summary>
        /// 发送文本卡片信息
        /// </summary>
        public void SendTextCard()
        {

            string title = txtTextCardTitle.Value;//标题，不超过128个字节，超过会自动截断
            string description = txtTextCardDesc.Value;//描述，不超过512个字节，超过会自动截断
            string url = txtTextCardURL.Value;//点击后跳转的链接。
            string btntxt = txtTextCardBtn.Value;//按钮文字。 默认为“详情”， 不超过4个文字，超过自动截断。【非必须】

            if (title == "")
            {
                lblErorrMsg.Text = "请输入消息标题！";
                return;
            }
            else if (description == "")
            {
                lblErorrMsg.Text = "请输入消息描述！";
                return;
            }
            else if (url == "")
            {
                lblErorrMsg.Text = "请输入点击消息连接！";
                return;
            }

            string departmentId = (hdnMsgDepartmentId.Value);
            string userId = "";
            if (departmentId == "0")
            {
                lblErorrMsg.Text = "请选择接收消息部门！";
                return;
            }

            SubCorpSendTextCardInfo subEntity = new SubCorpSendTextCardInfo();
            subEntity.title = title;
            subEntity.description = description;
            subEntity.url = url;
            subEntity.btntxt = btntxt;

            CorpSendTextCardInfo entity = new CorpSendTextCardInfo();
            entity.touser = userId;//YuanZhiMan
            entity.toparty = departmentId;
            entity.totag = "";
            entity.msgtype = "textcard";
            entity.agentid = Agentid;
            entity.textcard = subEntity;

            string json = JsonConvert.SerializeObject(entity);

            Send(json);
        }

        /// <summary>
        /// 发送图文信息
        /// </summary>
        public void SendNews()
        {
            string title = txtNewsTitle.Value;//标题，不超过128个字节，超过会自动截断
            string description = txtNewsDesc.Value;//描述，不超过512个字节，超过会自动截断
            string url = txtNewsURL.Value;//点击后跳转的链接。
            string picUrl = txtNewsPicURL.Value;//点击后跳转的链接。
            string btntxt = txtNewsBtn.Value;//按钮文字。 默认为“详情”， 不超过4个文字，超过自动截断。【非必须】

            if (title == "")
            {
                lblErorrMsg.Text = "请输入消息标题！";
                return;
            }
            else if (description == "")
            {
                lblErorrMsg.Text = "请输入消息描述！";
                return;
            }
            else if (picUrl == "")
            {
                lblErorrMsg.Text = "请输入图片地址！";
                return;
            }
            else if (url == "")
            {
                lblErorrMsg.Text = "请输入点击消息连接！";
                return;
            }

            string departmentId = (hdnMsgDepartmentId.Value);
            string userId = "";
            if (departmentId == "0")
            {
                lblErorrMsg.Text = "请选择接收消息部门！";
                return;
            }

            List<ArticlesInfo> articlesList = new List<ArticlesInfo>();

            ArticlesInfo articlesEntity = new ArticlesInfo();
            articlesEntity.title = title;
            articlesEntity.description = description;
            articlesEntity.url = url;
            articlesEntity.picurl = picUrl;
            articlesEntity.btntxt = btntxt;

            articlesList.Add(articlesEntity);

            CorpSendNewsnewsInfo subEntity = new CorpSendNewsnewsInfo();
            subEntity.articles = articlesList;

            CorpSendNewsInfo entity = new CorpSendNewsInfo();
            entity.touser = userId;//YuanZhiMan
            entity.toparty = departmentId;
            entity.totag = "";
            entity.msgtype = "news";
            entity.agentid = Agentid;
            entity.news = subEntity;

            string json = JsonConvert.SerializeObject(entity);

            Send(json);
        }

        /// <summary>
        /// 发送图片信息
        /// </summary>
        public void SendImage()
        {
            string json = "";
            string filePath = hidFilePath.Value;
            if (filePath == "")
            {
                lblErorrMsg.Text = "请上传图片信息！";
                return;
            }

            string departmentId = (hdnMsgDepartmentId.Value);
            string userId = "";
            if (departmentId == "0")
            {
                lblErorrMsg.Text = "请选择接收消息部门！";
                return;
            }

            string media_id = GetMediaId("image", filePath);//获取上传临时素材的ID

            //消息实体赋值        
            CorpSendImageimageInfo subEntity = new CorpSendImageimageInfo();
            subEntity.media_id = media_id;

            CorpSendImageInfo entity = new CorpSendImageInfo();
            entity.touser = userId;//YuanZhiMan
            entity.toparty = departmentId;
            entity.totag = "";
            entity.msgtype = "image";
            entity.agentid = Agentid;
            entity.image = subEntity;

            json = JsonConvert.SerializeObject(entity);

            Send(json);
        }

        /// <summary>
        /// 发送文件信息
        /// </summary>
        public void SendFile()
        {
            string json = "";
            string filePath = hidFilePath.Value;
            if (filePath == "")
            {
                lblErorrMsg.Text = "请选择上传文件！";
                return;
            }

            string departmentId = (hdnMsgDepartmentId.Value);
            string userId = "";
            if (departmentId == "0")
            {
                lblErorrMsg.Text = "请选择接收消息部门！";
                return;
            }

            string media_id = GetMediaId("file", filePath);//获取上传临时素材的ID

            //消息实体赋值        
            CorpSendFilefileInfo subEntity = new CorpSendFilefileInfo();
            subEntity.media_id = media_id;

            CorpSendFileInfo entity = new CorpSendFileInfo();
            entity.touser = userId;//YuanZhiMan
            entity.toparty = departmentId;
            entity.totag = "";
            entity.msgtype = "file";
            entity.agentid = Agentid;
            entity.file = subEntity;

            json = JsonConvert.SerializeObject(entity);

            Send(json);
        }

        /// <summary>
        /// 发送微信消息
        /// </summary>
        /// <param name="url">请求地址</param>
        /// <param name="json">请求数据</param>
        public void Send(string json = "")
        {
            //发送微信消息
            CorpMessageApi messageApi = new CorpMessageApi();
            try
            {
                CorpSendMsgResultInfo resultInfo = new CorpSendMsgResultInfo();

                resultInfo = messageApi.SendMessage(accessToken, json);

                if (resultInfo.errcode != 0)
                {
                    //返回错误消息
                    lblErorrMsg.Text = JsonConvert.SerializeObject(resultInfo);
                }
                else
                {
                    lblMsg.Text = JsonConvert.SerializeObject(resultInfo);
                }
                refresh();
            }
            catch (Exception ex)
            {
                //记录错误日志
                lblErorrMsg.Text = ex.Message;
            }
        }

        /// <summary>
        /// 上传图片素材，获取素材ID
        /// </summary>
        /// <returns></returns>
        public string GetMediaId(string uploadType, string filePath)
        {
            CorpMediaResultInfo respDic = CorpMediaApi.MediaUpload(accessToken, uploadType, filePath);
            return respDic.media_id;
        }

        /// <summary>
        /// 发送消息给用户
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void SendMsg(object sender, EventArgs e)
        {
            lblErorrMsg.Text = "";
            lblMsg.Text = "";
            string msgType = ddlMessageType.Value;

            switch (msgType)
            {
                case "text":
                    SendText();
                    break;
                case "image":
                    SendImage();
                    break;
                case "file":
                    SendFile();
                    break;
                case "textcard":
                    SendTextCard();
                    break;
                case "news":
                    SendNews();
                    break;
                default:
                    break;
            }
        }
        #endregion

        #region 部门管理

        /// <summary>
        /// 创建部门
        /// </summary>
        public void CreateDepartment()
        {
            string json = "";
            string contactsToken = GetContactsToken();
            string departmentName = txtDepartmentName.Value;

            int departmentId = Convert.ToInt16(hdnDepartmentId.Value);

            if (departmentName == "")
            {
                lblDepartmentErrorMsg.Text = "请输入新部门名称！";
                return;
            }
            if (departmentId == 0)
            {
                lblDepartmentErrorMsg.Text = "请选择所属部门！";
                return;
            }

            DepartmentInfo entity = new DepartmentInfo();
            entity.name = departmentName;//部门名称。长度限制为1~32个字符，字符不能包括\:?”<>｜【必填】
            entity.parentid = departmentId;//父部门id，32位整型【必填】
            entity.order = 1;//在父部门中的次序值。order值大的排序靠前。有效的值范围是[0, 2^32)【必填】
                             //entity.id = 5;//部门id，32位整型，指定时必须大于1。若不填该参数，将自动生成id【非必填】
            json = JsonConvert.SerializeObject(entity);

            CorpDepartmentApi deparmentBll = new CorpDepartmentApi();
            DepartmentResultInfo resultEntity = deparmentBll.CreateDepartment(contactsToken, json);
            lblDepartmentMsg.Text = JsonConvert.SerializeObject(resultEntity);
        }

        /// <summary>
        /// 编辑部门
        /// </summary>
        public void EditDepartment()
        {
            string json = "";
            string contactsToken = GetContactsToken();

            int editDepartmentId = Convert.ToInt16(hdnEditDepartmentId.Value);
            int parentDepartmentId = Convert.ToInt16(hdnParentDepartmentId.Value);
            string departmentName = txtNewDepartmentName.Value;

            if (departmentName == "")
            {
                lblDepartmentErrorMsg.Text = "请输入新部门名称！";
                return;
            }

            if (editDepartmentId == 0)
            {
                lblDepartmentErrorMsg.Text = "请选择需修改的部门！";
                return;
            }
            else if (parentDepartmentId == 0)
            {
                lblDepartmentErrorMsg.Text = "请选择需所属上级部门！";
                return;
            }

            DepartmentInfo entity = new DepartmentInfo();
            entity.name = departmentName;//部门名称。长度限制为1~32个字符，字符不能包括\:?”<>｜【必填】
            entity.parentid = parentDepartmentId;//父部门id，32位整型【必填】
            entity.order = 1;//在父部门中的次序值。order值大的排序靠前。有效的值范围是[0, 2^32)【必填】
            entity.id = editDepartmentId;//部门id，32位整型，指定时必须大于1。若不填该参数，将自动生成id【非必填】
            json = JsonConvert.SerializeObject(entity);

            CorpDepartmentApi deparmentBll = new CorpDepartmentApi();
            CommonResultInfo resultEntity = deparmentBll.UpdateDepartment(contactsToken, json);
            lblDepartmentMsg.Text = JsonConvert.SerializeObject(resultEntity);
        }

        /// <summary>
        /// 删除部门
        /// </summary>
        /// <param name="departmentId">部门ID</param>
        public void DeleteDepartment()
        {
            string contactsToken = GetContactsToken();
            int departmentId = Convert.ToInt16(hdnDeleteDepartmentId.Value);
            if (departmentId == 0)
            {
                lblDepartmentErrorMsg.Text = "请选择需删除的部门！";
                return;
            }
            CorpDepartmentApi deparmentBll = new CorpDepartmentApi();
            CommonResultInfo resultEntity = deparmentBll.DeleteDepartment(contactsToken, departmentId);
            lblDepartmentMsg.Text = JsonConvert.SerializeObject(resultEntity);
        }

        /// <summary>
        /// 获取部门信息
        /// </summary>
        /// <param name="departmentId"></param>
        /// <returns></returns>
        public List<DepartmentInfo> GetDepartmentList(int departmentId)
        {
            string contactsToken = GetContactsToken();

            CorpDepartmentApi deparmentBll = new CorpDepartmentApi();

            DepartmentResultInfo resultEntity = deparmentBll.GetDepartmentList(contactsToken, departmentId);
            //lblMsg.Text = JsonConvert.SerializeObject(resultEntity);
            return resultEntity.department;
        }

        public string GetContactsToken()
        {
            string contactsToken = Request.Cookies["ContactsToken"] == null ? "" : Request.Cookies["ContactsToken"].Value;
            if (contactsToken == null || contactsToken == "")
            {
                Secret = System.Configuration.ConfigurationManager.AppSettings["ContactsSecret"];
                contactsToken = CommonHelper<object>.GetAccessToken(CorpID, Secret);
                HttpCookie cookie = new HttpCookie("ContactsToken");
                cookie.Value = contactsToken;
                cookie.Expires = DateTime.Now.AddSeconds(7000);
                Response.Cookies.Add(cookie);
            }

            return contactsToken;
        }

        protected void DepartmentManage(object sender, EventArgs e)
        {
            lblDepartmentMsg.Text = "";
            lblDepartmentErrorMsg.Text = "";
            string departmentType = ddlDepartment.Value;

            switch (departmentType)
            {
                case "create":
                    CreateDepartment();
                    break;
                case "update":
                    EditDepartment();
                    break;
                case "delete":
                    DeleteDepartment();
                    break;
                default:
                    break;
            }
            refresh();
        }

        protected void refresh()
        {
            deparmentList = JsonConvert.SerializeObject(GetDepartmentList(1));
            hdnDepartmentList.Value = deparmentList;
        }
        #endregion

        #region 人员管理

        /// <summary>
        /// 创建人员信息
        /// </summary>
        public void CreateUser()
        {
            string contactsToken = GetContactsToken();
            string userId = txtUserId.Value;
            string name = txtUserName.Value;
            string ename = txtEnglishName.Value;
            string mobile = txtmobile.Value;
            int departmentId = Convert.ToInt16(hdndepartTreeview.Value);
            string position = txtposition.Value;
            string email = txtemail.Value;

            if (userId == "")
            {
                lblUserErrorMsg.Text = "请输入账号！";
                return;
            }
            if (name == "")
            {
                lblUserErrorMsg.Text = "请输入姓名！";
                return;
            }
            if (departmentId == 0)
            {
                lblUserErrorMsg.Text = "请选择用户部门！";
                return;
            }
            if(email == "" && mobile == "")
            {
                lblUserErrorMsg.Text = "手机号和邮箱不能同时为空！";
                return;
            }

            CorpUserInfo userEntity = new CorpUserInfo();

            userEntity.userid = userId;
            userEntity.name = name;
            userEntity.english_name = ename;
            userEntity.mobile = mobile;
            userEntity.department = new int[] { departmentId };
            userEntity.order = new int[] { 1 };
            userEntity.position = position;
            userEntity.gender = "1";
            userEntity.email = email;
            userEntity.isleader = 0;
            userEntity.enable = 1;
            //userEntity.avatar_mediaid = "2-G6nrLmr5EC3MNb_-zL1dDdzkd0p7cNliYu9V5w7o8K0";//上传素材ID
            userEntity.telephone = "020-123456";
            //userEntity.extattr = new CorpUserExtattrInfo();
            userEntity.to_invite = false;
            //userEntity.external_profile = new CorpUserExternalProfileInfo();

            string json = JsonConvert.SerializeObject(userEntity);

            CorpUserApi userBll = new CorpUserApi();

            CommonResultInfo resultEntity = userBll.CreateUser(contactsToken, json);

            lblUserMsg.Text = JsonConvert.SerializeObject(resultEntity);
        }

        /// <summary>
        /// 更新用户信息
        /// </summary>
        public void UpdateUser()
        {
            string contactsToken = GetContactsToken();
            string userId = txtUserId.Value;
            string name = txtUserName.Value;
            string ename = txtEnglishName.Value;
            string mobile = txtmobile.Value;
            int departmentId = Convert.ToInt16(hdndepartTreeview.Value);
            string position = txtposition.Value;
            string email = txtemail.Value;

            if (userId == "")
            {
                lblUserErrorMsg.Text = "请输入账号！";
                return;
            }
            if (name == "")
            {
                lblUserErrorMsg.Text = "请输入姓名！";
                return;
            }
            if (departmentId == 0)
            {
                lblUserErrorMsg.Text = "请选择用户部门！";
                return;
            }
            if (email == "" && mobile == "")
            {
                lblUserErrorMsg.Text = "手机号和邮箱不能同时为空！";
                return;
            }

            CorpUserInfo userEntity = new CorpUserInfo();

            userEntity.userid = userId;
            userEntity.name = name;
            userEntity.english_name = ename;
            userEntity.mobile = mobile;
            userEntity.department = new int[] { departmentId };
            userEntity.order = new int[] { 1 };
            userEntity.position = position;
            userEntity.gender = "1";
            userEntity.email = email;
            userEntity.isleader = 0;
            userEntity.enable = 1;
            //userEntity.avatar_mediaid = "2-G6nrLmr5EC3MNb_-zL1dDdzkd0p7cNliYu9V5w7o8K0";//上传素材ID
            userEntity.telephone = "020-123456";
            //userEntity.extattr = new CorpUserExtattrInfo();
            userEntity.to_invite = false;
            //userEntity.external_profile = new CorpUserExternalProfileInfo();

            string json = JsonConvert.SerializeObject(userEntity);

            CorpUserApi userBll = new CorpUserApi();

            CommonResultInfo resultEntity = userBll.UpdateUser(contactsToken, json);

            lblUserMsg.Text = JsonConvert.SerializeObject(resultEntity);
        }

        /// <summary>
        /// 删除用户信息
        /// </summary>
        public void DeleteUser()
        {
            string contactsToken = GetContactsToken();
            string userId = txtUserId.Value;
            if (userId == "")
            {
                lblUserErrorMsg.Text = "请输入账号！";
                return;
            }
            CorpUserApi userBll = new CorpUserApi();

            CommonResultInfo resultEntity = userBll.DeleteUser(contactsToken, userId);

            lblUserMsg.Text = JsonConvert.SerializeObject(resultEntity);
        }

        /// <summary>
        /// 根据部门ID获取用户信息
        /// </summary>
        public void GetUserList()
        {
            string contactsToken = GetContactsToken();
            string departmentId = (hdnUserListDepartId.Value);

            CorpUserApi userBll = new CorpUserApi();

            List<CorpUserSimpleListInfo> resultEntity = userBll.GetUserList(contactsToken, departmentId, 0);


            lblUserMsg.Text = JsonConvert.SerializeObject(resultEntity);
        }

        /// <summary>
        /// 根据部门ID获取用户详情信息
        /// </summary>
        public void GetUserDetailList()
        {
            string contactsToken = GetContactsToken();
            string departmentId = hdnUserListDepartId.Value;

            if(departmentId == "")
            {
                lblUserErrorMsg.Text = "请选择部门！";
                return;
            }

            CorpUserApi userBll = new CorpUserApi();

            List<CorpUserInfo> resultEntity = userBll.GetUserDetailList(contactsToken, departmentId, 1);

            hdnUserList.Value = JsonConvert.SerializeObject(resultEntity);
        } 
         
        protected void UserManage(object sender, EventArgs e)
        {
            lblUserMsg.Text = "";
            lblUserErrorMsg.Text = "";
            string userType = ddlUser.Value;

            switch (userType)
            {
                case "create":
                    CreateUser();
                    break;
                case "update":
                    UpdateUser();
                    break;
                case "delete":
                    DeleteUser();
                    break;
                case "list":
                    GetUserDetailList();
                    break;
                default:
                    break;
            }
           // refresh();
        }

        #endregion

    }
}