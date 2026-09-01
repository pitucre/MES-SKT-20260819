<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="EquipmentInspectionItemListTreeImport.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.EquipmentInspectionItemListTreeImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div id="toolbar" class="toolBar">
        <div class="toolbar-btn" onclick="Download()" title="设备点检模板下载">
            <div class="icon-16-copy"></div>
            <div class="btn-text">设备点检模板下载</div>
        </div>
        <div class="clear0"></div>
    </div>
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">上传路径<em>*</em>
            </td>
            <td class="Field2" style="text-align: left">
                <asp:FileUpload ID="fuPickList" runat="server" onchange="uploadFile(this.value)" />
                <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click"></asp:LinkButton>
                <input class="SearchButton" id="btnSave" type="button" value="保 存" onclick="Save()" />
                <span id="spmessinfo" style="font-weight: bold; font-size: 18px;"></span>
            </td>
        </tr>
    </table>
    <div style="height: 5px"></div>
    <%--<table class="ListTable" width="100%" id="tbOfflineList">
        <tr class="ListTableHeader">
            <th width="3%">序号</th>
            <th>父节点</th>
            <th>检验项名称</th>
            <th>录入方式</th>
        </tr>
    </table>--%>
    <asp:GridView ID="GridView1" runat="server" Width="100%">
        <%--<Columns>
            <asp:TemplateField HeaderText="ID" Visible="true"></asp:TemplateField>
        </Columns>--%>
    </asp:GridView>
    <%--   </div>--%>

    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript" language="javascript">
        var entityList = [];
        function uploadFile(filePath) {
            var index = layer.load(2, { shade: false });
            $("#spmessinfo").text("正在加载中...");
            if (filePath.length > 0) {
                var str = '';
                var postback = $('#<%= linkUploadFile.ClientID %>').attr('href');
                var funcStartIndex = postback.indexOf('\'');
                var funcEndIndex = postback.indexOf('\',');
                if (funcStartIndex != -1 && funcEndIndex != -1) {
                    var str = postback.substring(funcStartIndex + 1, funcEndIndex);
                    __doPostBack(str, '');
                } else {
                    return false;
                }
            }
        }

        function countNumber() {
            var strInfo = JSON.stringify(entityList);
        }

        function Delet(obj, SignId) {
            var tab = document.getElementById("tbOfflineList");
            tab.deleteRow(obj.parentElement.parentElement.rowIndex);
            //重新加载
            countNumber();
        }

        function ShowOfflineGRN(entity) {
            var index = layer.load(2, { shade: false });
            $("#spmessinfo").text("正在加载中...");
            setTimeout(function () {
                //load(entity);
            }, 500);
        }

        //function load(entity) {
        //    var logList = '';
        //    var _css = 'ListTableOddRow';
        //    $("#tbOfflineList tr:gt(0)").remove();


        //    for (var i = 0; i < entity.length; i++) {
        //        if (i % 2 == 0) _css = 'ListTableEvenRow';
        //        else _css = 'ListTableOddRow';

        //        logList += '<tr class="' + _css + '" id=' + (i + 1) + '>';
        //        logList += '<td>' + (i + 1).toString() + '</td>';
        //        logList += '<td>' + entity[i].parent + '</td>';
        //        logList += '<td>' + entity[i].item + '</td>';
        //        logList += '<td>' + entity[i].inputtype + '</td>';
        //        logList += '</tr>';



        //    }
        //    $("#tbOfflineList").append(logList);
        //    $("#spmessinfo").text("加载完毕...");
        //    layer.closeAll();
        //    setTimeout(function () {
        //        $("#spmessinfo").text("");
        //    }, 4000);
        //}

        function Download() {
            var filePath = '<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"设备点检模板.xls" %>';
             return window.open(filePath);
         }
        var entityList = [];
        function Save() {
           
            var parent = "";
            var item = "";
            var inputtype = "";
            $("#<%=this.GridView1.ClientID %> tr:gt(0)").each(function () {
                parent = $(this).find("td").eq(0).text();
                item = $(this).find("td").eq(1).text();
                inputtype = $(this).find("td").eq(2).text();
                Sorting = $(this).find("td").eq(3).text();
                entityList.push({
                    "ParentName": parent,
                    "InspectionItemName": item,
                    "InspectionMethodName": inputtype,
                    "Sorting": Sorting
                });
            });

            if (entityList.length == 0) {
                return
            }
            //console.log(entityList)

            //var entity = {};
            //entity.InspectionItemList = JSON.stringify(entityList);
            <%--entity.UserName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";--%>
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxPrint.ExecuteSpc("uspSaveImportInspectionItem", JSON.stringify(entity));
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxQualityInspection.SaveImportEquipmentInspectionItem(JSON.stringify(entityList));
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            //alert("导入成功！");
            document.forms[0].submit();
            alert("<%=Resources.Messages.SaveInSuccess %>");
            window.parent.window.UpdateList();
        }
    </script>
</asp:Content>
