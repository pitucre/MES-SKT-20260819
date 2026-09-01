<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true"
    CodeBehind="ColourItemCodeList.aspx.cs" Inherits="SKT.LeanMES.Web.SDP.ColourItemCodeList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <!--打印插件未安装的提示区域-->
    <div id="noprtplg" class="Tips">
    </div>
    <!--打印状态的信息提示区域-->
    <div id="lblMessage" class="Tips" style="text-align: center">
    </div>
    <table width="100%" class="EditeContentTable">
       
        <tr>
            <td class="Label1">色粉编码:
            </td>
            <td class="Field1">
                <input type="text" id="txtColourItemCode" class="TextBox" style="height: 25px; width: 250px; text-transform: uppercase; font-size: 16px; font-weight: bold;" disabled="disabled" />

            </td>
        </tr>
        
    </table>
    <div class="clear5">
    </div>
    <div id="info" style="text-align: center; color: Green; font-weight: bold; text-transform: uppercase;">
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/layui.all.js"></script>
    <link href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/ws.js" type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js?v=3" type="text/javascript"></script>
    <script type="text/javascript">
       
        var ProdOrderId = '<%=Request.QueryString["ProdOrderId"]%>';
        $(function () {
            
            var entity = {};
            entity.ProdOrderId = ProdOrderId;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetColourItemCodeList", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return;
            } else {
                
                $("#txtColourItemCode").val(JSON.parse(ajax.value)[0].ColourItemCode);
               
            }
           
        });


    </script>
</asp:Content>
