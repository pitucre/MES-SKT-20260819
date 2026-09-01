using iTextSharp.text.pdf;
using Microsoft.JScript;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Data;
using System.Web.UI;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class TechnologyParam : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipment));

            if (!this.IsPostBack)
            {
                String LinePlanCode = Request.QueryString["LinePlanCode"];
                DataTable Dt = (new Equipments()).GetTechnologyParam(LinePlanCode);
                if (Dt != null && Dt.Rows.Count > 0)
                {
                    this.PageData = Dt;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private DataTable PageData
        {
            set
            {
                this.Text0.Value = value.Rows[0][1].ToString();
                this.Label9.Text = value.Rows[0][1].ToString();

                this.Text2.Value = value.Rows[1][1].ToString();
                this.Label10.Text = value.Rows[1][1].ToString();

                this.Text3.Value = value.Rows[2][1].ToString();
                this.Label11.Text = value.Rows[2][1].ToString();

                this.Text4.Value = value.Rows[3][1].ToString();
                this.Label12.Text = value.Rows[3][1].ToString();

                this.Text5.Value = value.Rows[4][1].ToString();
                this.Label13.Text = value.Rows[4][1].ToString();

                this.Text6.Value = value.Rows[5][1].ToString();
                this.Label14.Text = value.Rows[5][1].ToString();

                this.Text7.Value = value.Rows[6][1].ToString();
                this.Label15.Text = value.Rows[6][1].ToString();

                this.Text8.Value = value.Rows[7][1].ToString();
                this.Label16.Text = value.Rows[7][1].ToString();

                this.Text9.Value = value.Rows[8][1].ToString();
                this.Label17.Text = value.Rows[8][1].ToString();

                this.Text10.Value = value.Rows[9][1].ToString();
                this.Label18.Text = value.Rows[9][1].ToString();

                this.Text11.Value = value.Rows[10][1].ToString();
                this.Label19.Text = value.Rows[10][1].ToString();

                this.Text12.Value = value.Rows[11][1].ToString();
                this.Label20.Text = value.Rows[11][1].ToString();

                this.Text13.Value = value.Rows[12][1].ToString();
                this.Label21.Text = value.Rows[12][1].ToString();

                this.Text14.Value = value.Rows[13][1].ToString();
                this.Label22.Text = value.Rows[13][1].ToString();

                this.Text15.Value = value.Rows[14][1].ToString();
                this.Label23.Text = value.Rows[14][1].ToString();

                this.Text16.Value = value.Rows[15][1].ToString();
                this.Label24.Text = value.Rows[15][1].ToString();

                this.Text17.Value = value.Rows[16][1].ToString();
                this.Label25.Text = value.Rows[16][1].ToString();

                this.Text18.Value = value.Rows[17][1].ToString();
                this.Label26.Text = value.Rows[17][1].ToString();

                this.Text19.Value = value.Rows[18][1].ToString();
                this.Label27.Text = value.Rows[18][1].ToString();

                this.Text20.Value = value.Rows[19][1].ToString();
                this.Label28.Text = value.Rows[19][1].ToString();


                this.Text21.Value = value.Rows[20][1].ToString();
                this.Label29.Text = value.Rows[20][1].ToString();

                this.Text22.Value = value.Rows[21][1].ToString();
                this.Label30.Text = value.Rows[21][1].ToString();

                this.TempReal1.Value = value.Rows[22][1].ToString();
                this.Label31.Text = value.Rows[22][1].ToString();

                this.TempReal2.Value = value.Rows[23][1].ToString();
                this.Label32.Text = value.Rows[23][1].ToString();

                this.TempReal3.Value = value.Rows[24][1].ToString();
                this.Label33.Text = value.Rows[24][1].ToString();

                this.TempReal4.Value = value.Rows[25][1].ToString();
                this.Label34.Text = value.Rows[25][1].ToString();

                this.TempReal5.Value = value.Rows[26][1].ToString();
                this.Label35.Text = value.Rows[26][1].ToString();

                this.Text25.Value = value.Rows[27][1].ToString();
                this.Label36.Text = value.Rows[27][1].ToString();

                this.Inject_P1.Value = value.Rows[28][1].ToString();
                this.Label37.Text = value.Rows[28][1].ToString();

                this.Inject_P2.Value = value.Rows[29][1].ToString();
                this.Label38.Text = value.Rows[29][1].ToString();

                this.Inject_P3.Value = value.Rows[30][1].ToString();
                this.Label39.Text = value.Rows[30][1].ToString();

                this.Inject_P4.Value = value.Rows[31][1].ToString();
                this.Label40.Text = value.Rows[31][1].ToString();

                this.Inject_V1.Value = value.Rows[32][1].ToString();
                this.Label41.Text = value.Rows[32][1].ToString();

                this.Inject_V2.Value = value.Rows[33][1].ToString();
                this.Label42.Text = value.Rows[33][1].ToString();

                this.Inject_V3.Value = value.Rows[34][1].ToString();
                this.Label43.Text = value.Rows[34][1].ToString();

                this.Inject_V4.Value = value.Rows[35][1].ToString();
                this.Label44.Text = value.Rows[35][1].ToString();

                this.Inject_S1.Value = value.Rows[36][1].ToString();
                this.Label45.Text = value.Rows[36][1].ToString();

                this.Inject_S2.Value = value.Rows[37][1].ToString();
                this.Label46.Text = value.Rows[37][1].ToString();

                this.Inject_S3.Value = value.Rows[38][1].ToString();
                this.Label47.Text = value.Rows[38][1].ToString();

                this.Inject_S4.Value = value.Rows[39][1].ToString();
                this.Label48.Text = value.Rows[39][1].ToString();

                this.SampleValueVPPosition.Value = value.Rows[40][1].ToString();
                this.Label49.Text = value.Rows[40][1].ToString();

                this.Text39.Value = value.Rows[41][1].ToString();
                this.Label50.Text = value.Rows[41][1].ToString();

                this.Charge_Force_1.Value = value.Rows[42][1].ToString();
                this.Label51.Text = value.Rows[42][1].ToString();

                this.Charge_Verlocity_1.Value = value.Rows[43][1].ToString();
                this.Label52.Text = value.Rows[43][1].ToString();
            }
        }
    }
}