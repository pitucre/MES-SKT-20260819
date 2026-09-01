using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SerialNumber.Model;

using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.SerialNumber.BLL
{
    public class SerialNumber
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 传入参数产生序列号
        /// </summary>
        /// <returns></returns>
        public string GetSampleSFC(int nextID, string currentSequence)
        {
            string strResult = "";

            string strPrefix = "";
            string strSuffix = "";
            string strSN = "";
            //产生前缀后缀
            SKT.LeanMES.SerialNumber.BLL.SerialNumber bllHeader = new SerialNumber();
            SKT.LeanMES.SerialNumber.Model.SerialNumberInfo model = new SerialNumberInfo();
            model = bllHeader.GetInfo(nextID);
            strPrefix = getPrefixSN(model.Prefix, model.Type_Value, model.Revision);
            strSuffix = getPrefixSN(model.Suffix, model.Type_Value, model.Revision);
            //产生序列号
            SKT.LeanMES.SerialNumber.BLL.SerialNumberSeed bllDetail = new SerialNumberSeed();
            SKT.LeanMES.SerialNumber.Model.SerialNumberSeedInfo modelD = new SerialNumberSeedInfo();
            modelD = bllDetail.GetInfo(nextID);
            strSN = GetSampleSN(currentSequence.Trim(), modelD.Sequence_Length);
            strResult = strPrefix + strSN + strSuffix;

            return strResult;
        }

        /// <summary>
        /// 获得样例序号
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        private string GetSampleSN(string strCurrentSeq, long intLength)
        {
            string strResult = "";
            for (int i = strCurrentSeq.Length; i < intLength; i++) //不足长度补左边0
            {
                strResult += "0";
            }
            strResult += strCurrentSeq;
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
                strResult += GetUDPValueFromDB(strVar, -1, -1);
                strTemp = strTemp.Substring(j + 1);
                k += j + 2;
            } while (i >= 0);
            return strResult;
        }

        /// <summary>
        /// 通过执行存储过程返回结果
        /// </summary>
        /// <param name="strName"></param>
        /// <param name="itemId"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        private string GetUDPValueFromDB(string strName, int itemId, int prodOrderId)
        {
            string strResult = "";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
                new SqlParameter("@PrefixSuf", SqlDbType.VarChar, 100)
            };
            parms[0].Value = itemId;
            parms[1].Value = prodOrderId;
            parms[2].Value = strResult;
            parms[2].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, strName, parms);
            return parms[2].Value.ToString();
        }

        /// <summary>
        /// 通过执行函数返回结果
        /// </summary>
        /// <param name="strName"></param>
        /// <param name="itemId"></param>
        /// <param name="prodOrderId"></param>
        /// <returns></returns>
        private string GetUDFValueFromDB(string strName, int itemId, int prodOrderId)
        {
            string result = "";
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@ItemId", SqlDbType.Int),
                  new SqlParameter("@ProdOrderId", SqlDbType.Int)
            };
            parms[0].Value = itemId;
            parms[1].Value = prodOrderId;
            string sql = "SELECT dbo." + strName + "(@ItemId,@ProdOrderId)";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                if (rdr.Read())
                {
                    result = rdr.GetString(0);
                }
            }
            return result;
        }

        /// 检测函数属于方法函数还是存储过程
        /// </summary>
        /// <param name="funcName"></param>
        /// <returns></returns>
        private string GetFuncType(string funcName)
        {
            string result = "";
            SqlParameter[] parms = new SqlParameter[] { 
                  new SqlParameter("@name",SqlDbType.NVarChar,50)
            };
            parms[0].Value = funcName;

            string sql = "SELECT type FROM sys.sysobjects WHERE name=@name";

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, parms))
            {
                if (rdr.Read())
                {
                    result = rdr.GetString(0);
                }
            }
            return result;
        }

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
            //strPrefixN = GetUDPValue(strPrefix, strItem, strVer);
            // strPrefixN = GetFnValue(strPrefix, strItem, strVer);
            strPrefixN = strPrefix;

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
                var innerFunc = GetVarValue(strVar);
                if (innerFunc == "")//非内置时间函数
                {
                    var entity = new SerialNumberPerfixSuf().GetInfo(strVar);
                    if (entity != null && entity.Code != null)
                    {
                        string funcType = GetFuncType(entity.Code).Trim();

                        if (funcType == "P")//存储过程
                        {
                            innerFunc = GetUDPValueFromDB(entity.Code, -1, -1);
                        }
                        else if (funcType == "FN")
                        {
                            innerFunc = GetUDFValueFromDB(entity.Code, -1, -1);
                        }
                    }
                }
                strResult += innerFunc;
                strTemp = strTemp.Substring(j + 1);
                k += j + 2;
            } while (i >= 0);
            return strResult;
        }

        /// <summary>
        /// 得到用户自定义函数结果
        /// </summary>
        /// <param name="strPrefix"></param>
        /// <returns></returns>
        private string GetFnValue(string strPrefix, string strItem, string strVer)
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
                strVar = strPrefix.Substring(k + 1, j);
                string strVarUpper = strVar.ToUpper();
                int p = strVarUpper.IndexOf("UdfPrefixSuf_");
                if (p != -1)
                {
                    strVar = strVar.Substring(12); //去除用户自定义函数名的前缀
                }
                strResult += "%" + strVar + "%";
                strTemp = strTemp.Substring(j + 1);
                k += j + 2;
            } while (i >= 0);
            return strResult;
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


        /// <summary>
        /// 编辑（添加或更新） SerialNumber 信息。
        /// </summary>
        /// <param name="entity">SerialNumber 实体对象。</param>
        public void Edit(SerialNumberInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@NextID", SqlDbType.Int),                
                new SqlParameter("@Next_Number_Type", SqlDbType.VarChar, 20),
                new SqlParameter("@Apply_Type", SqlDbType.VarChar, 10),
                new SqlParameter("@Type_Value", SqlDbType.VarChar, 100),
                new SqlParameter("@Revision", SqlDbType.VarChar, 5),
                new SqlParameter("@Prefix", SqlDbType.VarChar, 128),
                new SqlParameter("@Suffix", SqlDbType.VarChar, 128),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@SampleSerialNumber", SqlDbType.VarChar, 100),
                new SqlParameter("@Description", SqlDbType.NVarChar, 200)
            };
            parms[0].Value = entity.SerialNumberID;
            parms[1].Value = entity.Next_Number_Type;
            parms[2].Value = entity.Apply_Type;
            parms[3].Value = entity.Type_Value;
            parms[4].Value = entity.Revision;
            parms[5].Value = entity.Prefix;
            parms[6].Value = entity.Suffix;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.ModifyBy;
            parms[9].Value = entity.Remark;
            parms[10].Value = entity.SampleSerialNumber;
            parms[11].Value = entity.Description;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SerialNumberEdit", parms);
        }

        /// <summary>
        /// 编辑（添加或更新） SerialNumber 信息。
        /// </summary>
        /// <param name="entity">SerialNumber 实体对象。</param>
        public Int32 Edit(SerialNumberInfo entity, SerialNumberSeedInfo entitySeed)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@NextID", SqlDbType.Int),                
                new SqlParameter("@Next_Number_Type", SqlDbType.VarChar, 20),
                new SqlParameter("@Apply_Type", SqlDbType.VarChar, 10),
                new SqlParameter("@Type_Value", SqlDbType.VarChar, 100),
                new SqlParameter("@Revision", SqlDbType.VarChar, 5),
                new SqlParameter("@Prefix", SqlDbType.VarChar, 128),
                new SqlParameter("@Suffix", SqlDbType.VarChar, 128),
                new SqlParameter("@Sequence_Base", SqlDbType.BigInt),
                new SqlParameter("@Number_Sequence", SqlDbType.NVarChar,50),
                new SqlParameter("@Max_Seq", SqlDbType.BigInt),
                new SqlParameter("@Sequence_Length", SqlDbType.BigInt),
                new SqlParameter("@Current_Sequence", SqlDbType.BigInt),
                new SqlParameter("@Min_Sequence", SqlDbType.BigInt),
                new SqlParameter("@IncrementBy", SqlDbType.BigInt),
                new SqlParameter("@Warning", SqlDbType.BigInt),
                new SqlParameter("@Reset", SqlDbType.VarChar),                              
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),             
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@SampleSerialNumber", SqlDbType.VarChar, 100),
                new SqlParameter("@Description", SqlDbType.NVarChar, 200)
            };
            parms[0].Value = entity.SerialNumberID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Next_Number_Type;
            parms[2].Value = entity.Apply_Type;
            parms[3].Value = entity.Type_Value;
            parms[4].Value = entity.Revision;
            parms[5].Value = entity.Prefix;
            parms[6].Value = entity.Suffix;
            //从表对象
            parms[7].Value = entitySeed.Sequence_Base;
            parms[8].Value = entitySeed.Number_Sequence;
            parms[9].Value = entitySeed.Max_Seq;
            parms[10].Value = entitySeed.Sequence_Length;
            parms[11].Value = entitySeed.Current_Sequence;
            parms[12].Value = entitySeed.Min_Sequence;
            parms[13].Value = entitySeed.IncrementBy;
            parms[14].Value = entitySeed.Warning;
            parms[15].Value = entitySeed.Reset;

            parms[16].Value = entity.CreateBy;
            parms[17].Value = entity.ModifyBy;
            parms[18].Value = entity.Remark;
            parms[19].Value = entity.SampleSerialNumber;
            parms[20].Value = entity.Description;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SerialNumber_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SerialNumberId 字符串删除 SerialNumber 信息。
        /// </summary>
        /// <param name="idString">SerialNumberId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SerialNumber_Delete", parms);
        }

        /// <summary>
        /// 根据 SerialNumberId 获取实体信息。
        /// </summary>
        /// <param name="serialNumberId">SerialNumberId。</param>
        /// <returns>SerialNumber 实体对象。</returns>
        public SerialNumberInfo GetInfo(Int32 serialNumberId)
        {
            SerialNumberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = serialNumberId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SerialNumber_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SerialNumberInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), rdr.GetString(10), rdr.GetDateTime(11),
                        rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SerialNumber 实体对象。</returns>
        public SerialNumberInfo GetInfo(String fieldValue)
        {
            SerialNumberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SerialNumber_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SerialNumberInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), rdr.GetString(10), rdr.GetDateTime(11),
                        rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SerialNumber 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="serialNumberCount">serialNumber 总数。</param>
        /// <returns>SerialNumber 列表。</returns>
        public List<SerialNumberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SerialNumberInfo> list = new List<SerialNumberInfo>();
            SerialNumberInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_SerialNumber", "SerialNumberID",////Basal_SerialNumber
                "[SerialNumberID], [SerialNumber_Source], [Next_Number_Type], [Apply_Type], [Type_Value], [Revision], [Prefix], [Suffix], [Remark], [SampleSerialNumber], [Description], [CreateDateTime], [CreateBy], [ModifyDateTime], [ModifyBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SerialNumberInfo(rdr.GetInt32(0), GetCompleteSourceType(rdr.GetString(1)), GetCompleteNumberType(rdr.GetString(2)), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9), rdr.GetString(10), rdr.GetDateTime(11),
                        rdr.GetString(12), rdr.GetDateTime(13), rdr.GetString(14));

                    list.Add(entity);
                }
                rdr.Close();
            }
            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// get complete name for Number Type
        /// </summary>
        /// <param name="intType"></param>
        /// <returns></returns>
        public String GetCompleteNumberType(String strTyp)
        {
            String strType = "";
            //switch (strTyp)
            //{
            //    case "1":
            //        strType = "产品条码";
            //        break;
            //    case "2":
            //        strType = "物料条码";
            //        break;
            //    case "3":
            //        strType = "包装箱号";
            //        break;
            //    case "4":
            //        strType = "IQC检验单号";
            //        break;
            //    case "5":
            //        strType = "收料单号";
            //        break;
            //    case "6":
            //        strType = "栈板";
            //        break;
            //    default:
            //        break;
            //}

            strType = new SerialNumberType().GetInfo(int.Parse(strTyp)).SerialNumberType;
            return strType;
        }
        /// <summary>
        /// get complete name for getdata from database
        /// </summary>
        /// <param name="strType"></param>
        /// <returns></returns>
        public String GetCompleteSourceType(String strType)
        {
            String strCType = "";
            switch (strType)
            {
                case "S":
                    strCType = "Generate Sequence";
                    break;
                case "C":
                    strCType = "Customer Provided";
                    break;
                default:
                    break;
            }
            return strCType;
        }
        /// <summary>
        /// 十进制数转化为特定的进制数
        /// </summary>
        /// <param name="paramLong">需要转化的十进制数</param>
        /// <param name="paramString">进制数序列</param>
        /// <returns></returns>
        public string formatInBase(long paramLong, String paramString)
        {
            int i = paramString.Length;
            string str = "";
            while (paramLong > 0)
            {
                str = paramString[(int)(paramLong % i)] + str;
                paramLong /= i;
            }
            if (str.Length == 0)
                str = "0";
            return str;
        }
        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 得到默认的三十六进制字符串
        /// </summary>
        /// <param name="paramInt"></param>
        /// <returns></returns>
        public string getDefaultDigitSet(Int64 paramInt)
        {
            string arrayOfChar = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            return arrayOfChar.Substring(0, Convert.ToInt32(paramInt));
        }
        /// <summary>
        /// 任意进制数转化为十进制数
        /// </summary>
        /// <param name="paramString1"></param>
        /// <param name="paramString2"></param>
        /// <returns></returns>
        public long formatToLong(string paramString1, string paramString2)
        {
            long l = 0;
            int i = paramString2.Length;
            int j = paramString1.Length - 1;
            for (int k = 0; j >= 0; k++)
            {
                int m = paramString2.IndexOf(paramString1[j]);
                if (m < 0)
                {
                    return -1;
                }
                l += (long)Math.Pow(i, k) * m;
                j--;
            }
            return l;
        }
        /// <summary>
        /// 规则通用方法
        /// </summary>
        /// <returns></returns>
        public String GenerateRuleMethod(Int32 appTypeId, Int32 appRuleId, Int32 appId, String SN)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AppTypeId", SqlDbType.Int), 
                new SqlParameter("@AppRuleId", SqlDbType.Int),
                new SqlParameter("@AppId",SqlDbType.Int),
                new SqlParameter("@SN",SqlDbType.NVarChar,512)
            };
            parms[0].Value = appTypeId;
            parms[1].Value = appRuleId;
            parms[2].Value = appId;
            parms[3].Value = SN;
            parms[3].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGenerateOrderSN", parms);
            return (String)parms[3].Value;

        }

        /// <summary>
        /// 根据任意关联序列号获取产品序列号
        /// </summary>
        /// <param name="CSN">任意关联序列号</param>
        /// <returns></returns>
        public string GetSNByCSN(string CSN)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@CSN",SqlDbType.NVarChar,512)
            };

            parms[0].Value = CSN;
            parms[0].Direction = ParameterDirection.InputOutput;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_SerialNumber_GetSNByCSN", parms);
            return (string)parms[0].Value;
        }
        /// <summary>
        /// 获取关联客户序列号
        /// </summary>
        /// <param name="sn"></param>
        /// <returns></returns>
        public string GetSNByCustome(string sn)
        {
            string str = @" select Value from Prod_SerialNumber where UID=(select UID from  Prod_SerialNumber where  Value=@SN) and SNTypeID=10";
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SN", SqlDbType.NVarChar, 512)
            };
            parms[0].Value = sn;
            string result = "";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, str, parms))
            {
                if (rdr.Read())
                {
                    result = rdr.GetString(0);
                }
            }
            return result;
        }



    }
}
