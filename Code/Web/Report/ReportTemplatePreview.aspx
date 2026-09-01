<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ReportPreViewUI.master"
     CodeBehind="ReportPage.aspx.cs" Inherits="SKT.LeanMES.Web.Report.ReportPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContentReport" runat="server">
   <div id="sdpUI" style="width:100%; text-align:center;"> 
        <div style="width: 100%; height: 200px; display: table;">
            <span style="width: 100%; color: rgb(33, 173, 247); margin-right: auto; margin-left: auto; vertical-align: middle; display: 

table-cell;">正在加载数据...<br><img src="../Content/plugin/dialog/skin/default/images/loadinga.gif"/></span>
        </div>

    </div>
     <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.store.js" type="text/javascript"></script>
    <script type="text/javascript">
          $(document).ready(function () {
              data = store.get("PreviewCookie");
              $("#sdpUI").html(decodeURI(data));
          })
    </script>
</asp:Content>