<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MouldAbnormalList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldAbnormalList" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
         <tr>
            <td class="Label3"><%=Resources.lang.EquipmentCode%></td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentCode" runat="server" ></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectDequiment()" />
            </td>
            <td class="Label3"><%=Resources.lang.EquipmentName%></td>
            <td class="Field3">
                <asp:TextBox ID="txtEquipmentName" runat="server" ></asp:TextBox>
            </td>
              <td class="Label3">状态</td>
              <td class="Field3">
             <asp:DropDownList runat="server" ID="drpStatus">
                     <asp:ListItem Value="-1">请选择</asp:ListItem>
                    <asp:ListItem Value="0">待分配</asp:ListItem>
                    <asp:ListItem Value="1">待处理</asp:ListItem>
                    <asp:ListItem Value="2">待审核</asp:ListItem>
                    <asp:ListItem Value="3">已审核</asp:ListItem>
                </asp:DropDownList>
            </td> 
        </tr>
        <tr>
            <td class="Label3"><%=Resources.lang.MouldName%></td>
            <td class="Field3">
                <asp:TextBox ID="txtMouldName" runat="server" ></asp:TextBox>
            </td>
              <td class="Label3">异常类型</td>
            <td class="Field3" >
                <asp:TextBox ID="txtAnormalType" runat="server" ></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectAnormalType()" />
            </td>
               <td class="Label3">申请人</td>
            <td class="Field3" >
                <asp:TextBox ID="txtApplyName" runat="server" ></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectUser(4)" />
                <asp:HiddenField ID="hdApplyName" runat="server" />
            </td>
        </tr>
        <tr>
             <td class="Label3">处理人</td>
             <td class="Field3" >
                <asp:TextBox ID="txtHandlePerson" runat="server"></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectUser(5)" />
                <asp:HiddenField ID="hdHandlePerson" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent"  >
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" OnRowDataBound="GridView1_RowDataBound" >
        <Columns>
            <asp:BoundField DataField="EquipmentCode" HeaderText="<%$ Resources:lang,EquipmentCode %>" ItemStyle-Width="13%" />
            <asp:BoundField DataField="EquipmentName" HeaderText="<%$ Resources:lang,EquipmentName %>" ItemStyle-Width="9%" />
             <asp:BoundField DataField="BomName" HeaderText="<%$ Resources:lang,MouldName %>" ItemStyle-Width="9%" />
            <asp:BoundField DataField="ResTypeName" HeaderText="粉体类型"  Visible="false" ItemStyle-Width="9%"/>
             <asp:BoundField DataField="AnormalTypeName" HeaderText="异常类型" ItemStyle-Width="9%" />
             <asp:BoundField DataField="Status" HeaderText="状态" ItemStyle-Width="6%" />
              <asp:BoundField DataField="StartTime" HeaderText="异常开始时间" ItemStyle-Width="13%" />
              <asp:TemplateField  HeaderText="异常结束时间" ItemStyle-Width="13%">
                <ItemTemplate>                   
                    <%#Eval("EndTime", "{0:yyyy-MM-dd HH:mm:ss}").ToString().Replace("1900-01-01 00:00:00", "")%>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:BoundField DataField="CName" HeaderText="申请人" ItemStyle-Width="7%" />
              <asp:BoundField DataField="HandlePerson" HeaderText="处理人" ItemStyle-Width="7%" />
             <asp:BoundField DataField="MangerPerson" HeaderText="负责人" ItemStyle-Width="7%" />
            <asp:BoundField DataField="CreateTime" HeaderText="申请日期" ItemStyle-Width="14%" />
            <asp:BoundField DataField="ModifyCname" HeaderText="修改人" ItemStyle-Width="7%" />
            <asp:BoundField DataField="AuditTime" HeaderText="修改时间" ItemStyle-Width="14%" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.MoludAbnormal"
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
         var chooseFlag = -1;
         /*粉体类型*/
         function selectResourceType() {
              chooseFlag = 1;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=5&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
         }

         /*异常类型*/
         function selectAnormalType() {
             chooseFlag = 2;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=702&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
         }

          /*选择设备*/
         function selectDequiment() {
             var searchCondition = "  ParentTypeId =1";
             chooseFlag = 3;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&SearchCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
            
         }
            /*选择模具*/
         function selectMould() {
             var searchCondition = "  ParentTypeId =-4";
             chooseFlag = 4;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&SearchCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
            
         }
          /*选择用户*/
         function selectUser(type) {

             chooseFlag = type;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
         }

          function getChooseValue(list) {
          <%--  if (chooseFlag == 1) {
                $("#<%=this.txtResNamtType.ClientID %>").val(list[0][1]);
                
            } else--%>
                if (chooseFlag == 2) {
                $("#<%=this.txtAnormalType.ClientID %>").val(list[0][1]);
             
            } else if (chooseFlag == 3) {
                $("#<%=this.txtEquipmentCode.ClientID %>").val(list[0][1]);
              
            }else if (chooseFlag == 4) {
                $("#<%=this.hdApplyName.ClientID %>").val(list[0][2]);
                $("#<%=this.txtApplyName.ClientID %>").val(list[0][3]);
            }
              else if (chooseFlag == 5) {
                  $("#<%=this.hdHandlePerson.ClientID %>").val(list[0][2]);
                  $("#<%=this.txtHandlePerson.ClientID %>").val(list[0][3]);
              
            }
        }
     </script>
    <script type="text/javascript">
        isMultiple = false;
        var openWinUrl = "";
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");

        //增加 
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldAbnormalEdit.aspx?name=MouldAbnormalAdd&Id=-1";
            dialog({ title: mesLang("新增"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        //编辑
        function Save() {

           
            var idStr = getOneRecordId();
            if (idStr == "") return;
            //xiang.yan 2024-4-26  列取值由索引改为列明
            // 5》6 改为 Status
            var status = getOneRecordCellTextByFiled("Status");
            if (status == "待分配") {
                alert("该异常记录信息暂未分配处理人");
                return;
            }
         
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldAbnormalHandleEdit.aspx?name=MouldAbnormalEdit&Id=" + idStr;
            dialog({ title: mesLang("编辑"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

         //任务分配 
        function Replace() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            //xiang.yan 2024-4-26  列取值由索引改为列明
            // 5》6 改为 Status
            var status = getOneRecordCellTextByFiled("Status");
            if (status == "待审核") {
                alert("该异常记录信息为【待审核】状态不能分配");
                return;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/ReplaceAbnormalPersonEdit.aspx?name=MouldAbnormalReplace&&Id=" + idStr;
            dialog({ title: mesLang("任务分配"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        function Audit() {
            var idStr = getOneRecordId();

            //xiang.yan 2024-4-26  列取值由索引改为列明
            // 6 改为 Status
            if (getOneRecordCellTextByFiled("Status") == "已审核") {
                alert("该异常记录信息已审核");
                return;
            }
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldAbnormalAudit.aspx?name=MouldAbnormalAudit&Id=" + idStr;
            dialog({ title: mesLang("审核模具异常信息"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }
        function ChangeMould()
        {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldChangeEdit.aspx?name=MouldChangeApplyChangMould&Id=" + idStr;
            dialog({ title: mesLang("更换模具"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        function MouldConfirm()
        {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldChangeConfirm.aspx?name=MouldChangeApplyConfirm&Id=" + idStr;
            dialog({ title: mesLang("换模确认"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        //刷新 
        function refresh() {
            document.forms[0].submit();
        }


        //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldAbnormalView.aspx?Id=" + idStr;
            dialog({ title: mesLang("查看"), src: openWinUrl, width: 1000, height: 600, resizeable: false });
        }

        function Scrap(){
            
            var idStr = getOneRecordId();
            if (idStr == "") return false;
            if (!confirm("是否确认报废？")) return false;
            hdnOperate.val("scrap");
            hdnIdString.val(idStr);
            document.forms[0].submit();
        }
         
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

        //更新列表
        function UpdateList(applyNo) {
         
            document.forms[0].submit();
        }
        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
          
    </script>
</asp:Content>

