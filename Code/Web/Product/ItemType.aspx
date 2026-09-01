<%@ Page Language="C#" MasterPageFile="~/Masters/ViewMaster.master" 
    AutoEventWireup="true" CodeBehind="ItemType.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemType" %>

<asp:Content ID="Content2" ContentPlaceHolderID="viewcontent" runat="server">
    <table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                类型代码
            </td>
            <td class="Field2">
                <asp:TextBox CssClass="TextBox" ID="txtItemTypeCode" runat="server" ClientIDMode="Static"></asp:TextBox>
            </td>
            <td class="Label2">
                类型名称
            </td>
            <td class="Field2">
                <asp:TextBox CssClass="TextBox" ID="txtItemTypeName" runat="server" ClientIDMode="Static"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="Label2" colspan="4" align="center" style="text-align:center">
                <input type="button" id="btnQuery" value="查询" onclick="Query()" />
            </td>
        </tr>
    </table>
    <div class="clear5">
    </div>
    <div class="ListTableTitle">
        <div style="position: absolute; left: 10px; top: 5px; line-height: 18px;">
            物料类型明细
        </div>
    </div>
    <div id="divItemTypeInfo">
    </div>
    <script type="text/javascript" src="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/js/skt.utility.printer.js"></script>
    <link href="../Content/jquery-easyui-1.4.2/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="../Content/jquery-easyui-1.4.2/themes/icon.css" rel="stylesheet" type="text/css" />
    <script src="../Content/jquery-easyui-1.4.2/jquery.min.js" type="text/javascript"></script>
    <script src="../Content/jquery-easyui-1.4.2/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../Content/plugin/layer/layer.js" type="text/javascript"></script>
    <script type="text/javascript">
        var userName = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var strShow = "";          
        var isEnter = false;
        //初始方法
        $(function () {
            GetItemTypeInfo("","");
        });
        //#region 查询按钮事件
        function Query() {
            var ItemTypeCode = $("#txtItemTypeCode").val();
            var ItemTypeName = $("#txtItemTypeName").val();
            GetItemTypeInfo(ItemTypeCode, ItemTypeName);
        }
        //#endregion

        //#region 查询物料类型信息
        function GetItemTypeInfo(ItemTypeCode, ItemTypeName) {
            //var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetItemTypeInfoTest(ItemTypeCode, ItemTypeName).value;
            $('#divItemTypeInfo').datagrid({
                height: $(window).height() - 136, //列表高度
                url: '../ASHX/ItemTypeInfo.ashx',//查询数据地址
                queryParams:{type: "GetItemTypeInfo", ItemTypeCode: ItemTypeCode, ItemTypeName: ItemTypeName},
                striped: true,//奇偶行颜色区分
                fitColumns: true,
                singleSelect: true, //多选
                rownumbers: true,  //显示行号
                pagination: true, //分页
                nowrap: false,
                showFooter: true,
                loadMsg: '加载中，请稍候…',
                pageSize: 10,
                pageList: [10, 20, 50, 100, 150, 200],
                idField: 'ITEMTYPEID',
                columns: [[{ field: 'ck', checkbox: true },
                            { field: 'ITEMTYPECODE', title: '物料类型编号', width: 120, align: 'left' },
                            { field: 'ITEMTYPENAME', title: '物料类型名称', width: 120, align: 'left' },
                            { field: 'REMARK', title: '备注', width: 120, align: 'left' },
                            { field: 'CREATEBY', title: '创建人', width: 120, align: 'left' },
                            { field: 'CREATEDATETIME', title: '创建时间', width: 120, align: 'left' }
                         ]],
                onLoadSuccess: function (data) {
                    if (data.total == 0) {
                        //当没有记录时提示没有记录信息
                        $(this).datagrid('appendRow', { ITEMTYPECODE: '<div style="text-align:center;color:red">没有相关记录！</div>' }).datagrid('mergeCells', { index: 0, field: 'ITEMTYPECODE', colspan: 5 });
                    }
                },
                onDblClickRow: function (index, row) {
                    //双击事件
                    Edit();
                }
            });

            //#region 格式化分页提示
            var p = $('#divItemTypeInfo').datagrid('getPager');
            $(p).pagination({
                beforePageText: '第', //页数文本框前显示的汉字           
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
            });
            //#endregion

            //清除选中状态
            $('#divItemTypeInfo').datagrid('clearSelections');
        }
        //#endregion

        //#region 新增物料类型信息
        function Add() {
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemTypeEdit.aspx?name=ItemTypeAdd&ID=-1";
            dialog({ title: "新增物料类型", src: openWinUrl, width: 500, height: 300 })
        }
        //#endregion

        //#region 编辑物料类型信息
        function Edit() {
            var row = $('#divItemTypeInfo').datagrid('getSelected');
            if (row.ITEMTYPECODE.indexOf("没有相关记录") >= 0) {
                return false;
            }
            if (row == null) {
                alert("请先选择需要修改的数据");
                return false;
            }
            openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Product/ItemTypeEdit.aspx?name=ItemTypeEdit&ID=" + row.ITEMTYPEID;
            strShow = dialog({ title: "<%=Resources.Pages.Product_ItemEdit %>", src: openWinUrl, width: 500, height: 300 });
        }
        //#endregion

        //#region 删除物料类型信息
        function Delete() {
            var idStr = "";
            var rows = $('#divItemTypeInfo').datagrid('getSelections');
            for (var i = 0; i < rows.length; i++) {
                idStr += rows[i].ITEMTYPEID + ",";
            }
            if (idStr == "") {
                alert("请先选择要删除的物料类型信息！");
                return false;
            }
            if (confirm('确定要删除吗？')) {
                //删除数据
                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.DeleteItemTypeInfo(idStr);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }
                layer.msg('<font style="font-weight:bold;color:Green;font-size:20px;">删除成功</font>', { icon: 1 });
                Query();
            }
        }
        //#endregion

        //#region 新增/编辑之后查询物料类型信息
        function UpdateList(strName) {
            $("#<%=this.txtItemTypeName.ClientID %>").val(strName);
            Query();
            closeDialog();
        }
        //#endregion
    </script>
</asp:Content>
