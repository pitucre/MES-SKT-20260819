<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SMTFeedValidationList.aspx.cs"
    Inherits="SKT.LeanMES.Web.SMT.SMTFeedValidationList" MasterPageFile="~/Masters/ViewMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
 <%--<object width="0" height="0" id="AndonActiveX" codebase="../Content/Component/Andon/AndonSetup.msi" classid="clsid:685F0A47-944D-4145-BF4E-76A02A422B02"></object>--%>
  <div style="font-family: 幼圆; font-size: large;  margin-left:10px; margin-top:10px;"> 
   <table width="80%" >
        <tr>
              <td align="right">
              <%=Resources.lang.SMT_MaterialProcess%>：
              </td>
              <td align="left">
              1.<%=Resources.lang.SMT_SetUpLine%>
              </td>
        </tr>
        <tr>
        <td></td>
        <td align="left">2.<%=Resources.lang.Feeding%></td>
        </tr>
        <tr>
        <td></td>
        <td align="left">3.<%=Resources.lang.AddFeeding%></td>
        </tr>
    </table>
    </div>
    <script type="text/javascript">
    //线别设置方法
        function setUpLine() {
            window.location.href = "SMTSetupLine.aspx?name=SMTSetupLine&ID=-1";
        }
        //上料方法
        function Feed() {
            window.location.href = "SMTFeedValidationEdit.aspx?name=SMTFeedValidationEdit&ID=-1";
        }
        //续料方法
        function AddFeed() {
            window.location.href = "SMTAddFeeding.aspx?name=SMTAddFeeding&ID=-1";
        }
        function UpdateList() {
            document.forms[0].submit();
        }


        function RelieveAlert() {

            window.location.href = "SMTRelieveAlert.aspx?name=SMTRelieveAlert&ID=-1";
 
           
        }

    </script>
</asp:Content>
