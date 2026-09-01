using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.SDP.BLL;
using SKT.LeanMES.SDP.Model;
using AjaxPro;
using System.Data;
using System.Transactions;
using SKT.Common.Model;
using SKT.Common.Framework.Model;
using SKT.LeanMES.Web.AppCode;
using SKT.LeanMES.Lookup.Model;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Web.AjaxServices.CommonTemplate;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using SKT.LeanMES.CommonHelper.BLL;
using Newtonsoft.Json;
using System.Net;
using System.IO;
using System.Data.SqlClient;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class MeterialParam
    {
        public string ID { set; get; }
        public string IP { set; get; }
        public string Materiel { set; get; }
        public string CallbackUrl { set; get; }
    }
    public class MeterialResult
    {
        public string Status { set; get; }
        public object error { set; get; }
        public string ServerNo { set; get; }
        public int LayerNo { set; get; }
        public int PositionNo { set; get; }
    }
    public class AjaxMaterialPDA
    {
        /// <summary>
        /// 根据公共数据源ID获取公共数据源内容
        /// </summary>
        /// <param name="DataSourceId"></param>
        /// <returns></returns>
        [AjaxPro.AjaxMethod]
        public List<EquipmentsInfo> GetEquipmentAll()
        {
            SearchSettings searchSettings = new SearchSettings();
            return new SKT.LeanMES.Equipment.BLL.Equipments().GetAll(0, 100, "CreateDateTime DESC", searchSettings);
        }

        [AjaxPro.AjaxMethod]
        public List<MaterialUnitInfo> GetMaterialInfoAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            if (!String.IsNullOrEmpty(searchSettings.ExtensionCondition))
            {
                return new SKT.LeanMES.Material.BLL.MaterialUnit().GetMaterialInfoAll(startRow, maxRows, sortExpression, searchSettings);
            }
            return null;
        }

        [AjaxPro.AjaxMethod]
        public EquipmentsInfo GetEquipmentInfo(String EquipmentCode)
        {
            SKT.LeanMES.Equipment.BLL.Equipments equipmentsBLL = new LeanMES.Equipment.BLL.Equipments();
            List<EquipmentsInfo> list = equipmentsBLL.GetAll(0, 1, "EquipmentId ASC", new SearchSettings { ExtensionCondition = $"EquipmentCode='{EquipmentCode}'" });
            if (list != null && list.Count > 0)
            {
                return list[0];
            }
            return null;
        }

        /// <summary>
        /// 调用存储过程
        /// </summary>
        /// <param name="spName">存储过程</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns>strJson</returns>
        [AjaxMethod]
        public MeterialResult MaterialInStock(string strJson, byte flag = 0)
        {
            try
            {
                PDAMaterialInStockInfo entity = ComMethod.JsonToEntity<PDAMaterialInStockInfo>(strJson);
                if (entity == null)
                {
                    return new MeterialResult { Status = "-1", error = new { Message = "请填写参数" } };
                }
                //验证设备
                if (string.IsNullOrEmpty(entity.EquipmentCode))
                {
                    return new MeterialResult { Status = "-1", error = new { Message = "请填写设备编码" } };
                }
                SKT.LeanMES.Equipment.BLL.Equipments equipmentsBLL = new LeanMES.Equipment.BLL.Equipments();
                EquipmentsInfo eInfo = equipmentsBLL.GetInfo(entity.EquipmentCode, false);
                if (eInfo == null)
                {
                    return new MeterialResult { Status = "-1", error = new { Message = "设备不存在" } };
                }
                if (eInfo.EquipmentId < 1 || string.IsNullOrEmpty(eInfo.EquipmentCode))
                {
                    return new MeterialResult { Status = "-1", error = new { Message = "设备编码不存在" } };
                }
                entity.EquipmentId = eInfo.EquipmentId;
                entity.EquipmentCode = eInfo.EquipmentCode;

                //验证物料
                SKT.LeanMES.Material.BLL.MaterialUnit mbll = new LeanMES.Material.BLL.MaterialUnit();
                SearchSettings settings = new SearchSettings();
                settings.ExtensionCondition = $"a.SerialNumber='{entity.MaterialGRN}'";
                List<MaterialUnitInfo> list = mbll.GetMaterialInfoAll(0, 10, "", settings);
                if (list.Count < 1)
                {
                    return new MeterialResult { Status = "-1", error = new { Message = "物料不存在" } };
                }
                PDAMaterialInStock bll = new PDAMaterialInStock();
                foreach (MaterialUnitInfo info in list)
                {
                    entity.MaterialGRN = info.SerialNumber;
                    entity.MaterialCode = info.ItemCode;
                    entity.MaterialQty = info.Qty;
                    entity.Status = 0;
                    entity.CallbackUrl = "http://sktmes004/LJ/MobileApp/SMTWarehousingback.aspx"; ;
                    entity.CallbackResult = string.Empty;
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ServerNo = string.Empty;
                    entity.Id = bll.MaterialInStockEdit(entity, flag);
                    //请求料塔位置  
                    if (entity.Id > 0)
                    {
                        entity.Status = 0;
                        entity.ServerNo = "T21090081-1-2";
                        entity.LayerNo = 1;
                        entity.PositionNo = 2;
                        bll.MaterialInStockEdit(entity, 1);

                        /*
                        MeterialParam param = new MeterialParam();
                        param.ID = eInfo.EquipmentCode;
                        param.IP = $"http://{eInfo.EquipmentIP}:{eInfo.EquipmentPort}";
                        param.Materiel = entity.MaterialGRN;
                        param.CallbackUrl = "http://sktmes004/LJ/MobileApp/SMTWarehousingback.aspx";

                        HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://172.16.30.43:8090/MeterialTower/Save");
                        request.Method = "POST";
                        byte[] bytes = Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(param));
                        request.ContentType = "application/json; charset=UTF-8";
                        request.ContentLength = bytes.Length;
                        Stream myResponseStream = request.GetRequestStream();
                        myResponseStream.Write(bytes, 0, bytes.Length);

                        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                        StreamReader myStreamReader = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
                        string retString = myStreamReader.ReadToEnd();
                        //"{\"ID\":\"T21090081\",\"MakeRand\":\"d68ai8fnw6h2qgc2cscgum8l0y531c\",\"ServerNo\":\"GRN041185-580059568\",\"Sign\":\"1BDE0CD1E111C4E69C0538202F7F5AA4\",\"error\":\"当前手动模式\",\"LayerNo\":\"1\",\"PositionNo\":\"1\",\"Status\":\"14\",\"Materiel\":null}"
                        myStreamReader.Close();
                        myResponseStream.Close();

                        if (response != null)
                        {
                            response.Close();
                        }
                        if (request != null)
                        {
                            request.Abort();
                        }
                        MeterialResult result = ComMethod.JsonToEntity<MeterialResult>(retString);
                        if (result.Status == "0")
                        {
                            entity.Status = 1;
                            entity.ServerNo = result.ServerNo;
                            entity.LayerNo = result.LayerNo;
                            entity.PositionNo = result.PositionNo;
                            bll.MaterialInStockEdit(entity, 1);
                        }*/
                    }
                    //记录料塔位置
                }

                return new MeterialResult { Status = "0" };
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        private bool UrlCheck(string strUrl)
        {
            if (!strUrl.Contains("http://") && !strUrl.Contains("https://"))
            {
                strUrl = "http://" + strUrl;
            }
            try
            {
                HttpWebRequest myRequest = (HttpWebRequest)WebRequest.Create(strUrl);
                myRequest.Method = "HEAD";
                myRequest.Timeout = 10000;  //超时时间10秒
                HttpWebResponse res = (HttpWebResponse)myRequest.GetResponse();
                return (res.StatusCode == HttpStatusCode.OK);
            }
            catch
            {
                return false;
            }
        }
    }
}