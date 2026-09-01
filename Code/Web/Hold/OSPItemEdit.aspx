<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="OSPItemEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Hold.OSPItemEdit" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">产品编码
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" IsRequired='1'
                            Width="64%">
                        </asp:TextBox><input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..."
                            title="Select" onclick="openChoosePage(1);" /><em>*</em>
                        <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
            </td>
        </tr>
       <tr>
            <td class="Label2">产品名称
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">产品规格
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemSpec" runat="server" Text="" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%;
        border-collapse: collapse; margin-top: 5px;" class="EditeContentTable">
        <tr class="ListTableHeader">
            <th scope="col" style="width: 60px;text-align:center;">
                序号
            </th>
            <th scope="col" style="width: 100px;text-align:center;">
                工序段类型<em>*</em>
            </th>
            <th scope="col" style="width: 80px;text-align:center;">
                工序段时间（分）
            </th>
            <th scope="col" style="width: 100px;text-align:center;">
                开始站<em>*</em>
            </th>
            <th scope="col" style="width: 100px;text-align:center;">
                结束站<em>*</em>
            </th>           
            <th scope="col" id="thAddDetail" onclick="addDtl()" style="color: #0066CC;cursor: pointer; width: 70px;text-align:center;">
                +新增
            </th>
        </tr>
        <tbody id="tbodyOSP">
 
        </tbody>
        
    </table>

    <script type="text/javascript">
        var Id = '<%=Request.QueryString["ID"]%>';        
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";

        $().ready(function(){
            getItemInfo();
        });

        function getItemInfo() {
            var entity = {};
            entity.OSPItemId = Id;
             
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("uspGetOSPItemDtl", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            var result = JSON.parse(ajax.value);

            var itemEntity = result.data[0];
            $("#hdnItemId").val(itemEntity.ItemId);
            $("#txtItemCode").val(itemEntity.ItemCode);
            $("#lblItemName").text(itemEntity.ItemName);
            $("#lblItemSpec").text(itemEntity.ItemSpec);
            load(result.data1);
        }

        function load(list){
            var html = "";

            for(var i=0;i<list.length;i++){
                var entity = list[i];

                html += "<tr class='ListTableOddRow'>" +
                    "<td align='center' class='Field'>" + (i + 1) + "<input type='hidden' name='OSPItemDtlId' value='" + entity.OSPItemDtlId + "' /></td>" +

                    "<td align='center' class='Field'><input type=\"text\" name=\"txtOSPTypeName\"  IsRequired='1' class=\"TextBox\" value=\"" + entity.OSPTypeName + "\" disabled=\"disabled\" style=\" width:100px;\" >"
                    +"<input type=\"button\" id=\"btnSelectOSPType\" onclick=\"SelectOSPType(this);\" class=\"ButtonBox\" value=\"...\" />" 
                    +"<input type='hidden' name='OSPTypeId' value='"+entity.OSPTypeId+"' /></td>"+

                    "<td align='center' class='Field' name='OSPTypeTime'>" + entity.OSPTypeTime + "</td>" +

                    "<td align='center' class='Field'><input type=\"text\" name=\"txtStartStation\"  IsRequired='1' class=\"TextBox\" value=\"" + entity.StartStation + "\" disabled=\"disabled\" style=\" width:100px;\" >"
                    + "<input type=\"button\" id=\"btnSelectStartStation\" onclick=\"SelectStation(this,1);\" class=\"ButtonBox\" value=\"...\" />"
                    +"<input type='hidden' name='StartStationId' value='"+entity.StartStationId+"' /></td>"+

                    "<td align='center' class='Field'><input type=\"text\" name=\"txtEndStation\"  IsRequired='1' class=\"TextBox\" value=\"" + entity.EndStation + "\" disabled=\"disabled\" style=\" width:100px;\" >"
                    + "<input type=\"button\" id=\"btnSelectEndStattion\" onclick=\"SelectStation(this,0);\" class=\"ButtonBox\" value=\"...\" />"
                    + "<input type='hidden' name='EndStationId' value='" + entity.EndStattionId + "' /></td>" +
                    
                    "<td align='center' class='Field'><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteDtl(this)\"> "+mesLang("删 除")+" </span></td>" +

                    "</tr>";
            }

            $("#tbodyOSP").html(html);
        }

        function addDtl(){
            var html = "";

            html += "<tr class='ListTableOddRow'>" +
                    "<td align='center' class='Field'><span name='seq'>" + ($("#tbodyOSP tr").length + 1) + "</span><input type='hidden' name='OSPItemDtlId' value='-1' /></td>" +

                    "<td align='center' class='Field'><input type=\"text\" name=\"txtOSPTypeName\"  IsRequired='1' class=\"TextBox\" value=\"\" disabled=\"disabled\" style=\" width:100px;\" >"
                    +"<input type=\"button\" id=\"btnSelectOSPType\" onclick=\"SelectOSPType(this);\" class=\"ButtonBox\" value=\"...\" />" 
                    +"<input type='hidden' name='OSPTypeId' value='' /></td>"+

                    "<td align='center' class='Field'  name='OSPTypeTime'></td>" +

                    "<td align='center' class='Field'><input type=\"text\" name=\"txtStartStation\"  IsRequired='1' class=\"TextBox\" value=\"\" disabled=\"disabled\" style=\" width:100px;\" >"
                    + "<input type=\"button\" id=\"btnSelectStartStation\" onclick=\"SelectStation(this,1);\" class=\"ButtonBox\" value=\"...\" />"
                    +"<input type='hidden' name='StartStationId' value='-1' /></td>"+

                    "<td align='center' class='Field'><input type=\"text\" name=\"txtEndStation\"  IsRequired='1' class=\"TextBox\" value=\"\" disabled=\"disabled\" style=\" width:100px;\" >"
                    + "<input type=\"button\" id=\"btnSelectEndStattion\" onclick=\"SelectStation(this,0);\" class=\"ButtonBox\" value=\"...\" />"
                    +"<input type='hidden' name='EndStationId' value='-1' /></td>"+
                    
                    "<td align='center' class='Field'><span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteDtl(this)\"> 删 除 </span></td>" +
                    "</tr>";

            $("#tbodyOSP").append(html);
        }

        function deleteDtl(obj) {
            var trObj = $(obj).parent().parent().remove();

            $("#tbodyOSP tr").each(function (i,o) {
                $(o).find("span[name=seq]").text(i+1);
            });
        }

        function Save() {
            var itemId = $("#hdnItemId").val();
            var ospArr = [];
            $("#tbodyOSP tr").each(function (i, o) {
                var OSPItemDtlId = $(o).find("input[name=OSPItemDtlId]").val();
                var OSPTypeId = $(o).find("input[name=OSPTypeId]").val();
                var StartStationId = $(o).find("input[name=StartStationId]").val();
                var EndStationId = $(o).find("input[name=EndStationId]").val();

                ospArr.push({OSPItemDtlId:OSPItemDtlId, OSPTypeId: OSPTypeId, StartStationId: StartStationId, EndStationId:EndStationId});
            });

            if (ospArr.length == 0) {
                alert("请新增工序段产品细项！");
                return;
            }

            var entity = {};
            entity.OSPItemId = Id;
            entity.ItemId = itemId;
            entity.OSPItemDtl = JSON.stringify(ospArr);
            entity.UserName = userName;
            var ajax = SKT.AjaxCommon.DBService.ExecuteSpc("Prod_OSPItem_Edit", JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert("保存成功！");
            window.parent.location.href = window.parent.location.href;

        }

        var currentTrObj = null;
        var isStartStation = 0;

        function SelectStation(obj,type) {
            currentTrObj = $(obj).parent().parent();

            isStartStation = type;
            openChoosePage(8);
        }

        function SelectOSPType(obj) {
            currentTrObj = $(obj).parent().parent();
            openChoosePage(827);
        }

        var flags;
        function openChoosePage(flags) {
            var condition = "";

             flag = flags;
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                    flags +
                    "&Multiple=false&SearchCondition=" +
                    condition +
                    "&rnd=" +
                    Math.random(),
                width: 680,
                height: 300
            });

        }

        function getChooseValue(list) {             
            if (flag == 1) {
                $("#txtItemCode").val(list[0][2]);
                $("#hdnItemId").val(list[0][0]);

                $("#lblItemName").text(list[0][1]);
                $("#lblItemSpec").text(list[0][6]);
            }
            else if (flag == 8) {
                
                if (isStartStation == 1) {
                    if (currentTrObj.find("input[name=EndStationId]").val() == list[0][0]) {
                        alert("开始站和结束站不能一样！");
                        return;
                    }
                    currentTrObj.find("input[name=txtStartStation]").val(list[0][1]);
                    currentTrObj.find("input[name=StartStationId]").val(list[0][0]);
                }
                else {
                    if (currentTrObj.find("input[name=StartStationId]").val() == list[0][0]) {
                        alert("开始站和结束站不能一样！");
                        return;
                    }
                    currentTrObj.find("input[name=txtEndStation]").val(list[0][1]);
                    currentTrObj.find("input[name=EndStationId]").val(list[0][0]);
                }

                currentTrObj = null;
                isStartStation = 0;
            }
            else if (flag == 827) {
                currentTrObj.find("input[name=txtOSPTypeName]").val(list[0][1]);
                currentTrObj.find("input[name=OSPTypeId]").val(list[0][0]);
                currentTrObj.find("td[name=OSPTypeTime]").text(list[0][2]);
            }
        }
         
    </script>
</asp:Content>
