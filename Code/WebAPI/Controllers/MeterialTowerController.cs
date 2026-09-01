
using Newtonsoft.Json;
//using SKT.LeanMES.Web.AjaxServices;
using Swashbuckle.Swagger.Annotations;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Http;
using WebAPI.Models;
using WebAPI.Ult;

namespace WebAPI.Controllers
{
    /// <summary>
    /// 料塔接口
    /// </summary>
    public class MeterialTowerController : ApiController
    {

        /// <summary>
        /// 料塔存料
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        [Route("MeterialTower/Save")]
        public async Task<dynamic> MaterialTowerSave([FromBody] MaterialTowerInParam param)
        {
            param.PositionNo = "0";
            param.LayerNo = "0";

            MaterialTowerResponse result = null;
            try
            {
                //查询料塔存储设备
                InternalMaterialTowerParam temp = new InternalMaterialTowerParam()
                {
                    ID = param.ID,
                    IP = param.IP,
                    LayerNo = "0",
                    PositionNo = "0",
                    Materiel = "",
                    OPType = "5",
                    Status = "0",
                    NextLayerNo = "0",
                    NextPositionNo = "0",
                };

                var res = await CheckMeterialInfo(temp);
                //查询空的存储位置
                if (!string.IsNullOrEmpty(res))
                {
                    var layers = res.Split(';');
                    Dictionary<string, string> positiontDic = new Dictionary<string, string>();
                    for (var i = 0; i < layers.Length; i++)
                    {
                        if (!string.IsNullOrEmpty(param.NextLayerNo) && param.NextLayerNo!="0") break;

                        var positions = layers[i].Split(':');
                        if (positions.Length == 2)
                        {
                            if (positions[1].IndexOf("0") != -1)
                            {
                                var posiontStr = positions[1].Split(',');
                                if (posiontStr.Length > 0)
                                {
                                    for (int j = 0; j < posiontStr.Length; j++)
                                    {
                                        if (posiontStr[j] == "0")
                                        {
                                            if (param.PositionNo == "0")
                                            {
                                                param.LayerNo = positions[0];
                                                param.PositionNo = (j + 1).ToString();
                                            }
                                            else if (string.IsNullOrEmpty(param.NextLayerNo))
                                            {
                                                param.NextLayerNo = positions[0];
                                                param.NextPositionNo = (j + 1).ToString();
                                                break;
                                            }
                                        }
                                    }
                                }
                                //param.LayerNo = positions[0];
                                //param.PositionNo = (positions[1].Replace(",", "").IndexOf("0") + 1).ToString();
                                //break;
                            }
                        }
                    }
                }

                if (string.IsNullOrEmpty(param.NextLayerNo))
                {
                    param.NextLayerNo = param.LayerNo;
                    param.NextPositionNo = param.PositionNo;
                }

                if (param.LayerNo == "0") {
                    return Json(new MaterialTowerResponse()
                    {
                        ID = param.ID,
                        Status = "1",
                        error = "系统错误，未找到可用存储位置！"
                    });
                }

                InternalMaterialTowerParam temp2 = new InternalMaterialTowerParam()
                {
                    ID = param.ID,
                    IP = param.IP,
                    LayerNo = param.LayerNo,
                    PositionNo = param.PositionNo,
                    Materiel = param.Materiel,
                    OPType = "1",
                    Status = "0",
                    NextLayerNo = param.LayerNo,
                    NextPositionNo = param.PositionNo,
                };

                var res2 = await HttpHelper.PostAsync(param.IP, JsonHelper.ObjectToJson(temp2));



                result = JsonHelper.JsonToObject<MaterialTowerResponse>(res2);
                result.LayerNo = param.LayerNo;
                result.PositionNo = param.PositionNo;
                result.ServerNo = temp2.ServerNo;
            }
            catch (Exception ex)
            {
                result = new MaterialTowerResponse()
                {
                    ID = param.ID,
                    Status = "1",
                    error = "系统错误，" + ex.Message
                };
            }

            return Json(result);
        }

        /// <summary>
        /// 料塔取料
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        [Route("MeterialTower/TakeOut")]
        public async Task<dynamic> MaterialTowerTakeOut([FromBody] MaterialTowerInParam param)
        {
            MaterialTowerResponse res2 = await MaterialTowerOutStorageLight(param);
            return Json(res2);
        }


        /// <summary>
        /// 料塔取料停止
        /// </summary>
        /// <param name="cancelQuantity">撤销数量</param>
        /// <param name="meterialID">设备标识</param>
        /// <returns></returns>
        [Route("MeterialTower/TakeOutCancel")]
        public async Task<dynamic> MaterialTowerTakeOutCancel([FromBody] int cancelQuantity, string meterialID)
        {
            CacheHelper.Add(meterialID, cancelQuantity);

            return Json(new MaterialTowerResponse()
            {
                ID = "",
                Status = "0",
                error = "系统错误"
            });
        }

        /// <summary>
        /// 取料亮灯
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        private async Task<MaterialTowerResponse> MaterialTowerOutStorageLight(MaterialTowerInParam param)
        {

            //取料数限制为0时，继续操作
            int cancelTime = 0;
            //终止取料，暂时用缓存处理
            if (CacheHelper.Exsits(param.ID)) cancelTime = CacheHelper.Get<int>(param.ID);
            if (cancelTime != 0)
            {
                //终止取料操作
                CacheHelper.Set(param.ID, cancelTime - 1);
                WriteTextLog("回调异常，操作终止！", "终止取料操作！", DateTime.Now);

                return new MaterialTowerResponse()
                {
                    ID = param.ID,
                    Status = "1",
                    error = "取料终止操作！"
                };
            }

            //默认值设置
            if (string.IsNullOrEmpty(param.PositionNo) || string.IsNullOrEmpty(param.LayerNo))
            {
                param.PositionNo = "1";
                param.LayerNo = "1";
            }

            InternalMaterialTowerParam temp = new InternalMaterialTowerParam()
            {
                ID = param.ID,
                IP = param.IP,
                LayerNo = param.LayerNo,
                PositionNo = param.PositionNo,
                Materiel = param.Materiel,
                OPType = "2",
                Status = "0",
                NextLayerNo = "0",
                NextPositionNo = "0",
            };

            var res = await HttpHelper.PostAsync(param.IP, JsonHelper.ObjectToJson(temp));


            //缓存记录当前指令，回写接口可以读缓存数据判断
            MaterialTowerResponse res2 = null;
            try
            {
                res2 = JsonHelper.JsonToObject<MaterialTowerResponse>(res);
                res2.ServerNo = temp.ServerNo;
            }
            catch
            {
                res2 = new MaterialTowerResponse()
                {
                    ID = temp.ID,
                    Status = "1",
                    error = "系统错误"
                };
            }
            return res2;
        }

        /// <summary>
        /// 查询所有储位有无料
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        [Route("MeterialTower/CheckMeterial")]
        //public async Task<dynamic> MaterialTowerCheckMeterial([FromBody]MaterialTowerInParam param)
        public async Task<FileStreamResult> MaterialTowerCheckMeterial([FromBody] MaterialTowerInParam param)
        {

            param.PositionNo = "0";
            param.LayerNo = "0";
            InternalMaterialTowerParam temp = new InternalMaterialTowerParam()
            {
                ID = param.ID,
                IP = param.IP,
                LayerNo = param.LayerNo,
                PositionNo = param.PositionNo,
                Materiel = param.Materiel,
                OPType = "5",
                Status = "0",
                NextLayerNo = "0",
                NextPositionNo = "0",
            };

            //缓存记录当前状态数据，回写接口可以读缓存数据判断
            var res = await CheckMeterialInfo(temp);

            List<MeterialLayers> result = new List<MeterialLayers>();
            //查询空的存储位置
            if (!string.IsNullOrEmpty(res))
            {
                var layers = res.Split(';');
                for (var i = 0; i < layers.Length; i++)
                {
                    var layer = layers[i].Split(':');
                    if (layer.Length == 2)
                    {
                        var positions = layer[1].Split(',');
                        for (int p = 0; p < positions.Length; p++)
                        {
                            var curPosiont = "";
                            if (p + 1 < 10) curPosiont += "00" + (p + 1);
                            else if (p + 1 < 100) curPosiont += "0" + (p + 1);
                            else curPosiont = (p + 1).ToString();

                            result.Add(new MeterialLayers
                            {
                                MeterialID = param.ID,
                                LayNo = layer[0],
                                PositoinNo = curPosiont
                            });
                        }
                    }
                }
            }


            return GetStream(result.Select(t => t.CompleteNo).ToList(), param.ID);
        }

        private FileStreamResult GetStream(List<string> dataList, string fileName)
        {

            var sbHtml = new StringBuilder("<html><head><meta http-equiv=Content-Type content=\"text/html; charset=utf-8\"><body>");
            sbHtml.Append("<table border='1' cellspacing='0' cellpadding='0'>");
            sbHtml.Append("<tr>");
            var lstTitle = new List<string> { "cellName" };
            foreach (var item in lstTitle)
            {
                sbHtml.AppendFormat("<td style='font-size: 14px;text-align:center;background-color: #DCE0E2; font-weight:bold;' height='25'>{0}</td>", item);
            }
            sbHtml.Append("</tr>");

            for (int i = 0; i < dataList.Count; i++)
            {
                sbHtml.Append("<tr>");
                sbHtml.AppendFormat("<td style='font-size: 12px;height:20px;'>{0}</td>", dataList[i]);
                sbHtml.Append("</tr>");
            }
            sbHtml.Append("</table></body></html>");

            //第二种:使用FileStreamResult
            byte[] fileContents = Encoding.GetEncoding("gb2312").GetBytes(sbHtml.ToString());
            var fileStream = new MemoryStream(fileContents);
            return new FileStreamResult(fileStream, "application/ms-excel", fileName + ".xls");

        }

        /// <summary>
        /// 获取设备仓储信息
        /// </summary>
        /// <param name="info"></param>
        /// <returns></returns>
        private async Task<string> CheckMeterialInfo(InternalMaterialTowerParam info)
        {
            return await HttpHelper.PostAsync(info.IP, JsonHelper.ObjectToJson(info));
        }

        /// <summary>
        /// 料塔查询真实有无料
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        [Route("MeterialTower/CheckEntity")]
        public async Task<dynamic> MaterialTowerCheckEntity([FromBody] MaterialTowerInParam param)
        {

            //默认值设置
            if (string.IsNullOrEmpty(param.PositionNo) || string.IsNullOrEmpty(param.LayerNo))
            {
                param.PositionNo = "0";
                param.LayerNo = "0";
            }

            InternalMaterialTowerParam temp = new InternalMaterialTowerParam()
            {
                ID = param.ID,
                IP = param.IP,
                LayerNo = param.LayerNo,
                PositionNo = param.PositionNo,
                Materiel = param.Materiel,
                OPType = "6",
                Status = "0"
            };

            var res = await HttpHelper.PostAsync(param.IP, JsonHelper.ObjectToJson(temp));

            //缓存记录当前指令，回写接口可以读缓存数据判断

            MaterialTowerResponse res2 = null;
            try
            {
                res2 = JsonHelper.JsonToObject<MaterialTowerResponse>(res);
            }
            catch
            {
                res2 = new MaterialTowerResponse()
                {
                    ID = temp.ID,
                    Status = "1",
                    error = "系统错误"
                };
            }

            return Json(res2);
        }

        /// <summary>
        /// 料塔清除料塔有料
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        [Route("MeterialTower/ClearPosition")]
        public async Task<dynamic> ClearPosition([FromBody] MaterialTowerInParam param)
        {

            //默认值设置
            if (string.IsNullOrEmpty(param.PositionNo) || string.IsNullOrEmpty(param.LayerNo))
            {
                param.PositionNo = "1";
                param.LayerNo = "1";
            }

            //http请求初始化
            HttpHelper.InitializeClient();

            InternalMaterialTowerParam temp = new InternalMaterialTowerParam()
            {
                ID = param.ID,
                IP = param.IP,
                LayerNo = param.LayerNo,
                PositionNo = param.PositionNo,
                Materiel = param.Materiel,
                OPType = "3",
                Status = "0"
            };

            var res = await HttpHelper.PostAsync(param.IP, JsonHelper.ObjectToJson(temp));


            //缓存记录当前指令，回写接口可以读缓存数据判断

            MaterialTowerResponse res2 = null;
            try
            {
                res2 = JsonHelper.JsonToObject<MaterialTowerResponse>(res);
                res2.ServerNo = temp.ServerNo;
            }
            catch
            {
                res2 = new MaterialTowerResponse()
                {
                    ID = temp.ID,
                    Status = "1",
                    error = "系统错误"
                };
            }

            return Json(res2);
        }
        /// <summary>
        /// 料塔清空所有储位
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        [Route("MeterialTower/ClearAll")]
        public async Task<dynamic> ClearAll([FromBody] MaterialTowerInParam param)
        {
            param.PositionNo = "0";
            param.LayerNo = "0";

            InternalMaterialTowerParam temp = new InternalMaterialTowerParam()
            {
                ID = param.ID,
                IP = param.IP,
                LayerNo = param.LayerNo,
                PositionNo = param.PositionNo,
                Materiel = param.Materiel,
                OPType = "4",
                Status = "0"
            };

            var res = await HttpHelper.PostAsync(param.IP, JsonHelper.ObjectToJson(temp));


            //缓存记录当前指令，回写接口可以读缓存数据判断

            MaterialTowerResponse res2 = null;
            try
            {
                res2 = JsonHelper.JsonToObject<MaterialTowerResponse>(res);
                res2.ServerNo = temp.ServerNo;
            }
            catch
            {
                res2 = new MaterialTowerResponse()
                {
                    ID = temp.ID,
                    Status = "1",
                    error = "系统错误"
                };
            }

            return Json(res2);
        }

        /// <summary>
        /// 料塔自检
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        [Route("MeterialTower/SelfCheck")]
        public async Task<dynamic> SelfCheck([FromBody] MaterialTowerInParam param)
        {
            param.PositionNo = "0";
            param.LayerNo = "0";

            //http请求初始化
            HttpHelper.InitializeClient();

            InternalMaterialTowerParam temp = new InternalMaterialTowerParam()
            {
                ID = param.ID,
                IP = param.IP,
                LayerNo = param.LayerNo,
                PositionNo = param.PositionNo,
                Materiel = param.Materiel,
                OPType = "8",
                Status = "0"
            };

            var res = await HttpHelper.PostAsync(param.IP, JsonHelper.ObjectToJson(temp));


            //缓存记录当前指令，回写接口可以读缓存数据判断
            MaterialTowerResponse res2 = null;
            try
            {
                res2 = JsonHelper.JsonToObject<MaterialTowerResponse>(res);
            }
            catch
            {
                res2 = new MaterialTowerResponse()
                {
                    ID = temp.ID,
                    Status = "1",
                    error = "系统错误"
                };
            }

            return Json(res2);
        }
        /// <summary>
        /// 料塔测试
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        [Route("MeterialTower/Test")]
        public async Task<dynamic> Test([FromBody] MaterialTowerInParam param)
        {

            param.PositionNo = "0";
            param.LayerNo = "0";

            InternalMaterialTowerParam temp = new InternalMaterialTowerParam()
            {
                ID = param.ID,
                IP = param.IP,
                LayerNo = param.LayerNo,
                PositionNo = param.PositionNo,
                Materiel = param.Materiel,
                OPType = "7",
                Status = "0"
            };

            var res = await HttpHelper.PostAsync(param.IP, JsonHelper.ObjectToJson(temp));

            //缓存记录当前指令，回写接口可以读缓存数据判断
            MaterialTowerResponse res2 = null;
            try
            {
                res2 = JsonHelper.JsonToObject<MaterialTowerResponse>(res);
            }
            catch
            {
                res2 = new MaterialTowerResponse()
                {
                    ID = temp.ID,
                    Status = "1",
                    error = "系统错误"
                };
            }

            return Json(res2);
        }

        /// <summary>
        /// 料塔回调接口
        /// </summary>
        /// <param name="param"></param>
        /// <returns></returns>
        [Route("MeterialTower/CallBack")]
        [HttpPost]
        public async Task<dynamic> CallBack([FromBody]MaterialTowerResponse param)
        {
            try
            {
                //状态返回1则是机器正常执行状态，回调MES业务
                if (param.Status == "1")
                {
                    //料塔-回调
                    WebAPI.MaterialTower.MaterialTower bll = new WebAPI.MaterialTower.MaterialTower();
                    var entity = new TowerGRNInfo
                    {
                        EquipmentCode = param.ID,
                        GRN = param.ServerNo.Split('_')[0],
                        LayerNo = param.LayerNo,
                        PositionNo = param.PositionNo,
                        Msg = param.error,
                    };
                    //修改GRN状态为取出
                    var item = bll.MaterialTowerCallBack(entity);

                    //获取操作类型
                    var opArr = param.MakeRand.Split('-');
                    var opType = 0;
                    if (opArr.Length == 2)
                    {
                        int.TryParse(opArr[0], out opType);
                    }


                    //if (item != null && opType == 2)
                    if (item != null)
                    {
                        new Task(() =>
                    {
                        Thread.Sleep(1000);

                        //继续调用亮灯接口，取下一个GRN
                        var inParam = new MaterialTowerInParam
                        {
                            IP = $"http://{item.EquipmentIP}:{item.EquipmentPort}",
                            ID = item.EquipmentCode,
                            Materiel = item.GRN,
                            LayerNo = item.LayerNo,
                            PositionNo = item.PositionNo,
                        };

                        WriteTextLog("继续调用取料亮灯API，取下一个GRN", JsonConvert.SerializeObject(inParam), DateTime.Now);

                        MaterialTowerResponse result = MaterialTowerOutStorageLight(inParam).Result;

                        if (result.Status != "0")
                        {
                            item.Msg = $"调用取料亮灯接口失败：{result.error},GRN[{item.GRN}]";
                            throw new Exception(item.Msg);
                        }
                        //料塔-工单取料—修改GRN状态为待取料
                        bll.MaterialTowerOutStorage(item);

                    }).Start();
                    }

                    else
                    {
                        WriteTextLog("回调异常，操作终止！", "", DateTime.Now);
                        return Json(new
                        {
                            ID = param.ID,
                            MakeRand = param.MakeRand,
                            Sign = param.Sign,
                            Status = "2",
                            error = "回调异常，操作终止！"
                        });
                    }
                }
                else
                {

                    WriteTextLog("机器运行错误！", JsonHelper.ObjectToJson(param), DateTime.Now);
                }
            }
            catch (Exception ex)
            {
                param.error = $"{param.error}{ex.Message}";
                param.Status = "2";
                WriteTextLog("回调异常", ex.Message, DateTime.Now);
            }
            var data = new
            {
                ID = param.ID,
                MakeRand = param.MakeRand,
                Sign = param.Sign,
                Status = "0",
                error = ""
            };
            return Json(data);
        }

        private void WriteTextLog(string action, string strMessage, DateTime time)
        {
            string path = AppDomain.CurrentDomain.BaseDirectory + @"\Log\";
            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);

            string fileFullPath = path + time.ToString("yyyy-MM-dd") + ".txt";
            StringBuilder str = new StringBuilder();
            str.Append("Time:    " + time.ToString() + "\r\n");
            str.Append("Action:  " + action + "\r\n");
            str.Append("Message: " + strMessage + "\r\n");
            str.Append("-----------------------------------------------------------\r\n\r\n");
            StreamWriter sw;
            if (!File.Exists(fileFullPath))
            {
                sw = File.CreateText(fileFullPath);
            }
            else
            {
                sw = File.AppendText(fileFullPath);
            }
            sw.WriteLine(str.ToString());
            sw.Close();
        }
    }
}
