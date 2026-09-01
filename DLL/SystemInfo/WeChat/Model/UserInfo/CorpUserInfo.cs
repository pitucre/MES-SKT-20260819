using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CropWeChat.Model
{

    public class CorpUserInfo
    {
        /// <summary>
        /// 成员UserID。对应管理端的帐号，企业内必须唯一。不区分大小写，长度为1~64个字节【必须】
        /// </summary>
        public string userid { get; set; }

        /// <summary>
        /// 成员名称。长度为1~64个字符【必须】
        /// </summary>
        public string name { get; set; }

        /// <summary>
        /// 英文名。长度为1-64个字节，由字母、数字、点(.)、减号(-)、空格或下划线(_)组成【非必须】
        /// </summary>
        public string english_name { get; set; }

        /// <summary>
        /// 手机号码。企业内必须唯一，mobile/email二者不能同时为空【非必须】
        /// </summary>
        public string mobile { get; set; }

        /// <summary>
        /// 成员所属部门id列表,不超过20个【必须】
        /// </summary>
        public int[] department { get; set; }

        /// <summary>
        /// 部门内的排序值，默认为0，成员次序以创建时间从小到大排列。数量必须和department一致，数值越大排序越前面。有效的值范围是[0, 2^32)【非必须】
        /// </summary>
        public int[] order { get; set; }

        /// <summary>
        /// 职位信息。长度为0~128个字符【非必须】
        /// </summary>
        public string position { get; set; }

        /// <summary>
        /// 性别。1表示男性，2表示女性【非必须】
        /// </summary>
        public string gender { get; set; }

        /// <summary>
        /// 邮箱。长度不超过64个字节，且为有效的email格式。企业内必须唯一，mobile/email二者不能同时为空【非必须】
        /// </summary>
        public string email { get; set; }

        /// <summary>
        /// 上级字段，标识是否为上级。在审批等应用里可以用来标识上级审批人【非必须】
        /// </summary>
        public int isleader { get; set; }

        /// <summary>
        /// 启用/禁用成员。1表示启用成员，0表示禁用成员【非必须】
        /// </summary>
        public int enable { get; set; }

        /// <summary>
        /// 成员头像的mediaid，通过素材管理接口上传图片获得的mediaid【非必须】
        /// </summary>
        public string avatar_mediaid { get; set; }

        /// <summary>
        /// 座机。由1-32位的纯数字或’-‘号组成。【非必须】
        /// </summary>
        public string telephone { get; set; }

        /// <summary>
        /// 自定义字段。自定义字段需要先在WEB管理端添加，见扩展属性添加方法，否则忽略未知属性的赋值。自定义字段长度为0~32个字符，超过将被截断[不使用]
        /// </summary>
        [JsonProperty(DefaultValueHandling = DefaultValueHandling.Ignore)]//默认值不序列化
        public CorpUserExtattrInfo extattr { get; set; }

        /// <summary>
        /// 是否邀请该成员使用企业微信（将通过微信服务通知或短信或邮件下发邀请，每天自动下发一次，最多持续3个工作日），默认值为true。【非必须】
        /// </summary>
        [JsonProperty(DefaultValueHandling = DefaultValueHandling.Ignore)]//默认值不序列化
        public bool to_invite { get; set; }

        /// <summary>
        /// 成员对外属性，字段详情见对外属性[不使用]
        /// </summary>
        [JsonProperty(DefaultValueHandling = DefaultValueHandling.Ignore)]//默认值不序列化
        public CorpUserExternalProfileInfo external_profile { get; set; }

        /// <summary>
        /// 头像url。注：如果要获取小图将url最后的”/0”改成”/100”即可。第三方仅通讯录应用可获取
        /// </summary>
        [JsonProperty(DefaultValueHandling = DefaultValueHandling.Ignore)]//默认值不序列化
        public string avatar { get; set; }

        /// <summary>
        ///员工个人二维码，扫描可添加为外部联系人；第三方仅通讯录应用可获取
        /// </summary>
        [JsonProperty(DefaultValueHandling = DefaultValueHandling.Ignore)]//默认值不序列化
        public string qr_code { get; set; }

        /// <summary>
        ///激活状态: 1=已激活，2=已禁用，4=未激活 已激活代表已激活企业微信或已关注微工作台（原企业号）。未激活代表既未激活企业微信又未关注微工作台（原企业号）。
        /// </summary>
        [JsonProperty(DefaultValueHandling = DefaultValueHandling.Ignore)]//默认值不序列化
        public string status { get; set; }
    }

    public class CorpUserExtattrInfo
    {
        public List<CorpUserExtattrAttrsInfo> attrs { get; set; }
    }

    public class CorpUserExtattrAttrsInfo
    {
        public string name { get; set; }
        public string value { get; set; }
    }

    public class CorpUserExternalProfileInfo
    {
        /// <summary>
        /// 属性列表，目前支持文本、网页、小程序（需参与小程序内测）三种类型
        /// </summary>
        public List<ExternalAttrInfo> external_attr { get; set; }
    }

    public class ExternalAttrInfo
    {
        /// <summary>
        /// 属性类型: 0-本文 1-网页 2-小程序
        /// </summary>
        public int type { get; set; }

        /// <summary>
        /// 属性名称： 需要先确保在管理端有创建改属性，否则会忽略
        /// </summary>
        public string name { get; set; }

        /// <summary>
        /// 文本类型的属性
        /// </summary>
        [JsonProperty(DefaultValueHandling = DefaultValueHandling.Ignore)]//默认值不序列化
        public ExternalAttrTextInfo text { get; set; }

        /// <summary>
        /// 网页类型的属性，url和title字段要么同时为空表示清除该属性，要么同时不为空
        /// </summary>
        [JsonProperty(DefaultValueHandling = DefaultValueHandling.Ignore)]//默认值不序列化
        public ExternalAttrWebInfo web { get; set; }

        /// <summary>
        /// 小程序类型的属性，appid和title字段要么同时为空表示清除改属性，要么同时不为空
        /// </summary>
        [JsonProperty(DefaultValueHandling = DefaultValueHandling.Ignore)]//默认值不序列化
        public ExternalAttrMiniprogramInfo miniprogram { get; set; }
    }

    public class ExternalAttrTextInfo
    {
        /// <summary>
        /// 文本属性内容,长度限制12个UTF8字符
        /// </summary>
        public string value { get; set; }
    }

    public class ExternalAttrWebInfo
    {
        /// <summary>
        /// 网页的url,必须包含http或者https头
        /// </summary>
        public string url { get; set; }

        /// <summary>
        /// 网页的展示标题,长度限制12个UTF8字符
        /// </summary>
        public string title { get; set; }
    }

    public class ExternalAttrMiniprogramInfo
    {
        /// <summary>
        /// 小程序appid，必须是有在本企业安装授权的小程序，否则会被忽略
        /// </summary>
        public string appid { get; set; }

        /// <summary>
        /// 小程序的页面路径
        /// </summary>
        public string pagepath { get; set; }

        /// <summary>
        /// 小程序的展示标题,长度限制12个UTF8字符
        /// </summary>
        public string title { get; set; }
    }
}
