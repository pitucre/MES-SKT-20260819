<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MaterialReceive.aspx.cs" Inherits="SKT.LeanMES.Web.MaterialDelivery.MaterialReceive" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%=Resources.lang.SelectEdge%><em>*</em>
            </td>
            <td class="Field1">
                <input type="text" disabled="disabled" value="" id="txtEdge" class="TextBox" />
                <input type="button" id="btnEdge" class="ButtonBox" value="..."
                    onclick="SelectEdge();" />
                <asp:HiddenField ID="hdfEdgeLine" Value="-1" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
                <%=Resources.lang.MinGRN%><em>*</em>
            </td>
            <td class="Field1">
                <input type="text" value="" id="txtGRN" class="TextBox" style="width: 97%; height: 25px;
                    font-size: 13.5px; font-weight: bold; text-transform: uppercase;" />
                <input type="button" id="btnSave" class="ButtonBox" value="..." title="" style="height: 27px;"
                    onclick="Save();" />
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div style="text-align: center;" class="Tips" id="msg">
    </div>
    <div class="clear5">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            物料列表
        </div>
    </div>
    <table class="ListTable" width="100%" id="tblRecHistory">
        <tr class="ListTableHeader">
            <th style="width:10%">
                线边仓
            </th>
            <th style="width:70%">
                物料GRN
            </th>
            <th style="width:10%">
                收料人
            </th>
            <th style="width:10%">
                收料时间
            </th>
        </tr>
    </table>

    <script type="text/javascript">
        $(function () {
            /*扫描GRN包装箱/GRN条码*/
            $("#txtGRN").keydown(function () {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    Save();
                }
            });
        });


        function Save() {

            var edgeId = parseInt($("#<%=this.hdfEdgeLine.ClientID %>").val());
            var edgeName = $("#txtEdge").val();
            var grn = $("#txtGRN").val();
            
            if (edgeId <= 0) {
                $("#msg").html("请选择线边仓!");
                $("#msg").css("color", "red");
                return false;
            }

            if (isNull(grn)) {
                $("#msg").html("请输入或扫描要收料的条码");
                $("#msg").css("color", "red");
                $("#txtGRN").val('').focus();
                return false;
            }

            $("#msg").html("正在收料，请稍后...");
            $("#msg").css("color", "");

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialDelivery.ReceiveMaterialList(grn, edgeId);
            if (ajax.error != null) {
                //SKT.Sound.Play();
                        
                $("#msg").html(ajax.error.Message);
                $("#msg").css("color", "red");
                $("#txtGRN").val('').focus();
                return false;
            }
            //clearWaitGrnTable();
            $("#txtGRN").val("");
            $("#txtGRN").focus();
            $("#msg").html("<%=Resources.Messages.ReceiveGRNSuccessful %>");
            $("#msg").css("color", "green");

            /*查询物料信息*/
            var list = ajax.value;
            if (list == null || list.length == 0) {
                return false;
            }

            var r = "";
            r += "<tr class='ListTableOddRow'>"; /*list[i].PackTime list[i].CreateBy*/
//            r += "<td style='text-align:center'></td>";
//            r += "<td style='text-align:center'>" + list[0].ItemCode + "</td>";
            r += "<td style='text-align:center'>" + list[0].StoreName + "</td>";
            r += "<td style='text-align:center'>" + list[0].SerialNumber + "</td>";
//            r += "<td style='text-align:center'>" + list[0].Quantity + "</td>";
            r += "<td style='text-align:center'>" + list[0].CreateBy + "</td>";
            r += "<td style='text-align:center'>" + list[0].ReceiveDateTime + "</td>";
            r += "</tr>";

            $("#tblRecHistory").append(r);

            $("#txtGRN").focus();
            $("#tblInfo").html("<img src=\"../Content/images/icon/comment.png\" style=\"vertical-align:middle;\" alt=\"\"/>当前共有收料记录：<b>" + ($("#tblRecHistory tr").length - 1).toString() + "</b> 条,本次扫描新增加记录：<b>" + (list.length).toString() + "</b> 条");
        }

        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tblRecHistory tr").length > 1) {
                $("#tblRecHistory tr:not(:first)").remove();
            }
        }

        /*选择线边仓*/
        function SelectEdge() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=52&Multiple=false&rnd=" + Math.random(), width: 400, height: 300 });
        }

        function getChooseValue(list) {
            $("#txtEdge").val(list[0][1]);
            $("#<%=this.hdfEdgeLine.ClientID %>").val(list[0][0])
            $("#txtGRN").focus();
        }

    </script>
</asp:Content>
