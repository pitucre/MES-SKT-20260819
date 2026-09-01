<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    Inherits="SKT.LeanMES.Web.SMT.LoadingListAdd" CodeBehind="LoadingListAdd.aspx.cs" %>

<%@ Import Namespace="Resources" %>

<%@ MasterType VirtualPath="~/Masters/ListMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <style type="text/css">
        .redFont {
            color: red;
        }

        td {
            max-width: 500px;
            word-wrap: break-word;
            /*overflow:hidden;*/
        }

        table {
            width: 100%
        }
    </style>
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">模板类型：<em>*</em></td>
            <%--<td class="Field2" id="tdLoadType"></td>--%>
            <td colspan="3">
                <asp:DropDownList ID="ddlLoadType" runat="server" ClientIDMode="Static">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.FielLoadPath %><em>*</em>
            </td>
            <td class="Field2" style="text-align: left">
                <asp:FileUpload ID="fuLoadingList" runat="server" onchange="uploadFile(this.value)" ClientIDMode="Static" />
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click" ClientIDMode="Static"></asp:LinkButton>
                <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady" CssClass="redFont">未载入</asp:Label>
            </td>

            <td class="Label2">
                <%=Resources.lang.FullSet%><em>*</em>
            </td>
            <td class="Field2">
                <asp:CheckBox ID="cbFullSet" runat="server" ClientIDMode="Static" Checked="true" Enabled="false" />
            </td>
        </tr>
        <tr>
            <td class="Label2">线别设备类型：<em>*</em></td>
            <td class="Field2" id="td-SMT-LineType"></td>
            <td class="Label2">线别设备序号：<em>*</em></td>
            <td class="Field2 redFont" id="td-SMT-LineType-Seq"><span>未加载</span></td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.SMTListName%><em>*</em>
            </td>
            <td class="Field2" colspan="1">
                <asp:TextBox ID="lab_SetupName" IsRequired="1" runat="server" ClientIDMode="Static"
                    CssClass="TextBox" Width="70%"></asp:TextBox>
            </td>

            <td class="Label2">
                <%= Resources.lang.ItemsName %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtModelName" name="ModelName" runat="server" CssClass="TextBox"
                    IsRequired="1" Enabled="false" ClientIDMode="Static" Width="64%"></asp:TextBox><input type="button" id="btnSelectItems" onclick="selectItems(this);" class="ButtonBox" value="..." />
                <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnItemName" runat="server" Value="" ClientIDMode="Static" />
            </td>

        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Revision %>
                <em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtRev" runat="server" IsRequired="1" ClientIDMode="Static" CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">
                <%=Resources.lang.Status %><em>*</em>
            </td>
            <td class="Field2">
                <label>未使用</label>
            </td>
            <%--            <td class="Field2">
                <asp:DropDownList ID="ddlStatus" ClientIDMode="Static" runat="server">
                </asp:DropDownList>
            </td> --%>
        </tr>
        <tr>
            <td class="Label2"><%= Resources.lang.Layout %></td>
            <td class="Field2">
                <asp:DropDownList ID="ddlLayout" runat="server">
                </asp:DropDownList>
            </td>
            <td class="Label2">扣料基数<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCLNumber" runat="server" Text="1" CssClass="TextBox" IsRequired="1" MaxLength='10'></asp:TextBox>
            </td>
        </tr>
        <tr class="clear5"></tr>
    </table>

    <div id="divBindTab" style="text-align: center">
        <table class="ListTable" width="100%" id="tbViewInsert">
        </table>

    </div>
    <div style="margin-top: 5px;">
        <asp:GridView ID="GridView1" AutoGenerateColumns="false" runat="server" DataSourceID="">
            <Columns>
                <%--<asp:BoundField DataField="SetupName" HeaderText="上料清单"  SortExpression="SetupName" />--%>
                <asp:BoundField DataField="Area" HeaderText="区" SortExpression="Area" ItemStyle-Width="40px" />
                <asp:BoundField DataField="Position" HeaderText="料站/插槽" SortExpression="Position" />
                <asp:BoundField DataField="ItemCode" HeaderText="物料编码" SortExpression="ItemCode" />
                <asp:BoundField DataField="SmtNum" HeaderText="需求用量" SortExpression="SmtNum" />
                <%--<asp:BoundField DataField="LocationType" HeaderText="位置"  SortExpression="LocationType" />--%>
                <asp:BoundField DataField="FeederType" HeaderText="飞达类型" SortExpression="FeederType" />
                <asp:BoundField DataField="Point" HeaderText="点位" SortExpression="Point" />
                <asp:BoundField DataField="ReplaceNum" HeaderText="替代料" SortExpression="ReplaceNum" />
                     <asp:BoundField DataField="ElementDescription" HeaderText="元件说明" SortExpression="ElementDescription" />
            </Columns>
        </asp:GridView>
        <%--    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
        MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.SMT.BLL.LoadingList_DETAIL"
        SelectMethod="GetLoadTypeTempView" SelectCountMethod="GetCount">
        <SelectParameters>
            <asp:Parameter Name="searchSettings" Type="Object" />
        </SelectParameters>
    </asp:ObjectDataSource>--%>
        <%--        <asp:GridView ID="GridView1" runat="server" Width="100%" OnRowDataBound="GridView1_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="ID" Visible="true"></asp:TemplateField>
            </Columns>
        </asp:GridView>--%>
    </div>
    <asp:HiddenField ID="hdnIsSwitchable" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnIsRefDesignator" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnFamilyMatrixID" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hfSMTColName" runat="server" Value="" ClientIDMode="Static" />
    <asp:HiddenField ID="hfJsonLoadType" runat="server" Value="" ClientIDMode="Static" />
    <asp:HiddenField ID="hdfDefualtLoadType" runat="server" Value="" ClientIDMode="Static" />
    <asp:HiddenField ID="hfJsonLineRelation" runat="server" Value="" ClientIDMode="Static" />
    <asp:HiddenField ID="hfJsonSeq" runat="server" Value="" ClientIDMode="Static" />
    <script type="text/javascript">
        var id = '<%=Request.QueryString["ID"]==null?-1: Convert.ToInt32(Request.QueryString["ID"]) %>';
        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var errStr = "";
        var txtModelName = $("#<%=this.txtModelName.ClientID %>").val();
        var txtRev = $("#<%=this.txtRev.ClientID %>").val();
        //var TxtBoardQTY = $("#TxtBoardQTY").val();
        var txtCustomerName = "";
        var loadColName = '<%=colNameJson %>'; //上载的表格列名
        var xlsTbJson = '<%=xlsTbJson %>'; //上载的表格
        var colEntity;
        var SMTColName = [];
        var objLoadCol;
        var objSMTCol;
        var mulSelFlag = 0;  //用于验证是否多重绑定 
        var fullSelFlag = 0;    //用于验证是否完全绑定所需列
        $(function () {
            //createLoadType($("#hfJsonLoadType").val());
            createSMTLineType($("#hfJsonLineRelation").val(), -1, "createSMTLineSeq");
            if (loadColName !== '') {
                //var colEntity = JSON.parse($("#hfSMTColName").val());
                var xlsEntity = JSON.parse(xlsTbJson);
                objLoadCol = JSON.parse(loadColName);
                objSMTCol = SMTColName;
                initBindTab(xlsEntity);
            }
        });

        function initBindTab(entity) {
            if (!entity || entity.length === 0) return false;
            var r = '';
            var arrHead = [];
            r += "<tr class='ListTableHeader '>";
            for (var item in entity[0]) {
                arrHead.push(item);
                r += "<th class=''>" + item + "</th>";
            }
            r += "</tr>";
            for (var i = 0; i < entity.length; i++) {
                r += "<tr class='ListTableOddRow '>";
                //for (var j = 0; j < Object.keys(entity[0]).length; j++) {
                //    if (j > 0) {  //第一列是系统生成的行号
                //        var index = j -1;
                //        r += "<td class=''>" + entity[i]['ExcCol_' + index] + "</td>";
                //    }
                //}
                for (var item in entity[i]) {
                    r += "<td class=''>" + (entity[i][item] == null ? '' : entity[i][item]) + "</td>";
                    console.log(entity[i][item])
                }
                r += "</tr>";
            }
            $("#tbViewInsert").html(r);
            //$("#divBindTab").html("文件加载完成");
        }

        var genSMTColList = function (selectIndex) {
            var s = '<select class="ddlSMTCol" name="ddlSMTCol">';
            s += '<option value ="-1" selected="selected">忽略</option>';
            for (var i = 0; i < objSMTCol.length; i++) {
                if (i === selectIndex * 1) {
                    s += '<option selected="selected" value =' + i + '>' + objSMTCol[i] + '</option>';
                } else {
                    s += '<option value =' + i + '>' + objSMTCol[i] + '</option>';
                }
            }
            s += '</select>';
            return s;
        }

        function Save() {
            if ($("#lbFileReady").val() === "未载入") {
                alert("请先载入上料清单");
                return false;
            }
            if ($("#ddlLoadType").val() === "-1") {
                alert("请选择模板类型！");
                return false;
            }
            var LLinfo = {};
            LLinfo.ID = id;
            LLinfo.ItemId = $("#hdnItemId").val();
            LLinfo.SetupName = $("#lab_SetupName").val();
            LLinfo.CustomerName = '';
            LLinfo.Revision = $("#txtRev").val();
            LLinfo.StatusID = 0//$("#ddlStatus").val();   ZCL  新增默认为 未使用状态
            LLinfo.IsFullSet = $("#cbFullSet").attr("checked") === "checked" ? true : false;
            LLinfo.LoadingTypeId = $("#ddlLoadType").val() * 1;

            var c = $("#dll-SMT-LineType").val() * 1;
            if ($("#dll-SMT-LineType").val() * 1 == -1) {
                alert("请选择线别设备类型");
                return false;
            }
            LLinfo.EquipmentLineId = $("#dll-SMT-LineType").val() * 1;
            LLinfo.SequenceNo = $("#dll-SMT-LineType-Seq").val() * 1;
            LLinfo.CreateBy = user;
            LLinfo.SmtLayout = $("#<%=ddlLayout.ClientID %>").val();
            LLinfo.CLNumber = parseFloat($("#<%=txtCLNumber.ClientID %>").val());

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.SaveByUserBind(LLinfo);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                alert("<%= Messages.SaveInSuccess %>");
            }

            parent.window.UpdateList($("#lab_SetupName").val());
        }

        //验证下拉框选择
        function checkSelected() {
            var colSeq = document.getElementsByName("ddlSMTCol"); //获取当前选定值
            var strColSeq = [];
            var fullArr = [];
            for (var i = 0; i < colSeq.length; i++) {
                strColSeq.push(colSeq[i].value);
                if (colSeq[i].value * 1 !== -1) {
                    fullArr.push(colSeq[i].value);
                }
            }
            //检验是否重复选中
            var arr = strColSeq.sort();
            for (var i = 0; i < strColSeq.length; i++) {
                if (arr[i] === arr[i + 1] && arr[i] * 1 !== -1) {
                    mulSelFlag = 0;
                    alert("重复绑定内容：" + objSMTCol[arr[i]]);
                    return false;
                } else {
                    mulSelFlag = 1;
                }
            }
            //检验是否绑定完整(剔除-1)
            if (fullArr.length === SMTColName.length) {
                fullSelFlag = 1;
            } else {
                fullSelFlag = 0;
                //alert("数据未绑定完整");
                return false;
            }
        }

        function selectItems(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 680, height: 300 });
        }
        function getChooseValue(list) {
            //$("#txtModelName").val(list[0][1] + ' (' + list[0][2] + ')');

            $("#<%=this.txtModelName.ClientID %>").val(list[0][1]);
            $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
            $("#<%=this.hdnItemName.ClientID %>").val(list[0][1]);

        }

        function selectCustomer(obj) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&CallBackFunc=getChooseValueCustomer&rnd=" + Math.random(), width: 680, height: 300 });
        }

        function getChooseValueCustomer(list) {
        }

        function uploadFile(filePath) {
            if (filePath.length > 0) {
                var str = '';
                var postback = $('#<%= linkUploadFile.ClientID %>').attr('href');
                var funcStartIndex = postback.indexOf('\'');
                var funcEndIndex = postback.indexOf('\',');
                if (funcStartIndex != -1 && funcEndIndex != -1) {
                    var str = postback.substring(funcStartIndex + 1, funcEndIndex);

                    __doPostBack(str, '');
                } else {
                    return false;
                }
                //$("#linkUploadFile").click();
            }
        }

        function createLoadType(strJson, dfIndex) {
            var objJson;
            dfIndex = dfIndex || 0;
            if (typeof strJson === 'undefined' || strJson === "") {
                return;
            } else {
                objJson = $.parseJSON(strJson);
            }
            var ddlHtml = "<select class='ddlLoadType' id='ddlLoadType'> ";
            ddlHtml += "<option value='-1'>全部</option> ";
            for (var i = 0; i < objJson.length; i++) {
                var ItemName = objJson[i].ItemName;
                var ItemValue = objJson[i].ItemValue;
                if (ItemValue === dfIndex) {
                    ddlHtml += "<option selected='selected' value='" + ItemValue + "'>" + ItemName + "</option> ";
                } else {
                    ddlHtml += "<option value='" + ItemValue + "'>" + ItemName + "</option> ";
                }
            }
            ddlHtml += "</select>";
            $("#tdLoadType").html(ddlHtml);
        }

        function createSMTLineType(strJson, dfIndex, changeCb) {
            var objJson;
            dfIndex = dfIndex || 0;
            if (typeof strJson === 'undefined' || strJson === "") {
                return;
            } else {
                objJson = $.parseJSON(strJson);
            }
            var ddlHtml = "<select class='dll-SMT-LineType' id='dll-SMT-LineType' onchange='" + changeCb + "($(this).val())'>";
            ddlHtml += "<option selected='selected' value='-1'>请选择</option> ";
            for (var i = 0; i < objJson.length; i++) {
                var ItemName = objJson[i].ItemName;
                var ItemValue = objJson[i].ItemValue;
                if (ItemValue === dfIndex) {
                    ddlHtml += "<option selected='selected' value='" + ItemValue + "'>" + ItemName + "</option> ";
                } else {
                    ddlHtml += "<option value='" + ItemValue + "'>" + ItemName + "</option> ";
                }
            }
            ddlHtml += "</select>";
            $("#td-SMT-LineType").html(ddlHtml);
        }

        function createSMTLineSeq(typeId) {
            var objJson, strJson;
            //参数判断
            if (typeId * 1 === -1) {
                $("#td-SMT-LineType-Seq").html('未加载');
                return false;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.GetEquipmentLineSeq(typeId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                strJson = ajax.value;
            }

            if (typeof strJson === 'undefined' || strJson === "") return false;
            objJson = $.parseJSON(strJson);
            if (objJson.length === 0) {
                $("#td-SMT-LineType-Seq").html("未找到该线别类型序号");
                return false;
            }
            var ddlHtml = "<select class='dll-SMT-LineType-Seq' id='dll-SMT-LineType-Seq'> ";
            for (var i = 0; i < objJson.length; i++) {
                var itemName = objJson[i].ItemName;
                var itemValue = objJson[i].ItemValue;
                ddlHtml += "<option value='" + itemValue + "'>" + itemName + "</option> ";
            }
            ddlHtml += "</select>";
            $("#td-SMT-LineType-Seq").html(ddlHtml);
        }

        //$("#ddlLoadType").change(function () {
        //    //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.GetLoadTypeSeq($(this).val() * 1);
        //    var entity = getColSeq();
        //    console.log(entity.ColPosition)
        //    console.log(entity.ColTable)
        //})

        //function getColSeq() {
        //    var type = $("#ddlLoadType").val();
        //    var ajax = SKT.LeanMES.Web.AjaxServices.AjaxServicesLoadingList.GetLoadTypeSeq(type);
        //    return ajax.value;
        //}
    </script>
</asp:Content>
