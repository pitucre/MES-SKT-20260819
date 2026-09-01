<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="ResourceManageList.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.ResourceManageList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%=Resources.lang.ItemCode %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="选择产品"
                    onclick="selectItem();" />

            </td>
      <%--      <td class="Label2">
                <%=Resources.lang.Layout %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox"></asp:TextBox><input type="button" id="btnStation" class="ButtonBox" value="..." title="选择工作工序"
                    onclick="selectStation();" />
            </td>--%>
              <td class="Label2">
                <%=Resources.lang.ResName %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnSelectDefaultOpt" class="ButtonBox" value="..." title="选择资源"
                    onclick="selectRes();" />
            </td>

        </tr>
      <%--  <tr>
          
            <td class="Label2">
                <%=Resources.lang.ResName %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnRes" class="ButtonBox" value="..." title="选择资源"
                    onclick="selectRes();" />
            </td>

             <td class="Label2">
              
            </td>
            <td class="Field2">
             
            </td>


        </tr>--%>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_OnRowDataBound" ItemStyle-HorizontalAlign="Center">
        <Columns>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode %>" SortExpression="ItemCode"
                HeaderStyle-Width="180px" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang,ItemName %>" SortExpression="ItemName"
                HeaderStyle-Width="180px" />
            <%-- <asp:TemplateField HeaderText="资源类别" SortExpression="CategoryType" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <%#Eval("CategoryType").ToString() == "1" ? "设备" : "线别"%>
                </ItemTemplate>
            </asp:TemplateField>--%>
         
         <%--   <asp:BoundField DataField="LineName" HeaderText="<%$ Resources:lang,LineName %>" SortExpression="LineName"
                HeaderStyle-Width="180px" />--%>
            <asp:BoundField DataField="ResName" HeaderText="<%$ Resources:lang,ResName %>" SortExpression="ResName"
                HeaderStyle-Width="180px" />
            <asp:BoundField DataField="Face" HeaderText="<%$ Resources:lang,Layout %>" SortExpression="Face"
                HeaderStyle-Width="120px" />
            <asp:TemplateField HeaderText="前置时间(单位)" SortExpression="FrontTime" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <%#Eval("FrontTime").ToString()+"("+Eval("FrontUnit").ToString()+")"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="后置时间(单位)" SortExpression="PostTime" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <%#Eval("PostTime").ToString()+"("+Eval("PostUnit").ToString()+")"%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="产能(单位)" HeaderStyle-Width="120px" SortExpression="Capacity" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <%#Eval("Capacity").ToString()+"("+Eval("CapacityUnit").ToString()+")"%>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="EfficiencyFactor" HeaderText="工作效率因子" SortExpression="EfficiencyFactor"
                HeaderStyle-Width="120px" />
            <asp:BoundField DataField="Priority" HeaderText="<%$ Resources:lang,Priority %>" SortExpression="Priority"
                HeaderStyle-Width="120px" />
            <asp:BoundField DataField="CreateBy" HeaderText="<%$ Resources:lang,CreateBy %>"/>
            <asp:BoundField DataField="CreateTime" HeaderText="<%$ Resources:lang,CreateDateTime %>"
                 DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" HtmlEncode="false" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang,ModifyBy %>"/>
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang,ModifyDateTime %>"
                DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"  HtmlEncode="false" HeaderStyle-Width="180px" />

            <asp:BoundField DataField="Remark" HeaderText="<%$ Resources:lang,Remark %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Resource.BLL.ResourceManage"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
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
        var isCopy = '<%=Request.QueryString["Action"] %>';

        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceManageEdit.aspx?name=Resource_ResourceManageAdd&ID=-1";
            dialog({ title: "<%=Resources.Pages.Resource_ResourceManageAdd %>", src: openWinUrl, width: 750, height: 450 });
        }

        function Edit() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceManageEdit.aspx?name=Resource_ResourceManageEdit&ID=" + idStr;
            dialog({ title: "<%=Resources.Pages.Resource_ResourceManageEdit %>", src: openWinUrl, width: 750, height: 450 });
        }

        function Copy() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceManageEdit.aspx?name=Resource_ResourceManageEdit&ID=" + idStr + "&Action=Copy";
            dialog({ title: "<%=Resources.Pages.Resource_ResourceManageEdit %>", src: openWinUrl, width: 750, height: 450 });
        }

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Resource/ResourceManageView.aspx?name=Resource_ResourceManageView&ID=" + idStr ;
            dialog({ title: "<%=Resources.Pages.Resource_ResourceManageView %>", src: openWinUrl, width: 750, height: 450 });
        }



        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            hdnOperate.val("delete");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }

        function UpdateList(namestr) {
            $("#txtItemCode").val(namestr);
            document.forms[0].submit();
        }

        var flag = -1;

        /*选择线别*/
        function selectLine() {
            flag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*选择产品*/
        function selectItem() {
            flag = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*选择工序*/
        function selectStation() {
            flag = 4;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*选择资源*/
        function selectRes() {
            flag = 6;

            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=6&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        /*设置从选择窗口选取的值*/
        function getChooseValue(list) {
            if (flag == 1) {

               <%-- $("#<%=this.txtLineName.ClientID%>").val(list[0][1]);--%>
            } else if (flag == 3) {

                $("#<%=this.txtItemCode.ClientID%>").val(list[0][2]);

            } else if (flag == 4) {

              <%--  $("#<%=this.txtStation.ClientID%>").val(list[0][1]);--%>
            } else if (flag == 6) {

           $("#<%=this.txtResName.ClientID%>").val(list[0][1]);


            }
    flag = -1;
}
    </script>
</asp:Content>
