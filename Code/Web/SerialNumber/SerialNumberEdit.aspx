<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="SerialNumberEdit.aspx.cs" Inherits="SKT.LeanMES.Web.SerialNumber.SerialNumberEdit"
    Title="Edit SerialNumber" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server" EnableViewState="true">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.SerialNumberType %><em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <asp:DropDownList ID="ddlNumberType" runat="server" ClientIDMode="Static" IsRequired="1" OnSelectedIndexChanged="ddlNumberType_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label2">对象类型
            </td>
            <td class="Field2">
                <asp:DropDownList runat="server" ID="ddlObjectType">
                    <asp:ListItem Value="1">产品</asp:ListItem>
                    <asp:ListItem Value="2">产品组</asp:ListItem>
                    <asp:ListItem Value="3">设备</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="Label2">具体对象
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtValue" runat="server" CssClass="TextBox" IsRequired="1" Text="ALL"
                    Enabled="false"></asp:TextBox><input type="button" id="Button1" class="ButtonBox"
                        value="..." title="" onclick="selectItem();" /><em>*</em>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Revision %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtVer" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.SerialNumberPrefix %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtPrefix" runat="server" Width="85%" CssClass="TextBox" MaxLength='50'></asp:TextBox><input
                    type="button" id="btnPrefix" class="ButtonBox" value="..." title="" onclick="selectPFormat();" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.SerialNumberSuffix %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtSuffix" runat="server" Width="85%" CssClass="TextBox" MaxLength='50'></asp:TextBox><input
                    type="button" id="btnSuffix" class="ButtonBox" value="..." title="" onclick="selectSFormat();" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.SequenceBase %><span id="spanBase"><em>*</em></span>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtBase" runat="server" IsRequired="1" Text="10" MaxLength='5' CssClass="TextBox"></asp:TextBox>
            </td>
            <td class="Label2">

                <%= Resources.lang.NumericalSystemList %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtNumberSeq" runat="server" Width="83%" CssClass="TextBox" MaxLength='50'
                    Style="text-transform: uppercase"></asp:TextBox>
                <input id="chkDefault" type="checkbox" onclick="DefaultCharacter()" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.SequenceLength %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtLength" runat="server" IsRequired="1" CssClass="TextBox" MinValue='1'
                    MaxValue='20' MaxLength='2'></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.MaxSeq %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMax" runat="server" IsRequired="1" MaxLength='10' CssClass="TextBox"
                    Style="text-transform: uppercase"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.MinSeq %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtMin" runat="server" IsRequired="1" CssClass="TextBox" oninput="setSeq(this)"
                    Text="1" MaxLength='10' Style="text-transform: uppercase"></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.IncrementBy %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtIncrement" runat="server" CssClass="TextBox" Text="1" MaxLength='10'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.CurrentSeq %><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtCurrent" runat="server" IsRequired="1" Text="1" CssClass="TextBox"
                    MaxLength='10'></asp:TextBox>
            </td>
            <td class="Label2">
                <%= Resources.lang.WarningSeq %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtWarning" runat="server" CssClass="TextBox"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.ResetWay %>
            </td>
            <td class="Field2">
                <asp:DropDownList ID="ddlReset" runat="server">
                </asp:DropDownList>
            </td>
            <td class="Label2">
                <%= Resources.lang.SampleSerialNumber %>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtSample" runat="server" CssClass="TextBox" ReadOnly="true"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%= Resources.lang.Description %>
            </td>
            <td class="Field2" colspan="3">
                <asp:TextBox ID="txtDesc" runat="server" CssClass="TextBox" TextMode="MultiLine"
                    Width="100%" Height="40"></asp:TextBox>
            </td>
        </tr>
        <%--<tr>
            <td class="Label2">
                <%= Resources.lang.IsAccordOrderReset %>
            </td>
            <td class="Field2" colspan="3">
                <asp:DropDownList ID="ddlIsAccordOrderReset" runat="server">
                    <asp:ListItem Text="<%$ Resources:Enum, Yes %>" Value="1"></asp:ListItem>
                    <asp:ListItem Text="<%$ Resources:Enum, No %>" Value="" Selected="True"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>--%>
    </table>
    <script type="text/javascript">
        var NextID = "<%=Request.QueryString["ID"] %>";
        var chooseItem = 0;
        var SearchCondition = " Name='NextNumberPara'"; //SUBSTRING(Value,1,1)='%'";

        var item = "", itemgroup = "";

        $(function () {
            if (document.getElementById("<%=this.chkDefault.ClientID %>").checked) {
                $("#<%=this.txtBase.ClientID %>").removeAttr("IsRequired");
            } else {
                $("#<%=this.txtBase.ClientID %>").attr("IsRequired", "1");
            }


            $("#<%=this.ddlObjectType.ClientID %>").change(function () {
                if ($(this).val() == "1") {
                    itemgroup = $("#<%=this.txtValue.ClientID %>").val();
                    $("#<%=this.txtValue.ClientID %>").val(item);
                } else if ($(this).val() == "2") {
                    item = $("#<%=this.txtValue.ClientID %>").val();
                    $("#<%=this.txtValue.ClientID %>").val(itemgroup);
                }
            })
            if (!document.getElementById("<%=this.chkDefault.ClientID %>").checked) {
                $("#<%=this.txtLength.ClientID %>,#<%=this.txtMax.ClientID %>,#<%=this.txtMin.ClientID %>,#<%=this.txtWarning.ClientID %>")
                .bind("keyup", function () {
                    getIntVal(this)
                });
            }
        });

        //显示默认36进制数
        function DefaultCharacter() {
            if (document.getElementById("<%=this.chkDefault.ClientID %>").checked) {
                $("#<%=this.txtBase.ClientID %>").removeAttr("IsRequired");
                $("#<%=this.txtBase.ClientID %>").val("");
                $("#<%=this.txtNumberSeq.ClientID %>").val("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ");
                $("#<%=this.txtNumberSeq.ClientID %>").focus();
                $("#spanBase").hide();
                document.getElementById("<%=this.txtNumberSeq.ClientID %>").disabled = false;
                document.getElementById("<%=this.txtBase.ClientID %>").disabled = true;
                $("#<%=this.txtCurrent.ClientID %>,#<%=this.txtIncrement.ClientID %>,#<%=this.txtLength.ClientID %>,#<%=this.txtMax.ClientID %>,#<%=this.txtMin.ClientID %>,#<%=this.txtWarning.ClientID %>").unbind("keyup");

            }
            else {
                $("#<%=this.txtBase.ClientID %>").attr("IsRequired", "1");
                $("#<%=this.txtBase.ClientID %>").val("10");
                $("#<%=this.txtNumberSeq.ClientID %>").val("");
                document.getElementById("<%=this.txtNumberSeq.ClientID %>").disabled = true;
                document.getElementById("<%=this.txtBase.ClientID %>").disabled = false;
                $("#spanBase").show();
                $("#<%=this.txtCurrent.ClientID %>,#<%=this.txtIncrement.ClientID %>,#<%=this.txtLength.ClientID %>,#<%=this.txtMax.ClientID %>,#<%=this.txtMin.ClientID %>,#<%=this.txtWarning.ClientID %>").bind("keyup", function () {
                    getIntVal(this)
                });
                $("#<%=this.txtCurrent.ClientID %>,#<%=this.txtIncrement.ClientID %>,#<%=this.txtLength.ClientID %>,#<%=this.txtMax.ClientID %>,#<%=this.txtMin.ClientID %>,#<%=this.txtWarning.ClientID %>").keyup();
            }
        }

        function Save() {
            //必填字段是否为空
            var ddlNumberType = $("#<%=this.ddlNumberType.ClientID %>").val();
            var ddlObjectType = $("#<%=this.ddlObjectType.ClientID %>").val();
            var txtValue = $("#<%=this.txtValue.ClientID %>").val();
            var txtBase = $("#<%=this.txtBase.ClientID %>").val();
            var txtNumberSeq = $("#<%=this.txtNumberSeq.ClientID %>").val();
            var txtCurrent = $("#<%=this.txtCurrent.ClientID %>").val();
            var sequenceLength = $("#<%=this.txtLength.ClientID %>").val();
            var maxSeq = $("#<%=this.txtMax.ClientID %>").val();
            var minSeq = $("#<%=this.txtMin.ClientID %>").val();
            var isCheck = document.getElementById("<%=this.chkDefault.ClientID %>").checked;

            //var ddlIsAccordOrderReset = $("#<%--<%=this.ddlIsAccordOrderReset.ClientID %>--%>").val();
            if (isNull(txtValue) || isNull(txtCurrent) || isNull(sequenceLength) || isNull(maxSeq) || isNull(minSeq)) {
                alert("<%= Resources.Messages.WithAsteriskIsRequiredAlert %>");
                return false;
            }
            if (isNull(txtBase) && isNull(txtNumberSeq)) {
                alert("<%= Resources.Messages.WithAsteriskIsRequiredAlert %>");
                return false;
            }
            if (isNull(ddlNumberType)) {
                alert("<%= Resources.Messages.WithAsteriskIsRequiredAlert %>");
                return false;
            }

            //输入必须为数字字母类型            
            var incrementBy = $("#<%=this.txtIncrement.ClientID %>").val();
            var warning = $("#<%=this.txtWarning.ClientID %>").val();
            if (txtBase.length > 0 && !isNumber(txtBase)) {
                alert("<%= Resources.lang.SequenceBase%>:" + "<%= Resources.Messages.MustbeNumber %>");
                return false;
            }
            if (!isNumber(sequenceLength)) {
                alert("<%= Resources.lang.SequenceLength%>:" + "<%= Resources.Messages.MustbeNumber %>");
                return false;
            }
            if (!isNumberOrLetter(maxSeq)) {
                alert("<%= Resources.lang.MaxSeq%>:" + "<%= Resources.Messages.MustbeNumberOrLetter %>");
                return false;
            }
            if (!isNumberOrLetter(minSeq)) {
                alert("<%= Resources.lang.MinSeq%>:" + "<%= Resources.Messages.MustbeNumberOrLetter %>");
                return false;
            }
            if (!isNumberOrLetter(incrementBy)) {
                alert("<%= Resources.lang.IncrementBy%>:" + "<%= Resources.Messages.MustbeNumberOrLetter %>");
                return false;
            }
            if (warning.length > 0 && !isNumberOrLetter(warning)) {
                alert("<%= Resources.lang.WarningSeq%>:" + "<%= Resources.Messages.MustbeNumberOrLetter %>");
                return false;
            }
            if (!isNumberOrLetter(txtCurrent)) {
                alert("<%= Resources.lang.CurrentSeq%>:" + "<%= Resources.Messages.MustbeNumberOrLetter %>");
                return false;
            }
            if (!isCheck && parseInt(maxSeq) < parseInt(minSeq)) {
                alert("序号最小值不能大于序号最大值！");
                return false;
            }
            if (!isCheck && parseInt(maxSeq) < parseInt(txtCurrent)) {
                alert("当前序号值不能大于序号最大值！");
                return false;
            }
            //2016-12-21 长度验证
            if (maxSeq.length > sequenceLength * 1) {
                alert("序号最大值不能超出设定长度！");
                return false;
            }

            var entity = {};
            entity.SerialNumberID = NextID;
            entity.SerialNumber_Source = 'S';
            entity.Next_Number_Type = ddlNumberType;
            entity.Apply_Type = ddlObjectType;
            entity.Type_Value = txtValue;
            entity.Revision = $("#<%=this.txtVer.ClientID %>").val();
            entity.Prefix = $("#<%=this.txtPrefix.ClientID %>").val().trim();
            entity.Suffix = $("#<%=this.txtSuffix.ClientID %>").val().trim();
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.ModifyBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
            entity.Description = $("#<%=this.txtDesc.ClientID %>").val();
            entity.SampleSerialNumber = $("#<%= this.txtSample.ClientID %>").val();
            entity.Remark = "";
            //entity.IsAccordOrderReset = new Boolean(ddlIsAccordOrderReset);
            /*从表信息*/
            var entityS = {};
            if (isNull(txtBase)) {
                entityS.Sequence_Base = 0;
            }
            else {
                entityS.Sequence_Base = txtBase;
            }
            if (isNull(txtNumberSeq)) //为空时处理
            {
                entityS.Number_Sequence = "";
            }
            else {
                entityS.Number_Sequence = txtNumberSeq;
            }
            entityS.Max_Seq = maxSeq;
            entityS.Sequence_Length = sequenceLength;
            entityS.Current_Sequence = txtCurrent;
            entityS.Min_Sequence = minSeq;
            if (isNull(incrementBy)) {
                entityS.IncrementBy = 1;
            }
            else {
                entityS.IncrementBy = incrementBy;
            }
            if (isNull(warning)) {
                entityS.Warning = 0;
            }
            else {
                entityS.Warning = warning;
            }

            entityS.Reset = $("#<%= this.ddlReset.ClientID %>").val();

            var ajaxMin = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.ChangeToDeciaml(entityS.Sequence_Base, entityS.Number_Sequence, entityS.Min_Sequence);
            if (ajaxMin.value == -1) {
                alert("<%= Resources.lang.MinSeq%>:" + "<%= Resources.lang.DigitNotMatch %>");
                return false;
            }
            entityS.Min_Sequence = ajaxMin.value;

            var ajaxMax = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.ChangeToDeciaml(entityS.Sequence_Base, entityS.Number_Sequence, entityS.Max_Seq);
            if (ajaxMax.value == -1) {
                alert("<%= Resources.lang.MaxSeq%>:" + "<%= Resources.lang.DigitNotMatch %>");
                return false;
            }
            entityS.Max_Seq = ajaxMax.value;

            var ajaxCur = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.ChangeToDeciaml(entityS.Sequence_Base, entityS.Number_Sequence, entityS.Current_Sequence);
            if (ajaxCur.value == -1) {
                alert("<%= Resources.lang.CurrentSeq%>:" + "<%= Resources.lang.DigitNotMatch %>");
                return false;
            }
            entityS.Current_Sequence = ajaxCur.value;

            var ajaxInc = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.ChangeToDeciaml(entityS.Sequence_Base, entityS.Number_Sequence, entityS.IncrementBy);
            if (ajaxInc.value == -1) {
                alert("<%= Resources.lang.IncrementBy%>:" + "<%= Resources.lang.DigitNotMatch %>");
                return false;
            }
            entityS.IncrementBy = ajaxInc.value;

            var ajaxWarn = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.ChangeToDeciaml(entityS.Sequence_Base, entityS.Number_Sequence, entityS.Warning);
            if (ajaxWarn.value == -1) {
                alert("<%= Resources.lang.WarningSeq %>:" + "<%= Resources.lang.DigitNotMatch %>");
                return false;
            }
            entityS.Warning = ajaxWarn.value;

            /*Save Event*/

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.EditSerialNumber(entity, entityS);
            if (ajax.error == null) {
                var ajaxSN = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.GenerateSNSample(ajax.value, txtCurrent);
                if (ajaxSN.error == null) {
                    //var serialNumberId = parseInt(ajax.value);
                    //entity.SampleSerialNumber = ajaxSN.value;
                    var ajaxS = SKT.LeanMES.Web.AjaxServices.AjaxSerialNumber.EditSampleSerialNumber(ajax.value, ajaxSN.value);
                    if (ajaxS.error != null) {
                        alert(ajaxS.error.Message);
                        return false;
                    }
                }
                else {
                    alert(ajaxSN.error.Message);
                    return false;
                }
                alert("<%= Resources.Messages.SaveInSuccess %>");
                parent.window.UpdateList(txtValue);
            }
            else {
                alert(ajax.error.Message);
                return false;
            }
        }

        function selectItem() {

            if ($("#<%=this.ddlObjectType.ClientID %>").val() == "1") {
                //选择产品
                chooseItem = 1;
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
            }
            else if ($("#<%=this.ddlObjectType.ClientID %>").val() == "2") {
                //选择产品组
                chooseItem = 39;
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=39&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
            }
            else if ($("#<%=this.ddlObjectType.ClientID %>").val() == "3") {
                //选择设备
                chooseItem = 54;
                dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=54&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
            }

}

function selectPFormat() {
    chooseItem = 4;
    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&PageCondition=" + SearchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
}

function selectSFormat() {
    chooseItem = 5;
    dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&PageCondition=" + SearchCondition + "&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
       }

       function getChooseValue(list) {
           if (chooseItem == 1) {

               $("#<%=this.txtValue.ClientID %>").val(list[0][2] == "" ? "ALL" : list[0][2]);
               $("#<%=this.txtVer.ClientID %>").val(list[0][3]);
           } else if (chooseItem == 39) {
               $("#<%=this.txtValue.ClientID %>").val(list[0][1]);
            } else if (chooseItem == 54) {
                $("#<%=this.txtValue.ClientID %>").val(list[0][1]);
            }
            else if (chooseItem == 4) {
                var preFix = $("#<%=this.txtPrefix.ClientID %>").val().trim();
                $("#<%=this.txtPrefix.ClientID %>").val(preFix + list[0][1]);
            }
            else if (chooseItem == 5) {
                var sufFix = $("#<%=this.txtSuffix.ClientID %>").val().trim();
                $("#<%=this.txtSuffix.ClientID %>").val(sufFix + list[0][1]);
            }
    chooseItem = 0;
        }

        function setSeq(obj) {
            var currentSeq = parseInt($("#<%=this.txtCurrent.ClientID%>").val());
            if (parseInt(obj.value) > currentSeq) {
                $("#<%=this.txtCurrent.ClientID%>").val(obj.value);
            }
        }
    </script>
</asp:Content>
