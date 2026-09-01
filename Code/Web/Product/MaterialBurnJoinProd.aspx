<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true" CodeBehind="MaterialBurnJoinProd.aspx.cs" Inherits="SKT.LeanMES.Web.Product.MaterialBurnJoinProd" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table width="100%" class="EditeContentTable">
         <tr>
            <td class="Label1">软件名称</td>
            <td class="Field1">
                <span id="SoftName"></span>
            </td>
        </tr>
        <tr>
            <td class="Label1">关联产品<em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                            Width="64%">
                        </asp:TextBox><input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..."
                            title="Select" onclick="openChoosePage(1);" /><em>*</em>
                        <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1">关联物料<em>*</em></td>
            <td class="Field1">
                <asp:TextBox ID="TextMaterialCode" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static"
                            Width="64%">
                        </asp:TextBox><input type="button" id="Button1" runat="server" class="ButtonBox" value="..."
                            title="Select" onclick="openChoosePage(816);" /><em>*</em>
                        <asp:HiddenField ID="hdnMaterialId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
        <tr>
            <td class="Label1"> 
            </td>
            <td class="Field1">
                <input id="btnAdd" type="button" value="增加" class="button" onclick="saveData()" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataSourceID="ObjectDataSource1">
        <Columns>
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品描述" />
            <asp:BoundField DataField="MItemCode" HeaderText="物料编码" />
            <asp:BoundField DataField="MItemName" HeaderText="物料描述" />
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <input name="delItem" type="button" value="删除" onclick="delItemRow('<%# Eval("ItemId").ToString() %>','<%# Eval("MaterialItemId").ToString() %>')" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Molding.BLL.MaterialBurnMember"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        var flag =0;
        var ID = '<%=Request.QueryString["ID"] %>';
        var SoftName=decodeURIComponent('<%=Request.QueryString["SF"] %>');
        $("#SoftName").html(SoftName);
        var BomItemCode="";

        function CheckItem(){
            if($("#hdnItemId").val() == ""||$("#hdnItemId").val()=="-1"){
                alert("请选择产品");
                return false;
            }
            
            return true;
        }

        function openChoosePage(flags) {
            if(flags==1){
                var condition = "";        
                flag = flags;
                dialog({
                    title: "<%= Resources.Common.ChooseWindow %>",
                    src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                    flags +
                    "&Multiple=false&SearchCondition=" +
                    condition +
                    "&rnd=" +
                    Math.random(),
                    width: 650,
                    height: 350
                });
            }else if(flags==816){
               if(!CheckItem()){
                  return;
                }
                //var BomItemCode = $("table.ListTable tr.ListTableOddRow").find("td:eq(1)").text();
                //$("table.ListTable tr.ListTableSelectedRow").find("td:eq(1)").text();
               if(!BomItemCode){
                   alert("未检测到关联产品编码!");
                   return false;
               }
                var searchCondition = " BomItemCode = '"+BomItemCode+"'";        
                flag = flags;
                dialog({
                    title: "<%= Resources.Common.ChooseWindow %>",
                    src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                    flags +
                    "&Multiple=false&SearchCondition=" +
                    searchCondition +"&PageCondition="+searchCondition+
                    "&rnd=" +
                    Math.random(),
                    width: 650,
                    height: 350
                });
            }
            
        }

        
        function getChooseValue(list) {
            if (flag == 1) {
                $("#txtItemCode").val(list[0][2]);
                $("#hdnItemId").val(list[0][0]);
                BomItemCode=list[0][2];
            }else if(flag==816){
                $("#TextMaterialCode").val(list[0][1]);
                $("#hdnMaterialId").val(list[0][0]);
            }
        }
        function saveData() {
            var entity = {};            
            entity.BurnMemberId = -1;
            entity.BurnId = ID;
            entity.ItemId = $("#hdnItemId").val();
            entity.MaterialItemId = $("#hdnMaterialId").val();

            if(!CheckItem()){
                return;
            }
            if($("#hdnMaterialId").val() == ""||$("#hdnMaterialId").val()=="-1"){
                alert("请选择物料");
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.MaterialBurnMemberAdd(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                if(window.confirm("新增成功,是否继续新增？")){
                    document.forms[0].submit();
                }
                else{
                    parent.window.Refresh();
                }               
                return true;
            }
        }

        function delItemRow(itemId,MaterialItemId){
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMolding.DelMaterialBurnMember(itemId,ID,MaterialItemId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            if(window.confirm("删除成功,是否继续删除？")){
                document.forms[0].submit();
            }
            else{
                parent.window.Refresh();
            }               
            return true;
        }
    </script>
</asp:Content>
