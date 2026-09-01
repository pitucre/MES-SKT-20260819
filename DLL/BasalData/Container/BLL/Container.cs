using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Container.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Container.BLL
{
    public class Container
    {
        #region 容器维护
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Container 信息。
        /// </summary>
        /// <param name="entity">Container 实体对象。</param>
        public Int32 Edit(ContainerInfo entity, string PLStr, string PLVStr, string RevStr, string SOIDStr, string MinQStr, string MaxQStr, string PLVIDStr, string SeaStr, string DIDStr, string CDIDStr)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ContainerId", SqlDbType.Int),
                new SqlParameter("@Name", SqlDbType.NVarChar, 50),
                new SqlParameter("@Description", SqlDbType.NVarChar, 50),
                new SqlParameter("@DataTypeId", SqlDbType.Int),
                new SqlParameter("@Height", SqlDbType.Decimal),
                new SqlParameter("@Width", SqlDbType.Decimal),
                new SqlParameter("@Depth", SqlDbType.Decimal),
                new SqlParameter("@Weight", SqlDbType.Decimal),
                new SqlParameter("@MaxFillWeight", SqlDbType.Decimal),
                new SqlParameter("@Status", SqlDbType.VarChar, 40),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@MixShopOrders", SqlDbType.Bit),

                new SqlParameter("@PLStr",  SqlDbType.NVarChar, 1000),
                new SqlParameter("@PLVStr", SqlDbType.NVarChar, 1000),
                new SqlParameter("@RevStr", SqlDbType.NVarChar, 1000),
                new SqlParameter("@SOIDStr", SqlDbType.NVarChar, 1000),
                new SqlParameter("@MinQStr", SqlDbType.NVarChar, 1000),
                new SqlParameter("@MaxQStr", SqlDbType.NVarChar, 1000),
                new SqlParameter("@PLVIDStr", SqlDbType.NVarChar, 1000),
                new SqlParameter("@SeaStr", SqlDbType.NVarChar, 1000),
                new SqlParameter("@DIDStr", SqlDbType.NVarChar, 1000),
                new SqlParameter("@CDIDStr", SqlDbType.NVarChar, 1000),             
                new SqlParameter("@MixItems", SqlDbType.Bit),
                new SqlParameter("@Sequence", SqlDbType.Bit)
            };
          
            parms[0].Value = entity.ContainerId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Name;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.DataTypeId;
            parms[4].Value = entity.Height;
            parms[5].Value = entity.Width;
            parms[6].Value = entity.Depth;
            parms[7].Value = entity.Weight;
            parms[8].Value = entity.MaxFillWeight;
            parms[9].Value = entity.Status;
            parms[10].Value = entity.ModifyBy;
            parms[11].Value = entity.CreateBy;
            parms[12].Value = entity.MixShopOrders;

            parms[13].Value = PLStr;
            parms[14].Value = PLVStr;
            parms[15].Value = RevStr;
            parms[16].Value = SOIDStr;
            parms[17].Value = MinQStr;
            parms[18].Value = MaxQStr;
            parms[19].Value = PLVIDStr;
            parms[20].Value = SeaStr;
            parms[21].Value = DIDStr;
            parms[22].Value = CDIDStr;
            parms[23].Value = entity.MixItems;
            parms[24].Value = entity.Sequence;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Container_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ContainerId 字符串删除 Container 信息。
        /// </summary>
        /// <param name="idString">ContainerId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Container_Delete", parms);
        }

        /// <summary>
        /// 根据 ContainerId 获取实体信息。
        /// </summary>
        /// <param name="containerId">ContainerId。</param>
        /// <returns>Container 实体对象。</returns>
        public ContainerInfo GetInfo(Int32 containerId)
        {
            ContainerInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@containerId", SqlDbType.Int)
            };

            parms[0].Value = containerId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Container_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ContainerInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetDecimal(4), 
                        rdr.GetDecimal(5), rdr.GetDecimal(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetBoolean(14));
                    entity.DataTypeName = rdr.GetString(15);
                    entity.MixItems = rdr.GetBoolean(16);
                    entity.Sequence = rdr.GetBoolean(17);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Container 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="containerCount">container 总数。</param>
        /// <returns>Container 列表。</returns>
        public List<ContainerInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ContainerInfo> list = new List<ContainerInfo>();
            ContainerInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwContainerDataType", "[ContainerId]",
             "[ContainerId], [Name], [Description], [DataTypeId], [Height], [Width], [Depth], [Weight], [MaxFillWeight], [Status], [ModifyDateTime], [ModifyBy], [CreateDateTime], [CreateBy], [MixShopOrders],[DataTypeName], [MixItems],IsPackBySeq ,PackingValue", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ContainerInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetDecimal(4), 
                        rdr.GetDecimal(5), rdr.GetDecimal(6), rdr.GetDecimal(7), rdr.GetDecimal(8), rdr.GetString(9), 
                        rdr.GetDateTime(10), rdr.GetString(11), rdr.GetDateTime(12), rdr.GetString(13), rdr.GetBoolean(14));
                    entity.DataTypeName = rdr.GetString(15);
                    entity.MixItems = rdr.GetBoolean(16);
                    entity.Sequence = rdr.GetBoolean(17);
                    entity.PackingValue = rdr.GetString(18);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
        #endregion

        #region 包装打印更重打印
        public int GetNextIDByTypeValue(string typeValue)
        {
            int nextId = 0;
            SqlParameter[] parms = new SqlParameter[]
            {
                  new SqlParameter("@TypeValue",SqlDbType.NVarChar,50),
                  new SqlParameter("@NextID",SqlDbType.Int)
            };
            parms[0].Value = typeValue;
            parms[1].Value = nextId;
            parms[1].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetNextIDByTypeValue", parms);
            return Convert.ToInt32(parms[1].Value);
        }

        /// <summary>
        /// 产生容器序列号
        /// </summary>
        /// <param name="NextID">产生序号所用规则ID</param>
        /// <param name="Qty">数量</param>        
        /// <param name="UserID">用户ID</param>
        /// <returns></returns>
        public string PrintMoreCaronSNStr(int NextID, int Qty, int ContainerID, int OpeID, int ResID, int UserID)
        {
            string containerNumber = "";

            //string strPrefix = "";
            //string strSuffix = "";
            //产生前缀后缀
            //SKT.MES.BasalData.BLL.NextNumber bllHeader = new NextNumber();
            //SKT.MES.BasalData.Model.NextNumberInfo model = new NextNumberInfo();
            //model = bllHeader.GetInfo(NextID);
            //strPrefix = getPrefixSN(model.Prefix, model.Type_Value, model.Revision);
            //strSuffix = getPrefixSN(model.Suffix, model.Type_Value, model.Revision);
            //SqlParameter[] parms = new SqlParameter[]{
            //        new SqlParameter("@NextID",SqlDbType.Int),
            //        new SqlParameter("@ReleaseQty",SqlDbType.Int),
            //        new SqlParameter("@Prefix",SqlDbType.NVarChar,50),
            //        new SqlParameter("@Suffix",SqlDbType.NVarChar,50),
            //        new SqlParameter("@ContainerID",SqlDbType.Int),
            //        new SqlParameter("@OpeID",SqlDbType.Int),
            //        new SqlParameter("@ResID",SqlDbType.Int),
            //        new SqlParameter("@UserID",SqlDbType.Int),
            //        new SqlParameter("@conDataNumber",SqlDbType.NVarChar,1000)
            //    };
            //parms[0].Value = NextID;
            //parms[1].Value = Qty;
            //parms[2].Value = strPrefix;
            //parms[3].Value = strSuffix;
            //parms[4].Value = ContainerID;
            //parms[5].Value = OpeID;
            //parms[6].Value = ResID;
            //parms[7].Value = UserID;
            //parms[8].Value = containerNumber;
            //parms[8].Direction = ParameterDirection.InputOutput;
            //SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspPrintMoreCaronSNStr", parms);

            //containerNumber = (String)parms[8].Value;
            return containerNumber;

        }

        #endregion

        #region 私有方法
        /// <summary>
        /// 产生前缀部分
        /// </summary>
        /// <param name="strPrefix">前缀表达式</param>
        /// /// <param name="strItem">关联Item</param>
        /// /// <param name="strVer">关联Item版本</param>
        /// <returns></returns>
        private string getPrefixSN(string strPrefix, string strItem, string strVer)
        {
            string strResult = "";
            string strTemp = "";
            string strVar = "";
            string strPrefixN = "";//用来保存取得用户自定义函数值后的前缀
            int i = 0;
            int j = 0;
            int k = 0;
            strPrefixN = GetUDPValue(strPrefix, strItem, strVer);
            strTemp = strPrefixN;
            do
            {
                i = strTemp.IndexOf("%");
                if (i == -1) //前缀结尾为固定字符
                {
                    strResult += strTemp;
                    break;
                }
                else //前缀开头或中间为固定字符
                {
                    strResult += strTemp.Substring(0, i);
                }
                strTemp = strTemp.Substring(i + 1);
                j = strTemp.IndexOf("%");
                k += i;
                strVar = strPrefixN.Substring(k, j + 2);
                strResult += GetVarValue(strVar);
                strTemp = strTemp.Substring(j + 1);
                k += j + 2;
            } while (i >= 0);
            return strResult;
        }

        /// <summary>
        /// 得到用户自定义存储过程结果
        /// </summary>
        /// <param name="strPrefix"></param>
        /// <returns></returns>
        private string GetUDPValue(string strPrefix, string strItem, string strVer)
        {
            string strResult = "";
            string strTemp = "";
            string strVar = "";
            int i = 0;
            int j = 0;
            int k = 0;
            strTemp = strPrefix;
            do
            {
                i = strTemp.IndexOf("[");
                if (i == -1) //前缀结尾为固定字符
                {
                    strResult += strTemp;
                    break;
                }
                else //前缀开头或中间为固定字符
                {
                    strResult += strTemp.Substring(0, i);
                }
                strTemp = strTemp.Substring(i + 1);
                j = strTemp.IndexOf("]");
                k += i;
                strVar = strPrefix.Substring(k + 1, j);
                strResult += GetUDPValueFromDB(strVar, strItem, strVer);
                strTemp = strTemp.Substring(j + 1);
                k += j + 2;
            } while (i >= 0);
            return strResult;
        }

        /// <summary>
        /// 通过执行存储过程返回结果
        /// </summary>
        /// <param name="strName"></param>
        /// <param name="strItem"></param>
        /// <param name="strVer"></param>
        /// <returns></returns>
        private string GetUDPValueFromDB(string strName, string strItem, string strVer)
        {
            string strResult = "";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Item", SqlDbType.VarChar, 50),
                new SqlParameter("@Revision", SqlDbType.VarChar, 5),
                new SqlParameter("@Result", SqlDbType.VarChar, 30)
            };
            parms[0].Value = strItem;
            parms[1].Value = strVer;
            parms[2].Value = strResult;
            parms[2].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, strName, parms);
            return parms[2].Value.ToString();
        }

        /// <summary>
        /// 获取变量的值
        /// </summary>
        /// <returns></returns>
        private string GetVarValue(string strVar)
        {
            string strResult = "";
            switch (strVar)
            {
                case "%YEAR%":
                    strResult = DateTime.Now.Year.ToString();
                    break;
                case "%MONTH%":
                    strResult = DateTime.Now.Month.ToString();
                    if (strResult.Length < 2)
                    {
                        strResult = "0" + strResult;
                    }
                    break;
                case "%DAY%":
                    strResult = DateTime.Now.ToString("dd");
                    break;
                case "%DATE_TIME%":
                    strResult = DateTime.Now.ToString("yyyyMMddHHmmss");
                    break;
                case "%HOUR%":
                    strResult = DateTime.Now.Hour.ToString();
                    break;
                case "%MINUTE%":
                    strResult = DateTime.Now.Minute.ToString();
                    break;
                case "%SECOND%":
                    strResult = DateTime.Now.Second.ToString();
                    break;
                case "%2D_YEAR%":
                    strResult = DateTime.Now.ToString("yy");
                    break;
                case "%DAY_OF_WEEK%":
                    strResult = Convert.ToInt16(DateTime.Now.DayOfWeek).ToString();
                    break;
                case "%DAY_OF_YEAR%":
                    strResult = Convert.ToInt16(DateTime.Now.DayOfYear).ToString();
                    break;
                case "%WEEK_OF_YEAR%":
                    System.Globalization.GregorianCalendar gc = new System.Globalization.GregorianCalendar();
                    strResult = gc.GetWeekOfYear(DateTime.Now, System.Globalization.CalendarWeekRule.FirstDay, DayOfWeek.Monday).ToString();
                    break;
                default:
                    break;
            }
            return strResult;
        }

        #endregion
    }
}