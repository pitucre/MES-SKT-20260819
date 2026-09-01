using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.SPC.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.SPC.BLL
{
    public class SPCTask
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SPCTask 信息。
        /// </summary>
        /// <param name="entity">SPCTask 实体对象。</param>
        public Int32 Edit(SPCTaskInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SPCTaskId", SqlDbType.Int),
                new SqlParameter("@SPCProjectId", SqlDbType.Int),
                new SqlParameter("@TaskName", SqlDbType.NVarChar, 50),
                new SqlParameter("@TaskDesc", SqlDbType.NVarChar, 100),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@IsRefeshData", SqlDbType.Bit),
                new SqlParameter("@RefeshInterval", SqlDbType.Decimal),
                new SqlParameter("@USL", SqlDbType.Decimal),
                new SqlParameter("@LSL", SqlDbType.Decimal),                
                new SqlParameter("@SPCGetDataProc", SqlDbType.VarChar, 50),
                new SqlParameter("@SPCActionProc", SqlDbType.VarChar, 50),
                new SqlParameter("@SPCAGraphProc", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@UnitId", SqlDbType.Int),
                new SqlParameter("@IsCurve", SqlDbType.Bit)
            };

            parms[0].Value = entity.SPCTaskId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.SPCProjectId;
            parms[2].Value = entity.TaskName;
            parms[3].Value = entity.TaskDesc;
            parms[4].Value = entity.ItemId;
            parms[5].Value = entity.LineId;
            parms[6].Value = entity.StationId;
            parms[7].Value = entity.IsRefeshData;
            parms[8].Value = entity.RefeshInterval;
            parms[9].Value = entity.USL;
            parms[10].Value = entity.LSL;            
            parms[11].Value = entity.SPCGetDataProc;
            parms[12].Value = entity.SPCActionProc;
            parms[13].Value = entity.SPCAGraphProc;
            parms[14].Value = entity.CreateBy;
            parms[15].Value = entity.ModifyBy;
            parms[16].Value = entity.UnitId;
            parms[17].Value = entity.IsCurve;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_SPCTask_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SPCTaskId 字符串删除 SPCTask 信息。
        /// </summary>
        /// <param name="idString">SPCTaskId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_SPCTask_Delete", parms);
        }

        /// <summary>
        /// 根据 SPCTaskId 获取实体信息。
        /// </summary>
        /// <param name="sPCTaskId">SPCTaskId。</param>
        /// <returns>SPCTask 实体对象。</returns>
        public SPCTaskInfo GetInfo(Int32 sPCTaskId)
        {
            return ComMethod.GetInfo<SPCTaskInfo>(sPCTaskId, "Quality_SPCTask_GetInfo");  
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SPCTask 实体对象。</returns>
        public SPCTaskInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<SPCTaskInfo>(fieldValue, "Quality_SPCTask_GetInfo");  
        }

        /// <summary>
        /// 分页获取 SPCTask 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="sPCTaskCount">sPCTask 总数。</param>
        /// <returns>SPCTask 列表。</returns>
        public List<SPCTaskInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SPCTaskInfo> list = new List<SPCTaskInfo>();
           
            //表名或者视图
            string strTb = "vwGetSPCTaskList";
            //主键
            string strKey = "SPCTaskId";
            //查询栏位字串
            string strColumns = @"[SPCTaskId], [ProjectName],[GraphType], [TaskName], [TaskDesc], [ItemCode], [LineName], [Station], [IsRefeshData], [RefeshInterval], [USL], [LSL],[SPCGetDataProc], [SPCActionProc], [SPCAGraphProc], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime],UnitId,Unit";

            return ComMethod.GetComList<SPCTaskInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 保存SPC测试录入数据信息
        /// add by peter on 2018-1-8 ,用于SPC取数
        /// </summary>
        public string SaveSpcTestData(string OrderNo, string ItemCode, string TaskName, string txtRemark, int TestWay,
           string userName, string TestValue, string TestResult, int sampleGroupNum)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OrderNo", SqlDbType.NVarChar,50),
                new SqlParameter("@ItemCode", SqlDbType.NVarChar,50),
                new SqlParameter("@TaskName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 100),
                new SqlParameter("@TestWay", SqlDbType.Int),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20),
                new SqlParameter("@TestValue", SqlDbType.NVarChar,20),
                new SqlParameter("@TestResult", SqlDbType.NVarChar,20),
                new SqlParameter("@SampleGroupNum", SqlDbType.Int),
                new SqlParameter("@StrValue", SqlDbType.NVarChar,100)
            };

            parms[0].Value = OrderNo;
            parms[1].Value = ItemCode;
            parms[2].Value = TaskName;
            parms[3].Value = txtRemark;
            parms[4].Value = TestWay;
            parms[5].Value = userName;
            parms[6].Value = TestValue;
            parms[7].Value = TestResult;
            parms[8].Value = sampleGroupNum;
            parms[9].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveSpcTestData", parms);
            return Convert.ToString(parms[9].Value);
        }

        /// <summary>
        /// 显示SPC录入的数据信息
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <param name="txtTaskName"></param>
        /// <returns></returns>
        public List<SPCTaskInfo> GetSpcTestDataList(string ItemCode, string txtTaskName)
        {
            List<SPCTaskInfo> list = new List<SPCTaskInfo>();
            SPCTaskInfo entity = null;
            SqlParameter[] param = new SqlParameter[]{
                new SqlParameter("@ItemCode",SqlDbType.NVarChar,50),
                new SqlParameter("@TaskName",SqlDbType.NVarChar,50)
             };
            param[0].Value = ItemCode;
            param[1].Value = txtTaskName;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetSpcTestDataList", param))
            {
                while (rdr.Read())
                {
                    entity = new SPCTaskInfo();
                    entity.SpcId = rdr.GetInt32(0);
                    entity.TestValue = rdr.GetString(1);
                    entity.TestResult = rdr.GetString(2);
                    entity.TestWay = rdr.GetString(3);
                    entity.TestDataTime = rdr.GetDateTime(4);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据ID删除SPC信息
        /// </summary>
        /// <param name="id"></param>
        public void DelSpcById(int id)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int)
            };

            parms[0].Value = id;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDelSpcById", parms);
        }

        /// <summary>
        ///  通过验证输入的的不良代码，并返回启不良ID
        ///  add by peter on 2018-10-10 ,用于SPC取数
        /// </summary>
        /// <param name="nccode"></param>
        /// <returns></returns>
        public string GetNcCodeId(string nccode)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@NcCode", SqlDbType.NVarChar,50),
                new SqlParameter("@NcId", SqlDbType.NVarChar,10)
            };

            parms[0].Value = nccode;
            parms[1].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetSpcNcCodeId", parms);
            return Convert.ToString(parms[1].Value);
        }

        /// <summary>
        /// 获取当前已扫描的样本数
        /// </summary>
        /// <param name="ItemCode"></param>
        /// <param name="taskName"></param>
        /// <param name="sampleGroup"></param>
        /// <returns></returns>
        public int GetScanGroupNum(string ItemCode, string taskName, string sampleGroup)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemCode", SqlDbType.NVarChar,50),
                new SqlParameter("@TaskName", SqlDbType.NVarChar,50),
                new SqlParameter("@SampleGroup", SqlDbType.NVarChar,50),
                new SqlParameter("@Num", SqlDbType.Int)
            };

            parms[0].Value = ItemCode;
            parms[1].Value = taskName;
            parms[2].Value = sampleGroup;
            parms[3].Direction = ParameterDirection.Output;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspGetScanGroupNum", parms);
            return Convert.ToInt32(parms[3].Value);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}
