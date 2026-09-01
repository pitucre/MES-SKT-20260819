<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SampleNumberImport.aspx.cs"
    MasterPageFile="~/Masters/EditMaster.master" Inherits="SKT.LeanMES.Web.SampleNumberManagement.SampleNumberImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label1">上传文件路径<em>*</em>
            </td>
            <td class="Field1">
                <asp:FileUpload ID="FuUrl" runat="server" ClientIDMode="Static" onchange="uploadFile(this.value)" />
                <div style="display: none;">
                    <asp:Button ID="btnUpload" runat="server" OnClick="btnUpload_Click" ClientIDMode="Static" />
                </div>
            </td>
        </tr>
    </table>
    <div style="margin-top: 2px;">
        <asp:GridView ID="GvImport" runat="server" Width="100%">
            <Columns>
                <asp:BoundField DataField="SampleNumber" HeaderText="序列号" ItemStyle-CssClass="SampleNumber" />
                <asp:BoundField DataField="SampleName" HeaderText="样品名称" ItemStyle-CssClass="SampleName" />
                <asp:BoundField DataField="Station" HeaderText="工序名称" ItemStyle-CssClass="Station" />
                <asp:BoundField DataField="ExpirationDate" HeaderText="失效日期" ItemStyle-CssClass="ExpirationDate" />
                <asp:BoundField DataField="PrototypeAttr" HeaderText="不良属性" ItemStyle-CssClass="PrototypeAttr" />
                <asp:BoundField DataField="NcCodes" HeaderText="不良代码" ItemStyle-CssClass="NcCodes" />
                <asp:BoundField DataField="Remark" HeaderText="备注" ItemStyle-CssClass="Remark" />
            </Columns>
        </asp:GridView>
    </div>
    <script>
        var gridId = "<%=this.GvImport.ClientID%>";

        //保存
        function Save() {
            var trs = $("#" + gridId + " tr:not(.ListTableHeader)");
            if (trs.length <= 0) {
                alert("请先导入样品序号信息");
                return;
            }
            //遍历需要导入的数据
            var arr = [];
            var trObj;
            var item = {};
            var isOk = true;
            trs.each(function () {
                trObj = $(this);
                var SampleNumber = $.trim(trObj.find(".SampleNumber").text());
                var SampleName = $.trim(trObj.find(".SampleName").text());
                var Station = $.trim(trObj.find(".Station").text());
                var ExpirationDate = $.trim(trObj.find(".ExpirationDate").text());
                var PrototypeAttr = $.trim(trObj.find(".PrototypeAttr").text());
                var NcCodes = $.trim(trObj.find(".NcCodes").text());
                var remark = $.trim(trObj.find(".Remark").text());

                if (!SampleNumber) {
                    alert("样品序号不能为空");
                    isOk = false;
                    return false;
                }
                if (SampleName == "") {
                    alert("样品名称不能为空");
                    isOk = false;
                    return false;
                }
                if (Station == "") {
                    alert("工序名称不能为空");
                    isOk = false;
                    return false;
                }
                if (!ExpirationDate) {
                    alert("失效日期不能为空");
                    isOk = false;
                    return false;
                }
                ExpirationDate = ExpirationDate.replace(/\//g, "-").replace(/\./g, "-");
                if (!isDate(ExpirationDate) && !isDateTime(ExpirationDate)) {
                    alert("失效日期格式不正确");
                    isOk = false;
                    return false;
                }
                if (PrototypeAttr == "") {
                    alert("不良属性不能为空");
                    isOk = false;
                    return false;
                }
                if (PrototypeAttr != "良品" && PrototypeAttr != "不良品") {
                    alert("不良属性值必须为‘良品’或‘不良品’");
                    isOk = false;
                    return false;
                }
                if (PrototypeAttr == "不良品" && NcCodes == "") {
                    alert("不良品必须维护不良代码");
                    isOk = false;
                    return false;
                }
                //if (!isPositiveInt(MaxUserCount)) {
                //    alert("最大使用次数必须为整数");
                //    isOk = false;
                //    return false;
                //}
                //if (!isPositiveInt(UsedCount)) {
                //    alert("已使用次数必须为整数");
                //    isOk = false;
                //    return false;
                //}
                //if (!remark) {
                //    alert("备注不能为空");
                //    isOk = false;
                //    return false;
                //}

                item = {};
                item.SampleNumber = SampleNumber;  //样品序号
                item.SampleName = SampleName;  //样品名称
                item.Station = Station;  //工序名称
                item.ExpirationDate = ExpirationDate;
                item.PrototypeAttr = PrototypeAttr == "不良品" ? 0 : 1;
                item.NcCodes = NcCodes;
                item.Remark = remark;
                item.SubId = -1;
                arr.push(item);

            });
            if (!isOk) {
                return false;
            }
            parent.addDetail(arr, 1);
            window.parent.closeDialog();
        }

        function uploadFile(filePath) {
            if (filePath.length > 0) {
                $("#btnUpload").click();
            }
        }

        //判断日期类型是否为yyyy-MM-dd格式的类型
        function isDate(str) {
            if (str.length != 0) {
                var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/;
                var r = str.match(reg);
                if (r == null)
                    return false;
            }
            return true;
        }

        //判断日期类型是否为yyyy-MM-dd hh:mm:ss格式的类型
        function isDateTime(str) {
            if (str.length != 0) {
                var reg = /^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/;
                var r = str.match(reg);
                if (r == null)
                    return false;
            }
            return true;
        }

        //匹配整数
        function isPositiveInt(val) {
            var reg = /^[0-9]\d*$/;
            return reg.test(val);
        }

        //下载模板
        function Download() {
            var fieldPath ='<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot%>' + "样品模板.xls";
            window.open(fieldPath);
            return null;
        }
    </script>
</asp:Content>

