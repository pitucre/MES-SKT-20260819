<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="StationMatList.aspx.cs" Inherits="SKT.LeanMES.Web.Product.StationMatList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                工序名称
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtStationName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectStation" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectStation(8);" />   
            </td>
            <td class="Label3">
               物料编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label3">
                
            </td>
            <td class="Field3">
             
            </td>
        </tr>
        <tr>
            <td class="Label3">
              物料大类
            </td>
            <td class="Field3">   
                 <asp:TextBox ID="txtCategoryOne" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="btnSelectCategory" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectCategory(1);" />  
            </td>
            <td class="Label3">
                物料中类
            </td>
            <td class="Field3">
            <asp:TextBox ID="txtCategoryTwo" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="Button1" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectCategory(2);" />                  
            </td>
            <td class="Label3">
                物料小类
            </td>
            <td class="Field3">
             <asp:TextBox ID="txtCategoryThree" runat="server" CssClass="TextBox"  ClientIDMode="Static"></asp:TextBox><input
                    type="button" id="Button2" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseItem %>"
                    onclick="selectCategory(3);" />                     
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" >
        <Columns>
            <%-- To Do --%>
            <asp:BoundField DataField="Station" HeaderText="工序名称" SortExpression="Station" />
            <asp:BoundField DataField="ItemCode" HeaderText="物料编码"  SortExpression="ItemCode" />
            <asp:BoundField DataField="ItemName" HeaderText="物料描述"
                SortExpression="ItemName" />
            <asp:BoundField DataField="CategoryOne" HeaderText="物料大类"
                SortExpression="CategoryOne" />
            <asp:BoundField DataField="CategoryTwo" HeaderText="物料中类"
                SortExpression="CategoryTwo" />
            <asp:BoundField DataField="CategoryThree" HeaderText="物料小类"
                SortExpression="CategoryThree" />            
            <asp:BoundField DataField="CreateBy" HeaderText="创建人"  SortExpression="CreateBy" />
            <asp:BoundField DataField="CreateDateTime" HeaderText="创建时间" SortExpression="CreateDateTime"  DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy %>" 
                SortExpression="ModifyBy" />
              <asp:BoundField DataField="ModifyDateTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>" 
                SortExpression="ModifyDateTime" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>   
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Product.BLL.StationMateriel"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
 
    <input  type="hidden" value="-1" id ="hdnCategoryOne" />
    <input  type="hidden" value="-1" id ="hdnCategoryTwo" />
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">

        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        var chooseFlag = 0;
        function selectCategory(flag) {
            chooseFlag = flag;
            var pageCondition = "";
            var parentId = -1;

            if (flag == 1) {
                pageCondition = "ParentId = -1";
            }
            else if (flag == 2) {
                parentId = $("#hdnCategoryOne").val();

                pageCondition = "ParentId !=-1 AND ParentId IN (SELECT ItemCategoryId FROM vwGetCategoryTree where ParentId = -1)";
                if ( parentId != "-1") {
                    pageCondition += " And ParentId=" + parentId;
                }
            }
            else if (flag == 3) {
                parentId = $("#hdnCategoryTwo").val();
                pageCondition = "ParentId !=-1 AND ParentId Not IN (SELECT ItemCategoryId FROM vwGetCategoryTree where ParentId = -1)";
                if (parentId != "-1") {
                    pageCondition += " And ParentId=" + parentId;
                }
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=110&PageCondition=" + escape(pageCondition)+"&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function selectStation(flag) {
            chooseFlag = flag;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flag.toString() + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#hdnCategoryOne").val(list[0][0]);
                $("#txtCategoryOne").val(list[0][2]);
            }
            else if (chooseFlag == 2) {
                $("#hdnCategoryTwo").val(list[0][0]);
                $("#txtCategoryTwo").val(list[0][2]);
            }
            else if (chooseFlag == 3) {
                $("#hdnCategoryThree").val(list[0][0]);
                $("#txtCategoryThree").val(list[0][2]);
            }
            else if (chooseFlag == 8) {
                $("#<%=this.txtStationName.ClientID %>").val(list[0][1]);    
            }
        }

       
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemBomEdit.aspx?name=Product_BomAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Product_BomAdd %>", src: openWinUrl, width: 690, height: 400 });
        }

        function Edit() {

            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/StationMatEdit.aspx?name=Product_StationMatEdit";
            dialog({ title: "<%=Resources.Pages.Product_StationMatEdit %>", src: openWinUrl, width: 1000, height: 500 });
        }
        
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(namestr) {
            $("#txtItemBomName").val(namestr);
            document.forms[0].submit();
        }
        
 
    </script>
</asp:Content>
