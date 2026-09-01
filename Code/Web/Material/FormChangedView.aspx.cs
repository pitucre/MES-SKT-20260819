using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SDYC.Data;

namespace SKT.LeanMES.Web.Material
{
    public partial class FormChangedView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "FormChangeDtledId";

            int FormChangeDtlId = -1;
            string idStr = Request.QueryString["ID"] == null ? "-1" : Request.QueryString["ID"].ToString();
            int.TryParse(idStr, out FormChangeDtlId);


            DataTable table = new DataTable();
            using (MAction action=new MAction ("Prod_FormChangeDtled"))
            {
                string sql = string.Format(@"FormChangeDtlId={0}", FormChangeDtlId);
                table = action.Select(sql).ToDataTable();
            }


            GridView1.DataSource = table;
            GridView1.DataBind();

            this.Master.PageGridView = this.GridView1;

            int FormChangeId = -1;
            using (MAction action = new MAction("Prod_FormChangeDtl"))
            {
                if (action.Fill(FormChangeDtlId))
                {
                    FormChangeId = action.Get<int>("FormChangeId");
                }
            }


            using (MAction action = new MAction("Prod_FormChange"))
            {
               if(action.Fill(FormChangeId))
                {
                    txtFormChangeNo.Text = action.Get<string>("FormChangeNo");
                    txtDocumentType.Text = action.Get<string>("DocumentType");
                    txtWarehouseCode.Text = action.Get<string>("WarehouseCode");

                    txtWarehouseName.Text = action.Get<string>("WarehouseName");
                   
                }
            }


        }
    }
}