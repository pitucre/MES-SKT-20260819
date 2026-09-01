<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/ListMaster.master"
    CodeBehind="ResourceCapacityList.aspx.cs" Inherits="SKT.LeanMES.Web.Resource.ResourceCapacityList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <%--查询模块--%>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3" >
                <%=Resources.lang.ItemCode %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                  <input type="button" id="btnSelectItem" class="ButtonBox" value="..." title="选择产品"
                                onclick="selectItem();" />
            </td>
            <td class="Label3" >
                <%=Resources.lang.ItemName %>
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtItemName" runat="server" CssClass="TextBox"></asp:TextBox>
                  <input type="button" id="btnSelectItem1" class="ButtonBox" value="..." title="选择产品"
                                onclick="selectItem1();" />
            </td>     
           
                 <td class="Label3" >
                线别
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtLineName" runat="server" CssClass="TextBox"></asp:TextBox>
                <input
                                type="button" id="btnSelectDefaultOpt" class="ButtonBox" value="..." title="选择线别"
                                onclick="selectLine();" />
            </td>             
        </tr>
        <tr>
           
 
         <%--   <td class="Label3" >
               <%=Resources.lang.Station %>
            </td>
            <td class="Field3" >
               <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox"></asp:TextBox>
                <input type="button" id="btnStation" class="ButtonBox" value="..." title="选择工作工序"
                                    onclick="selectStation();" />
           
            </td> --%>
           <%--  <td class="Label3" >
                <%=Resources.lang.ResName %>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtResName" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                <input type="button" id="btnRes" class="ButtonBox" value="..." title="选择资源"
                                    onclick="selectRes();" />
            </td>--%>
         <td class="Label3" >
                 <%=Resources.lang.ShiftName %>
            </td>
             <td class="Field3">
                 <asp:TextBox ID="txtShiftName" runat="server" CssClass="TextBox"></asp:TextBox>
                 <input type="button" id="btnShiftName" class="ButtonBox" value="..." title="选择班制"
                                    onclick="selectShitfName();" />
             </td> 
               <td class="Label3" >
              
            </td>
            <td class="Field3" >
             
           
            </td> 
             <td class="Label3" >
              
            </td>
            <td class="Field3" >
             
           
            </td> 
        </tr>
        
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_OnRowDataBound">
        <Columns>
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode %>" SortExpression="ItemCode"
                HeaderStyle-Width="120px" /> 
             <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang,ItemName %>" SortExpression="ItemName"
                HeaderStyle-Width="120px" />
            <asp:BoundField DataField="LineName" HeaderText="线别" SortExpression="LineName"
                HeaderStyle-Width="100px" />
          <%--  <asp:BoundField DataField="ResName" HeaderText="<%$ Resources:lang,ResName %>" SortExpression="ResName"
                HeaderStyle-Width="90px" />--%>
            <asp:BoundField DataField="Face" HeaderText="<%$ Resources:lang,Layout %>" SortExpression="Face"
                HeaderStyle-Width="100px" />
            <asp:TemplateField HeaderText="产能/单位" HeaderStyle-Width="100px"  SortExpression="Capacity" >
                <ItemTemplate>
                    <%#Eval("Capacity").ToString()+"/"+Eval("CapacityTimeUnit").ToString()%>
                </ItemTemplate>
            </asp:TemplateField>
         <%--  <asp:BoundField DataField="Capacity" HeaderText="产能" SortExpression="Capacity"
                HeaderStyle-Width="60px" />--%>
             <asp:BoundField DataField="ShiftName" HeaderText="<%$ Resources:lang,ShiftName %>" SortExpression="ShiftName"
                HeaderStyle-Width="60px" />
           <%--  <asp:BoundField DataField="ProductionShift" HeaderText="<%$ Resources:lang,ProductionShift %>" SortExpression="ProductionShift"
                HeaderStyle-Width="60px" />--%>
             <asp:BoundField DataField="WorkTimes" HeaderText="工作时长(H)" SortExpression="WorkTimes"
                HeaderStyle-Width="60px" />
               <asp:BoundField DataField="RestTimes" HeaderText="作息时长(H)" SortExpression="RestTimes"
                HeaderStyle-Width="60px" />
            
               <asp:TemplateField HeaderText="实际工作时长"  HeaderStyle-Width="60px" >
                <ItemTemplate>
                    <%#Convert.ToDecimal(Eval("WorkTimes"))-Convert.ToDecimal(Eval("RestTimes"))%>
                </ItemTemplate>
            </asp:TemplateField>
               <asp:BoundField DataField="CapacityCount" HeaderText="预计产出" SortExpression="CapacityCount"
                HeaderStyle-Width="60px" />
          
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Resource.BLL.ResourceCapacityManage"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <script type="text/javascript">
        isMultiple = false;
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

           /*选择产品*/
        function selectItem1() {
            flag = 2;
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
             /*选择资源*/
        function selectShitfName() {
            flag = 5;

            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=49&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*设置从选择窗口选取的值*/
        function getChooseValue(list) {
            if (flag == 1) {

                $("#<%=this.txtLineName.ClientID%>").val(list[0][1]);
            } else if (flag == 2) {

                $("#<%=this.txtItemName.ClientID%>").val(list[0][1]);
            } else if (flag == 3) {

                $("#<%=this.txtItemCode.ClientID%>").val(list[0][2]);

            } else if (flag == 4) {


            } else if (flag == 6) {

              <%--  $("#<%=this.txtResName.ClientID%>").val(list[0][1]);--%>


            }else if (flag == 5) {

                $("#<%=this.txtShiftName.ClientID%>").val(list[0][1]);


            }
            flag = -1;
        }
    </script>
</asp:Content>
