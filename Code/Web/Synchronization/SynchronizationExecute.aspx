<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="SynchronizationExecute.aspx.cs" Inherits="SKT.LeanMES.Web.Synchronization.SynchronizationExecute" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">    
    <div id="Synchronization_DIV">        
        <div class="infoTips">
            存储过程参数信息
        </div>
        <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px;
            min-width: 760px; width: 100%; overflow: auto; border-collapse: collapse;" id="tabParamter">
            <tr style="min-height: 30px;"  class="ListTableHeader">
                <th style="width: 150px;">
                    业务名称
                </th>
                <th style="width: 150px">
                    存储过程名称
                </th>
                <th>
                    参数
                </th>
            </tr>
        </table>
        <table style="border-collapse: inherit;" width="100%">
            <tr>
                <td align="center" style="text-align:center">
                    <input type="button" onclick="onSynchronization()" value="同步" class="button"/>
                </td>
            </tr>
        </table>
    </div>
    <div style=" height:38px; ">
        <div id="loading" style="display: none; z-index: 111;">
            <div style="background: #cccccc; position: absolute; z-index: 112; top: 0; left: 0px;
                filter: Alpha(opacity=60); -moz-opacity: 0.6; opacity: 0.6;" id="loading-bg">
            </div>
            <div style="position: absolute; top: 35%; left: 35%; z-index: 113; background: #f7f7f7;
                width: 360px; border: 1px solid #333333; height: 65px; line-height: 65px; text-align: center;"
                id="loading-content">
                正在同步数据，请不要关闭页面...
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#loading").css("display", "none");
            $("#error").css("display", "none");
            
            var arrEntity = SKT.LeanMES.Web.AjaxServices.AjaxSynchronization.GetAll('<%=Request.QueryString["ID"].ToString() %>');
            if (arrEntity.error != null) {
                return false;
            }
            
            var entitys = arrEntity.value;
            var html = setProcParameter(entitys);
            //for (var i = 0; i < entity.length; i++) {
            //    html += " <input type=\"button\" onclick=\"onSynchronization('" + entity[i].StoredProcedureName + "'," + entity[i].Timeout + ")\" value=\"" + entity[i].BusinessName + "\" />";
            //}
            $("#Synchronization_DIV").html(html);
        });

        function setProcParameter(entitys) {
            var tabHasProc = ";";

            var tabParamter = document.getElementById("tabParamter");
            for (var i = 0; i < entitys.length; i++) {
                var procName = entitys[i].ProcName;
                
                //当前的存储过程已经存在，则下一个
                if (tabHasProc.indexOf(";" + procName + ";") >= 0) {
                    continue;
                }
                tabHasProc = tabHasProc + procName + ";";

                rowNewIdx = tabParamter.rows.length;
                row = tabParamter.insertRow(rowNewIdx);
                row.className = "ListTableOddRow";
                row.tagName = "trParameter";

                //业务名称
                cell = row.insertCell(0);
                cell.align = "center";
                cell.innerHTML = entitys[i].BusinessName

                //存储过程名称
                cell = row.insertCell(1);
                cell.align = "center";
                cell.innerHTML = procName;

                //参数
                cell = row.insertCell(2);
                cell.align = "center";
                cell.valign = "top"
                var innerXml = "";
                for (parameterIndex = 0; parameterIndex < entitys.length; parameterIndex++) {
                    if (entitys[parameterIndex].ProcName == procName) {
                        if ($.trim(entitys[parameterIndex].ParameterName) != "") {
                            innerXml = innerXml + '<tr class="ListTableOddRow" name="trParameter">' +
                                '<td>' + entitys[parameterIndex].ParameterName +
                                '</td><td>' + entitys[parameterIndex].ParameterType +
                                '</td><td>' + entitys[parameterIndex].Maxlength +
                                '</td><td>' + '<input type="text" name="txtParameterValue" value="" style="width:95%" />' +
                                '</td>';
                            innerXml = innerXml + "</tr>";
                        }
                    }
                }

                if (innerXml != "") {
                    cell.innerHTML = '<table border="0" width="100%">' +
                        '<tr class="ListTableHeader"><th>参数名</th><th>参数类型</th><th>参数长度</th><th>参数值</th></tr>' +
                        innerXml +
                      '</table>';
                }
                else {
                    cell.innerText = "无";
                }
            }
        }

        function onSynchronization() {
            if (!confirm("数据同步可能会涉及远程服务器，需要一点时间，在此期间请不要关闭页面。确定现在进行同步数据吗？")) {
                return false;
            }

            $("#loading").css("display", "block");
            $("#loading").width($(window).width());
            $("#loading").height($(window).height());
            $("#loading-bg").width($(window).width());
            $("#loading-bg").height($(window).height());
            
            var parms = [];
            var trProc = document.getElementById("tabParamter");
            for (i = 1; i < trProc.rows.length; i++) {
                var trParameters = $(trProc.rows[i]).find("tr[name='trParameter']");
                if (trParameters.length > 0) {
                    for (j = 0; j < trParameters.length; j++) {
                        var parm = {};
                        parm.BusinessName = $.trim(trProc.rows[i].cells[0].innerText);
                        parm.ProcName = $.trim(trProc.rows[i].cells[1].innerText);

                        parm.ParameterName = $.trim(trParameters[j].cells[0].innerText);
                        parm.ParameterType = $.trim(trParameters[j].cells[1].innerText);
                        parm.Maxlength = $.trim(trParameters[j].cells[2].innerText);
                        parm.ParameterValue = $.trim(trParameters.find("input[name='txtParameterValue']").val());
                        parms.push(parm);
                    }
                }
                else {
                    var parm = {};
                    parm.BusinessName = $.trim(trProc.rows[i].cells[0].innerText);
                    parm.ProcName = $.trim(trProc.rows[i].cells[1].innerText);

                    parm.ParameterName = "";
                    parm.ParameterType = "";
                    parm.Maxlength = "-1";
                    parm.ParameterValue = "";
                    parms.push(parm);
                }

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSynchronization.ExecuteNonQuery(parms);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    $("#loading").css("display", "none");
                    $("#c").css("display", "block");
                    $("#error").html(ajax.error.Message);
                    return;
                }
                parms.splice(0, parms.length);
            }            
            $("#loading").css("display", "none");
            alert("同步成功！");
            parent.window.Refresh();
        }

    </script>
</asp:Content>
