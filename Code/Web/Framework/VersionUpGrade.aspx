<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="VersionUpGrade.aspx.cs" Inherits="SKT.LeanMES.Web.Framework.VersionUpGrade" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <style type="text/css">
        .guize_html {
            position: fixed;
            top: 25%;
            left: 50%;
            margin-top: -80px;
            margin-left: -159px;
            width: 318px;
            height: auto;
            border-radius: 4px;
            background-color: #fff;
            color: #000;
            text-align: center;
            font-size: 12px;
        }

        .guize_html p {
            padding: 0 10px;
            text-align: left;
            text-indent: 2em;
        }

        .guize_html_nei {
            width: 318px;
            min-height: 350px;
            overflow-y: auto;
            max-height: 500px;
            height: 350px;
            display: block;
            text-align:left;
            font-family : 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
            font-size:15px;            
        }

        .btn {
            display: block;
            margin: 10px auto;
            width: 240px;
            height: 40px;
            border-radius: 4px;
            background-color: #009688;
            color: #fff;
            text-align: center;
            line-height: 40px;
            cursor: pointer;
        }

        .overfloat {
            position: fixed;
            top: 0;
            left: 0;
            z-index: 9;
            display: none;
            width: 100%;
            height: 100%;
            background-color: rgba(1,1,1,.5);
        }

        .noShow{
            display:none;
        }
    </style>

    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">更新版本</td>
            <td class="Field2">
                <asp:TextBox ID="txtVersion" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">更新时间
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtDateTimeStart" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
                ~
                <asp:TextBox ID="txtDateTimeEnd" runat="server" CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="Version" HeaderText="版本" />
            <asp:BoundField DataField="UpgradeDatetime" HeaderText="更新时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="Description" HeaderText="更新内容" />
            <asp:TemplateField HeaderText="更多">
                <ItemTemplate>
                    <%# "<a name='more' href='#' onclick='ShowMore(this)'>...</a>" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Remark" HeaderText="更新说明" HeaderStyle-CssClass="noShow" ControlStyle-CssClass="noShow" FooterStyle-CssClass="noShow" ItemStyle-CssClass="noShow"  />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Web.AjaxServices.AjaxCommon"
        SelectMethod="GetAllVersion" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <div class="overfloat" id="gui_kai">
        <div class="guize_html">
            <textarea class="guize_html_nei" rows="10" cols="1" readonly>                
            </textarea>
            <div id="g_close" class="btn">
                确定
            </div>
        </div>
    </div>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        isMultiple = false;
        _isHms = true;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        $(document).ready(function () {
            hdnOperate.val("");

            $('#g_close').click(function () {
                $("#gui_kai").hide();
            });
        });

        function ShowMore(obj) {            
            $(".guize_html_nei").html($(obj).parent().next()[0].innerHTML);

            $("#gui_kai").show();
        }
    </script>
</asp:Content>
