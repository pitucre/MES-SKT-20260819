using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.IO;
using System.Data;
using ExcelHelper = SKT.LeanMES.Web.AppCode.Utility.ExcelHelper;

namespace SKT.LeanMES.Web.Product
{
    public partial class MaterialMoldingEdit : BasePage
    {
        public String IsCopy;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMolding));
            IsCopy = Request.QueryString["Action"] == null ? "" : Request.QueryString["Action"].ToString();
        }

        protected void linkUploadFile_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtItemCode.Value))
            {
                WebHelper.ShowMessage("产品不能为空！");
                return;
            }

            if (!fileUploads.HasFile)
            {
                WebHelper.ShowMessage(Resources.Messages.FielLoadPathEmpty);
                return;
            }

            string fileExtension = System.IO.Path.GetExtension(fileUploads.PostedFile.FileName).ToLower();
            string allowExtension = ".xls";
            string allowTwoExtension = ".xlsx";
            if (fileExtension != allowExtension && fileExtension != allowTwoExtension)
            {
                WebHelper.ShowMessage(Resources.Messages.FileTypeError);
                return;
            }

            string filename = DateTime.Now.ToString("yyyyMMddhhmmss") + System.IO.Path.GetFileName(fileUploads.PostedFile.FileName).ToString();
            string filePath = Server.MapPath("..\\TempFile");
            if (!Directory.Exists(filePath))
            {
                try
                {
                    Directory.CreateDirectory(filePath);
                }
                catch (Exception)
                {
                    throw new ApplicationException("Create folder failed.");
                }
            }

            fileUploads.PostedFile.SaveAs(filePath + "\\" + filename); //modify by Alen 2014-12-31
            filename = filePath + "\\" + filename;//modify by Alen 2014-12-31

            DataTable dt = null;
            try
            {
                //读取excel数据
                dt = ExcelHelper.ExcelToDataTable(filename,2);
                if (dt == null || dt.Rows.Count < 1) { throw new Exception("未发现导入的数据!"); }

                var entity = new LeanMES.Molding.Model.MaterialMoldingInfo();
                entity.ModifyBy = AccountController.GetCurrentUser().UserId;
                entity.MoldingId = string.IsNullOrEmpty(hidMoldingId.Value) ? 0 : int.Parse(hidMoldingId.Value);
                entity.ItemId = string.IsNullOrEmpty(hidItemId.Value) ? 0 : int.Parse(hidItemId.Value);
                entity.ItemCode = txtItemCode.Value;
                entity.IsImport = 1;
                entity.Member = new List<LeanMES.Molding.Model.MaterialMoldingMemberInfo>();

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int usage = 0;
                    DataRow row = dt.Rows[i];

                    if (!string.IsNullOrEmpty(dt.Rows[i][2].ToString()) && !int.TryParse(row[2].ToString(), out usage))
                        throw new Exception(string.Format("第{0}行，列'用量'格式错误!", i + 1));

                    entity.Member.Add(new SKT.LeanMES.Molding.Model.MaterialMoldingMemberInfo()
                    {
                        Operate = 1,
                        MoldingMemberId = 0,
                        MachineType = GetMachineType(row[0]),
                        SourceItemCode = row[1].ToString(),
                        Usage = usage,
                        Location = row[3].ToString(),
                        StationName = row[4].ToString(),
                        Specification = row[5].ToString(),
                        IsProgrammer = row[6].ToString() == "Y",
                        TargetItemCode = row[7].ToString(),
                        Remark = row[8].ToString()
                    });
                }

                new LeanMES.Molding.BLL.MaterialMolding().Save(entity);

                WebHelper.ShowMessage(Resources.Messages.ImportSuccess);

                if (entity.MoldingId == 0)
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "refresh", "<script>Refresh()</script>");
            }
            catch (Exception ex)
            {
                WebHelper.ShowMessage(ex.Message);
            }


        }

        int GetMachineType(object type)
        {
            int t = 0;
            if (type != null)
            {
                switch (type.ToString())
                {

                    case "不变料号":
                        t = 1;
                        break;
                    case "变料号":
                        t = 2;
                        break;
                    case "组合料":
                        t = 3;
                        break;
                }
            }
            return t;
        }

        /* Get XLS sheet Name*/
        private static string GetSheetName(string filePath)
        {
            string sheetName = "Sheet1";

            System.IO.FileStream tmpStream = File.OpenRead(filePath);
            byte[] fileByte = new byte[tmpStream.Length];
            tmpStream.Read(fileByte, 0, fileByte.Length);
            tmpStream.Close();

            byte[] tmpByte = new byte[]{Convert.ToByte(11),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),
           Convert.ToByte(11),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),Convert.ToByte(0),
           Convert.ToByte(30),Convert.ToByte(16),Convert.ToByte(0),Convert.ToByte(0)};

            int index = GetSheetIndex(fileByte, tmpByte);
            if (index > -1)
            {

                index += 16 + 12;
                System.Collections.ArrayList sheetNameList = new System.Collections.ArrayList();

                for (int i = index; i < fileByte.Length - 1; i++)
                {
                    byte temp = fileByte[i];
                    if (temp != Convert.ToByte(0))
                        sheetNameList.Add(temp);
                    else
                        break;
                }
                byte[] sheetNameByte = new byte[sheetNameList.Count];
                for (int i = 0; i < sheetNameList.Count; i++)
                    sheetNameByte[i] = Convert.ToByte(sheetNameList[i]);

                sheetName = System.Text.Encoding.Default.GetString(sheetNameByte);
            }
            return sheetName;
        }

        private static int GetSheetIndex(byte[] FindTarget, byte[] FindItem)
        {
            int index = -1;

            int FindItemLength = FindItem.Length;
            if (FindItemLength < 1) return -1;
            int FindTargetLength = FindTarget.Length;
            if ((FindTargetLength - 1) < FindItemLength) return -1;

            for (int i = FindTargetLength - FindItemLength - 1; i > -1; i--)
            {
                System.Collections.ArrayList tmpList = new System.Collections.ArrayList();
                int find = 0;
                for (int j = 0; j < FindItemLength; j++)
                {
                    if (FindTarget[i + j] == FindItem[j]) find += 1;
                }
                if (find == FindItemLength)
                {
                    index = i;
                    break;
                }
            }
            return index;
        }
    }
}