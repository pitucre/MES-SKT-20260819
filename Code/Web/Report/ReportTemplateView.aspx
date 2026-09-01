<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Masters/ViewMaster.master"  
   CodeBehind="ReportTemplateView.aspx.cs" Inherits="SKT.LeanMES.Web.Report.ReportTemplateView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
<table width="100%" class="EditeContentTable">
    
    <tr>
        <td class="Label" align="left" colspan="2">
       <%-- <%=Resources.Messages.WithAsteriskIsRequired %>--%>
        <span style="float:right;"><a href="javascript:void(0);" onclick="resizeContent();"><%=Resources.lang.ExpandOrCollapse%></a></span>
        </td>
    </tr>
    <tr class="ReportInfo">
        <td class="Label1">报表名称(中文)</td>
        <td class="Field1">
            <asp:Label ID="txtReportCNName" runat="server" ClientIDMode="Static"></asp:Label>
            <asp:HiddenField  ID="hdnReportName" runat="server"/>
        </td>
    </tr>
    <tr class="ReportInfo">
        <td class="Label1">报表名称(英文)</td>
        <td class="Field1">
          <asp:Label ID="txtReportENName" runat="server" ClientIDMode="Static"></asp:Label>
        </td>
    </tr>
    <tr class="ReportInfo">
        <td class="Label1">报表图标</td>
        <td class="Field1">
            <span id="reportIcon" style="vertical-align:middle">无</span><%--<span style="margin-left:5px;"><a href="javascript:void(0)" onclick="chooseIcon();">选择图标</a></span>--%>
            <asp:HiddenField ID="hdnIcon" runat="server"/>
        </td>
    </tr>
    <tr class="ReportInfo">
        <td class="Label1"><%=Resources.lang.Sequence %></td>
        <td class="Field1">
           <asp:Label ID="txtSequence" runat="server" ClientIDMode="Static"></asp:Label>
        </td>
    </tr>
    <tr class="ReportInfo">
        <td class="Label1">报表类型</td>
        <td class="Field1">
            <SKTControl:ReportDDL runat="server" ID="ddlReport" ClientIDMode="Static" Visible="false" ></SKTControl:ReportDDL>
            <asp:Label ID="lblReport" runat="server" ></asp:Label>
        </td>
    </tr>
    <tr class="ReportInfo">
        <td class="Label1"><%=Resources.lang.Description %></td>
        <td class="Field1">
          <asp:Label ID="txtTmplDesc" runat="server" ClientIDMode="Static"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="Label" align="left" colspan="2"> 
                <span style="float: left; font-weight:bold;">模板内容&nbsp;&nbsp;</span>
                <span style="float: right; color: #cccccc">编辑器版本 1.0.0</span>
        </td>
    </tr>
    <tr>
        <td class="Field" align="left" colspan="2">
            <div id="loadingmsg" class="loadingmessage">
                    <%=Resources.Messages.LoadingData %></div>
            <iframe id="ifCtrl" name="ifCtrl" frameborder="0" width="100%" height="195px" marginheight="0" marginwidth="0" scrolling="auto" src=""></iframe>
            <asp:HiddenField ID="hdnValue" runat="server" Value=""/>
        </td>
    </tr>
</table>
<script type="text/javascript">
    var reportId = '<%=Request.QueryString["ID"] %>';

    $(function () {
        $(document).keydown(function (e) {
            if (e.which == 83 && e.ctrlKey) {
                Save();
            }
        });

        var iframes = document.getElementById("ifCtrl");
        iframes.src = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/highlight/htmlmixededitor.aspx?rnd=" + Math.random();
        var values = $("#<%=this.hdnValue.ClientID %>").val();
        if (iframes.attachEvent) {
            iframes.attachEvent("onload", function () {
                $("#loadingmsg").hide();
                if (values != "") {
                    iframes.contentWindow.setData(values);
                }
                else {
                    iframes.contentWindow.setData("<div>你可以在此编辑您的HTML代码</div>\n<script type='text/javascript'>/*您可以在此写入您的js代码*/<\/script>");
                }
                setCodeHeight();
            });
        }
        else {
            iframes.onload = function () {
                $("#loadingmsg").hide();
                if (values != "") {
                    iframes.contentWindow.setData(values);
                }
                else {
                    iframes.contentWindow.setData("<div>你可以在此编辑您的HTML代码</div><script type='text/javascript'>/*您可以在此写入您的js代码*/<\/script>");
                }
                setCodeHeight();
            };
        }
    });
    function resizeContent() {
        var iframes = document.getElementById("ifCtrl");
        $(".ReportInfo").toggle();
        if ($("#ifCtrl").css("height").replace("px", "") == "195") {
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("height", "390px");
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("overflow", "auto");
            $("#ifCtrl").css("height", "390px");
        }
        else {
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("height", "195px");
            $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("overflow", "auto");
            $("#ifCtrl").css("height", "195px");
        }
    }

    //设置代码编辑器的高度
    function setCodeHeight() {
        var iframes = document.getElementById("ifCtrl");
        $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("height", "195px");
        $(".CodeMirror-scroll", iframes.contentWindow.document.body).css("overflow", "auto");
        $("#ifCtrl").css("height", "195px");
    }

    //选择图标
    function chooseIcon() {
        dialog({ title: '<%=Resources.lang.ChooseIcon %>', src: 'ChooseIcon.aspx', width: 400, height: 300 });
    }

    //显示选中的图标
    function setIcon(icon, iconname) {
        $("#reportIcon").html("<img src='" + icon + "'/>");
        $("#<%=this.hdnIcon.ClientID %>").val(iconname);
        closeDialog();
    }
</script>
</asp:Content>
