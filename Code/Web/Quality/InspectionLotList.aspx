<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="InspectionLotList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.InspectionLotList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
<table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                批次号
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtInspectionLotNo" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
               状态
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlState" runat="server">
                <asp:ListItem Text="--请选择--" Value=""></asp:ListItem> 
                <asp:ListItem Text="锁定" Value="1"></asp:ListItem>
                <asp:ListItem Text="检验中" Value="2"></asp:ListItem>
                <asp:ListItem Text="完成" Value="3"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">
                检查日期
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtCreateDateTimeStart" runat="server"  CssClass="DateTimeBox" ClientIDMode="Static"></asp:TextBox>
                ~
                <asp:TextBox ID="txtCreateDateTimeEnd" runat="server"  CssClass="DateTimeBox"  ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label3">
                产品编码
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
               结果
            </td>
            <td class="Field3">
                <asp:DropDownList ID="ddlResultId" runat="server">
                <asp:ListItem Text="--请选择--" Value=""></asp:ListItem> 
                <asp:ListItem Text="Pass" Value="0"></asp:ListItem>
                <asp:ListItem Text="Reject" Value="1"></asp:ListItem>
                <asp:ListItem Text="ByPass" Value="2"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3">
               工单
            </td>
            <td class="Field3">
               <asp:TextBox ID="txtOrderNo" runat="server" ClientIDMode="Static" CssClass="TextBox"></asp:TextBox><input
                    type="button" id="btnOrder" onclick="openChoosePage(44);" class="ButtonBox"
                    value="..." title="Select" /><asp:HiddenField ID="hdnProdOrderId" runat="server" Value="-1" ClientIDMode="Static" /> 
            </td>
        </tr>
       <tr>
            <td class="Label3">
               QC类型
            </td>
            <td class="Field3">
                <asp:DropDownList ID="txtQCType" runat="server">
                <asp:ListItem Text="--请选择--" Value=""></asp:ListItem> 
                <asp:ListItem Text="PQC" Value="3"></asp:ListItem>
                <asp:ListItem Text="OQC" Value="5"></asp:ListItem>
                </asp:DropDownList>
            </td>
       </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
<asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" >
        <Columns>
            <asp:BoundField DataField="InspectionLotNo" HeaderText="批次号"  />
            <asp:BoundField DataField="SystemTypeName" HeaderText="QC类型"  />
            <asp:BoundField DataField="OrderNo" HeaderText="工单"  />
            <asp:BoundField DataField="State"  HeaderText="状态"  >
<%--                <HeaderStyle CssClass="hidden" />
                <ItemStyle  CssClass="hidden" />
                <FooterStyle CssClass="hidden" />--%>
            </asp:BoundField>  
            <%--<asp:BoundField DataField="LotQty" HeaderText="批量"  ItemStyle-Width="80px"/>--%>
            <asp:TemplateField HeaderText="批量">
                 <ItemTemplate>   
                     <a href="javascript:void(0);"onclick="<%# "showDetail(this,'" +Eval("InspectionLotNo") + "')"  %>" />
                    <%# Eval("LotQty")%>     
                 </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ActualQty" HeaderText="已抽数量" />
            <asp:BoundField DataField="ItemCode" HeaderText="产品编码" />
            <asp:BoundField DataField="ItemName" HeaderText="产品名称" />
            <asp:BoundField DataField="Result" HeaderText="结果"  ItemStyle-Width="100px"/>
            <asp:BoundField DataField="CreateBy" HeaderText="检查人"  ItemStyle-Width="100px"/>
            <asp:BoundField DataField="CreateDateTime"  HeaderText="检查时间"  ItemStyle-Width="150px" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}"/>
            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Quality.BLL.InspectionLot"
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

     function View() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionLotMemberList.aspx?name=QC_InspectionLotMemberList&ID=" + idStr;
         dialog({ title: mesLang("检验项"), src: openWinUrl, width: 860, height: 500 });
     }
        function showDetail(objDom, InspectionLotNo) {
         if (InspectionLotNo === "") return false;
         openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionLotSNList.aspx?name=QC_InspectionLotSNList&QcLotNo=" + InspectionLotNo;
         dialog({ title: "批次明细列表", src: openWinUrl, width: 860, height: 500 });
        }
     /*得到选中记录的值*/
     function getSelectedRowsData() {
         var selValues = [];
         var checkboxs = document.getElementsByName("chkSelect");
         var checkboxCount = checkboxs.length;

         for (var i = 0; i < checkboxCount; i++) {
             if (checkboxs[i].checked) {
                 var parent =$(checkboxs[i]).parent();
                 parent.siblings().each(function () {
                     if($(this).attr("field")!="")
                     {
                         selValues[$(this).attr("field")] = $(this).text();
                     }

                 })
             }
         }
         return selValues;
     }
       //取消锁定
     function CancelLock() {

         var idStr = getOneRecordId();
         if (idStr === "") return false;
         var re = getSelectedRowsData();
         //var status = $.trim($("#<%=this.GridView1.ClientID%> input[name=\"chkSelect\"]:checked").parent().siblings(".status").text());
         var qc =re.SystemTypeName ;
         var state = re.State;
         if (qc == "PQC" || state != "锁定") {

             alert("只允许取消【OQC】类型【锁定】状态的单据！");
             return;
         }

         if (confirm("确认要取消锁定吗？")) {
             hdnOperate.val("cancelLock");
             hdnIdString.val(idStr);
             document.forms[0].submit();
         }
     }

     var flag = -1;
         function openChoosePage(flags) {
            flag = flags;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" + flags + "&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }
      function getChooseValue(list) {
           if (flag == 44) {
                if (list[0][0] != "-1") {
                    $("#<%= this.txtOrderNo.ClientID %>").val(list[0][1]);
                    $("#<%= this.hdnProdOrderId.ClientID %>").val(list[0][0]);
                }
            }
            flag = -1;
        }
     function Export() {
         var idStr = getOneRecordId();
         if (idStr === "") return false;
         hdnOperate.val("ExportExcel");
         hdnIdString.val(idStr);
         document.forms[0].submit();
         hdnOperate.val("");
         hdnIdString.val("");
     }

 </script>
</asp:Content>
