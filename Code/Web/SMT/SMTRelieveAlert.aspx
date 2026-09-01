<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMTRelieveAlert.aspx.cs"
    Inherits="SKT.LeanMES.Web.SMT.SMTRelieveAlert" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
  <object width="0" height="0" id="AndonActiveX" codebase="../Content/Component/Andon/AndonSetup.msi" classid="clsid:685F0A47-944D-4145-BF4E-76A02A422B02"></object>
  <div style="font-family: 幼圆; font-size: large;  margin-left:10px; margin-top:10px;"> 
   <table width="80%" >
        <tr>
              <td align="right">
              <%=Resources.lang.RelieveAlertNotes%>：
              </td>
              <td align="left">
                 <%=Resources.lang.RelieveAlertNotes1%>
              </td>
        </tr>
        <tr>
        <td></td>
        <td align="left"><%=Resources.lang.RelieveAlertNotes2%></td>
        </tr>
        <tr>
        <td></td>
        <td align="left"><%=Resources.lang.RelieveAlertNotes3%></td>
        </tr>
    </table>
    </div>

      <script type="text/javascript">
          //关闭方法
          function Close() {
              HistoryGo();
          }

          function RelieveAlert() {
              try {
                  var reg=document.getElementById("AndonActiveX").AndonStart(false);
                  if (reg == 1) {
                      //ToDo..
                      savehistory();
                  }
                //  alert("<%=Resources.Messages.RelieveAlert %>");
              }
              catch (e) {
                  alert("<%=Resources.Messages.InvalidRelieveAlert %>");
                  
              }
          }

          function Return() {
              HistoryGo();
          }
          function HistoryGo() {
              history.go(-1);
          }

          function savehistory() {
              var HostName = document.getElementById("AndonActiveX").GetComputerName();
              var Comment = "报警结束";
              //不执行后面的方法
              var ajaxStr = SKT.LeanMES.Web.Controls.PageSQLService.Search("wtZcpRixrm0n04w6MVUErNzAWhRz3qGS9l42h5aLBA0ZO631lNuhSQ==",
             "54ok/8VECBw=", "mXlEkSiwBnocX7QgXC5Bhsu4lqzclV89V+RqwzpwBSE=",
                "1FzU4DWWuP6PyHLnzbXfVRGijzltjAFa#{'" + HostName + "'}#M4W4Ay5+hUfs0V33htfh1YmMdeorpOaO", "+rp516xMJ2A=");
              if (ajaxStr.value == "") {
                  alert("<%=Resources.Messages.RelieveExistsAlert %>");   
                  return false;
              }
              else {
                  /**end**/
                  var flage = 1;   //0表示报警记录，1表示关闭记录
                  var Action = 1;
                  var Errcode = "";  //待获取
                  /*****获取errorCode*****/
                  var ajaxValue = SKT.LeanMES.Web.Controls.PageSQLService.Search("H0dZQmiL7S0XnDjnp1N1rtdGDglXMrsR6aYmv17CUxfZUQr/OT+kig==",
             "54ok/8VECBw=", "mXlEkSiwBnocX7QgXC5Bhsu4lqzclV89V+RqwzpwBSE=",
                "1FzU4DWWuP6PyHLnzbXfVRGijzltjAFa#{'" + HostName + "'}#M4W4Ay5+hUfs0V33htfh1YmMdeorpOaO", "+rp516xMJ2A=");
                  if (ajaxValue.error == null) {
                      var entity = ajaxValue.value;
                      if (entity[0] != null) {
                          Errcode = entity[0].Field2;
                      }
                  }
                  /****end****/
                  var Status = 1;   //报警记录状态
                  var ajaxsave = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.SaveAlertHistory(flage, HostName, Comment, Action, Errcode, Status);
                  if (ajaxsave.error != null) {
                      alert(ajaxsave.error.Message);
                  }
                  alert("<%=Resources.Messages.RelieveAlert %>");
              }
          }
    </script>

</asp:Content>
   