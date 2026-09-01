<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="StationParamEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.StationParamEdit"
    Title="Edit StationParam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %></div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemName%>
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <div class="toolBar">
<%--        <div class="toolbar-btn">
            <div class="icon-16-add">
            </div>
            <div class="btn-text" onclick="AddParam()">
                新增参数</div>
            <div id='messageText' style="color: Red">
            </div>
        </div>--%>
    </div>
    <table id="tableParam" width="100%" class="ListTable" cellpadding="0px" cellspacing="0px"
        style="text-align: center">
        <thead>
            <tr class="ListTableHeader" style="text-align: center">
                <th style="width: 10%">
                    序号<em>*</em>
                </th>
                <th style="width: 30%">
                    工序名称<em>*</em>
                </th>
                <th style="width: 20%">
                    参数名称<em>*</em>
                </th>
                <th style="width: 20%">
                    参数值<em>*</em>
                </th>
                <th style="width: 5%">
                    操作
                </th>
            </tr>
        </thead>
        <tr class="ListTableEvenRow">
            <td>
                <input type="text" style="width: 90%" isrequired="1" name="txtSeq" value="1" />
                <input type="hidden" style="display: none" value="-1" name="hdnStationParamId" />
            </td>
            <td class="Field2">
                <input type="hidden" id='hdnStationId' name='hdnStationId' value="-1" />
                <input id="txtStation" class="TextBox" style="width: 90%" isrequired="1" disabled="disabled" />
                <input type="button" id="btnSelectStation" class="ButtonBox" value="..." onclick="selectStation(this);" />
            </td>
            <td>
                <input type="text" style="width: 96%" cssclass="TextBox" isrequired="1" name="txtParamName"
                    onchange="valiDateParam(this)" />
            </td>
            <td>
                <input type="text" style="width: 96%" cssclass="TextBox" isrequired="1" name="txtParamValue" />
            </td>
            <td>
                <input type="button" value="删除" onclick="DeleteParam(this)" />
            </td>
        </tr>
    </table>
    <script type="text/javascript">
         var stationParamId = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>

        $(document).ready(function(){
            ShowParamList();
        });

        //新增一个参数
        function AddParam() {
            var tableParam = document.getElementById("tableParam");
             var count= $("#tableParam tr").length;

            var row, cel

            row = tableParam.insertRow(tableParam.rows.length);
            row.className = "ListTableEvenRow";

            cel = row.insertCell(0);
            cel.innerHTML = '<input type="text" style="width:90%" CssClass="TextBox" IsRequired="1"  MaxLength="50" name="txtSeq" value="'+count+'"/>'+
                            '<input type="hidden" style="display:none" value="-1" name="hdnStationParamId"/>';

            cel = row.insertCell(1);
            cel.innerHTML = "<input type=\"hidden\" id='hdnStationId' name='hdnStationId' value=\"-1\" />"
            + "<input type=\"text\" name=\"txtStation\" class=\"TextBox\" disabled=\"disabled\"  style=\" width:90%;\" IsRequired=\"1\"  MaxLength=\"50\" >"
            + "<input type=\"button\" id=\"btnSelectStation\" onclick=\"selectStation(this);\" class=\"ButtonBox\" value=\"...\" />";

            cel = row.insertCell(2);
            cel.innerHTML = '<input type="text" style="width:96%" CssClass="TextBox" IsRequired="1"  MaxLength="50" name="txtParamName" onchange="valiDateParam(this)" />';

            cel = row.insertCell(3);
            cel.innerHTML = '<input type="text" style="width:96%" CssClass="TextBox" IsRequired="1"  MaxLength="50" name="txtParamValue"/>';

            cel = row.insertCell(4);
            cel.innerHTML = '<input type="button" value="删除" onclick="DeleteParam(this)"/>';

        }    
        //删除一个参数
        function DeleteParam(obj)
        {
            $(obj).parent().parent().remove();
            AgainSorting();
        }
        function AgainSorting() {
            $("#tableParam tr").each(function (index) {
                $(this).find("td").find("[name='txtSeq']").val(index);
            })
        }
         /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tableParam tr").length > 1) {
                $("#tableParam tr:not(:first)").remove();
            }
        }

        //显示已配置参数列表
        function ShowParamList()
        {
             //clearWaitGrnTable();

            var tableParam = document.getElementById("tableParam");
                
            var row , cel;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetStationParamList(stationParamId,-1);

            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else if(ajax.value != null && ajax.value != undefined && ajax.value.length > 0)
           {
                $("#tableParam tr:eq(1)").remove();
                var entity = ajax.value;
              
                for(var i = 0 ; i < entity.length ; i++)
                {       

                    row = tableParam.insertRow( tableParam.rows.length );
                    row.className = "ListTableEvenRow";

                    cel = row.insertCell(0);
                    cel.innerHTML = '<input type="text" style="width:90%" CssClass="TextBox" IsRequired="1"  MaxLength="50" name="txtSeq" value="'+ entity[i].ParamSeq +'"/>'
                                    +'<input type="hidden" style="display:none" name="hdnStationParamId" value="'+ entity[i].StationParamId +'"/>';

                    cel = row.insertCell(1);
                    cel.innerHTML = '<input type=\"hidden\" id=\"hdnStationId\" name=\"hdnStationId\" value="'+ entity[i].StationId +'" />'
                    + "<input type=\"text\" name=\"txtStation\" class=\"TextBox\" disabled=\"disabled\" style=\" width:90%;\" IsRequired=\"1\"  MaxLength=\"50\" value="+ entity[i].Station +" >"
                    + "<input type=\"button\" id=\"btnSelectStation\" onclick=\"selectStation(this);\" class=\"ButtonBox\" value=\"...\" />";

                    cel = row.insertCell(2);
                    cel.innerHTML = '<input type="text" style="width:96%"  CssClass="TextBox" IsRequired="1" MaxLength="50" value="'+ entity[i].ParamName +'" name="txtParamName" onchange="valiDateParam(this)"/>';

                    cel = row.insertCell(3);
                    cel.innerHTML = '<input type="text" style="width:96%"  CssClass="TextBox" IsRequired="1" MaxLength="50"  value="'+ entity[i].ParamValue +'" name="txtParamValue"/>';

                    cel = row.insertCell(4);
                    cel.innerHTML = '<input type="button" value="删除" onclick="DeleteParam(this)"/>';
                }
            }
        }
        var rowValidate=true;
        /*保存数据*/
        function Save() {
            //保存数据
            var isSeq=true;
            var paramXML = '<ParamList>';
            if($("#tableParam tr").length <2){
                alert("没有参数需要保存！");
                return;
            }

            $("#tableParam tr").each(function(i,e)
            {
                if(i > 0)
                {
                    /* XMl转义字符串处理  */
                    var value = $(e).find("[name='txtParamValue']").val();
                    if (value.indexOf("<") >= 0 || value.indexOf(">") >= 0 || value.indexOf("&") >= 0) {
                        value = value.replace(/\&/g, "&amp;").replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
                    }
                    var name = $(e).find("[name='txtParamName']").val();
                    if (name.indexOf("<") >= 0 || name.indexOf(">") >= 0 || name.indexOf("&") >= 0) {
                        name = name.replace(/\&/g, "&amp;").replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
                    }
                    paramXML += '<Data>'
                        paramXML += '<StationParamId>'+$(e).find("[name='hdnStationParamId']").val()+'</StationParamId>'
                        paramXML += '<ParamSeq>'+$(e).find("[name='txtSeq']").val()+'</ParamSeq>'
                        paramXML += '<StationId>'+$(e).find("[name='hdnStationId']").val()+'</StationId>'
                        paramXML += '<ParamName>'+ name.replace(/'/g,"") +'</ParamName>'
                        paramXML += '<ParamValue>'+ value.replace(/'/g,"") +'</ParamValue>'
                    paramXML += '</Data>';

                    if(!isNumber($(e).find("[name='txtSeq']").val())){
                        isSeq=false;
                        alert("序号只能是数字");
                        return false;
                    }
                }
            })

            paramXML +='</ParamList>';
            if(isSeq&&rowValidate){
            var entity = {};

            entity.ItemId=stationParamId;
            entity.ParamName = paramXML;
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.StationParamEdit(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveInSuccess%>')
            parent.window.UpdateList($("#lblItemName").html());
           }
        }
        function valiDateParam(obj){
            var rowValidate = true;
            var trObj=obj.parentElement.parentElement;
            var nowValue= $(trObj).find("[name='hdnStationParamId']").val()+ $(trObj).find("[name='hdnStationId']").val()+ $(trObj).find("[name='txtParamName']").val();
            nowValue = nowValue.replace(/'/g,"");//单引号在这里会有报错，因此必须要去除这个单引号来比较，同时保存的时候也要去除单引号
            var allValue="";
            var rowIndex = trObj.rowIndex;
            var trs = $("#tableParam tr");
            for(i = 1; i < trs.length; i++) {
                var e = trs[i];
                if(rowIndex != i && $(e).find("[name='txtParamName']").val() != ""){
                    allValue = $(e).find("[name='hdnStationParamId']").val() + $(e).find("[name='hdnStationId']").val() + $(e).find("[name='txtParamName']").val(); 
                    allValue = allValue.replace(/'/g,"");
                    if(nowValue==allValue){
                        rowValidate = false;
                        $("#messageText").text("你选择的产品与输入的参数名称和第"+i+"行完全相同,请修改");
                        //alert('同产品同工位的参数名不能相同');
                        break;
                    }
                    else{
                        rowValidate = true;
                    }
                }
            }
            if(!rowValidate){
                $(trObj).find("[name='txtParamName']").css("background-color", "red");
                $(trObj).find("[name='txtParamName']").select();
            }
            else{
                $(trObj).find("[name='txtParamName']").css("background-color","");
            }
            return rowValidate;
        }
        var rowObj="";
        //选择工位
        function selectStation(obj) {
            chooseFlag = 6;
            rowObj=obj.parentElement.parentElement;
            var searchCondition = " Property ='Unit' ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 650, height: 300 });
        }
        function getChooseValue(list) {
             if (chooseFlag == 6) {
                rowObj.cells[1].children[0].value = list[0][0];
                rowObj.cells[1].children[1].value = list[0][1];         
            }
            chooseFlag = 0;
        }
    </script>
</asp:Content>
