<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="RMAList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.RmaList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">RMA单号
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRmaNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">类型
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlRmaType" runat="server">
                    <asp:ListItem Value="-1"> 全部</asp:ListItem>
                    <asp:ListItem Value="1">RMA</asp:ListItem>
                    <asp:ListItem Value="2">DOA</asp:ListItem>
                </asp:DropDownList>
                <asp:HiddenField ID="hfInspectionType" runat="server" Value="-1" />
            </td>
        </tr>
        <tr>
            <td class="Label2">退货日期
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCancelTime" runat="server" CssClass="DateTimeBox" IsRequired="1" Width="150px"></asp:TextBox>
            </td>
            <td class="Label2">客户名称
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCustomerName" MaxLength="20" runat="server" CssClass="TextBox"
                    IsRequired="1"></asp:TextBox>
                <input type="button" id="btnSelectCustomer" class="ButtonBox" value="..." onclick="selectCustomer()" />

            </td>
        </tr>
        <tr>
            <td class="Label2">产品编码
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="button" id="btnSelectItem" class="ButtonBox" value="..." onclick="selectItem()" />
            </td>

        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_OnRowDataBound" HorizontalAlign="Center">
        <Columns>

            <asp:BoundField DataField="RmaNo" HeaderText="RMA单号" ItemStyle-Width="120px" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="RTypeId" HeaderText="<%$Resources:lang,Type %>" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="CustomerName" HeaderText="客户名称" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Number" HeaderText="总数量" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="StatusName" HeaderText="状态" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" />

            <asp:BoundField DataField="CancelTime" HeaderText="退货时间" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$Resources:lang,CreateBy %>" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="CreateTime" HeaderText="<%$Resources:lang,CreateTime %>" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$Resources:lang,ModifyBy %>" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$Resources:lang,ModifyDateTime %>" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            <asp:BoundField DataField="Remark" HeaderText="<%$Resources:lang,Remark %>" ItemStyle-Width="150px" ItemStyle-HorizontalAlign="Center" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.Rma"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <input type="hidden" id="hdnRamNo" name="hdnRamNo" value="" />

    <script language="javascript" type="text/javascript">
     var openWinUrl = "";
     var hdnOperate = $("#hdnOperate");
     var hdnIdString = $("#hdnIdString");
     var hdnRamNo = $("#hdnRamNo");

     function Add() {
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/RMAEdit.aspx?name=QC_RMAAdd&ID=-1";
         dialog({ title: "<%=Resources.Pages.QC_RMAAdd %>", src: openWinUrl, width: 950, height: 660 });
     }

    function Edit() {
        //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
        // 6 改为 StatusName
        var Status = getRecordCellTextsByFiled("StatusName"); 
        if (Status == "已接收") {
            alert("状态已接收不允许编辑!");
            return;
        }
        var idStr = getOneRecordId();
        if (idStr === "") return false;
        openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/RMAEdit.aspx?name=QC_RMAEdit&ID=" + idStr;
        dialog({ title: "<%=Resources.Pages.QC_RMAEdit %>", src: openWinUrl, width: 950, height:660 });
     }

     function Save2Excel() {
         var hdnOperate = $("#hdnOperate");
         hdnOperate.val("ExportExcel");
         document.forms[0].submit();
         hdnOperate.val("");
     }

     function Delete() {
         var idStr = getDeletingRecordIdString();
         if (idStr === "") return false;
         hdnOperate.val("delete");
         hdnIdString.val(idStr);
         document.forms[0].submit();
     }
     function UpdateList(itemName) {
         document.forms[0].submit();
     }
    function selectCustomer() {
        chooseFlag = 1;
        dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
    }

    function selectItem() {
        chooseFlag = 2;
        dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
    }
    function getChooseValue(list) {
        if (chooseFlag == 1) {
            $("#<%=this.txtCustomerName.ClientID %>").val(list[0][1]);
                 
        } else if (chooseFlag == 2) {
            $("#<%=this.txtItemCode.ClientID %>").val(list[0][2]);
              
        } 
    }

        // 导出PDF文件
        function RMAPdfPrint() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            //xiang.yan 2024-4-29 根据列号去值，改为根据列名取值
            // 1 改为 RmaNo
            var rmaNo = getRecordCellTextsByFiled("RmaNo"); 
            hdnOperate.val("rmareportpdfprint");
            hdnRamNo.val(rmaNo);
            hdnIdString.val(idStr);
            document.forms[0].submit();
            hdnOperate.val("");
            hdnRamNo.val("");
        }

    </script>
</asp:Content>
