<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MsdEncapsulationIn.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdEncapsulationIn" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
  <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
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
            <td class="Label2">
                恒温箱编码<em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtContainerCode" runat="server" ClientIDMode="Static" IsRequired="1"  ></asp:TextBox>
              <input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..."
                            title="Select" onclick="openChoosePage(605);" />
                        <asp:HiddenField ID="hdnContainerId" runat="server" Value="-1" ClientIDMode="Static" />
                 </td>
             <td class="Label2">
                恒温箱名称<em>*</em>
            </td>
            <td class="Field2" colspan="3">
                <label id="lblContainerName"></label>
            </td>
           
        </tr>
        <tr>
             <td class="Label2">
                最大存放数
            </td>
            <td class="Field3">
                <label id="lblMaxTemp"></label>
            </td>
             <td class="Label2">
                可载数量
            </td>
            <td class="Field3">
             <label id="lblMinTemp"></label>
            </td>
             <td class="Label2">
                温度<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtTemp" runat="server" ClientIDMode="Static" IsRequired="1" MaxLength="5" MinValue='1'></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2">
                物料条码 <em>*</em>
            </td>
            <td class="Field3" colspan="5">
                <asp:TextBox ID="txtGrn" runat="server" ClientIDMode="Static"  ></asp:TextBox>
            </td>
             
        </tr>
       
    </table>
    <table id="tblBody" class="ListTable" style="border-width:0px;width:100%;border-collapse:collapse;" cellspacing="0" cellpadding="2">
        <tr class="ListTableHeader">
          
              <th scope="col">物料条码</th>
              <th scope="col">物料编码</th>
            <th scope="col">物料名称</th>
              <th scope="col">烘烤时长</th>
              <th scope="col">扫描时间</th>
        </tr>
    </table>
 <script src="../Content/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript">

    var ss = new Array();
    var xmlBake = "<Root>";
    function openChoosePage(flags) {
        var condition = "ContainerType=2";
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

    $(function() {
        /*扫描条码*/
        $("#txtGrn").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var grn = $("#txtGrn").val();
                    var temperature = $("#txtTemp").val();
                    var ajax = SKT.LeanMES.Web.MSD.MsdBakeEdit.GetInfoItemBake(temperature, grn);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    var entity = eval(ajax.value);
                    if (entity != null) {
                        if (isRepeat(entity)) {
                            var scanTime = formatDateTime(entity.ScanTime);
                        var tab = document.getElementById("tblBody");
                        var row = tab.insertRow(-1);
                        var cell1 = row.insertCell(-1).innerHTML = entity.SerialNumber;
                        var cell2 = row.insertCell(-1).innerHTML = entity.ItemCode;
                        var cell3 = row.insertCell(-1).innerHTML = entity.ItemName;
                        var cell4 = row.insertCell(-1).innerHTML = entity.HoursNum;
                        var cell5 = row.insertCell(-1).innerHTML = scanTime;
                         ss.push(entity);
                    xmlBake += "<Bake SerialNumber='"+entity.SerialNumber+"'  BakeHours='"+entity.HoursNum+"' ScanTime='"+scanTime+"'></Bake>";
                        }
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
        xmlBake += "</Root>";
        SKT.LeanMES.Web.MSD.MsdBakeEdit.BatchAddBake(hdnContainerId, xmlBake);
       


    }

    function getChooseValue(list) {
        $("#txtContainerCode").val(list[0][2] );
        $("#hdnContainerId").val(list[0][0]);
        $("#lblContainerName").text(list[0][1]);
        $("#lblMaxTemp").text(list[0][3]);
        $("#lblMinTemp").text(list[0][3] - list[0][4]);
    }
</script>
</asp:Content>
