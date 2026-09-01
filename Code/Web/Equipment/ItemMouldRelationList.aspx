<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="True"
    CodeBehind="ItemMouldRelationList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.ItemMouldRelationList" Title="ItemMouldRelationList List Page" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" Runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3"><%=Resources.lang.ItemCode%></td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
              <input type="button" class="ButtonBox"
                        value="..." onclick="selectItemCode()" />
            </td>
            <td class="Label3"><%=Resources.lang.ItemName%></td>
            <td class="Field3">
                <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox"></asp:TextBox>
              <input type="button" class="ButtonBox"
                        value="..." onclick="selectItemName()" />
            </td>
            <td class="Label3"><%=Resources.lang.MouldName%></td>
            <td class="Field3">
                <asp:TextBox ID="txtMouldName" runat="server" CssClass="TextBox"></asp:TextBox>
                 <input type="button"  class="ButtonBox"
                        value="..." onclick="selectMouldName()" />
            </td>
               
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
        <Columns>
            <%-- To Do --%>
              <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" />
            <asp:BoundField DataField="BomName" HeaderText="<%$ Resources:lang, MouldName %>" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang, CreateBy %>" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$ Resources:lang, CreateDateTime %>" />
            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang, Remark %>" />
        </Columns>


    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Equipment.BLL.ItemMouldRelation" SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>

    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        function Add() {
          
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/ItemMouldRelationEdit.aspx?name=ItemMouldRelationAdd&ID=-1&EqCode=''";
            <%--openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentItemRelationEdits.aspx?name=EquipmentItemRelationListAdd&ID=-1";--%>//类似BOM的添加模式
            dialog({ title: "<%=Resources.Pages.ItemMouldRelationAdd %>", src: openWinUrl, width: 850, height: 500});
        }


        var chooseFlag = -1;
        function selectItemName() {
         
             chooseFlag = 1;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 700, height: 450 });
        }

       function selectMouldName() {
             chooseFlag=2
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=705&Multiple=false&rnd=" + Math.random(), width: 700, height: 450 });
       }
        function selectItemCode() {
         
             chooseFlag = 3;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 700, height: 450 });
        }
        
          function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtItemName.ClientID %>").val(list[0][1]);
            } else if (chooseFlag == 2) {
                $("#<%=this.txtMouldName.ClientID %>").val(list[0][1]);
            }else if (chooseFlag == 3) {
                $("#<%=this.txtItemCode.ClientID %>").val(list[0][2]);
            }
        }
        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/ItemMouldRelationEdit.aspx?name=ItemMouldRelationEdit&ID=" + idStr;
            dialog({ title: mesLang("编辑产品与模具BOM关联"), src: openWinUrl, width: 850, height: 500 });
        }

        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function Refresh() {
            document.forms[0].submit();
        }
    </script>
</asp:Content>

