using System.Collections.Generic;

namespace SKT.LeanMES.ERP
{
    public class MODocCompleteMoRequest
    {
        public string OtherID { get; set; }
        public int ID { get; set; }
        public OrgInfo Org { get; set; }
        public string DocNo { get; set; }
        public bool OperateType { get; set; }
        public bool OperateResult { get; set; }
        public string ErrorMsg { get; set; }
        public string OperateOn { get; set; }
        public decimal OperateQty { get; set; }
        public string OperateBy { get; set; }
    }

    public class OrgInfo
    {
        public int ID { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
    }

    public class MODocCompleteMoResponse
    {
        public int ResCode { get; set; }
        public string ResMsg { get; set; }
        public bool Success { get; set; }
        public List<MODocCompleteMoData> Data { get; set; }
        public string Exception { get; set; }
    }

    public class MODocCompleteMoData
    {
        public string u9c_version { get; set; }
        public bool m_isSucess { get; set; }
        public string m_otherID { get; set; }
        public string m_iD { get; set; }
        public string m_code { get; set; }
        public string m_errorMsg { get; set; }
        public string m_datas { get; set; }
    }

    public class MiscRcvTransCreateResponse
    {
        public int ResCode { get; set; }
        public string ResMsg { get; set; }
        public bool Success { get; set; }
        public List<MiscRcvTransCreateData> Data { get; set; }
    }

    public class MiscRcvTransCreateData
    {
        public bool IsSucess {  get; set; }
        public string U9CVersion { get; set; }
        public string OtherID { get; set; }
        public string ID { get; set; }
        public string Code { get; set; }
        public string ErrorMsg { get; set; }
    }

}
