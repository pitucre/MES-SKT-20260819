<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="MsdBakeOut.aspx.cs" Inherits="SKT.LeanMES.Web.MSD.MsdBakeOut" %>

<%@ Import Namespace="Resources" %>
<%@ Import Namespace="SKT.LeanMES.Web" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">GRN <em>*</em>
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtGrn" runat="server" ClientIDMode="Static"></asp:TextBox>
                &nbsp;<label id="labtxt" class="redtext" style="color: red"></label>
            </td>

        </tr>
        <tr id="trRemark">
            <td class="Label2">备注 
            </td>
            <td class="Field3">
                <asp:TextBox ID="txtRemark" runat="server" ClientIDMode="Static"></asp:TextBox>
                &nbsp;<label id="labremark" class="redtext" style="color: red"></label>
            </td>

        </tr>
    </table>
    <table id="tblBody" class="ListTable" style="border-width: 0px; width: 100%; border-collapse: collapse;" cellspacing="0" cellpadding="2">
        <tr class="ListTableHeader">

            <th scope="col">GRN</th>
            <th scope="col">物料编码</th>
            <th scope="col">物料名称</th>
            <th scope="col">标准烘烤时长</th>
            <th scope="col">已烘烤时长</th>
            <th scope="col">烘烤状态</th>
            <th scope="col">扫描时间</th>
            <th scope="col">备注</th>
            <th scope="col">操作</th>
        </tr>
    </table>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript">

    var ss = new Array();
    var xmlBake = "<Root>";


    $(function() {

        /*扫描条码*/
        $("#txtGrn").on("keydown", function (e) {
                var curKey = 0, e = e || window.event;
                curKey = e.keyCode || e.which || e.charCode;
                if (curKey == 13) {
                    var grn = $("#txtGrn").val(); 
                    var ajax = SKT.LeanMES.Web.MSD.MsdBakeOut.GetInfo(grn);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
                    

                    var entity = eval(ajax.value);
                    if (entity.SerialNumber !=null) {
                        if (isRepeat(entity)) {

                        if (entity.EncapStauts != 4) {
                             $("#labtxt").text('未查到该GRN的烘烤记录信息');
                             return false;
                        }


                        if (entity.ActualHours < entity.BakeHours) {
                             $("#labtxt").text('实际烘烤时间小于标准烘烤时间');
                             return false;
                        }
                       
                        var remark = $("#txtRemark").val(); 
                        var scanTime = formatDateTime(entity.ScanTime);
                        var tab = document.getElementById("tblBody");
                        var row = tab.insertRow(-1);
                        var cell1 = row.insertCell(-1).innerHTML = entity.SerialNumber;
                        var cell2 = row.insertCell(-1).innerHTML = entity.ItemCode;
                        var cell3 = row.insertCell(-1).innerHTML = entity.ItemName;
                        var cell4 = row.insertCell(-1).innerHTML = entity.BakeHours;
                        var cell5 = row.insertCell(-1).innerHTML = entity.ActualHours;
                        var cell9 = row.insertCell(-1).innerHTML = entity.BakeStauts;
                        var cell6 = row.insertCell(-1).innerHTML = scanTime;
                        var cell7 = row.insertCell(-1).innerHTML = remark;
                        var cell8 = row.insertCell(-1).innerHTML = "<a href='javascript:void(0);' onclick=\"deleteRow(this,'tblBody','"+entity.SerialNumber+"')\">删除</a>";
                        ss.push(entity);

                       xmlBake += "<Bake SerialNumber='"+entity.SerialNumber+"' Remark='"+remark+"'></Bake>";
                       $("#txtRemark").val("");
                       $("#labremark").text("");
                       $("#labtxt").text("");
                       $("#txtGrn").val("");
                        }
                    } else {
                        alert("该GRN当前未进行烘烤！");
                    }
                   
                }
        });
     
 

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

     function ForceOut() {
        
        if (confirm("是否强制取出物料")) {
            if ($("#txtRemark").val() == "") {
                $("#labremark").text("备注信息不能为空");
                return false;
            }
                    var grn = $("#txtGrn").val(); 
                    var ajax = SKT.LeanMES.Web.MSD.MsdBakeOut.GetInfo(grn);
                    if (ajax.error != null) {
                        alert(ajax.error.Message);
                        return false;
                    }
      
                    var entity = eval(ajax.value);
                    if (entity.SerialNumber !=null) {
                        if (isRepeat(entity)) {

                        if (entity.EncapStauts != 4) {
                             $("#labtxt").text('未查到该GRN的烘烤记录信息');
                             return false;
                        }
                        var remark = $("#txtRemark").val(); 
                        var scanTime = formatDateTime(entity.ScanTime);
                        var tab = document.getElementById("tblBody");
                        var row = tab.insertRow(-1);
                        var cell1 = row.insertCell(-1).innerHTML = entity.SerialNumber;
                        var cell2 = row.insertCell(-1).innerHTML = entity.ItemCode;
                        var cell3 = row.insertCell(-1).innerHTML = entity.ItemName;
                        var cell4 = row.insertCell(-1).innerHTML = entity.BakeHours;
                        var cell5 = row.insertCell(-1).innerHTML = entity.ActualHours;
                        var cell9 = row.insertCell(-1).innerHTML = entity.BakeStauts;
                        var cell6 = row.insertCell(-1).innerHTML = scanTime;
                        var cell7 = row.insertCell(-1).innerHTML = remark;
                        var cell8 = row.insertCell(-1).innerHTML = "<a href='javascript:void(0);' onclick=\"deleteRow(this,'tblBody','"+entity.SerialNumber+"')\">删除</a>";
                        ss.push(entity);

                         xmlBake += "<Bake SerialNumber='"+entity.SerialNumber+"' Remark='"+remark+"'></Bake>";
                       $("#txtRemark").val("");
                       $("#labremark").text("");
                       $("#labtxt").text("");
                        }
                    } else {
                        alert("GRN错误或不在差异清单中");
                    }

        }
    }

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
            return;
        }
       if (xmlBake.indexOf('</Root>') < 0) {
            xmlBake += "</Root>";
        }
        var ajax = SKT.LeanMES.Web.MSD.MsdBakeOut.BatchOutBake(xmlBake);

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
