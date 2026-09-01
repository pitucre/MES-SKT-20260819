<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReturnToSupplierDtl.aspx.cs" MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.ReturnToSupplierDtl" %>

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
            <li class="current">退料GRN信息</li>
        </ul>
        <div class="tb_c tb_content">
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
                row.push(objData[i].ReturnOrder); //   data[0]
                row.push(objData[i].ItemCode); // data[1]
                row.push(objData[i].GRN); //data[2]
                row.push(objData[i].BalanceQty); //data[3]
                row.push(objData[i].CreateBy);//data[4]
                row.push(objData[i].CreateTime); //    data[5]
                row.push(objData[i].cBarCode); //    data[6]
                dataSet.push(row);
            }
            $('#tblRec').DataTable({
                data: dataSet,
                paging: true,
                searching: true,
                scrollCollapse: true,
                language: getJQTableLanguage,
                columns: [
                    { title: "退料单" },
                    { title: "物料编码" },
                    { title: "GRN" },
                    { title: "退料数量" },
                    { title: "操作人" },
                    { title: "操作时间" },
                    { title: "库位" }
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
      

    </script>
</asp:Content>

