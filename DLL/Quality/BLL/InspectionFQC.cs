using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class InspectionFQC
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新）
        /// </summary>
        /// <param name="strJson"></param>
        public void SaveCheck(string strJson)
        {
            ComMethod.Edit<InspectionFQCInfo>(strJson, "upsSaveFQCCechkResult");
        }

        /// <summary>
        /// 根据 InspectionFQCId 字符串删除 InspectionFQC 信息。
        /// </summary>
        /// <param name="idString">InspectionFQCId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            ComMethod.Delete(idString, userName, "Prod_InspectionFQC_Delete");
        }

        /// <summary>
        /// 根据 InspectionFQCId 获取实体信息。
        /// </summary>
        /// <param name="inspectionFQCId">InspectionFQCId。</param>
        /// <returns>InspectionFQC 实体对象。</returns>
        public InspectionFQCInfo GetInfo(Int32 inspectionFQCId)
        {
            return ComMethod.GetInfo<InspectionFQCInfo>(inspectionFQCId, "Prod_InspectionFQC_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>InspectionFQC 实体对象。</returns>
        public InspectionFQCInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<InspectionFQCInfo>(fieldValue, "Prod_InspectionFQC_GetInfo");
        }

        /// <summary>
        /// 分页获取 InspectionFQC 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="inspectionFQCCount">inspectionFQC 总数。</param>
        /// <returns>InspectionFQC 列表。</returns>
        public List<InspectionFQCInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "Prod_InspectionFQC";
            //主键
            string strKey = "InspectionFQCId";
            //查询栏位字串
            string strColumns = @"[InspectionFQCId], [InspectionFQCNo], [StationId], [ResourceId], [ItemId], [SealantDate], [StationQty], [StationFactQty], [FinishTime], [Statue], [Result], [Remark], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [PrintLv], [ProLine], [InspectionUser], [Auditing], [CheckDate]";
            return ComMethod.GetComList<InspectionFQCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 根据检验单ID获取FQC模版信息
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetFQCFormModel(Int32 intId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionFQCId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            return ComMethod.GetList("upsGetFQCTemplateModel", parms);
        }

        /// <summary>
        /// 根据检验单ID获取模版检验项信息
        /// </summary>
        /// <param name="intIqcId">FQC单号</param>
        /// <param name="intTempId">模版ID</param>
        /// <returns></returns>
        public string GetFqcFormItem(Int32 intId, Int32 intTempId)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@TemplateId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            parms[1].Value = intTempId;
            return ComMethod.GetList("upsGetFQCTemplateItem", parms);
        }

        /// <summary>
        /// 获取FQC检验单PDF报表文档
        /// </summary>
        /// <param name="intId"></param>
        /// <returns></returns>
        public string GetPdf(int intId, string strTargetPath, string strXmlFilePath, string strImgPath)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@InspectionFQCId", SqlDbType.Int)
				};
            parms[0].Value = intId;
            DataSet ds = ComMethod.GetListDataSet("upsGetFQCTemplateModel", parms, "dtFQCReport");

            if (ds.Tables.Count == 0) return "";
            ds.Tables[0].Rows[0]["CheckDate"] = Convert.ToDateTime(ds.Tables[0].Rows[0]["CheckDate"]).ToString("yyyy年MM月dd日");
            //检验项获取
            DataTable dt3 = null;
            DataTable dt4 = null;

            DataSet dsTemp = new DataSet();

            //获取检验项信息ITEM
            foreach (DataRow dr in ds.Tables[1].Rows)
            {
                SqlParameter[] parms1 = new SqlParameter[]{
					new SqlParameter("@InspectionId", SqlDbType.Int),
                    new SqlParameter("@TemplateId", SqlDbType.Int)
				};
                parms1[0].Value = intId;
                parms1[1].Value = Convert.ToInt32(dr["InspectionTemplateId"]);
                dsTemp = ComMethod.GetListDataSet("upsGetFQCTemplateItem", parms1, "dtItem");
                //表结构复制
                if (dt3 == null) dt3 = dsTemp.Tables[0].Clone();
                if (dt4 == null) dt4 = dsTemp.Tables[1].Clone();
                //添加Item头
                foreach (DataRow dr3 in dsTemp.Tables[0].Rows)
                {
                    dt3.Rows.Add(dr3.ItemArray);
                }
                //添加Item身
                foreach (DataRow dr4 in dsTemp.Tables[1].Rows)
                {
                    dt4.Rows.Add(dr4.ItemArray);
                }
            }
            //取得Lrc
            //SqlParameter[] parms2 = new SqlParameter[]{
            //        new SqlParameter("@InspectionId", SqlDbType.Int)
            //    };
            //parms2[0].Value = intId;
            //dsTemp = ComMethod.GetListDataSet("upsGetIQCTemplateLcrItem", parms2, "dtLrc");
            //int a = 0;
            //foreach (DataRow drTemp in dsTemp.Tables[1].Rows)
            //{
            //    if (drTemp["IQCLcrItemType"].ToString() == "1")
            //    {
            //        drTemp.BeginEdit();
            //        for (int i = 1; i <= 10; i++)
            //        {
            //            drTemp["Value" + i.ToString()] = replaceResult(drTemp["Value" + i.ToString()].ToString());
            //        }
            //        drTemp.EndEdit();
            //    }
            //    else if (drTemp["IQCLcrItemType"].ToString() == "2")
            //    {
            //        drTemp.BeginEdit();
            //        for (int i = 1; i <= 10; i++)
            //        {
            //            a++;
            //            drTemp["Value" + i.ToString()] = "(" + a.ToString() + ")";
            //        }
            //        drTemp.EndEdit();
            //    }
            //}

            ds.Tables.Add(dt3);
            ds.Tables.Add(dt4);
            //ds.Tables.Add(dsTemp.Tables[0].Copy());
            //ds.Tables.Add(dsTemp.Tables[1].Copy());

            //PDF产生
            return PDFHelper.ExportData(PDFHelper.Language.Simplified, strXmlFilePath, ds, strTargetPath, strImgPath);
        }
        //替换结果
        private string replaceResult(string str)
        {
            switch (str)
            {
                case "0": str = "□OK ■NG"; break;
                case "1": str = "■OK □NG"; break;
                default: str = "□OK □NG"; break;
            }
            return str;
        }
        /// <summary>
        /// 操作upsFQCGrnNG
        /// </summary>
        /// <param name="sn"></param>
        /// <param name="InspectionFQCNo"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public string FQCGrnNG(string sn, string InspectionFQCNo, int TemplateId, string Remarks, int type)
        {
            SqlParameter[] parms = new SqlParameter[]{
					new SqlParameter("@SN",sn),
                    new SqlParameter("@InspectionFQCNo",InspectionFQCNo),
                    new SqlParameter("@TemplateId",TemplateId),
                    new SqlParameter("@Remarks",Remarks),
                    new SqlParameter("@OType",type)
				};
            return ComMethod.GetList("upsFQCGrnNG", parms);
        }
    }
}