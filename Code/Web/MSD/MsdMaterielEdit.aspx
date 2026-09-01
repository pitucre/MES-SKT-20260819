<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MsdMaterielEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdMaterielEdit" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label1">
                产品编号<em>*</em>
            </td>
            <td class="Field1">
                 <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" Enabled="false" ClientIDMode="Static" Width="64%">
                        </asp:TextBox><input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..."
                            title="Select" onclick="openChoosePage(603);" /><em>*</em>
                        <asp:HiddenField ID="hdnItemId" runat="server" Value="-1" ClientIDMode="Static" />
               
            </td>
        </tr>
         <tr>
            <td class="Label1">
                产品名称<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtItemName" runat="server" ClientIDMode="Static" IsRequired="1" ReadOnly="True" 
                    CssClass="TextBox" MaxLength="30"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                MSD等级<em>*</em>
            </td>
            <td class="Field1">
                 <asp:DropDownList ID="ddlMSL" runat="server" ClientIDMode="Static" Width="80px">
                            </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="Label1">
                暴露时长（h）<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtFloorLife" runat="server" ClientIDMode="Static"  ReadOnly="True" IsRequired="1" MaxLength="7"
                    CssClass="TextBox" MinValue='1'></asp:TextBox>
            </td>
        </tr>
        <tr class="isBakeContainer">
            <td class="Label1">
                烘烤次数<em>*</em>
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtBakeCount" runat="server" ClientIDMode="Static" IsRequired="1" ReadOnly="True" 
                    CssClass="TextBox" MaxLength="7"></asp:TextBox> 
            </td>
        </tr>
        <tr>
            <td class="Label1">
               备注
            </td>
            <td class="Field1">
                <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" CssClass="TextArea"
                    ClientIDMode="Static" MaxLength="100"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table id="infotab">
       
    </table>
    <script type="text/javascript">
        var msdContainerId = '<%=Request.QueryString["ID"]%>';

        $().ready(function () {
            $("#ddlMSL").bind("change", function () {
                getMSLInfo(this.value);
            });
        });


         function getMSLInfo(mslId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMSD.GetMSLInfo(mslId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                var entity = ajax.value;
                if (entity != null) {
                    $("#<%=this.txtFloorLife.ClientID%>").val(entity.FloorLife);
                  
                    $("#<%=this.txtBakeCount.ClientID%>").val(entity.BakeCount);
                }
            }
        }


        function openChoosePage(flags) {
            var condition = "";
            dialog({
                title: "<%= Common.ChooseWindow %>",
                src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                    flags +
                    "&Multiple=false&SearchCondition=" +
                    condition +
                    "&rnd=" +
                    Math.random(),
                width: 600,
                height: 300

            });
        }


        function getChooseValue(list) {
            
            $("#txtItemName").val(list[0][1]);
            $("#txtItemCode").val(list[0][2]);
          $("#hdnItemId").val(list[0][0]);

               
        }


        $("#txtGRN").on("keydown", function (e) {
            var curKey = 0, e = e || window.event;
            curKey = e.keyCode || e.which || e.charCode;
            if (curKey == 13) {
              
                $("#msg").html("");
                var grn = $("#txtGRN").val();
                if (grn == "") {
                    CheckDifferenceList(CheckListNo);
                    return false;
                }
                var flag = true;
                for (var i = 0; i < $("#infotab tbody tr").length; i++) {
                    if (grn == $($("#infotab tbody tr")[i]).find("td:eq(0)").html()) {
                        for (var i = 0; i < CheckDifferenceListss.length; i++) {
                            if ($("#txtGRN").val() == CheckDifferenceListss[i].GRN) {
                                $("#infotab tbody").html('');
                                var htmlstr = "";
                                var value = CheckDifferenceListss[i].StockQty - CheckDifferenceListss[i].BalanceQty;
                                htmlstr += "<tr><td>" + CheckDifferenceListss[i].GRN + "</td>"
                                        + "<td>" + CheckDifferenceListss[i].BalanceQty + "</td>"
                                        + "<td>" + CheckDifferenceListss[i].StockQty + "</td>"
                                        + (value >= 0 ? "<td style='background:#7FFF00'>" + value + "</td>" : "<td style='background:red'>" + value + "</td>")
                                        + "<td><input type='text' name='qty' class='TextBox' isnumber='1' value='" + CheckDifferenceListss[i].NowQty + "'/></td>"
                                        + "</tr>";

                                $("#infotab tbody").html(htmlstr);
                                $("#infotab").table("refresh");
                                flag = false;
                                $("#infotab tbody").find("input[name='qty']").focus().select();
                                return true;
                            }
                        }
                    }
                }
                if (flag) {
                    confirmDialog("GRN错误或不在差异清单中");
                    return;
                }
            }
        });

            /*保存数据*/
                function Save() {
                    var itemId = $("#<%=this.hdnItemId.ClientID%>").val();
                    var bakeCount = $.trim($("#<%=this.txtBakeCount.ClientID%>").val());
                    var floorLife = $("#<%=this.txtFloorLife.ClientID%>").val();
                    var remark = $("#<%=this.txtRemark.ClientID%>").val();
                    var msl = $("#<%=this.ddlMSL.ClientID%>").find("option:selected").text();          

                    var entity = {};
                    entity.ItemId = parseInt(itemId);
                    entity.MsdLevel = msl;
                    entity.BakeCount = parseInt(bakeCount);
                    entity.FloorLife = parseInt(floorLife);       
                    entity.Remark = remark;
                    if (itemId == -1) {
                           alert("请选择产品");
                            return false;
                        
                    }
                    var ajax = SKT.LeanMES.Web.MSD.MsdMaterielEdit.Edit(entity);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }

                    alert('<%=Resources.Messages.SaveInSuccess%>');
                    parent.window.UpdateList();
                     
                }
    </script>
</asp:Content>
