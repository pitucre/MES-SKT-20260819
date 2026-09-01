<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MouldChangeApplyList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldChangeApplyList" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
         <tr>
            <td class="Label3">申请编号</td>
            <td class="Field3">
                <asp:TextBox ID="txtApplyNo" runat="server" ></asp:TextBox>
            </td>
            <td class="Label3">状态</td>
            <td class="Field3">
                <asp:DropDownList runat="server" ID="ddlStatus">
                    <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="0">新申请</asp:ListItem>
                    <asp:ListItem Value="1">待换模</asp:ListItem>
                    <asp:ListItem Value="2">换模中</asp:ListItem>
                    <asp:ListItem Value="3">已完成</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label3"><%=Resources.lang.ItemCode%></td>
            <td class="Field3">
                <asp:TextBox ID="txtItemCode" runat="server" ></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td class="Label3"><%=Resources.lang.EquipmentCode%></td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentCode" runat="server" ></asp:TextBox>
            </td>
            <td class="Label3"><%=Resources.lang.EquipmentName%></td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentName" runat="server" ></asp:TextBox>
            </td>
           <td class="Label3"><%=Resources.lang.ItemName%></td>
            <td class="Field3">
                <asp:TextBox ID="txtItemName" runat="server" ></asp:TextBox>
            </td>
        </tr>
      <tr>
           <td class="Label3">申请人</td>
             <td class="Field3" >
                <asp:TextBox ID="txtCreateBy" runat="server"></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectUser(1)" />
                <asp:HiddenField ID="hdCreateBy" runat="server" />
            </td>
           <td class="Label3">确认人</td>
             <td class="Field3" >
                <asp:TextBox ID="txtAffirmUser" runat="server"></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectUser(2)" />
                <asp:HiddenField ID="hdAffirmUser" runat="server" />
            </td>
           <td class="Label3">换模人</td>
             <td class="Field3" >
                <asp:TextBox ID="txtOperator" runat="server"></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectUser(3)" />
                <asp:HiddenField ID="hdOperator" runat="server" />
            </td>
      </tr>
      
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent"  >
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
             <asp:BoundField DataField="ApplyNo" HeaderText="申请编号" ItemStyle-Width="90px" />
            <asp:BoundField DataField="EquipmentCode" HeaderText="<%$ Resources:lang,EquipmentCode %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="EquipmentName" HeaderText="<%$ Resources:lang,EquipmentName %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang,ItemCode %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang,ItemName %>" ItemStyle-Width="90px" />
            <asp:BoundField DataField="Status" HeaderText="<%$ Resources:lang,Status %>" ItemStyle-Width="60px" />
                <asp:BoundField DataField="Operator" HeaderText="换模人" ItemStyle-Width="60px" />
            <%--<asp:BoundField DataField="StoreName" HeaderText="<%$ Resources:lang,WarehouseStorageName %>" ItemStyle-Width="90px" />
          
            <asp:BoundField DataField="StandarLive" HeaderText="<%$ Resources:lang,StandarLive %>" ItemStyle-Width="90px" />
          --%>
           <%-- <asp:BoundField DataField="StatusDesc" HeaderText="<%$ Resources:lang,EquipmentStatus %>" ItemStyle-Width="90px" />--%>
            <%--<asp:BoundField DataField="UseCount" HeaderText="累计使用寿命" ItemStyle-Width="90px" />--%>
          <%--  <asp:BoundField DataField="ProduceDate" HeaderText="<%$ Resources:lang,ProduceDate %>" ItemStyle-Width="130px" />--%>

           <asp:TemplateField HeaderText="实际开始换模时间" SortExpression="ActualStartTime" ItemStyle-Width="130px" >
                <ItemTemplate>
                    <%#Eval("ActualStartTime").ToString() == "1971/1/1 0:00:00" ? "" : Eval("ActualStartTime").ToString()%>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="实际完成换模时间" SortExpression="ActualFinish" ItemStyle-Width="130px" >
                <ItemTemplate>
                    <%#Eval("ActualFinish").ToString() == "1971/1/1 0:00:00" ? "" : Eval("ActualFinish").ToString()%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CreateBy" HeaderText="申请人" ItemStyle-Width="100px" />
            <asp:BoundField DataField="AffirmUserName" HeaderText="确认人" ItemStyle-Width="100px" />
            <asp:BoundField DataField="CreateTime" HeaderText="申请日期" ItemStyle-Width="130px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="修改人" ItemStyle-Width="100px" />
            <asp:BoundField DataField="ModifyTime" HeaderText="修改时间" ItemStyle-Width="130px" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.MoludApply"
        SelectMethod="GetAll" SelectCountMethod="GetCount"> 
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
  <%--  <object classid="clsid:62DEBC7F-D316-49E1-86EA-79B5D75E8A87" id="printerDemo" width="0"
        height="0" codebase="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Component/RouterDesigner/RouterDesigner.cab#version=1,0,0,0">
    </object>--%>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var chooseFlag = -1;

        //增加 
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldChangeApplyEdit.aspx?name=MouldChangeApplyAdd&Id=-1";
            dialog({ title: mesLang("新申请"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        //换模任务分配 
        function Replace() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            //xiang.yan 2024-4-26  列取值由索引改为列明
            // 1 改为 ApplyNo
            var applyNo = getOneRecordCellTextByFiled("ApplyNo");
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/ReplaceMoldPersonEdit.aspx?name=MouldChangeApplyReplace&&Id=" + idStr + "&ApplyNo=" + applyNo;
            dialog({ title: mesLang("换模任务分配"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }
        
        //编辑
        function Save() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldChangeApplyEdit.aspx?name=MouldChangeApplyEdit&Id=" + idStr;
            dialog({ title: mesLang("编辑"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        function ChangeMould() {
              var idStr = getOneRecordId();
            if (idStr == "") return;
            //xiang.yan 2024-4-26  列取值由索引改为列明
            // 6 改为 Status
            if (getOneRecordCellTextByFiled("Status") == "新申请" ) {
                  alert("请先分配换模人员");
                  return;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldChangeEdit.aspx?name=MouldChangeApplyChangMould&Id=" + idStr;
            dialog({ title: mesLang("更换模具"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }
        
        function MouldConfirm() {
            var idStr = getOneRecordId();
            if (idStr == "") return;

            //xiang.yan 2024-4-26  列取值由索引改为列明
            // 6 改为 Status
            var status = getOneRecordCellTextByFiled("Status");
            if (status != "换模中" && status != "已完成") {
                alert("请先更换模具");
                return;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldChangeConfirm.aspx?name=MouldChangeApplyConfirm&Id=" + idStr;
            dialog({ title: mesLang("换模确认"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        //刷新 
        function refresh() {
            document.forms[0].submit();
        }


<%--        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/EquipmentView.aspx?name=Equipment_EquipmentView&Id=" + idStr;
            dialog({ title: "<%=Resources.Pages.Equipment_EquipmentView%>", src: openWinUrl, width: 1000, height: 600, resizeable: false });
        }--%>

    

        //删除
        function Delete() {
            var idStr = getDeletingRecordIdString();
            if (idStr == "") return false;
            $(hdnOperate).val("Delete");
            $(hdnIdString).val(idStr);
            document.forms[0].submit();
        }

        function In() {
            var idStr = getRecordIdString();
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldInStock.aspx?name=Equipment_MouldIn&type=1&Id=" + idStr;
            dialog({ title: mesLang("模具入库"), src: openWinUrl, width: 455, height: 355, resizeable: false });
        }

        function Out() {

           var idStr = getRecordIdString();
           openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldInStock.aspx?name=Equipment_MouldOut&type=0&Id=" + idStr;
            dialog({ title: mesLang("模具出库"), src: openWinUrl, width: 455, height: 355, resizeable: false });
           <%-- var idStr = getRecordIdString();
            var equipmentCode = $('input[name="chkSelect"]:checked').parent().parent().find("td:eq(1)").html();
          
            if (idStr != "") {
                if (!window.confirm("确认出库？")) {
                    return "";
                }
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.UpdateStock(idStr, 0);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
           alert('<%=Resources.Messages.SaveSuccess%>');
            window.UpdateList(equipmentCode);--%>
        }

         /*选择用户*/
         function selectUser(type) {

             chooseFlag = type;
             //查询条件
             var searchCondition = "";
             if (chooseFlag == 3) {
                 searchCondition = " DepartName = '模具部'";
             }
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&PageCondition=" + searchCondition + "&rnd=" + Math.random(), width: 500, height: 300 });
         }

          function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.hdCreateBy.ClientID %>").val(list[0][2]);
                  $("#<%=this.txtCreateBy.ClientID %>").val(list[0][3]);
                
            } else
                if (chooseFlag == 2) {
                $("#<%=this.hdAffirmUser.ClientID %>").val(list[0][2]);
                  $("#<%=this.txtAffirmUser.ClientID %>").val(list[0][3]);
             
            } else if (chooseFlag == 3) {
                $("#<%=this.hdOperator.ClientID %>").val(list[0][2]);
                  $("#<%=this.txtOperator.ClientID %>").val(list[0][3]);
              
            }
        }

        //更新列表
        function UpdateList(applyNo) {
            $("#<%=this.txtApplyNo.ClientID %>").val(applyNo);
            document.forms[0].submit();
        }
        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
            
    </script>
</asp:Content>

