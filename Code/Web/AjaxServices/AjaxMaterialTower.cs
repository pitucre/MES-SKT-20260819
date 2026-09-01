using AjaxPro;
using Newtonsoft.Json;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Plan.BLL;
using SKT.LeanMES.Plan.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxMaterialTower
    {
        TowerGRN bll = new TowerGRN();

        /// <summary>
        /// 料塔URL
        /// </summary>
        public string TowerApi { get; set; }

        public AjaxMaterialTower()
        {
            TowerApi = ConfigurationManager.AppSettings["TowerApi"].ToString();
        }

        /// <summary>
        /// 异步提交
        /// </summary>
        /// <param name="url"></param>
        /// <param name="jsonContent"></param>
        /// <param name="encoding"></param>
        /// <returns></returns>
        public static async Task<string> PostAsync(string url, string jsonContent, Encoding encoding)
        {
            using (HttpClient httpClient = new HttpClient())
            {
                //设置请求头类型为：application/json
                httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                var content = new StringContent(jsonContent, encoding, "application/json");
                //using (HttpResponseMessage responseMessage = httpClient.PostAsync($"{towerApi}Save", content).Result)
                using (HttpResponseMessage responseMessage = await httpClient.PostAsync(url, content))
                {
                    //responseMessage.EnsureSuccessStatusCode();
                    var result = await responseMessage.Content.ReadAsStringAsync();
                    return result;
                    //if (!responseMessage.IsSuccessStatusCode)
                    //{
                    //    throw new Exception(result);
                    //}
                }
            }
        }


        #region 料塔—物料入库

        /// <summary>
        /// 料塔—物料入库—调用料塔亮灯接口
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public TowerGRNInfo MaterialTowerInStorage(TowerGRNInfo entity)
        {
            TowerGRNInfo returnEntity = null;
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                //验证GRN
                var info = bll.MaterialTowerInStorageValidateGRN(entity);

                //料塔API接口地址
                if (string.IsNullOrEmpty(TowerApi))
                {
                    throw new Exception("请先配置料塔API接口地址");
                }

                var tower = new MaterialTowerInParam()
                {
                    IP = $"http://{info.EquipmentIP}:{info.EquipmentPort}",
                    ID = entity.EquipmentCode,
                    Materiel = entity.GRN
                };
                var jsonContent = JsonConvert.SerializeObject(tower);

                //调用亮灯接口
                //var returnInfo = await PostAsync($"{towerApi}Save", jsonContent, Encoding.UTF8);
                var returnInfo = PostAsync($"{TowerApi}Save", jsonContent, Encoding.UTF8).Result;

                //解析接口返回数据
                MaterialTowerResponse result = JsonConvert.DeserializeObject<MaterialTowerResponse>(returnInfo);

                if (result.Status != "0")
                {
                    throw new Exception($"调用料架亮灯接口失败：{result.error.ToString()}");
                }
                entity.LayerNo = result.LayerNo.ToString();
                entity.PositionNo = result.PositionNo.ToString();

                //调用亮灯接口后，记录GRN状态为待存料
                returnEntity = bll.MaterialTowerInStorage(entity);

                return returnEntity;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }


        /// <summary>
        /// 料塔-物料入库—查看存料结果
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<TowerGRNInfo> MaterialTowerInStorageQueryResult(string grns)
        {
            try
            {
                return bll.MaterialTowerInStorageQueryResult(new TowerGRNInfo { ModifyBy = AccountController.GetCurrentUser().UserName }, grns);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        #endregion


        #region 料塔-工单取料

        /// <summary>
        /// 料塔-工单取料—获取投产中的工单
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<LinePlanOrderInfo> GetPlanOrderList(LinePlanOrderInfo entity)
        {
            try
            {
                var bll = new LinePlan();

                var where = "  StatusId = 2 AND TableName !='''' "; //获取投产中的排程单
                entity.FBILLNO = entity.FBILLNO?.Replace("'", string.Empty).Trim();
                if (!string.IsNullOrEmpty(entity.FBILLNO))
                {
                    where += $" AND FBILLNO LIKE '{entity.FBILLNO}%'";
                }
                var ss = new Common.Model.SearchSettings()
                {
                    ExtensionCondition = where
                };
                return bll.GetPlanOrderAll(1, 20, "FBILLNO", ss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 料塔-工单取料-备料—获取接料看板预警GRN
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<TowerGRNInfo> MaterialTowerGetPlanWarnGRN(TowerGRNInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                return bll.MaterialTowerGetPlanWarnGRN(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 料塔—工单取料—取料
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<TowerGRNInfo> MaterialTowerOutStorage(TowerGRNInfo entity)
        {
            List<TowerGRNInfo> list = null;
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                //验证GRN是否能取出
                list = bll.MaterialTowerOutStorageGRNInfo(entity);

                //料塔API接口地址
                if (string.IsNullOrEmpty(TowerApi))
                {
                    throw new Exception("请先配置料塔API接口地址");
                }

                var item = list[0];//料塔一次只能发送一个指令，调用取料亮灯接口后，必须手动取料后，触发回调接口，回调接口中继续调用亮灯接口
                if (item == null)
                {
                    throw new Exception("没有需要取料的数据");
                }
                item.ModifyBy = AccountController.GetCurrentUser().UserName;
                var tower = new MaterialTowerInParam()
                {
                    IP = $"http://{item.EquipmentIP}:{item.EquipmentPort}",
                    ID = item.EquipmentCode,
                    Materiel = item.GRN,
                    LayerNo = item.LayerNo,
                    PositionNo = item.PositionNo,
                };
                var jsonContent = JsonConvert.SerializeObject(tower);

                //调用取料亮灯接口
                var returnInfo = PostAsync($"{TowerApi}TakeOut", jsonContent, Encoding.UTF8).Result;

                //解析接口返回数据
                MaterialTowerResponse result = JsonConvert.DeserializeObject<MaterialTowerResponse>(returnInfo);

                if (result.Status != "0")
                {
                    item.Msg = $"调用料架取料亮灯接口失败：{result.error.ToString()},GRN[{item.GRN}]";
                    throw new Exception(item.Msg);
                }

                //更新领料单状态为已进行料塔取料
                if (!string.IsNullOrEmpty(entity.ApplyNo))
                {
                    UpdateMaterialTowerApplyFirstFlag(entity);
                }

                //料塔-工单取料—修改GRN状态为待取料
                bll.MaterialTowerOutStorage(item);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }


        ///// <summary>
        ///// 料塔-工单取料—获取领料单信息
        ///// </summary>
        ///// <param name="entity"></param>
        ///// <returns></returns>
        //[AjaxMethod]
        //public List<ApplyInfo> GetApplyInfo(ApplyInfo entity)
        //{
        //    try
        //    {
        //        var bll = new Apply();
        //        entity.ApplyNo = entity.ApplyNo?.Replace("'", string.Empty).Trim();
        //        entity.ItemCode = entity.ItemCode?.Replace("'", string.Empty).Trim();
        //        if (string.IsNullOrEmpty(entity.ApplyNo))
        //        {
        //            throw new Exception("请输入领料单号");
        //        }
        //        var where = $" ApplyNo = '{entity.ApplyNo}'";//获取领料单，不需要区分状态
        //        if (!string.IsNullOrEmpty(entity.ItemCode))
        //        {
        //            where += $" AND ItemCode = '{entity.ItemCode}'";
        //        }
        //        var ss = new Common.Model.SearchSettings()
        //        {
        //            ExtensionCondition = where
        //        };
        //        var list = bll.GetAll(-1, int.MaxValue, "ApplyId DESC", ss);
        //        return list;
        //    }
        //    catch (Exception ex)
        //    {
        //        WebHelper.HandleException(ex);
        //        return null;
        //    }
        //}

        /// <summary>
        /// 料塔-工单取料—备料-获取领料单明细GRN
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<TowerGRNInfo> MaterialTowerGetApplyGRN(TowerGRNInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                return bll.MaterialTowerGetApplyGRN(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 料塔-工单取料-按领料单号取料-更新是否领取首套料标识
        /// </summary>
        /// <param name="entity"></param>
        public void UpdateMaterialTowerApplyFirstFlag(TowerGRNInfo entity)
        {
            string sql = @"UPDATE pa SET pa.MaterialTowerApplyFirst = 1,pa.ModifyBy = ModifyBy,pa.ModifyDateTime = GETDATE() FROM dbo.Prod_Apply pa WHERE pa.ApplyNo = @ApplyNo";

            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@ApplyNo", SqlDbType.VarChar) { Value = entity.ApplyNo },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar) { Value = entity.ModifyBy },
            };

            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sql, parms);
        }


        #endregion


        #region 料塔-清空


        /// <summary>
        /// 料塔-清空—根据设备获取料塔中的GRN
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="flag">0：获取列表 1：获取单个实体</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<TowerGRNInfo> GetMaterialTowerEquipmentCodeList(TowerGRNInfo entity, int flag)
        {
            try
            {
                var where = "1 = 1";
                int maxCount;
                entity.EquipmentCode = entity.EquipmentCode?.Replace("'", string.Empty).Trim();
                entity.ItemCode = entity.ItemCode?.Replace("'", string.Empty).Trim();

                if (flag == 1)
                {
                    //只查单个实体
                    maxCount = 1;
                    if (string.IsNullOrEmpty(entity.EquipmentCode))
                    {
                        throw new Exception("请输入设备编码");
                    }
                    where += $"  AND EquipmentCode = '{entity.EquipmentCode}'";
                }
                else
                {
                    maxCount = 20;
                    //模糊查询
                    if (!string.IsNullOrEmpty(entity.EquipmentCode))
                    {
                        where += $" AND EquipmentCode LIKE '{entity.EquipmentCode}%'";
                    }
                }
                if (!string.IsNullOrEmpty(entity.ItemCode))
                {
                    where += $" AND ItemCode = '{entity.ItemCode}'";
                }
                var ss = new Common.Model.SearchSettings()
                {
                    ExtensionCondition = where
                };
                return bll.GetMaterialTowerEquipmentCodeAll(1, maxCount, "EquipmentCode", ss);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }

        /// <summary>
        /// 料塔-清空—根据设备获取料塔中的GRN
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="flag">0：获取列表 1：获取单个实体</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<TowerGRNInfo> GetMaterialTowerGRN(TowerGRNInfo entity)
        {
            try
            {
                return bll.GetMaterialTowerGRN(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }


        #endregion


        /// <summary>
        /// 取消取料
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void MaterialTowerCancelOutStorage(TowerGRNInfo entity)
        {
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                bll.MaterialTowerCancelOutStorage(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }


        #region 料塔-查询

        /// <summary>
        /// 料塔-清空—根据设备获取料塔中的GRN
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [AjaxMethod]
        public List<TowerGRNInfo> GetMaterialTowerGRNList(TowerGRNInfo entity)
        {
            try
            {
                return bll.GetMaterialTowerGRNList(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return null;
            }
        }
        #endregion

    }

    /// <summary>
    /// 料塔GRN
    /// </summary>
    public class TowerGRN
    {

        #region 料塔—物料入库

        /// <summary>
        /// 料塔对接—验证设备、GRN
        /// </summary>
        /// <param name=""></param>
        public TowerGRNInfo MaterialTowerInStorageValidateGRN(TowerGRNInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 50) { Value = entity.EquipmentCode },
                new SqlParameter("@GRN", SqlDbType.VarChar, 50) { Value = entity.GRN },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            return ComMethod.Get<TowerGRNInfo>("uspMaterialTowerInStorageValidateGRN", parms);
        }

        /// <summary>
        /// 料塔对接—记录GRN状态为待存料
        /// </summary>
        /// <param name=""></param>
        public TowerGRNInfo MaterialTowerInStorage(TowerGRNInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 50) { Value = entity.EquipmentCode },
                new SqlParameter("@GRN", SqlDbType.VarChar, 50) { Value = entity.GRN },
                new SqlParameter("@LayerNo", SqlDbType.VarChar, 5) { Value = entity.LayerNo },
                new SqlParameter("@PositionNo", SqlDbType.VarChar, 10) { Value = entity.PositionNo },
                new SqlParameter("@ActionType", SqlDbType.Int) { Value = 0 },
                new SqlParameter("@TowerMsg", SqlDbType.NVarChar, 4000) { Value = entity.Msg },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            return ComMethod.Get<TowerGRNInfo>("uspMaterialTowerInStorage", parms);
        }

        /// <summary>
        /// PDA料塔-物料入库—确认（只是验证存料结果）
        /// </summary>
        /// <param name=""></param>
        public List<TowerGRNInfo> MaterialTowerInStorageQueryResult(TowerGRNInfo entity, string grns)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@GRNs", SqlDbType.VarChar, -1) { Value = grns },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            return ComMethod.GetList<TowerGRNInfo>("uspMaterialTowerInStorageQueryResult", parms);
        }

        #endregion


        #region 料塔-工单取料

        /// <summary>
        /// 料塔-工单取料-备料—获取接料看板预警GRN
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<TowerGRNInfo> MaterialTowerGetPlanWarnGRN(TowerGRNInfo entity)
        {
            entity.ModifyBy = AccountController.GetCurrentUser().UserName;

            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@FBILLNO", SqlDbType.VarChar, 50) { Value = entity.FBILLNO },
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50) { Value = entity.ItemCode },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            return ComMethod.GetList<TowerGRNInfo>("uspMaterialTowerGetPlanWarnGRN", parms);
        }

        /// <summary>
        /// 料塔-工单取料—获取GRN明细信息
        /// </summary>
        /// <param name="entity"></param>
        /// <param name="grns"></param>
        public List<TowerGRNInfo> MaterialTowerOutStorageGRNInfo(TowerGRNInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@GRNs", SqlDbType.VarChar, -1) { Value = entity.GRN },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            return ComMethod.GetList<TowerGRNInfo>("uspMaterialTowerOutStorageGRNInfo", parms);
        }

        /// <summary>
        /// 料塔-工单取料—取料
        /// </summary>
        /// <param name="entity"></param>
        public void MaterialTowerOutStorage(TowerGRNInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
                        {
                new SqlParameter("@GRN", SqlDbType.VarChar, 50) { Value = entity.GRN },
                new SqlParameter("@ActionType", SqlDbType.Int) { Value = 0 },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
                        };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaterialTowerOutStorage", parms);
        }

        /// <summary>
        /// 料塔-工单取料—取料
        /// </summary>
        /// <param name=""></param>
        public void MaterialTowerOutStorageConfirm(TowerGRNInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@GRNs", SqlDbType.VarChar, -1) { Value = entity.GRN },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaterialTowerOutStorageConfirm", parms);
        }


        /// <summary>
        /// 料塔-工单取料—备料-获取领料单明细GRN
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<TowerGRNInfo> MaterialTowerGetApplyGRN(TowerGRNInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@ApplyNo", SqlDbType.VarChar, 50) { Value = entity.ApplyNo },
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50) { Value = entity.ItemCode },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            return ComMethod.GetList<TowerGRNInfo>("uspMaterialTowerGetApplyGRN", parms);
        }

        #endregion


        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 料塔设备 列表数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<TowerGRNInfo> GetMaterialTowerEquipmentCodeAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string columns = "EquipmentCode,EquipmentName";
            return ComMethod.GetComList<TowerGRNInfo>(ref this.recordCount, startRow, maxRows, "vwMaterialTowerEquipmentCode", string.Empty, columns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 获取料塔中的GRN
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<TowerGRNInfo> GetMaterialTowerGRN(TowerGRNInfo entity)
        {
            string sql = @"SELECT vw.EquipmentCode,vw.GRN,vw.cBarCode,vw.ItemCode,vw.Status,vw.BatchNo,vw.BalanceQty FROM dbo.vwMaterialTowerEquipmentGRN vw WHERE vw.Status = 1 AND vw.EquipmentCode = @EquipmentCode";
            entity.ItemCode = entity.ItemCode?.Replace("'", string.Empty).Trim();
            if (!string.IsNullOrEmpty(entity.ItemCode))
            {
                sql += " AND vw.ItemCode = @ItemCode ";
            }
            sql += " ORDER BY vw.EquipmentCode,vw.ItemCode,vw.BalanceQty,vw.CreateDateTime";

            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 50) { Value = entity.EquipmentCode },
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50) { Value = entity.ItemCode },
            };
            return ComMethod.GetListBySql<TowerGRNInfo>(sql, parms);
        }


        /// <summary>
        /// 获取料塔中的GRN
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<TowerGRNInfo> GetMaterialTowerGRNList(TowerGRNInfo entity)
        {
            string sql = @"SELECT vw.EquipmentCode,vw.GRN,vw.cBarCode,vw.ItemCode,vw.Status,vw.BatchNo,vw.BalanceQty,vw.StatusName FROM dbo.vwMaterialTowerEquipmentGRN vw WHERE vw.Status IN (0,1,2)";

            entity.EquipmentCode = entity.EquipmentCode?.Replace("'", string.Empty).Trim();
            entity.ItemCode = entity.ItemCode?.Replace("'", string.Empty).Trim();

            if (!string.IsNullOrEmpty(entity.EquipmentCode))
            {
                sql += " AND vw.EquipmentCode = @EquipmentCode ";
            }
            if (!string.IsNullOrEmpty(entity.ItemCode))
            {
                sql += " AND vw.ItemCode = @ItemCode ";
            }
            sql += " ORDER BY vw.EquipmentCode,vw.ItemCode,vw.CreateDateTime";

            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar, 50) { Value = entity.EquipmentCode },
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50) { Value = entity.ItemCode },
            };
            return ComMethod.GetListBySql<TowerGRNInfo>(sql, parms);
        }


        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 取消取料
        /// </summary>
        /// <param name=""></param>
        public void MaterialTowerCancelOutStorage(TowerGRNInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@BatchNo", SqlDbType.VarChar, 50) { Value = entity.BatchNo },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaterialTowerCancelOutStorage", parms);
        }


    }

    /// <summary>
    /// 料塔存料—MES发送给API的接口实体
    /// </summary>
    public class MaterialTowerInParam
    {
        /// <summary>
        /// 设备IP
        /// </summary>
        public string IP { get; set; }

        /// <summary>
        /// 料塔设备编码
        /// </summary>
        public string ID { get; set; }

        /// <summary>
        /// 物料编码（可为空）
        /// </summary>
        public string Materiel { get; set; }

        /// <summary>
        /// 回调接口
        /// </summary>
        public string ReIp { get; set; }

        /// <summary>
        /// 层号
        /// </summary>
        public string LayerNo { get; set; }

        /// <summary>
        /// 储位号
        /// </summary>
        public string PositionNo { get; set; }

    }


    /// <summary>
    /// 料塔操作接口返回参数
    /// </summary>
    public class MaterialTowerResponse
    {
        /// <summary>
        /// 料塔设备编码
        /// </summary>
        public string ID { get; set; }
        /// <summary>
        /// 30个随机字符0-9 a-f A-F 
        /// </summary>
        public string MakeRand { get; set; }
        /// <summary>
        /// 服务号（唯一，MES生成）
        /// </summary>
        public string ServerNo { get; set; }
        /// <summary>
        /// 校验码（ApiKey+ID+MakeRand）MD5加密，ApiKey为料塔提供的固定字符串;ID为设备编码
        /// </summary>
        public string Sign { get; set; }
        /// <summary>
        /// 错误信息
        /// </summary>
        public string error { get; set; }
        /// <summary>
        /// 料塔层号
        /// </summary>
        public string LayerNo { get; set; }
        /// <summary>
        /// 料塔储位号
        /// </summary>
        public string PositionNo { get; set; }
        /// <summary>
        /// 状态码【0.正常;1.下达存入操作指令（该料位有料）记录或下达取出操作指令（该料位无料）记录 ;2.设备报警;3.错误指令（没有记录） ;4.该层电机正在操作;5.该服务号层错误（不在正常范围内） ;
        /// 6.该服务号料位号错误  ;7.该服务号操作类型错误 ;8.下达存入操作指令（有层在运行不能执行存操作） ;9.下达取出操作指令（非在取状态下执行取操作） ;10.下达设备物料清空操作指令（只能有一条记录） ;
        /// 11.下达询问层、料位数量指令（只能有一条记录） ;12.下达存入操作指令（有层在运行）;13.下达设备物料清空操作指令（有层在运行）;14.当前手动模式;15.设备ID错误或者检验码错误 ;】 
        /// </summary>
        public string Status { get; set; }
        /// <summary>
        /// 物料编码（查询真实有无料时，此时Materiel字段标识有无料，0无料，1有料））
        /// </summary>
        public string Materiel { get; set; }
    }

    /// <summary>
    /// 料塔GRN实体
    /// </summary>
    public class TowerGRNInfo
    {
        /// <summary>
        /// 料塔-GRN信息表Id
        /// </summary>
        public int TowerGRNId { get; set; }

        /// <summary>
        /// 设备编码
        /// </summary>
        public string EquipmentCode { get; set; }

        /// <summary>
        /// GRN
        /// </summary>
        public string GRN { get; set; }

        /// <summary>
        /// 层码
        /// </summary>
        public string LayerNo { get; set; }

        /// <summary>
        /// 位号
        /// </summary>
        public string PositionNo { get; set; }

        /// <summary>
        /// 库位条码
        /// </summary>
        public string cBarCode { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 状态（0：待存料 1：在库 2：待取出 3：取出）
        /// </summary>
        public int? Status { get; set; }

        /// <summary>
        /// 消息
        /// </summary>
        public string Msg { get; set; }

        /// <summary>
        /// 批次号（取料时，需要连续取料，相同批次号的表示同一批需要取料的数据）
        /// </summary>
        public string BatchNo { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }

        /// <summary>
        /// 料塔IP地址
        /// </summary>
        public string EquipmentIP { get; set; }

        /// <summary>
        /// 料塔端口号
        /// </summary>
        public string EquipmentPort { get; set; }

        /// <summary>
        /// GRN可用数量
        /// </summary>
        public decimal BalanceQty { get; set; }

        /// <summary>
        /// 排程单号
        /// </summary>
        public string FBILLNO { get; set; }

        /// <summary>
        /// 需求数量
        /// </summary>
        public decimal NeedQty { get; set; }

        /// <summary>
        /// 领料单号
        /// </summary>
        public string ApplyNo { get; set; }

        /// <summary>
        /// 料塔GRN状态
        /// </summary>
        public string StatusName { get; set; }

    }


}