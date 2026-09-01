using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Maintenance.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Maintenance.BLL
{
    public class MaintenanceRelation
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 勾选保养项时的操作
        /// </summary>
        /// <param name="planId"></param>
        /// <param name="demoId"></param>
        /// <param name="temp">0为未选中，1为选中</param>
        /// <returns></returns>
        public void UpdateDemo(Int32 planId, Int32 demoId, Int32 demoSubId, Int32 temp, Int32 operatorId, String createBy,string fileSaveName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@planId", SqlDbType.Int),
                new SqlParameter("@demoId", SqlDbType.Int),
                new SqlParameter("@demoSubId",SqlDbType.Int),
                new SqlParameter("@temp", SqlDbType.Int),
                new SqlParameter("@operatorId", SqlDbType.Int),
                new SqlParameter("@createBy", SqlDbType.NVarChar,50),
                 new SqlParameter("@FileSaveName", SqlDbType.NVarChar,100)
            };

            parms[0].Value = planId;
            parms[1].Value = demoId;
            parms[2].Value = demoSubId;
            parms[3].Value = temp;
            parms[4].Value = operatorId;
            parms[5].Value = createBy;
            parms[6].Value = fileSaveName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSetDemo", parms);
        }
        public void DeleteRelation(int planId, int demoId)
        {
            SqlParameter[] array = new SqlParameter[]
            {
                new SqlParameter("@PlanId", SqlDbType.Int),
                new SqlParameter("@DemoId", SqlDbType.Int)
            };
            array[0].Value = planId;
            array[1].Value = demoId;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteRelationDemo", array);
        }
        /// <summary>
        /// 确认保养项时的操作
        /// </summary>
        /// <param name="planId"></param>
        /// <param name="demoId"></param>
        /// <param name="temp">0为未选中，1为选中</param>
        /// <returns></returns>
        public void CheckDemo(Int32 planId, Int32 operatorId, String createBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PlanId", SqlDbType.Int),
                new SqlParameter("@operatorId", SqlDbType.Int),
                new SqlParameter("@createBy", SqlDbType.NVarChar,50)
            };

            parms[0].Value = planId;
            parms[1].Value = operatorId;
            parms[2].Value = createBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspCheckDemo", parms);
        }
        /// <summary>
        /// 根据项目计划获取保养项目维护列表
        /// </summary>
        /// <returns></returns>
        public DataTable GetDemoList(Int32 Id)
        {
            DataTable list = new DataTable();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int)
               
            };
            parms[0].Value = Id;
           
            list = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspCreateDemoList", parms);
            return list;
        }
        public DataTable GetMyDemoList(Int32 Id,int type)
        {
            DataTable list = new DataTable();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@Type", SqlDbType.Int)
            };
            parms[0].Value =Id;
            parms[1].Value = type;

            list = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspMyDemoList", parms);

            return list;
        }

        // <summary>
        /// PDA根据设备编码获取保养内容
        /// </summary>
        /// <param name="FieldValue"></param>
        /// <returns></returns>
        public DataTable PDA_GetDemoList(string FieldValue, int Type)
        {
            DataTable list = new DataTable();
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar,50) { Value=FieldValue},
                new SqlParameter("@Type", SqlDbType.Int) { Value=Type}
            };

            list = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "usp_GetMaintenanceRelationInfo", parms);

            return list;
        }

        public void MaintainDemoBatch(string equimentCode, List<MaintainDemoInfo> maintains, string createBy, int operatorID, string serverImageNames)
        {
            
            // 填充数据
            DataTable dt = new DataTable();
            dt.Columns.Add("PlanID", typeof(int));
            dt.Columns.Add("DemoID", typeof(int));
            dt.Columns.Add("DemoSubID", typeof(int));
            dt.Columns.Add("MaintainWay", typeof(int));
            dt.Columns.Add("IsDone", typeof(int));
            dt.Columns.Add("IsOK", typeof(int));
            dt.Columns.Add("Remark", typeof(string));

            // 添加行 
            foreach (MaintainDemoInfo entity in maintains)
            {
                dt.Rows.Add(entity.PlanID, entity.DemoID, entity.DemoSubID, entity.MaintainWay, entity.IsDone, entity.IsOK, entity.Remark);
            }

            var parms = new SqlParameter[]
            {
                new SqlParameter("@EquimentCode", SqlDbType.VarChar, 50) { Value = equimentCode },
                new SqlParameter("@MaintainDemo", SqlDbType.Structured) { Value = dt },
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20) { Value = createBy },
                new SqlParameter("@OperatorID", SqlDbType.VarChar, 50) { Value = operatorID },
                new SqlParameter("@ServerImageNames", SqlDbType.VarChar) { Value = serverImageNames }
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspMaintainDemoBatch", parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}