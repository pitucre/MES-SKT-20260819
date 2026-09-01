<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="InspectionTemplateItemList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionTemplateItemList"  ViewStateMode="Enabled" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                模板类型
            </td>
            <td class="Field3">
                  <asp:DropDownList ID="ddlInspectionType" runat="server">
                </asp:DropDownList>
                <asp:HiddenField ID="hfInspectionType" runat="server" Value="-1" />
            </td>
             <td class="Label3">
               模板名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtInspectionTemplateName" runat="server" CssClass="TextBox"  IsRequired='1'  Enabled="false"></asp:TextBox><input id="button1" class="ButtonBox" type="button" onclick="SelectInspectionTemplate()" value="..." title="选择模板" /> 
                <asp:HiddenField ID="hfInspectionTemplateId" runat="server" Value="-1" />
                 <asp:HiddenField ID="hfInspectionTemplateName" runat="server"  />
            </td>
             <td class="Label2">
                <%=Resources.lang.ItemCode %><em>*</em>
            </td>
            <td class="Field2">
               <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"  IsRequired='1'  Enabled="false"></asp:TextBox><input id="button2" class="ButtonBox" type="button" onclick="SelectItem()" value="..." title="选择产品" /> 
                <asp:HiddenField ID="hfItemId" runat="server" Value="-1" />
                <asp:HiddenField ID="hfItemCode" runat="server" Value="" />
            </td>
        </tr>

    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound" >
        <Columns>
            <asp:BoundField DataField="CategoryOneName" HeaderText="<%$Resources:lang,CategoryOne %>" ItemStyle-Width="120px"/>
            <asp:BoundField DataField="CategoryTwoName" HeaderText="<%$Resources:lang,CategoryTwo %>" ItemStyle-Width="120px"/>
            <asp:BoundField DataField="CategoryThreeName" HeaderText="<%$Resources:lang,CategoryThree %>" ItemStyle-Width="120px"/>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$Resources:lang,ItemCode %>" ItemStyle-Width="120px"/>
            <%--<asp:BoundField DataField="VendorName" HeaderText="<%$Resources:lang,VendorName %>" />--%>
            <asp:BoundField DataField="InspectionTemplateName" HeaderText="<%$Resources:lang,InspectionTemplateName %>" ItemStyle-Width="150px"/>
             <asp:BoundField DataField="LotName" HeaderText="检验水平"  ItemStyle-Width="120px"/>
             <asp:BoundField DataField="AQLRuleNameTypeName" HeaderText="AQL规则"  ItemStyle-Width="140px"/>
             <%--<asp:BoundField DataField="AQLSampleName" HeaderText=" <%$Resources:lang,AqlName %>"  ItemStyle-Width="140px"/>--%>
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"  ItemStyle-Width="100px"/>
            <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,CreateTime %>"  ItemStyle-Width="150px"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.InspectionTemplateItem"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString" value=""/>
     <script language="javascript" type="text/javascript">
         var openWinUrl = "";
         var hdnOperate = $("#hdnOperate");
         var hdnIdString = $("#hdnIdString");

         function Add() {
             openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTemplateItemEdit.aspx?name=QC_InspectionTemplateItemAdd&ID=-1";
             dialog({ title: "<%=Resources.Pages.QC_InspectionTemplateAdd %>", src: openWinUrl, width: 750, height: 450 });
         }

         function Edit() {
             var idStr = getOneRecordId();
             if (idStr === "") return false;
             openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTemplateItemEdit.aspx?name=QC_InspectionTemplateItemEdit&ID=" + idStr;
             dialog({ title: "<%=Resources.Pages.QC_InspectionTemplateEdit %>", src: openWinUrl, width: 750, height: 650 });
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


         function SelectInspectionTemplate() {
             dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                 src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=75&CallBackFunc=getChooseValueInspectionTemplate&Multiple=false&rnd=" + Math.random(), width: 680, height: 400
             });
         }

         function getChooseValueInspectionTemplate(list) {
             $("#<%=this.hfInspectionTemplateId.ClientID%>").val(list[0][0]);
             $("#<%=this.txtInspectionTemplateName.ClientID%>").val(list[0][1]);
             $("#<%=this.hfInspectionTemplateName.ClientID%>").val(list[0][1]);
         }

         function SelectItem() {
             dialog({ title: "<%=Resources.Common.ChooseWindow %>",
                 src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getChooseValueItemCode&Multiple=false&rnd=" + Math.random(), width: 680, height: 400
             });
         }

         function getChooseValueItemCode(list) {
             $("#<%=this.hfItemId.ClientID%>").val(list[0][0]);
             $("#<%=this.txtItemCode.ClientID%>").val(list[0][1]);
             $("#<%=this.hfItemCode.ClientID%>").val(list[0][1]);
         }


         $(function () {
             $("#<%=this.ddlInspectionType.ClientID%>").change(function () {

                 $("#<%=this.hfInspectionType.ClientID%>").val($(this).val())
             });
         })
 </script>
</asp:Content>
