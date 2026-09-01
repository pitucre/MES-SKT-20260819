<%@ Page Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" CodeBehind="IQCMRBList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.IQCMRBList" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label3">
                IQC判定结果单号
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtMRBNo" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                状态
            </td>
            <td class="Field3">
                <select id="selMRBStatus" runat="server">
                    <option value="" selected="selected">请选择</option>
                    <option value="0">生成IQC判定结果</option>
                    <option value="1">处理完成</option>
                    <option value="3">审核完成</option>
                    <option value="2">结案</option>
                </select>
            </td>
            <td class="Label3">
                处理时间
            </td>
            <td class="Field3">
                <input type="text" id="txtPorcessDateFrom" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                <input type="text" id="txtPorcessDateTo" class="DateTimeBox" runat="server" readonly="readonly" />
            </td>
         </tr>
         <tr>
            <td class="Label3">
                IQC单号
            </td>
            <td class="Field3">
                <asp:TextBox runat="server" ID="txtIQCNo" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label3">
                审核时间
            </td>
            <td class="Field3">
                <input type="text" id="txtVerifyDateFrom" class="DateTimeBox" runat="server" readonly="readonly" />
                -
                <input type="text" id="txtVerifyDateTo" class="DateTimeBox" runat="server" readonly="readonly" />
            </td>
             <td class="Label3">
            </td>
            <td class="Field3">
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" style="table-layout:fixed;word-wrap:break-word;word-break:break-all">
        <Columns>
            <asp:BoundField DataField="MRBNo" HeaderText="IQC判定结果单号" SortExpression="MRBNo" HeaderStyle-Width="120px"/>
            <asp:BoundField DataField="InspectionNo" HeaderText="检验单号" SortExpression="InspectionNo" HeaderStyle-Width="120px"/>
            
            <asp:TemplateField HeaderText="合格数" SortExpression="QualifiedQty"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("QualifiedQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="不合格数" SortExpression="FledQty"  HeaderStyle-Width="100px">
                <ItemTemplate>
                    <%#Eval("FledQty","{0:G0}").ToString() %>
                </ItemTemplate>
            </asp:TemplateField>
       
            <asp:BoundField DataField="Auditing" HeaderText="异常原因" HeaderStyle-Width="180px" />
            <asp:BoundField DataField="MRBStatusName" HeaderText="状态" SortExpression="MRBStatus"  HeaderStyle-Width="80px" ItemStyle-CssClass="bill-status" />
            <asp:BoundField DataField="AttendPerson" HeaderText="处理人" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="ManageResultName" HeaderText="处理方式" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="AttendDateTime" HeaderText="处理时间" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="CloseCaseBy" HeaderText="结案人" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="CloseCaseTime" HeaderText="结案时间" HeaderStyle-Width="140px"/>
            <asp:BoundField DataField="DealRemark" HeaderText="备注" HeaderStyle-Width="180px"/>
            <asp:BoundField DataField="MRBVerifyBy" HeaderText="审核人" HeaderStyle-Width="80px"/>
            <asp:BoundField DataField="MRBVerifyTime" HeaderText="审核时间" HeaderStyle-Width="140px"/>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Material.BLL.MaterialIQC"
        SelectMethod="GetMRBList" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="hdnOperate" runat="server" ClientIDMode="Static" />
    <input type="hidden" id="hdnIdString"  name="hdnIdString" value="" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script language="javascript" type="text/javascript">
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") 
                return false;
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Quality/IQCMRBDetail.aspx?name=IQCMRBListView&InspectionId=" + idStr;
            dialog({ title: mesLang("IQC判定结果明细"), src: openWinUrl, width: 750, height: 650 });
        }

        function Process() {
            var idStr = getOneRecordId();
            if (idStr == "") 
                return false;
            var selectTr = $(".ListTable input[type='checkbox'][value='"+ idStr +"']").parent();       
            var billStatus = $.trim(selectTr.siblings(".bill-status").text());
            if (billStatus != "生成IQC判定结果" && billStatus != "处理完成"){
                alert("只允许处理“生成IQC判定结果”或“处理完成”状态单据");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/IQCFormAttend.aspx?name=Material_IQCFormAttend&InspectionId=" + idStr;
            dialog({ title: "<%=Resources.Pages.IQCFormAttend %>", src: openWinUrl, width: 750, height: 650 });
        }

        function Refresh() {
            hdnOperate.val("");
            document.forms[0].submit();
        }

        //导出到EXCEL
        function ImportToExcel() {
            hdnOperate.val("exportexcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }

        //MRB审核
        function Verify(){
            var idStr = getOneRecordId();
            if (idStr == ""){
                return false;
            }
            var selectTr = $(".ListTable input[type='checkbox'][value='"+ idStr +"']").parent();       
            var billStatus = $.trim(selectTr.siblings(".bill-status").text());
            if(billStatus != "结案"){
                alert("只允许审核“结案”状态单据");
                return false;
            }
            var entity = {};
            entity.InspectionId = idStr;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.MRBVerify(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("审核成功");
            doSearch();
        }

        //撤回处理
        function Withdraw() {
            var idStr = getOneRecordId();
            if (idStr == "") {
                return false;
            }
            var selectTr = $(".ListTable input[type='checkbox'][value='" + idStr + "']").parent();
            var billStatus = $.trim(selectTr.siblings(".bill-status").text());
            if (billStatus != "结案") {
                alert("只允许撤回“已结案，未审核”状态单据");
                return false;
            }
            var entity = {};
            entity.InspectionId = idStr;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialIQC.MRBWithdraw(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return;
            }
            alert("撤回成功");
            doSearch();
        }


    </script>
</asp:Content>