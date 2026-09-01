<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="PartList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.PartList" Title="Part List Page" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3"><%=Resources.lang.PartCode %></td>
            <td class="Field3">
                <asp:TextBox ID="txtPartCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3"><%= Resources.lang.myPartName %></td>
            <td class="Field3">
                <asp:TextBox ID="txtPartName" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">备件类别</td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="ddlEquipmentType" CssClass="TextBox"></asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectEqType()" />
            </td>
        </tr>
        <tr>
            <td class="Label3">生产厂商</td>
            <td class="Field3">
                <asp:TextBox ID="txtFactoryName" runat="server" CssClass="TextBox"></asp:TextBox><input type="button" id="btnPartSupplier" class="ButtonBox"
                                                                                                        value="..." onclick="selectPartFactory()" />
            </td>
            <td class="Label3"><%= Resources.lang.VendorName %></td>
            <td class="Field3">
                <asp:TextBox ID="txtPartSupplierName" runat="server" CssClass="TextBox"></asp:TextBox><input type="button" id="btnFactory" class="ButtonBox"
                    value="..." onclick="selectPartSupplier()" />

            </td>
            <td class="Label3">存放位置</td>
            <td class="Field3">
                <asp:TextBox ID="txtPosition" runat="server" CssClass="TextBox" MaxLength="50"
                    ClientIDMode="Static">
                </asp:TextBox>
                <input type="button" value="..." class="ButtonBox" onclick="selectPosition()" />

            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="PartCode" HeaderText="<%$ Resources:lang, PartCode %>" />
            <asp:BoundField DataField="PartName" HeaderText="<%$ Resources:lang, myPartName %>" />
            <asp:BoundField DataField="EquipmentTypeName" HeaderText="备件类别" />

            <asp:BoundField DataField="PartStand" HeaderText="<%$ Resources:lang, PartStand %>" />

            <asp:BoundField DataField="Qty" HeaderText="在线数量" />
      <%--       <asp:TemplateField HeaderText="当前库存">
                <ItemTemplate>
                    
                </ItemTemplate>
            </asp:TemplateField>--%>
            <asp:BoundField DataField="CurrentStock" HeaderText="当前库存" />
            <asp:BoundField DataField="MinStock" HeaderText="最小库存" />
            <asp:BoundField DataField="MaxStock" HeaderText="最大库存" />

            <asp:BoundField DataField="UnitName" HeaderText="计量单位" />
            <asp:BoundField DataField="FactoryName" HeaderText="生产厂商" />
            <asp:BoundField DataField="SupplierName" HeaderText="<%$ Resources:lang, VendorName %>" />
            <asp:BoundField DataField="PartLive" HeaderText="更换备件周期" />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
                 <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>"  DataFormatString="{0:yyyy-MM-dd hh:mm:ss}" />
             <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" DataFormatString="{0:yyyy-MM-dd hh:mm:ss}"  />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true"
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression"
        TypeName="SKT.LeanMES.Equipment.BLL.Part" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/PartEdit.aspx?name=PartAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.PartAdd %>", src: openWinUrl, width: 750, height: 390 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/PartEdit.aspx?name=PartEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.PartEdit %>", src: openWinUrl, width: 750, height: 390 });
        }
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/PartView.aspx?name=PartView&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.PartView %>", src: openWinUrl, width: 750, height: 390 });
        }
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
        function In() {
            var idStr = getSelectedValues();
            if (idStr == "") idStr=0;
            var part = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(1)").html();
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/PartInOrOut.aspx?name=PartEdit&ID=" + idStr + "&type=1&part=" + escape(part);
            dialog({ title: mesLang("备件入库"), src: openWinUrl, width: 750, height: 450 });
        }
        function Out() {
            var idStr = getSelectedValues();
           if (idStr == "") idStr = 0;
            var part = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(1)").html();
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/PartInOrOut.aspx?name=PartEdit&ID=" + idStr + "&type=2&part=" + escape(part);
            dialog({ title: mesLang("备件出库"), src: openWinUrl, width: 750, height: 450 });
        }
        function Refresh() {
            document.forms[0].submit();
        }

        function getChooseValue(list) {
            if (temp == 2) {
                $("#<%=this.txtPartSupplierName.ClientID %>").val(list[0][2]);

            } else if (temp == 4) {

                $("#<%=this.txtPosition.ClientID %>").val(list[0][1]);

            } else if (temp == 47) {
                $("#<%=this.txtFactoryName.ClientID %>").val(list[0][2]);

            }
         }

        function selectEqType() {
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquimentTypeDialog.aspx?name=Equipment_EquimentTypeDialog&controlId=4";
            dialog({ title: mesLang("备件类别"), src: openWinUrl, width: 255, height: 350 });
        }
       /*存放位置*/
       function selectPosition() {
           temp = 4;
           dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=609&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
      /*选择生产厂商*/
        function selectPartFactory() {
            temp = 47;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function selectPartSupplier() {
            temp = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        SetValue = function (list) {
            closeDialog();
            $("#HiddenEquipmentTypeId").val(list[0].id);
            $("#<%=ddlEquipmentType.ClientID%>").val(list[0].name);
        }
    </script>
</asp:Content>

