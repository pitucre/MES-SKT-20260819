<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ListMaster.master" AutoEventWireup="true" 
CodeBehind="MaterialRequestList.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialRequestList" %>
<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SearchContent" runat="server">
 <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
                <%=Resources.lang.MaterialRequestOrderNumber%>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtOrderNumber" runat="server"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.Requestor%>
            </td>
            <td class="Field2" colspan="3">
                 <asp:TextBox ID="txtRequestUser" runat="server" CssClass="TextBox"  IsRequired='1'></asp:TextBox><input type="button" id="btnSelectCustomer" class="ButtonBox" value="..."  title="选择用户" onclick="selectUserValue();"/>
                   <asp:HiddenField ID="hfRequestUserId" runat="server" Value="0" />
            </td>
        </tr>
      
    </table>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
 <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" 
        StartRowIndexParameterName="startRow" MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" 
        TypeName="SKT.LeanMES.Material.BLL.MaterialRequest" SelectMethod="GetAll" 
        SelectCountMethod="GetCount"  >
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1" 
        ondatabound="GridView1_DataBound1" onrowdatabound="GridView1_RowDataBound"  >
     <Columns>
        <%-- To Do --%>
        <asp:BoundField DataField="FormNO" HeaderText="<%$Resources:lang,MaterialRequestOrderNumber %>"  />
        <asp:BoundField DataField="OutForm" HeaderText="出库单号"  />
        <asp:BoundField DataField="RequestUserId" HeaderText="<%$Resources:lang,Requestor %>" />
        <asp:BoundField DataField="DepartId" HeaderText="<%$Resources:lang,AppDepart %>"/>
        <asp:BoundField DataField="State" HeaderText="<%$Resources:lang,Status %>"/>
        <asp:BoundField DataField="PrepareState" HeaderText="备料状态"/>
        <asp:BoundField DataField="Prioritys" HeaderText="<%$Resources:lang,priority %>"/>
        <asp:BoundField DataField="CreateDateTime" HeaderText="<%$Resources:lang,CreateDateTime %>"  />
     
    </Columns>

</asp:GridView>
   
 
      <input type="hidden" id="hdnOperate" name="hdnOperate" value=""/>
    <input type="hidden" id="hdnIdString" name="hdnIdString"  value=""/>
  <script>
      var hdnOperate = $("#hdnOperate");
      var hdnIdString = $("#hdnIdString");
      function Add() {
          openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/\Material/MaterialRequestEdit.aspx?name=Material_MaterialRequestEdit&ID=-1";
          dialog({ title: "<%=Resources.Pages.MaterialRequest_Add %>", src: openWinUrl, width: 800, height: 400 })
      }

      function Edit() {
          var idStr = getOneRecordId();
          if (idStr == "") return false;

          //获取已领料状态
                ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.Editable(idStr);
                if (ajax.error != null) {
                    return false;
                }
                //ajax.value为1表示没领料或不存此领料单据
                if (parseInt(ajax.value) == 1) {
                    openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/\Material/MaterialRequestEdit.aspx?name=Material_MaterialRequestAdd&ID=" + idStr;
                    dialog({ title: "<%=Resources.Pages.MaterialRequest_Edit %>", src: openWinUrl, width: 800, height: 400 })
                }
                else {
                    alert('<%=Resources.Messages.PickedCannotOperation%>');
                    return false;
                }
      }

      function addDetail(entity) {
          if (entity == null) {
              entity = {};
              entity.ItemId = "";
              entity.Modify_Ver = "";
              entity.ItemName = "";
          }

          var row, cell;
          rowNewIdx = tab.rows.length;
          row = tab.insertRow(rowNewIdx);
          row.className = "ListTableOddRow";

          cell = row.insertCell(0);
          cell.align = "center";
          cell.innerHTML = "<input type=\"text\" name=\"txtItems\" class=\"TextBox\" value=\"" + entity.ItemName + "\" disabled=\"disabled\">"
          + "<input type=\"button\" id=\"btnSelectItems\" onclick=\"selectItems(this);\" class=\"ButtonBox\" value=\"...\" />"
          +"<input type=\"hidden\" name=\"hdnItemId\" value=\"" + entity.ItemId + "\" />";

          cell = row.insertCell(1);
          cell.align = "center";
          cell.innerHTML = "<input type=\"text\" name=\"txtVersion\" class=\"TextBox\" disabled=\"disabled\" value=\"" + entity.Modify_Ver + "\"  />"

          cell = row.insertCell(2);
          cell.align = "center";
          cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
      }

      //刷新 
      function Refresh() {
          document.forms[0].submit();
      }

      function Delete() {
          var idStr = getDeletingRecordIdString();
          if (idStr == "") return false;

          var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.Editable(idStr);
          if (ajax.error != null) {
              return false;
          }
          if (parseInt(ajax.value) == 1) {
              idStr = getDeletingRecordIdString();
              hdnOperate.val("delete");
              hdnIdString.val(idStr);
              document.forms[0].submit();
          }
          else {
              alert('<%=Resources.Messages.PickedCannotOperation%>');
              return false;
          }
          
      }

      function selectUserValue() {
          dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&CallBackFunc=getChooseValueUser&Multiple=false&rnd=" + Math.random(), width: 500, height: 350 });
      }
      function getChooseValueUser(list) {
          $("#<%=this.txtRequestUser.ClientID %>").val(list[0][3]);
          $("#<%=this.hfRequestUserId.ClientID %>").val(list[0][0]);
      }

      function View() {
          var idStr = getOneRecordId();
          if (idStr == "") return false;
          openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/\Material/MaterialRequestView.aspx?ID=" + idStr;
          dialog({ title: "<%=Resources.Pages.MaterialRequest_View %>", src: openWinUrl, width: 800, height: 400 })
      }
      //备料中
      function Stock() {
          var idStr = getOneRecordId();
          if (idStr == "") return false;
          var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.EditPrepareState(idStr, 0);
          if (ajax.error != null) {
              alert(ajax.error.Message);
              return false;
          }
          alert("数据保存成功!");
          Refresh(); 
      }
      //已备料
      function HasStock() {
          var idStr = getOneRecordId();
          if (idStr == "") return false;
          var ajax = SKT.LeanMES.Web.AjaxServices.AjaxKanban.EditPrepareState(idStr, 1);
          if (ajax.error != null) {
              alert(ajax.error.Message);
              return false;
          }
          alert("数据保存成功!");
          Refresh(); 
      }
      function Refresh() {
          document.forms[0].submit();
      }
      //标签打印
      function PrintLabel() {
          //获取领料单id
          var idStr = getOneRecordId();
          if (idStr == "") {
              return false;
          }
          //获取加工流程单id
          var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetInfoByRequestInfo(parseInt(idStr));
          var processId = ajax.value.WOId;
          if (processId == -1) {
              alert("该领料单没有关联加工流程单!");
              return false;
          }
          openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ProcessForm/ProcessFormLabelPrint.aspx?ID=" + processId;
          dialog({ title: "标签打印", src: openWinUrl, width: 650, height: 300 });
      }
      //单据打印
      function PrintForm() {
          var idStr = getOneRecordId();
          if (idStr == "") {
              return false;
          }
          //获取加工流程单id
          var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetInfoByRequestInfo(parseInt(idStr));
          var processId = ajax.value.WOId;
          if (processId == -1) {
              alert("该领料单没有关联加工流程单!");
              return false;
          }
          var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProcessForm.GetInfoByProcessId(processId);
          if (ajax.error != null) {
              alert(ajax.error.Message);
              return;
          }

          var entity = ajax.value;
          //显示数据
          var formNo = entity.FormNO;
          var wins = $(window.parent);
          var w = wins.width();
          var h = wins.height();

          openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ProcessForm/ProcessProductFormPrint.aspx?name=ProcessProductFormPrint&ID=" + processId + "&formNo=" + formNo;
          // dialog({ title: "打印单据", src: openWinUrl, width: w, height: h });
          window.open(openWinUrl, "深圳市", 'height=980, width=1080');
      }
  </script>

</asp:Content>
