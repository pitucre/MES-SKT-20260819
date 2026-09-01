using System;
using System.Collections.Generic;
using System.Data;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class MouldAbnormalEdit : BasePage
    {
        AjaxEsop aEsop = new AjaxEsop();
        string filePath = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(MouldAbnormalEdit));
            //AjaxPro.Utility.RegisterTypeForAjax(typeof(InspectionTemplateEdit));

            var bll = new MoludAbnormal();

            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);

                if (id > 0)
                {

                    var model = bll.GetInfo(id);
                    PageData = model;


                }

            }
        }

        /// <summary>
        /// 获取设备在机模具信息
        /// </summary>
        /// <param name="equimentId">设备Id</param>
        /// <param name="equimentType">构件名称ID</param>

        /// <returns></returns>
        [AjaxMethod]
        public List<MoldFixtureUpLine> GetEquimentMouldAll(int equimentId, int equimentType)
        {
            List<MoldFixtureUpLine> list = new List<MoldFixtureUpLine>();
            try
            {
                var bll = new MoludApply();
                SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
                searchSettings.ExtensionCondition += " EquimentId=" + equimentId + " and MouldType=" + equimentType;
                list = bll.GetEquimentMouldAll(0, Int32.MaxValue, "", searchSettings);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
            return list;
        }


        /// <summary>
        /// 获取构件名称列表信息
        /// </summary>
        /// <param name="bomId">模具名称ID</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MoludBomChildInfo> GetMouldBomChild(int bomId)
        {
            List<MoludBomChildInfo> list = new List<MoludBomChildInfo>();
            try
            {
                MoludBom bll = new MoludBom();
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.AddCondition(" MouldBomId", bomId.ToString());
                searchSettings.ExtensionCondition += " MouldBomId =" + bomId;
                list = bll.GetBomChildAll(0, 10000, "", searchSettings);
            }
            catch (Exception)
            {
                throw;
            }
            return list;
        }

        /// <summary>
        /// 获取异常信息构件名称列表信息
        /// </summary>
        /// <param name="mouldAbnormalId">异常信息ID</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<MouldAbnormalDetail> GetAbnormalDetail(int mouldAbnormalId)
        {
            List<MouldAbnormalDetail> list = new List<MouldAbnormalDetail>();
            try
            {
                MoludAbnormal bll = new MoludAbnormal();
                SearchSettings searchSettings = new SearchSettings();
                searchSettings.AddCondition(" MouldAbnormalId", mouldAbnormalId.ToString());
                list = bll.GetDetailAll(0, 10000, "", searchSettings);
            }
            catch (Exception)
            {
                throw;
            }
            return list;
        }

        [AjaxMethod]
        public int Edit(MoludAbnormalInfo entity)
        {

            var result = -1;
            try
            {
                entity.CreateBy = AccountController.GetCurrentUser().UserName;

                var bll = new MoludAbnormal();

                result = bll.Add(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
            return result;
        }

        [AjaxMethod]
        public string[] GetMouldBomId(int equipmentId)
        {
            string[] bomArr = new string[2];
            try
            {

                SqlParameter[] paras=
                {
                     new SqlParameter("@EquimentId",SqlDbType.Int),
                };
                paras[0].Value = equipmentId;
                //string sql = @"SELECT TOP 1 MouldBomId,EquipmentName FROM Basal_EquimentMould A WITH(NOLOCK) inner join Basal_Equipment B WITH(NOLOCK) ON a.MouldId=b.EquipmentId where EquimentId="+ equipmentId;

                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetEquipmentMould", paras))
                {
                    if (rdr.Read())
                    {
                        bomArr[0] = Convert.ToString(rdr[0]);
                        bomArr[1] = Convert.ToString(rdr[1]);
                    }
                    rdr.Close();
                } 

            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);

            }
            return bomArr;
        }

        protected MoludAbnormalInfo PageData
        {
            set
            {
                this.hdMouldBomId.Value = value.MouldBomId.ToString();
                this.txtBomName.Text = value.BomName;

                this.hdnEquimentId.Value = value.EquipmentId.ToString();
                this.txtEquimentCode.Text = value.EquipmentName;


                //this.hdResourceTypeId.Value = value.ResourceTypeId.ToString();
                //this.txtResourceType.Text = value.ResTypeName;

                this.txtAbnormalReason.Text = value.AbnormalReason;
                this.txtAbnormalPhenomenon.Text = value.AbnormalPhenomenon;
                this.txtStartTime.Text = value.StartTime.ToString();

                this.hdStatus.Value = value.Status.ToString();
                var rcca = value.Rcca;

                // this.txtRemark.Text = value.Remark;

                if (value.PicFile != "")
                {
                    filePath = aEsop.LocalFileExists(value.PicFile, "MouldAnormal");
                    if (filePath != "")
                    {
                        this.image1.ImageUrl = filePath;
                    }
                    else
                    {
                        this.image1.ImageUrl = SKT.LeanMES.Web.WebHelper.WebRoot + "/ESOP/DownLoad.aspx?Action=MouldAnormal&fileName=" + value.PicFile;
                    }
                }
                lbFileReady.Text = value.PicFile;
            }
        }
    }
}