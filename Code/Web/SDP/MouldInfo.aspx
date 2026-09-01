<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MouldInfo.aspx.cs"
    Inherits="SKT.LeanMES.Web.SDP.MouldInfo" MasterPageFile="~/Masters/EditMaster.master"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <style type="text/css">
        #tbParaItem input[type="text"] { width: 80%; }
    </style>
    <link href="../Content/plugin/tabs/tabs.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/tabs/jPlugin-tabs.js" type="text/javascript" id="masterJsTab"></script>

    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            
            <li title="原料信息">原料信息
            </li>
        </ul>
        <div class="tb_c" style="min-height: 335px; overflow: auto;">
            <div>
                <table class="ListTable" cellspacing="0" cellpadding="4" style="border-width: 0px; min-width: 760px; width: 100%; overflow: auto; border-collapse: collapse;"
                    id="tbParaItem">
                    <tr class="ListTableHeader">
                        <th scope="col" align="center" width="120px">原料
                        </th>
                        <th scope="col" align="center">产品单重
                        </th>
                        <th scope="col" align="center">水口比重
                        </th>
                        <th scope="col" align="center">水口重
                        </th>
                        <th scope="col" align="center">产品重毛重
                        </th>
                        <th scope="col" align="center">周期
                        </th>
                        <th scope="col" align="center">单个毛重
                        </th>
                        
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div class="clear5">
    </div>
    <asp:HiddenField ID="filepaths" runat="server" Value="-1" ClientIDMode="Static" />
    <asp:HiddenField ID="hdnItemId" runat="server" ClientIDMode="Static" Value="-1" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>

    <link href="../Content/plugin/layui/css/layui.css" rel="stylesheet" />
    <script src="../Content/plugin/layui/layui.all.js"></script>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
           
            loadMaterial();
        });
        
        var Flag = 0;
        var MouldCode = '<%=Request.QueryString["MouldCode"]%>';
       
        function loadMaterial() {
          
                var entity = {};
                entity.MouldCode = MouldCode;

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSDP.ExecUDFProc("uspGetMachinedInjectionMoldInfo", JSON.stringify(entity));
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                if (ajax.value.length > 0) {
                    var list = JSON.parse(ajax.value[0]);
                    if (list.length > 0) {
                        for (var i = 0; i < list.length; i++) {
                            AddDetail(list[i]);
                        }
                    }
                }                           
        }
        function AddDetail(entity) {
            if (!entity) {
                entity = {};
                entity.ItemID = -1;
                entity.ItemCode = "";
                entity.ItemSingleWeight = 0;
                entity.SKBWeight = 0;
                entity.SKWeight = 0;
                entity.ItemTotalWeight = 0;
                entity.Weeks = 0;
                entity.SingleWeight = 0;

                if ($("tr[itemID=" + entity.ItemID + "]").length > 0) {
                    alert("请先录入新行数据");
                    return;
                }
            }

            var html = "<tr itemID='" + entity.ItemID + "' class='ListTableOddRow'><td><input class='itemCode' type=\"text\" name=\"txtItemCode\"   value=\"" +
                entity.ItemCode +
                "\" disabled=\"disabled\"></td><td><input class='ItemSingleWeight' value='" + entity.ItemSingleWeight + "' type='text' class='TextBox' disabled=\"disabled\" /></td><td><input class='SKBWeight' value='" + entity.SKBWeight + "' type='text' class='TextBox'  disabled=\"disabled\"/></td><td><input class='SKWeight' value='" + entity.SKWeight + "' type='text' class='TextBox' disabled=\"disabled\" /></td><td><input class='ItemTotalWeight' value='" + entity.ItemTotalWeight + "' type='text' class='TextBox'  disabled=\"disabled\"/></td><td><input class='Weeks' value='" + entity.Weeks + "' type='text' class='TextBox'  disabled=\"disabled\"/></td><td><input class='SingleWeight' value='" + entity.SingleWeight + "'  type='text' class='TextBox'  disabled=\"disabled\"/></td></tr>"
            $("#tbParaItem").append(html);
        }
       
    </script>
</asp:Content>
