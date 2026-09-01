<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MsdBakeEdit.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdBakeEdit" %>
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
                烤箱编码<em>*</em>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtContainerCode" runat="server" ClientIDMode="Static" IsRequired="1"  ></asp:TextBox>
                <input type="button" id="btnSelectItem" runat="server" class="ButtonBox" value="..."  title="Select" onclick="openChoosePage1(605);" />
                <asp:HiddenField ID="hdnContainerId" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnQty" runat="server" Value="0" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnUseQty" runat="server" Value="0" ClientIDMode="Static" />
             </td>
             <td class="Label2">
                烤箱名称
            </td>
            <td class="Field3" >
                <label id="lblContainerName"></label>
            </td>
             <td class="Label2">
                可载数量
            </td>
            <td class="Field2" >
                <label id="lblQty"></label>
            </td>
           
        </tr>
        <tr>
            <td class="Label2">
                烘烤条件<em>*</em>
            </td>
            <td class="Field4">
                <asp:TextBox ID="txtMslString" runat="server" ClientIDMode="Static" IsRequired="1"  ></asp:TextBox>
                <input type="button" id="Button1" runat="server" class="ButtonBox" value="..."   title="Select" onclick="openChoosePage2(821);" />
                <asp:HiddenField ID="hdnBid" runat="server" Value="-1" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnMaxTemp" runat="server" Value="0" ClientIDMode="Static" />
                <asp:HiddenField ID="hdnMinTemp" runat="server" Value="0" ClientIDMode="Static" />
             </td>
             <td class="Label2">
                封装厚度(mm)
            </td>
            <td class="Field3">
                <label id="lblmm"></label>
            </td>
             <td class="Label2">
                烘烤温度(℃)
            </td>
            <td class="Field3">
             <label id="lblC"></label>
            </td>
        </tr>
        <tr>
           <td class="Label2">
                烘烤时长(h)<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtH" runat="server" ClientIDMode="Static" IsRequired="1" onkeyup="if(isNaN(value))execCommand('undo');this.value=this.value.replace(/\D/gi,'')"
                       onblur='this.value=this.value.replace(/\D/gi,"")'     onafterpaste="if(isNaN(value))execCommand('undo')"  MinValue='1' ReadOnly="true"></asp:TextBox>
            </td>
           <td class="Label2" style="width: 18%;">
                当前温度(℃ )<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtTemp" runat="server" ClientIDMode="Static" IsRequired="1" onkeyup="if(isNaN(value))execCommand('undo');this.value=this.value.replace(/\D/gi,'')"
                       onblur='this.value=this.value.replace(/\D/gi,"")'     onafterpaste="if(isNaN(value))execCommand('undo')"  MinValue='1'></asp:TextBox>
            </td>
            <td class="Label2">
                物料条码<em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtGrn" runat="server" ClientIDMode="Static"  ></asp:TextBox>
            </td>
             
        </tr>
       
    </table>
    <div style="text-align:center;"><label id="labtxt" class="redtext" style="color:red"></label></div>
    <table id="tblBody" class="ListTable" style="border-width:0px;width:100%;border-collapse:collapse; margin-top:5px;" cellspacing="0" cellpadding="2">
        <tr class="ListTableHeader">
          
              <th scope="col">物料条码</th>
              <th scope="col">物料编码</th>
              <th scope="col">物料名称</th>
              <th scope="col">MSD等级</th>
              <th scope="col">烘烤时长</th>
              <th scope="col">扫描时间</th>
        </tr>
    </table>
<%-- <script src="../Content/js/jquery-3.1.0.min.js"></script>--%>
<script type="text/javascript">

    var ss = new Array();
    var xmlBake = "<Root>";
    var fa = 1;
    //烤箱编码
    function openChoosePage1(flags) {
        fa = 1;
        var condition = "ContainerType=2";
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
    //烘烤条件
    function openChoosePage2(flags) {
        fa = 2;
        //var condition = "1=1";
        var condition = "";

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
        $("#txtGrn").keydown(function (e) {
                var curKey = 0, e = e || window.event;
                $("#labtxt").text("");
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var grn = $.trim($("#txtGrn").val());
                    var temperature = $.trim($("#txtTemp").val());
                    var BakeHoursVal = $.trim($("#txtH").val());
                    var MaxNum = $.trim($("#hdnMaxTemp").val());
                    var MinNum = $.trim($("#hdnMinTemp").val());
                    var nowNum = $.trim($("#txtTemp").val());
                    if (temperature == "") {
                        $("#labtxt").text('请输入烤箱设定温度值');
                        return false;
                    }
                    if (parseInt(MaxNum) < parseInt(nowNum) || parseInt(MinNum) > parseInt(nowNum)) {
                        $("#labtxt").text("当前温度与烘烤箱烘烤温度不符");
                        return false;
                    }

                    if (BakeHoursVal == "") {
                        $("#labtxt").text('请输入烘烤时长(H)');
                        return false;
                    }
                    if (parseFloat(BakeHoursVal) <= 0) {
                        $("#labtxt").text('请输入正确的烘烤时长(H)！');
                        return false;
                    }
                    var result = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.GetMateriaStatus(grn);
                    if (result.error != null) {
                        $("#labtxt").text(result.error.Message);
                        return false;
                    }
               
                    if (result.value == "11")
                    {
                        $("#labtxt").text('物料已报废！');
                        return false;
                    }

                    var ajax = SKT.LeanMES.Web.MSD.MsdBakeEdit.GetInfoItemBake(parseInt(temperature), grn);
                    if (ajax.error != null) {
                        $("#labtxt").text(ajax.error.Message);
                        return false;
                    }
                   
                   
                    var entity = eval(ajax.value);
                    if (entity != null) {
                         if (entity.BakeCount <= entity.AlreadyBakeCount) {
                            $("#labtxt").text('烘烤次数已达最大数');
                            return false;
                         }

                        if (isRepeat(entity)) {
                        var scanTime = formatDateTime(entity.ScanTime);
                        var tab = document.getElementById("tblBody");
                        var row = tab.insertRow(-1);
                        var cell1 = row.insertCell(-1).innerHTML = entity.SerialNumber;
                        var cell2 = row.insertCell(-1).innerHTML = entity.ItemCode;
                        var cell3 = row.insertCell(-1).innerHTML = entity.ItemName;
                        var cell4 = row.insertCell(-1).innerHTML = entity.MSL;
                        var cell5 = row.insertCell(-1).innerHTML = BakeHoursVal;
                        var cell6 = row.insertCell(-1).innerHTML = scanTime;
                         ss.push(entity);
                         xmlBake += "<Bake SerialNumber='" + entity.SerialNumber + "' Temperature='" + temperature + "'  BakeHours='" + BakeHoursVal + "' ScanTime='" + scanTime + "'></Bake>";
                        }
                        $("#txtGrn").val("");

                    } else {
                     $("#labtxt").text("GRN错误或不在差异清单中");
                      
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
            $("#labtxt").text("没有检测到放入数据行");
           
            return false;
        }
        if (xmlBake.indexOf('</Root>')<=0) {
             xmlBake += "</Root>";
        }

        var ajax=SKT.LeanMES.Web.MSD.MsdBakeEdit.BatchAddBake(hdnContainerId, xmlBake);
        if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess%>');
            parent.window.UpdateList();

    }

    function getChooseValue(list) {
        if (fa == 1) {
            $("#txtContainerCode").val(list[0][2]);
            $("#hdnContainerId").val(list[0][0]);
            $("#lblContainerName").text(list[0][1]);
            $("#hdfQty").val(list[0][3]);
            $("#hdnUseQty").val(list[0][4]);
            $("#lblQty").text(list[0][3] - list[0][4]);
        }
        else if (fa == 2) {
            $("#txtMslString").val(list[0][1]);
            $("#hdnBid").val(list[0][0]);
            $("#hdnMaxTemp").val(list[0][5]);
            $("#hdnMinTemp").val(list[0][6]);
            $("#lblmm").text(list[0][2]);
            $("#lblC").text(list[0][6] + "~" + list[0][5]);
            $("#txtH").val(list[0][4]);
        }


    }
    //烘烤时当前温度与烤箱温度范围校验
    $("#txtTemp").keydown(function (e) {
        var curKey = 0, e = e || window.event;
          curKey = e.keyCode || e.which || e.charCode;
        if (curKey == 13) {
            ChekTemp();
        }
    });

    $("#txtTemp").blur(function () {
            ChekTemp();
    });

    function ChekTemp() {
         var MaxNum = $.trim($("#hdnMaxTemp").val());
         var MinNum = $.trim($("#hdnMinTemp").val());
         var nowNum = $.trim($("#txtTemp").val());
         var Container = $.trim($("#txtContainerCode").val());
         if (Container == "") {
             $("#labtxt").text("请选择烤箱");
             $("#txtTemp").val("");
             return false;
         }
         else {
             $("#labtxt").text("");
         }
         if (parseInt(MaxNum) < parseInt(nowNum) || parseInt(MinNum) > parseInt(nowNum)) {
             $("#labtxt").text("当前温度与烘烤箱烘烤温度不符");
             //$("#txtTemp").val("");
             $("#txtTemp").focus().select();
             return false;
         }
         else {
             $("#labtxt").text("");
         }
       //$("#labtxt").text("");
     }
</script>
</asp:Content>

   