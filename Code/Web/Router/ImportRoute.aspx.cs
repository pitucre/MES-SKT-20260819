using Newtonsoft.Json;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Router
{
    public partial class ImportRoute : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        string f_name;
        protected void Upload_Click(object sender, EventArgs e)
        {

            //申明几个变量
            IWorkbook workbook = null;
            FileStream fs = null;
            ISheet sheet = null;
            IRow row = null;
            ICell cell = null;
            DataTable dataTable = null;
            var edition = "";
            var DrawingNo = "";
            var Station = "";
            var describe = "";
            var Control = "";
            var EquipmentCode = "";
            var url = "";
            var name = "";
            var attributionCode = "";//归属编码

            HttpFileCollection hfc = System.Web.HttpContext.Current.Request.Files;

            //string Paths = Path.GetFullPath(fileBomUrl.PostedFile.FileName);
            //string fileNameNo = Path.GetFileName(fileBomUrl.PostedFile.FileName);

            string Paths = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/RourFile");
            if (!Directory.Exists(Paths))
            {
                Directory.CreateDirectory(Paths);
            }
            if (hfc.Count > 10)
            {
                this.Response.Write("<script>alert('导入的文件不能超过10个')</script>");
                return;
            }
            try
            {
                //首先我们需要使用一个变量来获取到由客户端上传的文件集合
                for (int i = 0; i < hfc.Count; i++)
                {
                    dataTable = new DataTable();
                    //接下来循环这个集合
                    HttpPostedFile hpf = hfc[i];
                    string IsXls = System.IO.Path.GetExtension(hpf.FileName).ToString().ToLower();
                    f_name = DateTime.Now.ToString("yyyyMMddHHmmssfff") + "_" + hpf.FileName;
                    name = Path.GetFileNameWithoutExtension(hpf.FileName);

                    if (IsXls != ".xlsx" && IsXls != ".xls")
                    {
                        this.Response.Write("<script>alert('" + f_name + "只可以选择Excel文件')</script>");
                        return;//当选择的不是Excel文件时,返回
                    }
                    //将每个文件实例化成可以直接访问的实体
                    //InsertRout(hpf.FileName, IsXls, f_name);
                    string filePath = Paths + "/" + f_name;
                    //this.fileBomUrl.PostedFile.SaveAs(filePath);
                    //fileBomUrl.PostedFile.InputStream.Close();
                    //fileBomUrl.PostedFile.InputStream.Dispose();
                    hfc[i].SaveAs(Path.Combine(Paths, f_name));

                    url = filePath;
                    fs = new FileStream(url, FileMode.Open, FileAccess.Read);
                    if (url.IndexOf(".xlsx") > 0) // 2007版本
                        workbook = new XSSFWorkbook(fs);
                    else if (url.IndexOf(".xls") > 0) // 2003版本
                        workbook = new HSSFWorkbook(fs);
                    sheet = workbook.GetSheetAt(0);
                    int rowCount = sheet.LastRowNum;
                    if (rowCount > 0)
                    {
                        for(int r = rowCount; r > 7; r--)
                        {
                            if (sheet.GetRow(r) != null)
                            {
                                rowCount = r;
                                break;
                            }
                        }

                        int currRow = 0; 
                        try
                        {
                            edition = sheet.GetRow(1).GetCell(0).StringCellValue;
                            edition = System.Text.RegularExpressions.Regex.Replace(edition, @"\s", "");
                            attributionCode = sheet.GetRow(1).GetCell(2).StringCellValue;
                            attributionCode = System.Text.RegularExpressions.Regex.Replace(attributionCode, @"\s", "");
                            var mycell = sheet.GetRow(2).GetCell(1);
                            mycell.SetCellType(cellType: CellType.String);
                            DrawingNo = sheet.GetRow(2).GetCell(1).StringCellValue;
                            dataTable.Columns.Add("Id");
                            dataTable.Columns.Add("Station");
                            dataTable.Columns.Add("Remrk");
                            dataTable.Columns.Add("Control");
                            dataTable.Columns.Add("Default1");
                            dataTable.Columns.Add("Default2");
                            dataTable.Columns.Add("Default3");
                            dataTable.Columns.Add("Default4");
                            int j = 1;
                            for (int k = 5; k <= rowCount; k++)
                            {
                                currRow = k;
                                if (sheet.GetRow(k).GetCell(0).StringCellValue == "Φ")
                                {
                                    dataTable.Rows.Add(j, Station, describe, Control, EquipmentCode);
                                    Station = "";
                                    describe = "";
                                    Control = "";
                                    EquipmentCode = "";
                                    break;
                                }
                                if (sheet.GetRow(k).GetCell(0).StringCellValue != "")
                                {
                                    if (Station != "")
                                    {

                                        dataTable.Rows.Add(j, Station, describe, Control,EquipmentCode);
                                        Station = "";
                                        describe = "";
                                        Control = "";
                                        EquipmentCode = "";
                                        j = j + 1;
                                    }
                                    Station = sheet.GetRow(k).GetCell(0).StringCellValue;
                                    if (Station == "入库")
                                    {
                                        Station = "";
                                        describe = "";
                                        Control = "";
                                        EquipmentCode = "";
                                        break;
                                    }
                                }
                                if (sheet.GetRow(k).GetCell(1).StringCellValue != "")
                                {
                                    if (describe == "")
                                    {
                                        describe = sheet.GetRow(k).GetCell(1).StringCellValue;
                                    }
                                    else
                                    {
                                        describe = describe + " - " + sheet.GetRow(k).GetCell(1).StringCellValue;
                                    }
                                }
                                if (sheet.GetRow(k).Count() > 4)
                                {
                                    if (sheet.GetRow(k).GetCell(4).StringCellValue != "")
                                    {
                                        if (Control == "")
                                        {
                                            Control = sheet.GetRow(k).GetCell(4).StringCellValue;
                                        }
                                        else
                                        {
                                            Control = Control + " - " + sheet.GetRow(k).GetCell(4).StringCellValue;
                                        }
                                    }
                                    if (sheet.GetRow(k).GetCell(5).StringCellValue != "")
                                    {
                                        if (EquipmentCode == "")
                                        {
                                            EquipmentCode = sheet.GetRow(k).GetCell(5).StringCellValue;
                                        }
                                        else
                                        {
                                            EquipmentCode = EquipmentCode + " - " + sheet.GetRow(k).GetCell(5).StringCellValue;
                                        }
                                    }
                                }
                            }
                            if (fs != null)
                            {
                                fs.Close();
                            }
                        }
                        catch (Exception ex)
                        {
                            var msg = "【"+f_name + "】 第" + currRow + "行 ：" + ex.Message; 
                            this.Response.Write("<script>alert(" + msg + ")</script>");
                            WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, msg, true);
                            return;
                        }

                        try
                        {
                            string bomChildJson = JsonConvert.SerializeObject(dataTable);
                            AjaxServices.AjaxRouter router = new AjaxServices.AjaxRouter();
                            SKT.LeanMES.Router.BLL.Router router2 = new SKT.LeanMES.Router.BLL.Router();
                            router.ImportRouter(DrawingNo, edition, attributionCode, AccountController.GetCurrentUser().UserName, bomChildJson);
                            router2.ImportRouterurl(Paths + '/' + f_name, DrawingNo, edition);
                        }
                        catch(Exception ex)
                        {
                            var msg = "【" + f_name + "】：" + ex.Message;
                            this.Response.Write("<script>alert(" + msg + ")</script>");
                            WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, msg, true);
                            return;
                        }
                        
                    }
                    string NewSaveUPLoadPath = Paths + '/' + f_name;
                    if (!File.Exists(NewSaveUPLoadPath))
                    {
                        File.Copy(url, NewSaveUPLoadPath);
                        File.Delete(url);
                    }

                }
                this.Response.Write("<script>alert('导入工艺路线成功')</script>");
            }
            catch (Exception ex)
            {

                this.Response.Write("<script>alert(" + f_name + ex + ")</script>");
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                return;
            }

        }


        public void linkUploadFile_Click(string url, string edition, string DrawingNo)
        {

            //string path = Server.MapPath(WebHelper.WebRoot + "/UploadFiles/RourFile");
            //if (!Directory.Exists(path))
            //{
            //    Directory.CreateDirectory(path);
            //}
            //try
            //{
            //    filePath = path + "/" + url.;
            //    this.filepaths.Value = filePath;
            //    this.fuLoadingList.PostedFile.SaveAs(filePath);
            //}
            //catch (Exception)
            //{

            //    throw;
            //}
            //finally
            //{
            //    fuLoadingList.PostedFile.InputStream.Close();
            //    fuLoadingList.PostedFile.InputStream.Dispose();
            //}
        }
    }
}