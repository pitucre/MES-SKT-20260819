<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="InspectionFileManage.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionFileManage" %>


<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server" ViewStateMode="Enabled">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                <%= Resources.lang.ItemCode%>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtitemcode" runat="server" CssClass="TextBox"
                    IsRequired="1" ClientIDMode="Static" Width="64%"></asp:TextBox><input type="button" id="btnSelectItems" onclick="selectItems(this);" class="ButtonBox" value="..." />
            </td>
            <td class="Label3">供应商
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtsuppliername" runat="server" CssClass="TextBox"
                    IsRequired="1" ClientIDMode="Static" Width="64%"></asp:TextBox><input
                        type="button" id="supplierName" class="ButtonBox" value="..." onclick="selectCustomer()" />
            </td>
            <td class="Label3">
                <%= Resources.lang.FileType%>
            </td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlltype">
                    <asp:ListItem>请选择</asp:ListItem>
                    <asp:ListItem>dll</asp:ListItem>
                    <asp:ListItem>xls</asp:ListItem>
                    <asp:ListItem>pdf</asp:ListItem>
                    <asp:ListItem>xls</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
          <%--  <asp:BoundField DataField="Number" HeaderText="<%$ Resources:lang, Sequence %>" />--%>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
            <asp:BoundField DataField="SupplierName" HeaderText="<%$ Resources:lang, FSupplierName %>" />           
           <%-- <asp:BoundField DataField="FileName" HeaderText="<%$ Resources:lang, FileName %>" />--%>
            <asp:TemplateField HeaderText="<%$ Resources:lang, FileName %>">  
                 <ItemTemplate>
                     <a href='javascript:void(0);' onclick="LoadZhenShu('<%#Eval("FileSaveName")%>')"><%# Eval("FileName") %> </a>  
                </ItemTemplate>  
           </asp:TemplateField>  
            <asp:BoundField DataField="FileVersion" HeaderText="文件版本" />
            <asp:BoundField DataField="FileType" HeaderText="<%$ Resources:lang, FileType %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="创建人" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="FileSaveName" HeaderText="磁盘文件名" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="save-name hidden" />
            <asp:BoundField DataField="DataSource" HeaderText="数据源" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="data-source hidden" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialIQC"
        SelectMethod="GetFileInfo" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="filename" name="filename" value="" />
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <asp:HiddenField ID="hidFileSaveName" runat="server" />
    <asp:HiddenField ID="hidDataSource" runat="server" />
    <style>
        .hidden {
            display: none;
        }
    </style>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var filename = $("#filename");

        $().ready(function () {
            $("#ckbMultipleSelected").parent().hide();
        });

        function Load() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/InspectionFileManageUpLoad.aspx?name=InspectionFileManageUpLoad&rnd=" + Math.random(), width: 700, height: 400
            });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            var filenames = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(5)").html();
            filename.val(filenames);
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);

            var checkedTrObj = $('input[name="chkSelect"]:checked').parent().parent();
            var fileName = $.trim(checkedTrObj.find(".save-name").html());
            var dataSource = $.trim(checkedTrObj.find(".data-source").html());
            $("#<%=this.hidFileSaveName.ClientID%>").val(fileName);
            $("#<%=this.hidDataSource.ClientID%>").val(dataSource);
            document.forms[0].submit();
        }
        //function Closess() {
        //    closeDialog();
        //}

        function selectItems(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function getChooseValue(list) {
            $("#txtitemcode").val(list[0][2]);
            itemcode = list[0][2];
        }
        function selectCustomer(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&CallBackFunc=getChooseValueCustomer&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function getChooseValueCustomer(list) {
            $('#txtsuppliername').val(list[0][2]);
            supplier = list[0][1];
        }
        //下载查看
        function FileSave(data) {
            //var FileName = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(5)").html();
            //if (FileName == '' || FileName == null) {
            //    alert("请选择记录");
            //    return false;
            //}
            var checkedTrObj = $('input[name="chkSelect"]:checked');
            if (checkedTrObj.length <= 0) {
                alert("请选择记录");
                return;
            } else if (checkedTrObj.length > 1) {
                alert("只能选择一条数据");
                return;
            }
            var fileName = $.trim(checkedTrObj.parent().parent().find(".save-name").html());
            <%--var path = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/UploadFiles/Inspection" + data;--%>
            try {
                var path = '<%=SKT.LeanMES.Web.WebHelper.InspectionFileRoot %>' + fileName;
                window.open(path);
            } catch (e) {
                alert(e);
                //console.log(e);
                //e;
            }
            //console.log(e);
        }
         function LoadZhenShu(data) {
            if (data == "未载入") {
                alert("未上传文件!");
                return false;
            }
            var path = GetFilePath("InspectionFile", data);
            window.open(path);
        }
    </script>
</asp:Content>
