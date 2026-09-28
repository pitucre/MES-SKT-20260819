#r "E:\source\MES\SKT\20260819\Code\Lib\SKT.Common.Utility.dll"
#r "System.Web"

using System;
using System.IO;
using System.Web;
using System.Data.SqlClient;
using System.Reflection;

// Load EncryptHelper
var assembly = Assembly.LoadFrom(@"E:\source\MES\SKT\20260819\Code\Lib\SKT.Common.Utility.dll");
var encryptHelperType = assembly.GetType("SKT.Common.Utility.EncryptHelper");
var encryptMethod = encryptHelperType.GetMethod("Encrypt", new Type[] { typeof(string) });
var decryptMethod = encryptHelperType.GetMethod("Decrypt", new Type[] { typeof(string) });

string connStr = "Server=172.16.5.144;Database=LeanMes;User Id=sa;Password=SAsa123;";

// ===== Fix M03 OEE Report =====
Console.WriteLine("=== Fixing M03 OEE Report ===");
string m03Original = File.ReadAllText(@"E:\source\MES\SKT\20260819\DataSql\m03OEEReport_template.txt");

// Modification 1: openLabelPrint with parameters
string oldLabel = @"function openLabelPrint(ExternalCode, WorkDate) {
    var url = '../Report/ReportPage.aspx?name=540D7348-E9F8-4F0A-9756-E0560DB27A9E';
    window.open(url, '_blank');
}";
string newLabel = @"function openLabelPrint(ExternalCode, WorkDate) {
    var url = '../Report/ReportPage.aspx?name=540D7348-E9F8-4F0A-9756-E0560DB27A9E&EquipmentCode=' + encodeURIComponent(ExternalCode) + '&WorkDate=' + encodeURIComponent(WorkDate);
    window.open(url, '_blank');
}";
string modified = m03Original.Replace(oldLabel, newLabel);
Console.WriteLine("Has encodeURIComponent: " + modified.Contains("encodeURIComponent"));

// Modification 2: rowAttrRender
string oldEnd = @"                pageSize: 100,
                isProcPage: true
            });
        }  
    
    
    
    function showDetail";
string newEnd = @"                pageSize: 100,
                isProcPage: true,
                rowAttrRender: function(row, index) {
                    if (row[""模穴数""] == ""0"" || row[""模穴数""] == 0) {
                        return 'style=""color: red;""';
                    }
                    return '';
                }
            });
        }  
    
    
    
    function showDetail";
modified = modified.Replace(oldEnd, newEnd);
Console.WriteLine("Has rowAttrRender: " + modified.Contains("rowAttrRender"));

// UrlEncode and Encrypt
string encoded = HttpUtility.UrlEncode(modified);
var encrypted = encryptMethod.Invoke(null, new object[] { encoded });

using (var conn = new SqlConnection(connStr))
{
    conn.Open();
    var cmd = new SqlCommand("UPDATE Report_Template SET TemplateContent=@content WHERE TemplateName='615562BE-0600-48B0-B41E-720047121637'", conn);
    cmd.Parameters.AddWithValue("@content", encrypted);
    cmd.ExecuteNonQuery();
    Console.WriteLine("M03 OEE Report saved!");
}

// ===== Fix Label Print Report =====
Console.WriteLine("\n=== Fixing Label Print Report ===");
string labelOriginal = File.ReadAllText(@"E:\source\MES\SKT\20260819\DataSql\labelPrintReport_template.txt");

string urlScript = @"<script type=""text/javascript"">$(function(){var p=new URLSearchParams(window.location.search);var eq=p.get(""EquipmentCode"");var dt=p.get(""WorkDate"");if(eq){$(""#OrderNO"").val(decodeURIComponent(eq));}if(dt){$(""#SCreateTime"").val(decodeURIComponent(dt));$(""#ECreateTime"").val(decodeURIComponent(dt));}if(eq||dt){setTimeout(function(){$(""#bnView"").click();},500);}});</script>";

string modified2 = labelOriginal.Replace("<script type=\"text/javascript\">", urlScript + "<script type=\"text/javascript\">");
Console.WriteLine("Has URLSearchParams: " + modified2.Contains("URLSearchParams"));

string encoded2 = HttpUtility.UrlEncode(modified2);
var encrypted2 = encryptMethod.Invoke(null, new object[] { encoded2 });

using (var conn = new SqlConnection(connStr))
{
    conn.Open();
    var cmd = new SqlCommand("UPDATE Report_Template SET TemplateContent=@content WHERE TemplateName='540D7348-E9F8-4F0A-9756-E0560DB27A9E'", conn);
    cmd.Parameters.AddWithValue("@content", encrypted2);
    cmd.ExecuteNonQuery();
    Console.WriteLine("Label Print Report saved!");
}

Console.WriteLine("\n=== All done! ===");
