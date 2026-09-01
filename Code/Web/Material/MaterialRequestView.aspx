<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MaterialRequestView.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialRequestView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
     <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2"> <%= Resources.lang.MaterialRequestOrderNumber %> </td>
            <td class="Field2">
                <asp:Label ID="lbFormNO" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label2"> <%= Resources.lang.ProcessFormNO %> </td>
             <td class="Field2"> 
                 <asp:Label ID="lbWONumber" runat="server" Text=""></asp:Label>
                 
            </td>
        </tr>
        <tr>
        
            <td class="Label2"> <%= Resources.lang.DepartmentName%>  </td>
            <td class="Field2"> 
                <asp:Label ID="lbDepartment" runat="server" Text=""></asp:Label>
            </td>
            <td class="Label2"> <%= Resources.lang.Requestor%>  </td>
            <td class="Field2"> 
                <asp:Label ID="lbRequestUser" runat="server" Text=""></asp:Label>
             </td> 
        </tr>
        <tr>
        
             <td class="Label2"> <%= Resources.lang.UserDate%> </td>
             <td class="Field2"> 
                 <asp:Label ID="lbUserDate" runat="server" Text="Label"></asp:Label>
             </td> 
            <td class="Label2"> <%= Resources.lang.Priority%>  </td>
            <td class="Field2"> 
                <asp:Label ID="lbPrioritys" runat="server" Text="Label"></asp:Label>
                 </td> 
        </tr>
    </table>
    <table id="tblExpand"  cellspacing="0" cellpadding="4" style="border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width:30%;">
                <%= Resources.lang.MaterialName%> 
            </th>
              <th scope="col" style="width:30%;">
                 物料描述
            </th>
            <th scope="col"  style="width:20%;">
                <%= Resources.lang.VersionNumber%> 
            </th>
            <th scope="col"  style="width:10%;">
               <%= Resources.lang.PickingQty%>    
            </th>
            <th scope="col"  style="width:10%;">
               <%= Resources.lang.PartUnit%>    
            </th>
            <th scope="col"  style="width:30%;">
                <%= Resources.lang.Remark%>     
            </th>
        </tr>
         <tr id="trNewInfo" class="ListTableOddRow"><td colspan="6" style="text-align:center;">暂无数据</td></tr>
    </table>
     <script type="text/javascript">
         var materialRequestId = '<%=Request.QueryString["ID"]%>';

         $(function () {
             /*加载领料记录*/
             initItem(materialRequestId);
         });

        
         function MaterialRequestMemberEdit(id) {
             var hdMaterialRequestMemberId = $(".hdMaterialRequestMemberId");
             var hdItemId = $(".hdItemId");
             var RequestQty = $(".RequestQty");
             var Remark = $(".Remark");


             var ent = {};
             ent.MaterialRequestId = id;
             ent.MaterialRequestMemberIdS = GetArrValue(hdMaterialRequestMemberId);
             ent.ItemIdS = GetArrValue(hdItemId);
             ent.RequestQtyS = GetArrValue(RequestQty);
             ent.RemarkS = GetArrValue(Remark); ;
             return ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.MaterialRequestMemberEdit(ent);


         }

         
         var tab = document.getElementById("tblExpand");
         function addDetail(entity) {
             if (entity == null) {
                 entity = {};
                 entity.ItemId = -1;
                 entity.IteRev = "";
                 entity.ItemName = "";
                 entity.MaterialRequestMemberId = -1;
                 entity.RequestQty = 0;
                 entity.Remark = "";
                 entity.Unit = "";
             }
             //add  by weixia  on  2015/5/7
             $("#trNewInfo").remove();
             var row, cell;
             rowNewIdx = tab.rows.length;
             row = tab.insertRow(rowNewIdx);
             row.className = "ListTableOddRow";

             cell = row.insertCell(0);
             cell.align = "center";
             cell.className = "Field";
             cell.innerHTML = entity.ItemName;

             cell = row.insertCell(1);
             cell.align = "center";
             cell.className = "Field";
             cell.innerHTML = entity.ItemDesc;

             cell = row.insertCell(2);
             cell.align = "center";
             cell.className = "Field";
             cell.innerHTML = entity.IteRev;

             cell = row.insertCell(3);
             cell.align = "center";
             cell.className = "Field";
             cell.innerHTML = entity.RequestQty;

             cell = row.insertCell(4);
             cell.align = "center";
             cell.className = "Field";
             cell.innerHTML = entity.Unit;

             cell = row.insertCell(5);
             cell.align = "center";
             cell.className = "Field";
             cell.innerHTML = entity.Remark;

            
         }

         function initItem(id) {
             var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.MaterialRequestMember_GetListByID(id);
             if (ajax.error == null) {
                 var entityAry = ajax.value;
                 for (var i = 0; i < entityAry.length; i++) {
                     addDetail(entityAry[i]);
                 }
             } else {
                 alert(ajax.error.Message);
             }
         }

         var flag = -1;
         var rowIndex = -1;
         var rowObj = null;
         function selectItems(obj) {
             flag = 5;
             rowObj = obj.parentElement.parentElement;
             rowIndex = rowObj.rowIndex;
             dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&CallBackFunc=getChooseValueMaterial&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
         }

         function getChooseValueMaterial(list) {
             var mid = list[0][0];
             var b = true;
             var o = $(".hdItemId");
             for (var i = 0; i < o.length; i++) {
                 if (mid == $(o[i]).val()) {
                     b = false;
                     alert("<%= Resources.Messages.MaterialExist %>");
                 }
             }
             if (b == true) {
                 if (flag == 5) {
                     rowObj.cells[0].children[1].value = list[0][0];
                     rowObj.cells[0].children[2].value = list[0][1];
                     rowObj.cells[1].children[0].value = list[0][3];
                     rowObj.cells[2].children[0].value = list[0][2];
                     rowObj.cells[4].children[0].value = list[0][5];
                 }
             }
             flag = -1;
         }
    </script>

</asp:Content>
