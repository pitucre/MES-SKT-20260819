<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.Equipment.MouldBomEdit" CodeBehind="MouldBomEdit.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="infoTips" align="left" colspan="6">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </td>
        </tr>
        <tr class="clear5">
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.MouldName%><em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtBomName" runat="server" IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label3">
               内径长(cm)<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtInternalDiameter" runat="server" IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label3">
              外径宽(cm)<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtExternalDiameter" runat="server" IsRequired='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
             <td class="Label2">
               面积(cm)<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtAcreage" runat="server" IsRequired='1'></asp:TextBox>
            </td>
            <td class="Label2">
              <span>最大压力(Ton)</span><em>*</em>
            </td>
            <td class="Field3" colspan="3">
                <asp:TextBox ID="txtMaxPressure" runat="server" IsRequired='1'></asp:TextBox>
            </td>
            
        </tr>
          <tr>
             <td class="Label2">
               描述
             </td>
            <td class="Field3" colspan="5">
                <asp:TextBox ID="txtDescribe" CssClass="TextArea" TextMode="MultiLine" runat="server"
                    ClientIDMode="Static" Width="99%" Height="75"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 5%;">
                行号
            </th>
            <th scope="col" style="width: 25%;">
                构件名称
            </th>
            <th scope="col" style="width: 25%;">
                可替换构件
            </th>
            <th scope="col" style="width: 40%;">
                构件描述
            </th>
            <th scope="col" onclick="addDetail(null);" id='btnAdd' style="color: #0066CC; cursor: pointer;
                width: 5%; font-weight: bold">
                +新增
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="5" style="text-align: center;">
                <span>暂无数据</span>
            </td>
        </tr>
    </table>
    <input type="hidden" id="hdnMouldBomId" runat="server" value="-1"/>
    <script type="text/javascript">

        var Id = <%= Request.QueryString["ID"] == null ? -1 : Convert.ToInt32(Request.QueryString["ID"].ToString())%>;
        var txtBomName = "";

         //入口
        $(function () {
            if (Id != '-1') {
                //显示模具BOm信息列表
                showMouldBomInfo(Id);
            }
        });

        //显示模具BOm信息列表
        function showMouldBomInfo(Id){
          
            var ajax = SKT.LeanMES.Web.Equipment.MouldBomEdit.GetMouldBomChildInfo(Id);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var list = ajax.value;
            if (list != null && list.length > 0) {
                for (var i = 0; i < list.length; i++) {
                    addDetail(list[i]);
                }
            }
        }

          //新增
        var tab = document.getElementById("tblExpand");
        var i = 0;
        function addDetail(entity) {
            if (entity == null) {
                entity = {};
                entity.MouldTypeId = -1;
                entity.ComponentCode = "";
                entity.Describe = "";
                entity.ReplaceComponentName = "";
            }
            i += 1;
            $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = tab.rows.length;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
            //行号
            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = i.toString();

            //构件名称
            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='hidden' name='hdnMouldTypeId' value='" + entity.MouldTypeId + "' /><input type='text' IsRequired='1' name='txtComponentName' class='TextBox' value='" + entity.ComponentCode + "' style='width:80%'  disabled='disabled'/>"
            + "<input type='button' id='btnSelect' onclick='selectComponent(this);' class='ButtonBox' value='...' />";

            //可替换构件
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='text' style='width:80%' CssClass='TextBox' readonly='readonly' name='txtReplaceComponentName' value='" + entity.ReplaceComponentName + "' disabled='disabled'/>"
            +"<input type='button' id='btnSelectReplace' onclick='selectReplace(this);' class='ButtonBox' value='...' />";

            //构件描述
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<input type='text' style='width:90%;' MaxLength='20' value='" + entity.Describe + "' class='txtDescribe' />";

            //操作
            cel = row.insertCell(4);
            cel.align = "center";
            cel.className = "Field";
            cel.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        //删除行数据
        function deleteItem(obj) {
            i = i - 1;
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }

        //选择构件名称
        function selectComponent(obj) {
            txtBomName = $.trim($("#<%=this.txtBomName.ClientID %>").val());
            if(txtBomName == ""){
               alert("请先输入<%=Resources.lang.MouldName%>");
               return false;
            }
            var condition = " ComponentName  like'" + txtBomName + "%'";
            var $obj = $(obj);
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=710&PageCondition=" + condition + "&CallBackFunc=getChooseValueComponent&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }

        //获取选中构件名称的返回值
        function getChooseValueComponent(list) {
            var mid = list[0][0];
            var b = true;
            var o = $("input[name='hdnMouldTypeId']");
            for (var i = 0; i < o.length; i++) {
                if (mid == $(o[i]).val() && mid != '-1') {
                    b = false;
                    alert("该构件名称已经存在！");
                }
            }
            if (b == true) {
                rowObj.cells[1].children[0].value = list[0][0]; //构件ID
                rowObj.cells[1].children[1].value = list[0][1]; //构件名称
            }
        }

        //选择可替换构件
        function selectReplace(obj){
            var $obj = $(obj);
            rowObj = obj.parentElement.parentElement;
            rowIndex = rowObj.rowIndex;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=710&CallBackFunc=getChooseValueReplace&Multiple=true&rnd=" + Math.random(), width: 600, height: 300 });
        }

        function getChooseValueReplace(list){
            var replaceCom = "";
            for (var i = 0; i < list.length; i++) {
                replaceCom += list[i][1];
                if (replaceCom != "") {
                    replaceCom += "|";
                }
            }
            replaceCom = replaceCom.substring(0, replaceCom.length - 1);
            rowObj.cells[2].children[0].value = replaceCom; //可替换构件
        }




        //保存数据
        function Save() {
           
            txtBomName = $.trim($("#<%=this.txtBomName.ClientID %>").val());
            var txtInternalDiameter = $("#<%=this.txtInternalDiameter.ClientID %>").val();
            var txtExternalDiameter = $("#<%=this.txtExternalDiameter.ClientID %>").val();
            var txtAcreage = $("#<%=this.txtAcreage.ClientID %>").val();
            var txtMaxPressure = $("#<%=this.txtMaxPressure.ClientID %>").val();
            var txtDescribe = $("#<%=this.txtDescribe.ClientID %>").val();
           
            var entity = {};
            entity.MouldBomId = Id;
            entity.BomName = txtBomName;
            entity.InternalDiameter = parseFloat(txtInternalDiameter);
            entity.ExternalDiameter = parseFloat(txtExternalDiameter);
            entity.Acreage = parseFloat(txtAcreage);
            entity.MaxPressure = txtMaxPressure;
            entity.Describe = txtDescribe;

            //明细数据
            var List = [];
            $("#tblExpand tr:not(:first)").each(function (index, element) {
                var model = {};
                model.MouldBomChildId = -1;
                //alert($(this).children("td:eq(1)").find("[name='hdnMouldTypeId']").val());
                model.MouldTypeId = $(this).children("td:eq(1)").find("[name='hdnMouldTypeId']").val();
                model.ComponentCode = $(this).children("td:eq(1)").find("[name='txtComponentName']").val();
                model.ReplaceComponentName = $(this).children("td:eq(2)").find("[name='txtReplaceComponentName']").val(); 
                model.Describe = $(this).children("td:eq(3)").find('input').val();
                List.push(model);
            });
            if (List.length == 0 || typeof List[0].MouldTypeId == 'undefined') {
                alert("请添加模具BOM的构件信息!");
                return false;
            }


            var mouldDtl = JSON.stringify(List);

            var ajax = SKT.LeanMES.Web.Equipment.MouldBomEdit.EditBom(entity,mouldDtl);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            $("#<%=this.hdnMouldBomId.ClientID %>").val(ajax.value);
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList(txtBomName);
        }
        
        function Trim(str) {
            return str.replace(/(^\s*)|(\s*$)/g, "");
        }

        function update() {
           document.forms[0].submit();
        }

    </script>
</asp:Content>

    
