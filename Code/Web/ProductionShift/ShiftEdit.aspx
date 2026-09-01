<%@ Page Language="C#" MasterPageFile="~/Masters/EditHeadMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.ProductionShift.ShiftEdit" CodeBehind="ShiftEdit.aspx.cs" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="infoTips" align="left" colspan="4">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.ShiftName%><em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtShiftName" runat="server" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                <%=Resources.lang.ShiftRemark%>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtShiftRemark" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="Server">
    <div class="ListTableTitle">
        <div><%=Resources.lang.ShiftMemberList%></div>
        <div id="spShift1"></div>
    </div>
    <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server">
        <Columns>
           
            <asp:BoundField DataField="Sequence" HeaderText="<%$Resources:lang,Sequence %>" HeaderStyle-Width="80px" />
             <asp:BoundField DataField="ProductionShift" HeaderText="<%$Resources:lang,ProductionShift %>" />
            <asp:BoundField DataField="StartTime" HeaderText="<%$Resources:lang,StartTime %>" />
            <asp:TemplateField HeaderText="开始时间是否跨天">
                <ItemTemplate>
                    <%#Eval("StartTimeIsterday").ToString().ToLower() == "true" ? "是" : "否"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="EndTime" HeaderText="<%$Resources:lang,EndTime %>" />
            <asp:TemplateField HeaderText="结束时间是否跨天">
                <ItemTemplate>
                    <%#Eval("IsInterday").ToString().ToLower() == "true" ? "是" : "否"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Description" HeaderText="<%$Resources:lang,Description %>" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.ProductionShift.BLL.Shift_Member"
        SelectMethod="GetAll" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>
   <div id="divZx">
     <div class="ListTableTitle">
       【<span id="spanBcxx"></span>】 <span>作息列表&nbsp;&nbsp;时间格式：(如八点半：0830)</span></div>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader" style="text-align: center">
            <th scope="col" style="width: 3%;">序号</th>
            <th scope="col" style="width: 15%;">开始时间(如:0830) </th>
            <th scope="col" style="width: 5%;">是否跨天 </th>
            <th scope="col" style="width: 15%;" id="trJcyj">结束时间(如:0830)</th>
            <th scope="col" style="width: 5%;">是否跨天 </th>
            <th scope="col" style="width: 8%;" id="trLrfs">描述</th>
            <th scope="col" style="width: 15%;">
                <span style="color: #0066CC; cursor: pointer;" onclick="addDetail();"><%=Resources.Buttons.COM_Add %></span> &nbsp;&nbsp;<span style="color: #0066CC; cursor: pointer;" onclick="SaveEntity();"><%=Resources.Buttons.COM_Save %></span>
            </th>
        </tr>
        <tbody id="tblExpandBody"></tbody>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="8" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>
        </div>

    <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
    <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
    <input type="hidden" id="hdnTIDString" name="hdnTIDString" value="" />
    
    <input type="hidden" id="hdnBcStartTime" value=""/>
    <input type="hidden" id="hdnBcEndTime" value=""/>

    <input type="hidden" id="hdnMemberId"/>
    
    <input type="hidden" id="hdnStartIsInterday"/>
    <input type="hidden" id="hdnEndIsInterday"/>
    <asp:Label ID="lblTID" runat="server" Visible="false"></asp:Label>
    <script type="text/javascript">

        loadfloatButtons("spShift1");
        var tab = document.getElementById("tblExpandBody");
        var selectRowClass = "selectRow";
        var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>
        isMultiple = false;
        var hdnOperate = $("#hdnOperate");
        var hdnIdString = $("#hdnIdString");
        var hdnTIDString = $("#hdnTIDString");
        var gridview = $("#<%=this.GridView1.ClientID %>");
        $(function(){
         if (Id==-1)
         {
             Id='<%=Request.Form["hdnTIDString"] %>';
             if (Id==0)
             {
                Id=-1;
             }
          }
            hdnTIDString.val(Id);

            var $input = $("input[type='checkbox']");
            for (let i = 1; i < $input.length; i++) {
                $($input[i]).click(function(e) {
                    e = window.event || e;
                    if(document.all) {
                        e.cancelBubble = true;
                    } else {
                        if ($(this).prop("checked")) {
                            $("input[type='checkbox'][name='chkSelect']").attr("checked", false);
                            $(this).prop('checked', true);
                            checkShift($(this).parent().parent());
                        };
                        e.stopPropagation();
                    }
                });
            }
           
         });
        //保存数据类型
        function Save() {

            var errStr = "";
            var txtShiftName = $.trim($("#<%=this.txtShiftName.ClientID %>").val());

            if (txtShiftName.length <= 0) {
                errStr += "<%= Resources.Messages.txtShiftNameEmpty %>";
            }
            var txtShiftRemark = $("#<%=this.txtShiftRemark.ClientID %>").val();
            if (errStr != "") {
                alert(errStr);
                return false;
            }
            var entity = {};
            entity.ShiftId = Id;
            entity.ShiftName = txtShiftName;
            entity.Remark = txtShiftRemark;

            var ajax_inserShift = SKT.LeanMES.Web.AjaxServices.AjaxServicesShift.EditShift(entity);
            if (ajax_inserShift.error != null) {
                alert(ajax_inserShift.error.Message);
                return false;
            }
            else {
                alert("<%= Resources.Messages.SaveInSuccess %>");
            }
             window.parent.UpdateList(txtShiftName);
        }

        function clk(obj) {
          
            var $cb = $(obj).find("input[type='checkbox'][name='chkSelect']");
            var ck = !$cb.prop('checked');
            $("input[type='checkbox'][name='chkSelect']").attr("checked", false);
            $cb.prop('checked', ck);

           //$("#divZx").show();
            checkShift(obj);

        }


        function checkShift(obj) {
            $("#spanBcxx").html("序号：" + $(obj).find("td:eq(1)").html() + "&nbsp;&nbsp;" + $(obj).find("td:eq(2)").html());
            $("#hdnMemberId").val($(obj).find("td:eq(0) input[type='checkbox']").val());
            $("#hdnBcStartTime").val($(obj).find("td:eq(3)").html());
            $("#hdnBcEndTime").val($(obj).find("td:eq(5)").html());
            $("#hdnStartIsInterday").val($(obj).find("td:eq(4)").html());
            $("#hdnEndIsInterday").val($(obj).find("td:eq(6)").html());


            var result = SKT.LeanMES.Web.AjaxServices.AjaxServicesShift.GetChildMemberList($("#hdnMemberId").val());
            if (result.error != null) {
                alert(result.error.Message);
                return false;
            }

            if (null != result) {
                var index = 1;
                $("#tblExpandBody ").html("");
                for (var i = 0; i < result.value.length; i++) {
                    addDetailTwo(result.value[i], index);
                    index++;
                }
            }
        }


        function addDetail() {
            if ($("#hdnMemberId").val() == "") {
                alert("请选择班次");
                return;
            }
           
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = GetIndex();
          
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = rowNewIdx+1;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording"  MaxLength="50"  style="width:150px;height:25px;" onblur="ValTimeZx(this,1)" onkeyup="this.value=this.value.replace(/\D/g,\'\')" onafterpaste="this.value=this.value.replace(/\D/g,\'\')"/>';
           
        
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '  <input type="checkbox" />';

            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording"   MaxLength="50"  style="width:150px;height:25px;" onblur="ValTimeZx(this,2)" onkeyup="this.value=this.value.replace(/\D/g,\'\')" onafterpaste="this.value=this.value.replace(/\D/g,\'\')"/>';
           
            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '  <input type="checkbox" />';


            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording"  MaxLength="50"  style="width:170px;height:25px;" />';

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";

          
        }

        function Trim(str) {
            return str.replace(/(^\s*)|(\s*$)/g, "");
        }
        function SaveEntity() {
            var docXml = "<Root>";
            var list = [];
            var startTime = "";
            var startIsInterday = 0;
            var endTime = "";
            var endIsInterday = 0;
            var description = "";

            var bcstartTime;
            var bcendTime;
            var start = 0;
            var end = 0;
            var parentStartTime = $("#hdnBcStartTime").val();
            bcstartTime = parentStartTime.split(":");
            var parentEndTime = $("#hdnBcEndTime").val();
            bcendTime = parentEndTime.split(":");
            start = parseInt(bcstartTime[0] + "" + bcstartTime[1]);
            end = parseInt(bcendTime[0] + "" + bcendTime[1]);
            var parentStartIsInterday = $("#hdnStartIsInterday").val();
            var parentEndIsInterday = $("#hdnEndIsInterday").val();

            if (Trim(parentStartIsInterday) == "是") {
                start = start + 2400;
            }
           
          
            if (Trim(parentEndIsInterday) == "是") {
                end = end + 2400;
            }

            var childStart = 0;
            var childEnd = 0;
            var isOk = true;
            var counts=$("#tblExpand tr:gt(0)").length;
               for (var i = 0; i < counts; i++) {
                        var data = $("#tblExpand tr:gt(0)")[i];
                       startTime = $(data).find("td:eq(1) input").val();
                 startIsInterday = $(data).find("td:eq(2) input[type='checkbox']").is(':checked');
                         endTime = $(data).find("td:eq(3) input").val();
                   endIsInterday = $(data).find("td:eq(4) input[type='checkbox']").is(':checked');
                     description = $(data).find("td:eq(5) input").val();  
                    
                     if (startTime != "" && endTime != "") {
                         childStart = parseInt(startTime.split(':')[0] + "" + startTime.split(':')[1]);
                         childEnd = parseInt(endTime.split(':')[0] + "" + endTime.split(':')[1]);
                         if (startIsInterday) {
                             childStart = childStart + 2400;
                         }
                         if (endIsInterday) {
                             childEnd = childEnd + 2400;
                         }
                         if (childEnd < childStart) {
                             alert("作息时间，结束时间不能小于开始时间！");
                             $(data).find("td:eq(1) input").focus();
                             isOk = false;
                             break;
                         }
                        
                         if (childStart < start || childEnd>end) {
                             alert("作息开始时间与结束不在班次工作时间之间！");
                             $(data).find("td:eq(1) input").focus();
                             isOk = false;
                             break;
                         }
                        docXml += "<Member StartTime='"+startTime+"' StartIsInterday='"+startIsInterday+"' EndTime='"+endTime+"' EndIsInterday='"+endIsInterday+"' Description='"+description+"'></Member>";
                  }
             
              }
           docXml += "</Root>";
           //if (counts == 0) {
           //       alert("请添加数据");
           //       return;
           //}
           if (isOk) {
               
          
              
                var merberId = parseInt($("#hdnMemberId").val());
          
              var ajax_inserShift =SKT.LeanMES.Web.AjaxServices.AjaxServicesShift.EditShiftChild(merberId,docXml);
                if (ajax_inserShift.error != null) {
                    alert(ajax_inserShift.error.Message);
                    return false;
                }
                else {
                    alert("<%= Resources.Messages.SaveInSuccess %>");
                }
           }
        }

        function GetIndex() {
            
            var list = $(tab).find("tr");

            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).attr("class").indexOf(selectRowClass) > -1) {

                    return i;
                }
            }
            return tab.rows.length;
        }


        function addDetailTwo(entity, i) {
           
            var row, cell;
            rowNewIdx = GetIndex();
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            $("#trNewInfo").remove();

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = i;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML ='<input type="text" class="InspectionAccording"  MaxLength="50"  value="'+entity.StartTime+'" style="width:150px;height:25px;" onblur="ValTimeZx(this,1)" onkeyup="this.value=this.value.replace(/\D/g,\'\')" onafterpaste="this.value=this.value.replace(/\D/g,\'\')"/>';


            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            if (entity.StartTimeIsterday) {
             cell.innerHTML =' <input type="checkbox" checked="checked"/>' ;
            } else {
              cell.innerHTML =' <input type="checkbox" />' ; 
            }
         
        
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording"  MaxLength="50"  value="'+entity.EndTime+'" style="width:150px;height:25px;" onblur="ValTimeZx(this,2)" onkeyup="this.value=this.value.replace(/\D/g,\'\')" onafterpaste="this.value=this.value.replace(/\D/g,\'\')"/>';

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
             if (entity.IsInterday) {
             cell.innerHTML =' <input type="checkbox" checked="checked"/>' ;
            } else {
              cell.innerHTML =' <input type="checkbox" />' ; 
            }

            cell = row.insertCell(5);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording"  MaxLength="50"  value="'+entity.Description+'" style="width:170px;height:25px;"/>'

            cell = row.insertCell(6);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }


          function deleteItem(obj) {
            if (typeof (obj) == "number") {
                tab.deleteRow(rowIndex);
            }
            else {
                tab.deleteRow(obj.parentElement.parentElement.rowIndex-1);
            }
        }

        function ValTime(obj) {
            var timeValue = $(obj).val();
            if (timeValue.length <= 0) {
                return;
            }           
            $(obj).val(intToTime($(obj).val()));
            timeValue = $(obj).val();
            var reg = /^(\d{1,2}):(\d{1,2})$/;
            var r = timeValue.match(reg);
            if (r == null) {
                alert("输入格式不正确，请按HH:mm的格式输入！");
                $(obj).val("");
                $(obj).focus();
                return;
            }
            var strs = new Array();
            strs = timeValue.split(":");
            if (parseInt(strs[0]) > 23 || parseInt(strs[1]) > 59) {
                alert("时间值不正确，小时不得大小23，分钟不得大于59！");
                $(obj).val("");
                $(obj).focus();
                return;
            }
           
        }

         function ValTimeZx(obj,type) {
            var timeValue = $(obj).val();
            if (timeValue.length <= 0) {
                return;
            }
                      
            $(obj).val(intToTime($(obj).val()));
            timeValue = $(obj).val();
            var reg = /^(\d{1,2}):(\d{1,2})$/;
            var r = timeValue.match(reg);
            if (r == null) {
                alert("输入格式不正确，请按HH:mm的格式输入！");
                $(obj).val("");
                $(obj).focus();
                return;
            }
            var strs = new Array();
            strs = timeValue.split(":");
            if (parseInt(strs[0]) > 23 || parseInt(strs[1]) > 59) {
                alert("时间值不正确，小时不得大小23，分钟不得大于59！");
                $(obj).val("");
                $(obj).focus();
                return;
            }
             //var bcstartTime;
             //var bcendTime;
             //var startTime = $("#hdnBcStartTime").val();
             //  bcstartTime = startTime.split(":");
             //var endTime = $("#hdnBcEndTime").val();
             //  bcendTime = endTime.split(":");
             
           //  if (type == 1) {
                
           //     if (parseInt(bcstartTime[0] +""+ bcstartTime[1]) > parseInt(strs[0] +""+  strs[1])) {
           //        alert("时间值不正确，开始时间不能大于班次开始时间！");
           //        $(obj).val("");
           //        $(obj).focus();
           //        return;
           //    }
             
           //  if (parseInt(strs[0] +""+ strs[1]) > parseInt(bcendTime[0] +""+  bcendTime[1])) {
           //        alert("时间值不正确，开始时间不能大于班次结束时间！");
           //        $(obj).val("");
           //        $(obj).focus();
           //        return;
           //    }

           //} else {
              
           //    if (parseInt(bcendTime[0] +""+ bcendTime[1]) < parseInt(strs[0] +""+ strs[1])) {
           //        alert("时间值不正确，结束时间不能大于班次结束时间！");
           //        $(obj).val("");
           //        $(obj).focus();
           //        return;
           //    }

           //  if (parseInt(strs[0] +""+ strs[1]) < parseInt(bcstartTime[0] +""+  bcstartTime[1])) {
           //        alert("时间值不正确，结束时间不能小于班次开始时间！");
           //        $(obj).val("");
           //        $(obj).focus();
           //        return;
           //    }
           //}
           
        }

        //新增数据字段
        function Add() {
            if (hdnTIDString.val() == -1) {
                alert("<%= Resources.Messages.MasterDataSaveFirst %>");
                return;
            }
            else {
                dialog({ title: "<%= Resources.Pages.ShiftMemberAdd %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ProductionShift/ShiftMemberEdit.aspx?name=ShiftMemberAdd&ID=-1&PID=" + hdnTIDString.val(), width: 600, height: 280, resizeable: true });
            }
        }

        //编辑
        function Edit() {
            if ($("#hdnMemberId").val() == "") {
                alert("请选择班次");
                return;
            }
           
            dialog({ title: "<%= Resources.Pages.ShiftMemberEdit %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/ProductionShift/ShiftMemberEdit.aspx?name=ShiftMemberEdit&ID=" + $("#hdnMemberId").val() + "&PID=" + hdnTIDString.val(), width: 600, height: 280, resizeable: true });
        }

        //删除
        function Delete() {
            if ($("#hdnMemberId").val() == "") {
                alert("请选择班次");
                return;
            }
            if (window.confirm("确定要删除吗")) {
                hdnOperate.val("delete");
                hdnIdString.val($("#hdnMemberId").val());
                document.forms[0].submit();
               
            }
            
        }

        function UpdateList(tID) {
            hdnTIDString.val(tID);
            document.forms[0].submit();
        }
     
    </script>
</asp:Content>
