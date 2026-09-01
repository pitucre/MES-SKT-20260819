<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialUnitEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.Material.MaterialUnitEdit" MasterPageFile="~/Masters/EditMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <link href="../Content/plugin/DataTables-1.10.12/css/jquery.dataTables.min.css" rel="stylesheet"
        type="text/css" />
    <script src="../Content/plugin/DataTables-1.10.12/js/jquery.js" type="text/javascript"></script>
    <script src="../Content/plugin/DataTables-1.10.12/js/jquery.dataTables.js" type="text/javascript"></script>
    <style>
        #tblRec th {
            background-color: #ececec;
            padding: 3px;
            height: 22px;
            border: 1px solid #d3d3d3;
            border-collapse: collapse;
            font-family: Verdana, 微软雅黑,黑体,宋体;
            color: #183152;
        }

        #tblRec tr td {
            border: 1px solid rgb(211, 211, 211);
        }

        thead td {
            border-bottom: 1px solid #ececec;
            border-collapse: collapse;
        }

        table.dataTable.no-footer {
            border-bottom: 1px solid #ececec;
            border-collapse: collapse;
        }

        .bg-red {
            background: red;
        }
    </style>
    <div class="wrap_tb" id="wrap_tb">
        <ul class="tb">
            <li class="current">基本信息</li>
            <li>历史操作明细</li>
        </ul>
        <div class="tb_c tb_content">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label2">物料条码
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtSerialNumber" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="Label2">批次号
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtLotCode" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">生产日期
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtDateCode" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="Label2">供应商料号
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="txtMPN" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">产品名称
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtItemName" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="Label2">产品描述
                    </td>
                    <td class="Field2" colspan="3">
                        <asp:Label ID="txtItemDesc" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">供应商
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtSupplier" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="Label2">库位条码
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtBarCode" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">总量
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtBalanceQty" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="Label2">剩余数量
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtCurrentQty" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">状态
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtStatus" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="Label2">创建人
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtCreate" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="Label2">生成物料条码时间
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtCreateTime" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td class="Label2">入库时间
                    </td>
                    <td class="Field2">
                        <asp:Label ID="txtStorageTime" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="tb_content">
            <div class="clear5"></div>
            <div id="divTableDtl">
                <table id="tblRec" class="row-border stripe" width="100%">
                </table>
            </div>
        </div>
    </div>
    <div class="clear5"></div>

    <asp:HiddenField runat="server" ClientIDMode="Static" ID="hfDataJson"></asp:HiddenField>
    <link href="../Content/plugin/calendar/skin/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.core.js"
        type="text/javascript"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.js"
        type="text/javascript" charset="GBK"></script>
    <script src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/plugin/calendar/js/jquery.ui.datepicker.zn.js"
        type="text/javascript"></script>
    <script type="text/javascript">
        var uNITID = '<%= Request.QueryString["ID"] %>';
        var getJQTableLanguage = {
            "lengthMenu": "每页 _MENU_ 条记录",
            "zeroRecords": "暂无数据",
            "info": "显示第 _PAGE_ 页,共 _PAGES_ 页",
            "infoEmpty": "",
            "search": "综合搜索:",
            "infoFiltered": "(从 _MAX_ 条记录中查询)",
            "paginate": {
                "first": "首页",
                "last": "尾页",
                "next": "后一页",
                "previous": "前一页"
            }
        };
        var strDataJson = $("#hfDataJson").val();
        var objData = JSON.parse(strDataJson).data;
        function showRecDtl() {
            var dataSet = []; //数据源 vwMaterialHistory
            for (var i = 0; i < objData.length; i++) {
                var row = [];
                row.push(objData[i].CreateDateTime); //   data[0]
                row.push(objData[i].OperateOrder); // data[1]
                row.push(objData[i].ActionType); //data[2]
                row.push(parseFloat(objData[i].Qty)); //data[3]
                row.push(objData[i].CreateBy);//data[4]
                row.push(objData[i].Remark); //    data[5]
                dataSet.push(row);
            }
            $('#tblRec').DataTable({
                data: dataSet,
                paging: true,
                searching: true,
                scrollCollapse: true,
                language: getJQTableLanguage,
                columns: [
                    { title: "日期" },
                    { title: "相关单据" },
                    { title: "操作类型" },
                    { title: "数量" },
                    { title: "操作人" },
                    { title: "备注" }
                ]
                , "createdRow": function (row, data, index) {
                    //var doSthInRow = false;
                    //if (doSthInRow) {
                    //    $(row).css('background', 'red');
                    //}
                }
            });
        }

        showRecDtl();
        function Save() {
            var errStr = "";
            var textLotCode = $("#txtLotCode").val();
            var txtProdDate = $("#txtProdDate").val();

            /*生产日期必须输入 add by watson 2015-03-31*/
            if (txtProdDate == "") {
                errStr += "<%=Resources.Messages.WithAsteriskIsRequiredAlert %>\n";
            }
            if (errStr != "") {
                alert(errStr);
                return false;
            }

            if (uNITID == null || uNITID == -1) {
                alert("<%=Resources.Messages.InvalidateParameter %>");
                return false;
            }

            var entity = {};
            entity.ID = uNITID;
            entity.LotCode = textLotCode;
            entity.DateCode = txtProdDate;

            var ajaxsave = SKT.LeanMES.Web.AjaxServices.AjaxMaterial.EditMaterailUnitGRN(entity);
            if (ajaxsave.error != null) {
                alert(ajaxsave.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveSuccess %>');
            parent.window.UpdateList($("#txtSerialNumber").val());
        }

    </script>
</asp:Content>
