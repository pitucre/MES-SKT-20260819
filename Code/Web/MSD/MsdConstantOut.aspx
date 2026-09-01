<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MsdConstantOut.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdConstantOut" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
  <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                GRN <em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtGrn" runat="server" ClientIDMode="Static"  ></asp:TextBox> &nbsp;<label id="labtxt" class="redtext" style="color:red"></label>
            </td>
             
        </tr>
        <tr id="trRemark">
            <td class="Label2">
                备注 
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRemark" runat="server" ClientIDMode="Static"  ></asp:TextBox>
            </td>
             
        </tr>
    </table>
    <table id="tblBody" class="ListTable" style="border-width:0px;width:100%;border-collapse:collapse;" cellspacing="0" cellpadding="2">
        <tr class="ListTableHeader">
          
            <th scope="col">GRN</th>
            <th scope="col">物料编码</th>
            <th scope="col">物料规格</th>
            <th scope="col">累计时间</th>
            <th scope="col">扫描时间</th>
            <th scope="col">备注</th>
            <th scope="col"> 操作</th>
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
                    var ajax = SKT.LeanMES.Web.MSD.MsdConstantOut.GetInfo(grn);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                     $("#labtxt").text('');
                    $("#txtRemark").val('');
                    var entity = eval(ajax.value);
                    if (entity.SerialNumber !=null) {
                        if (isRepeat(entity)) {
                        if (entity.EncapStatus!="恒温箱") {
                             $("#labtxt").text('未查到该GRN在恒温箱中信息');
                             return false;
                        }
                       
                        var remark = $("#txtRemark").val(); 
                        var scanTime = formatDateTime(new Date());
                        var tab = document.getElementById("tblBody");
                        var row = tab.insertRow(-1);
                        var cell1 = row.insertCell(-1).innerHTML = entity.SerialNumber;
                        var cell2 = row.insertCell(-1).innerHTML = entity.ItemCode;
                        var cell3 = row.insertCell(-1).innerHTML = entity.ItemSpec;
                        var cell5 = row.insertCell(-1).innerHTML = entity.TotalExposeMinute;
                        var cell6 = row.insertCell(-1).innerHTML = scanTime;
                        var cell7 = row.insertCell(-1).innerHTML = remark;
                        var cell8 = row.insertCell(-1).innerHTML = "<a href='javascript:void(0);' onclick=\"deleteRow(this,'tblBody','"+entity.SerialNumber+"')\">删除</a>";
                        ss.push(entity);

                        xmlBake += "<Bake SerialNumber='"+entity.SerialNumber+"' Remark='"+remark+"'></Bake>";
                       $("#txtRemark").val("");
                       $("#txtGrn").val("");

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
        //动态删除行  
    function deleteRow(obj,tab,serialNumber) {
        deleteData(serialNumber);  
        var tr = obj.parentNode.parentNode;  
        var tbody = tr.parentNode;  
        tbody.removeChild(tr);  
        
    } 
    function deleteData(serialNumber) {
   
            for (var i=0; i < ss.length; i++) {
                if (ss[i].SerialNumber == serialNumber) {
                    ss.splice(i, 1);
                }
            }
          
    }

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
    function BakeOut() {

        if (ss.length <= 0) {
            alert("没有检测到取出数据行");
            return false;
        }
        if (xmlBake.indexOf('</Root>') < 0) {
             xmlBake += "</Root>";
        }
      
        var ajax=SKT.LeanMES.Web.MSD.MsdConstantOut.BatchOutThermostat(xmlBake);
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
        $("#lblMaxTemp").text(list[0][3]);
        $("#lblMinTemp").text(list[0][4]);
    }
</script>
</asp:Content>
