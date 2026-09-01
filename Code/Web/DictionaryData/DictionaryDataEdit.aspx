<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="DictionaryDataEdit.aspx.cs" Inherits="SKT.LeanMES.Web.DictionaryData.DictionaryDataEdit"
    Title="Edit DictionaryData" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
     <div class="wrap_tb" id="wrap_tb">
        <ul class="tb">
            <li class="current" id="Div1">单位</li>
            <li>单位换算</li>
        </ul>
        <div class="tb_c tb_content">           
            <table width="100%" class="EditeContentTable"> 
                <tr>
                    <td class="Label2">
                        <%= Resources.lang.Name%><em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtName" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="20"></asp:TextBox>
                    </td>
                    <td class="Label2">
                        <%= Resources.lang.Description %><em>*</em>
                    </td>
                    <td class="Field2">
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox" IsRequired='1' MaxLength="50"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">
                        <%= Resources.lang.Remark %>
                    </td>
                    <td  colspan="3" class="Field2">
                        <asp:TextBox ID="txtRemark"  TextMode="MultiLine" Width="500px" runat="server" CssClass="TextArea" MaxLength="50"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div id="Transfer">
            <table id="tabTransfer" class="ListTable" width="100%">
                <tr class="ListTableHeader">                    
                    <th>元单位</th>
                    <th>换算单位</th>
                    <th>换算值</th>
                    <th scope="col" onclick="addUnitTranfer(null);" style="color: #0066CC;
                        cursor: pointer; width: 80px; vertical-align: middle;" align="center">
                        <img src="../Content/images/icon/Add.png" class="imgText" />
                        <%= Resources.Buttons.COM_Add %>
                    </th>
                </tr>
            </table>
        </div>
    </div>
    <script type="text/javascript">
        var dictionaryDataId = '<%=Request.QueryString["ID"]%>';

        $(document).ready(function () {
            if (dictionaryDataId != -1) {
                $("#<%=this.txtName.ClientID%>").attr("disabled", "disabled");

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDictionaryData.GetTransforByUnitID(dictionaryDataId);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                var list = ajax.value;
                for (i = 0; i < list.length; i++) {
                    addUnitTranfer(list[i]);
                }
            }
        });

        function addUnitTranfer(entity) {
            if (dictionaryDataId == -1) {
                alert("请先保存单位");
                return false;
            }
            if (entity == null) {
                entity = {};
                entity.UintID = dictionaryDataId;
                entity.UintName = $.trim($("#<%=this.txtName.ClientID%>").val());
                entity.TransforUnitID = -1;
                entity.TransforUnitName = "";
                entity.TransforData = 0;
            }

            var tab = document.getElementById("tabTransfer");
            var rowNewIdx = tab.rows.length;
            var row, cell;
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
            //原单位
            cell = row.insertCell(0);
            cell.align = "center";
            cell.innerHTML = $.trim($("#<%=this.txtName.ClientID%>").val());

            //换算单位
            cell = row.insertCell(1);
            cell.align = "center";
            cell.innerHTML = "<input type=\"hidden\" name=\"txtUnitID\" value=\"" +
                entity.TransforUnitID +
                "\" /><input type=\"text\" name=\"txtUnit\" style=\"width:80%;\"   value=\"" +
                entity.TransforUnitName + "\" disabled=\"disabled\">" +
                "<input type=\"button\" id=\"btnUnitType\" onclick=\"selChoosePage(this);\" class='chkEditableBOM ButtonBox'  value=\"...\"  />";

            //换算值
            cell = row.insertCell(2);
            cell.align = "center";
            cell.innerHTML = "<input type=\"text\" name=\"txtRplPercent\" style=\"width:80%;\" value=\"" +
                entity.TransforData +
                "\" class=\"NumericBox50\" onkeyup=\"this.value=this.value.replace(/[^\\d.]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^\\d.]/g,'')\"/>";

            //操作按钮
            cell = row.insertCell(3);
            cell.align = "center";
            cell.innerHTML =
                "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
        }

        //删除
        function deleteItem(obj) {
            var tab = document.getElementById("tabTransfer");

            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
        }

        var rowObj;
        function selChoosePage(obj) {
            rowObj = obj.parentElement;
            var searchCondition = " DicProperty='Unit' ";
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>"
            , src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&PageCondition= " + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350
            });
        }

        function getChooseValue(list) {
            //检查是否重复
            var exists = false;
            $("input[name=txtUnitID]").each(function () {
                if ($.trim($(this).val()) == list[0][0]) {
                    exists = true;
                }
            });
            if (exists) {
                alert("选择的换算单位已经存在");
                return false;
            }

            rowObj.children[0].value = list[0][0];
            rowObj.children[1].value = list[0][1];
        }

        /*保存数据*/
        function Save() {
            var txtName = $.trim($("#<%=this.txtName.ClientID%>").val());
            var txtDescription = $.trim($("#<%=this.txtDescription.ClientID%>").val());
            var txtRemark = $.trim($("#<%=this.txtRemark.ClientID%>").val());
            var txtModifyBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';
            var txtCreateBy = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName%>';


            /*表单验证*/
            /*如需表单验证可以此处处理验证 开始*/

            var entity = {};

            entity.DictionaryDataID = dictionaryDataId
            entity.Code = "";
            entity.Name = txtName;
            entity.DicProperty = "Unit";
            entity.Description = txtDescription;
            entity.Value = txtName;
            entity.Remark = txtRemark;
            entity.ModifyBy = txtModifyBy;
            entity.CreateBy = txtCreateBy;

            //收集单位换算
            var list = [];
            var tab = document.getElementById("tabTransfer");
            for (i = 1; i < tab.rows.length; i++) {
                var transfor = {};
                transfor.UnitTransforID = -1;
                transfor.UnitID = parseInt(dictionaryDataId);
                transfor.TransforUnitID = parseInt($(tab.rows[i]).find("td input[name='txtUnitID']").val());
                transfor.TransforData = parseFloat($(tab.rows[i]).find("td input[name='txtRplPercent']").val());
                list.push(transfor);
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxDictionaryData.DictionaryDataEdit(entity, list);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            if ('<%=Request.QueryString["inMenu"] %>' == "true") {
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/User/UserEdit.aspx?name=Account_UserEdit&ID=" + parseInt(ajax.value);
                location.href = openWinUrl;
            }
            else {
                parent.window.Refresh();
            }
        }
    </script>
</asp:Content>
