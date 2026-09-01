<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MouldSizeList.aspx.cs" Inherits="SKT.LeanMES.Web.Equipment.MouldSizeList" MasterPageFile="~/Masters/ListMaster.master" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="Server">
    <table class="EditeContentTable" width="100%">
         <tr>
            <td class="Label3"><%=Resources.lang.MouldCode%></td>
            <td class="Field3">
                <asp:TextBox ID="txtMouldeCode" runat="server" ></asp:TextBox><input type="button" value="..." class="ButtonBox" onclick="selectMould()" />
            </td>
            <td class="Label3"><%=Resources.lang.MouldName%></td>
            <td class="Field3">
                <asp:TextBox ID="txtBomName" runat="server" ></asp:TextBox>
            </td>
             <td class="Label3">测试项目</td>
            <td class="Field3">
                <asp:DropDownList ID="ddlTestItem" runat="server">
                    <asp:ListItem Text="--请选择--" Value="-1"></asp:ListItem>
                    <asp:ListItem Text="测试项目1" Value="1"></asp:ListItem>
                    <asp:ListItem Text="测试项目2" Value="2"></asp:ListItem>
                    <asp:ListItem Text="测试项目3" Value="3"></asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox ID="txtTestItemAvgMin" CssClass="numbercheck" runat="server" Width="50px" ></asp:TextBox> ~ <asp:TextBox ID="txtTestItemAvgMax" CssClass="numbercheck"  runat="server"  Width="50px" ></asp:TextBox>
            </td>
        </tr>
       <tr>
            <td class="Label3">构件名称</td>
            <td class="Field3">
                <asp:TextBox ID="txtComponentName" runat="server" ></asp:TextBox>
            </td>
            <td class="Label3">累计使用寿命</td>
            <td class="Field3">
                <asp:TextBox ID="txtUseCountMin" CssClass="numbercheck" runat="server" Width="67px" ></asp:TextBox> ~ <asp:TextBox ID="txtUseCountMax" CssClass="numbercheck"  runat="server"  Width="67px" ></asp:TextBox>
            </td>
             <td class="Label3"></td>
            <td class="Field3">                
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="searchConditions" runat="server" ContentPlaceHolderID="GridviewContent"   >
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server"  >
        <Columns>           
            <asp:BoundField DataField="MouldeCode" HeaderText="<%$ Resources:lang,MouldCode %>" HeaderStyle-Width="130px" />
            <asp:BoundField DataField="BomName" HeaderText="<%$ Resources:lang,MouldName%>" HeaderStyle-Width="100px" />
             <asp:BoundField DataField="ComponentName" HeaderText="构件名称" HeaderStyle-Width="100px" /> 
               <asp:TemplateField HeaderText="判断" HeaderStyle-Width="60px">
                <ItemTemplate>
                    <%# Judge(Eval("Result").ToString())%>
                </ItemTemplate>
            </asp:TemplateField> 
             <asp:BoundField DataField="Remark" HeaderText="备注"/>   
             <asp:BoundField DataField="UseCount" HeaderText="累计使用寿命" ItemStyle-Width="80px" />
            <asp:BoundField DataField="TestCount" HeaderText="测试次数" HeaderStyle-Width="60px" /> 
            <asp:BoundField DataField="ExternalDiameterAvg" HeaderText="测试项目1" HeaderStyle-Width="80px" />
             <asp:BoundField DataField="InternalDiameterAvg" HeaderText="测试项目2" HeaderStyle-Width="80px" />   
            <asp:BoundField DataField="TestItem3Avg" HeaderText="测试项目3" HeaderStyle-Width="80px" />                
             <asp:BoundField DataField="CreateBy" HeaderText="创建人" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="CreateTime" HeaderText="创建日期" HeaderStyle-Width="140px" />
            <asp:BoundField DataField="ModifyBy" HeaderText="<%$ Resources:lang, ModifyBy %>" />
            <asp:BoundField DataField="ModifyTime" HeaderText="<%$ Resources:lang, ModifyDateTime %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.MoludSizeManger"
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

         $(".numbercheck").keyup(function () {
             getDecimalVal(this);
         });

         var chooseFlag = -1;
         /*粉体类型*/
         function selectResourceType() {
              chooseFlag = 1;
             dialog({ title: "<%=Resources.Common.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=5&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
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
      

          function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtMouldeCode.ClientID %>").val(list[0][1]);
                
            } else if (chooseFlag == 2) {
                $("#<%=this.txtBomName.ClientID %>").val(list[0][1]);
             
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
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldSizeEdit.aspx?name=MouldSizeAdd&Id=-1";
            dialog({ title: mesLang("新增"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        //编辑
        function Save() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldSizeEdit.aspx?name=MouldSizeEdit&Id=" + idStr;
            dialog({ title: mesLang("编辑"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }

        //编辑
        function Copy()
        {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldSizeEdit.aspx?name=MouldSizeCopy&action=Copy&Id=" + idStr;
            dialog({ title: mesLang("复制"), src: openWinUrl, width: 950, height: 600, resizeable: false });
        }
     

        //刷新 
        function refresh() {
            document.forms[0].submit();
        }


       //查看
        function View() {
            var idStr = getOneRecordId();
            if (idStr == "") return;
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldSizeView.aspx?Id=" + idStr;
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
        function Remove() {
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
        function UpdateList(mouldeCode) {
            $("#<%=this.txtMouldeCode.ClientID%>").val(mouldeCode);
            document.forms[0].submit();
        }
        function Import() {
            hdnOperate.val("ExportExcel");
            document.forms[0].submit();
            hdnOperate.val("");
        }
          
    </script>
</asp:Content>

