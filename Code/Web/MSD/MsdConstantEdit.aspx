<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MsdConstantEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdConstantEdit" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <%--        <tr>
            <td class="Label2">
                操作类型<em>*</em>
            </td>
            <td class="Field2" colspan="5">
                 <asp:RadioButtonList ID="rblEncapsulationType" runat="server" RepeatDirection="Horizontal"
                                CssClass="rbl" CellSpacing="5" CellPadding="3">
                                <asp:ListItem Selected="True" Text="放入" Value="1"></asp:ListItem>
                                <asp:ListItem Text="拿出" Value="2"></asp:ListItem>
                            </asp:RadioButtonList>
            </td>
        </tr>--%>
        <tr>
            <td class="Label2">恒温箱编码<em>*</em>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtContainerCode" runat="server" ClientIDMode="Static" IsRequired="1"></asp:TextBox>
                <input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..."
                    title="Select" onclick="openChoosePage(605);" />
                <asp:HiddenField ID="hdnContainerId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnQty" runat="server" Value="0" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnUseQty" runat="server" Value="0" ClientIDMode="Static" />
            </td>
            <td class="Label2">恒温箱名称
            </td>
            <td class="Field3">
                <label id="lblContainerName"></label>
            </td>
            <td class="Label2">可载数量
            </td>
            <td class="Field2">
                <label id="lblQty"></label>
            </td>
        </tr>
        <tr>
            <td class="Label2">物料条码<em>*</em>
            </td>
            <td class="Field3" colspan="5">
                <asp:TextBox ID="txtGrn" runat="server" ClientIDMode="Static"></asp:TextBox>
                &nbsp;<label id="labtxt" class="redtext" style="color: red"></label>
            </td>

        </tr>

    </table>
    <table id="tblBody" class="ListTable" style="border-width: 0px; width: 100%; border-collapse: collapse;" cellspacing="0" cellpadding="2">
        <tr class="ListTableHeader">

            <th scope="col">物料条码</th>
            <th scope="col">物料编码</th>
            <th scope="col">物料名称</th>
            <th scope="col">扫描时间</th>
        </tr>
    </table>
    <script src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">

    var ss = new Array();
    var xmlBake = "<Root>";
    function openChoosePage(flags) {
        var condition = "ContainerType=1";
        dialog({
            title: "<%= Common.ChooseWindow %>",
            src: "<%= WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=" +
                flags +
                "&Multiple=false&PageCondition=" +
                condition +
                "&rnd=" +
                Math.random(),
            width: 600,
            height: 300

        });
    }

    $(function() {
        /*扫描条码*/
        $("#txtGrn").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                $("#labtxt").text("");
        
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var grn = $("#txtGrn").val();
                    var ajax = SKT.LeanMES.Web.MSD.MsdConstantEdit.GetInfo(grn);
                    if (ajax.error != null) {
                        $("#redtext").text(ajax.error.Message);
                        return false;
                    }

                    var result = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMateriaStatus(grn);
                    if (result.error != null) {
                        $("#labtxt").text(result.error.Message);
                        return false;
                    }

                    if (result.value == "11") {
                        $("#labtxt").text('物料已报废！');
                        return false;
                    }

                    var entity = eval(ajax.value);
                    if (entity != null) {
                        if (isRepeat(entity)) {
                         if (entity.EncapStatus != "已开封") {
                             var encapTxt = "";
                          
                            $("#labtxt").text("该GRN物料非开封状态,状态为："+entity.EncapStatus);
                             return false;
                        }
                         
                        var scanTime = formatDateTime(new Date());
                           
                        var tab = document.getElementById("tblBody");
                        var row = tab.insertRow(-1);
                        var cell1 = row.insertCell(-1).innerHTML = entity.SerialNumber;
                        var cell2 = row.insertCell(-1).innerHTML = entity.ItemCode;
                        var cell3 = row.insertCell(-1).innerHTML = entity.ItemName;
                         var cell6 = row.insertCell(-1).innerHTML = scanTime;
                         ss.push(entity);
                         xmlBake += "<Bake SerialNumber='"+entity.SerialNumber+"'  ScanTime='"+scanTime+"'></Bake>";
                        }
                        $("#txtGrn").val("");
                    } else {
                        alert("GRN错误或不在差异清单中");
                    }
                   
                }
        });
     
        function isRepeat(entity) {
            var isC = true;
            for (var i=0; i < ss.length; i++) {
                if (ss[i].SerialNumber == entity.SerialNumber) {
                    isC = false;
                }
            }
            return isC;

        }

    });


    var formatDateTime = function (date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        var h = date.getHours();
        var minute = date.getMinutes();
        minute = minute < 10 ? ('0' + minute) : minute;
        return y + '-' + m + '-' + d + ' ' + h + ':' + minute;
    };
    function BakeIn() {
        var hdnContainerId = $("#<%=this.hdnContainerId.ClientID%>").val();

       if (ss.length <= 0) {
            alert("没有检测到放入数据行");
            return false;
        }
        if (xmlBake.indexOf('</Root>')<=0) {
             xmlBake += "</Root>";
        }
       
        var ajax=SKT.LeanMES.Web.MSD.MsdConstantEdit.BatchAddThermostat(hdnContainerId, xmlBake);
        if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList();

    }

    function getChooseValue(list) {
        $("#txtContainerCode").val(list[0][2] );
        $("#hdnContainerId").val(list[0][0]);
        $("#lblContainerName").text(list[0][1]);
        $("#hdfQty").val(list[0][3]);
        $("#hdnUseQty").val(list[0][4]);
        $("#lblQty").text(list[0][3]-list[0][4]);
    
    }
    </script>
</asp:Content>
