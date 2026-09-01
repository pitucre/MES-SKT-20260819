<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="True"
    CodeBehind="StationParamView.aspx.cs" Inherits="SKT.LeanMES.Web.Product.StationParamView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="Server">
        <style>
        .ListTableTitleNew {
                align-items: center;
                height: 20px;
                background: #f7f7f7 url(/Content/images/l_bg_hover.gif) repeat-x;
                border-top: 1px solid #d3d3d3;
                border-left: 1px solid #d3d3d3;
                border-right: 1px solid #d3d3d3;
                border-bottom: 0px solid #d3d3d3;
                font-weight: bold;
                padding-top: 6px;
                padding-left: 10px;
                position: relative;
                font-family: Verdana, 微软雅黑,黑体, 宋体;
                font-size: 12px;
        }
    </style>
    <table width="99%" class="ContentTable" style="margin-bottom:5px;">
        <tr>
            <td class="Label2">
                <%= Resources.lang.ItemsName %>
            </td>
            <td class="Field2">
                <asp:Label ID="lblItemName" runat="server" ClientIDMode="Static"></asp:Label>
            </td>
            <%--<td class="Label2">
                <%= Resources.lang.StationName%><em>*</em>
            </td>
            <td class="Field2">
                <asp:TextBox ID="txtStation" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                    type="button" id="btnSelectStation" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseBom %>"
                    onclick="selectStation();"  />
                <asp:HiddenField ID="hdnStationId" runat="server" Value="-1" />
            </td>--%>
        </tr>
    </table>

    <table id="tableParam" width="99%" class="ListTable" cellpadding="3px" cellspacing="3px">
        <thead>
            <tr class="ListTableTitleNew" style="text-align: center">
                <th style="width: 20%">
                    序号
                </th>
                <th style="width: 40%">
                    参数名称
                </th>
                <th style="width: 40%">
                    参数值
                </th>
            </tr>
        </thead>
        <tr class='ListTableOddRow'><td colspan="3" align="center">暂无数据.</td></tr>
    </table>
    <script type="text/javascript">
        var itemId = <%= Request.QueryString["ID"].ToString()%>
         var stationId = <%= Request.QueryString["StationId"].ToString()%>

         $(document).ready(function(){
           ShowParamList(itemId,stationId);
         })

        /* 清空指定table中数据 */
        function clearWaitGrnTable() {
            if ($("#tableParam tr").length > 1) {
                $("#tableParam tr:not(:first)").remove();
            }
        }
        //显示已配置参数列表
        function ShowParamList(itemId,stationId)
        {        
            //if(stationId == -1){return;}
            if(itemId == -1){$("#lblItemName").text("无产品信息.");}

            clearWaitGrnTable();
            var tableParam = document.getElementById("tableParam");                
            var row , cel;

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetStationParamList(itemId,-1);    
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var entity = ajax.value ,i = 0;    
            for(i = 0 ; i < entity.length ; i++){
                row = tableParam.insertRow(tableParam.rows.length);
                row.className = ( i%2 == 0 ? "ListTableOddRow" : "ListTableEvenRow");

                cel = row.insertCell(0);
                cel.innerHTML = entity[i].ParamSeq;

                cel = row.insertCell(1);
                cel.innerHTML =  entity[i].ParamName;

                cel = row.insertCell(2);
                cel.innerHTML = entity[i].ParamValue;
            } 
            if(i==0){
                $(tableParam).append("<tr class='ListTableOddRow'><td colspan='3' align='center'>暂无数据.</td></tr>");
            }  
        }
        //选择工位
//        function selectStation() {
//            chooseFlag = 6;
//            var searchCondition = " Property ='Unit' ";
//            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=8&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
//        }
//        function getChooseValue(list) {
//             if (chooseFlag == 6) {
//                $("#this.txtStation.ClientID ").val(list[0][1]);
//                $("#this.hdnStationId.ClientID ").val(list[0][0]);

//              
//              var txtStationId = $("#this.hdnStationId.ClientID").val();
//      
//              ShowParamList(itemId,txtStationId);
//            
//            }
//            chooseFlag = 0;
//        }
    </script>
</asp:Content>
