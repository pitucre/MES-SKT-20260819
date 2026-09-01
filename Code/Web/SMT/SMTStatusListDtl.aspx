<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Masters/EditMaster.master"
    CodeBehind="SMTStatusListDtl.aspx.cs" Inherits="SKT.LeanMES.Web.SMT.SMTStatusListDtl" %>
<%@ MasterType VirtualPath="~/Masters/EditMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server" ViewStateMode="Enabled">
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
            background: red
        }
    </style>

    <div id="divLabelInfo">
        <table class="EditeContentTable" width="100%">
            <tr>
                <td class="Label2">工单：</td>
                <td class="Field2" id="tdOrderNo"></td>
                <td class="Label2">物料清单：</td>
                <td class="Field2" id="tdListName"></td>
            </tr>            
            <tr>
                <td class="Label2">上料项：</td>
                <td class="Field2" id="tdTotal"></td>

            </tr>
        </table>
    </div>
    <div class="clear5"></div>
    <div id="divTableDtl">
        <table id="tblRec" class="row-border stripe" width="100%">
        </table>
    </div>
    <asp:HiddenField runat="server" ClientIDMode="Static" ID="hfDataJson"></asp:HiddenField>


    <script type="text/javascript">
        var orderId = '<%=Request.QueryString["ID"] %>';
        var orderNo = '<%=Request.QueryString["orderNo"] %>';
        var listName = '<%=Request.QueryString["list"] %>';
        var strDataJson = $("#hfDataJson").val();
        var objData = JSON.parse(strDataJson);
        $("#tdOrderNo").html(orderNo);
        $("#tdListName").html(listName);
        $("#tdTotal").html(objData.length);

        var getJQTableLanguage = function () {
            return {
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
        }
        
        function showRecDtl(doclean) {
            var dataSet = []; //数据源
            if (doclean) { //清空，绑定表格
                //$('#tblRec').DataTable().destroy();
                //$('#tblRec').empty();
            }

            for (var i = 0; i < objData.length; i++) {
                var row = [];
                row.push(objData[i].SetupName); //上料清单   data[0]
                row.push(objData[i].TableSlotSN); //插槽 data[1]
                row.push(objData[i].ItemCode); //data[2]
                row.push(objData[i].GRN);//data[3]
                row.push(objData[i].SNQty); //数量     data[4]
                row.push(objData[i].MUQTY); //需要数量    data[5]
                row.push(objData[i].StatusDesc); //状态   data[6]
                row.push(objData[i].CreationTime); //上料时间    data[7]
                row.push(objData[i].SmtTable); //   面别 data[8]
                row.push(objData[i].LineName); //   线别 data[9]
                row.push(objData[i].EquipmentName); //   设备 data[10]
                row.push(objData[i].IsNewAdd); //   是否续料 data[11]
                dataSet.push(row);
            }
            $('#tblRec').DataTable({
                data: dataSet,
                paging: true,
                searching: true,
                scrollCollapse: true,
                language: getJQTableLanguage(),
                columns: [
                    { title: "机台" },
                    { title: "插槽" },
                    { title: "物料编码" },
                    { title: "GRN" },
                    { title: "物料数量" },
                    { title: "所需数量" },
                    { title: "状态" },
                    { title: "上料时间" },
                    { title: "面别" },
                    { title: "线别" },
                    { title: "设备" },
                    { title: "是否为续料" }

                ]
                , "createdRow": function (row, data, index) {
                    var curQty = data[4] * 1;
                    var needQty = data[5] * 1; 
                    var mGRN = data[3];
                    if (curQty < needQty && mGRN !== '') {
                        $(row).css('background','red');
                    }
                }
            });
        }

        showRecDtl(true);
    </script>
</asp:Content>

