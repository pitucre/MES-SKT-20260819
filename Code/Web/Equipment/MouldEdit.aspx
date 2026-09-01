<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MouldEdit.aspx.cs"
    Inherits="SKT.LeanMES.Web.Equipment.MouldEdit" MasterPageFile="~/Masters/EditHeadMaster.master" %>

<%@ MasterType VirtualPath="~/Masters/EditHeadMaster.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">

    <div class="wrap_tb" style="min-height: 350px; min-width: 600px">
        <ul class="tb">
            <li class="current" title="<%= Resources.lang.BaseInfo%>">
                <%= Resources.lang.BaseInfo%>
            </li>
            <%-- <li title="扩展信息">扩展信息</li>--%>
        </ul>

        <div class="tb_c">
            <table class="EditeContentTable" width="100%">
                <tr>
                    <td class="Label3">
                        <%= Resources.lang.MouldCode%><em>*</em>
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtEquipmentCode" runat="server" CssClass="TextBox" MaxLength="50"
                            IsRequired='1' ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td class="Label3">模具名称<em>*</em>
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtEquipmentName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired='1' ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td rowspan="6" class="Field3" style="text-align: center;">
                        <div class="layui-upload">
                            <button type="button" class="layui-btn" style="background-color: #4E8CD4" id="test1"><span>上传图片</span></button>
                            <div class="layui-upload-list">
                                <asp:Image runat="server" CssClass="layui-upload-img" ID="image1" />

                                <p style="color: red"><span>支持图片格式：GIF/JPG/PNG/BMP 图片大小：不超过1MB</span></p>
                                <p id="demoText"></p>
                            </div>
                            <asp:Label runat="server" ClientIDMode="Static" ID="lbFileReady" CssClass="redFont hide" ForeColor="Red">未载入</asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">客户名称
                    </td>
                    <td class="Field3">
                        <asp:TextBox runat="server" ID="txtCustomName" CssClass="TextBox" ReadOnly="true"></asp:TextBox>
                        <input type="button" class="ButtonBox" value="..." onclick="selectCustomer()" />
                    </td>

                    <td class="Label3">
                        <%= Resources.lang.Supplier %><em>*</em>
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtSupplierName" runat="server" CssClass="TextBox" Enabled="false" IsRequired="1"
                            ReadOnly="true"></asp:TextBox><input type="button" class="ButtonBox"
                                value="..." onclick="selectSupplier()" />
                        <asp:HiddenField ID="hdnSupplierCode" runat="server" Value="-1" />
                    </td>

                </tr>

                <tr>
                    <td class="Label3">当前位置
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtPosition" runat="server" CssClass="TextBox" MaxLength="50"
                            Enabled="false" ClientIDMode="Static">
                        </asp:TextBox>
                        <input type="button" value="..." class="ButtonBox" onclick="selectPosition()" />
                        <asp:HiddenField ID="HiddenPosition" Value="-1" runat="server" ClientIDMode="Static" />
                    </td>
                    <td class="Label3">公司<em>*</em>
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtCompanyName" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"
                            Enabled="false" ClientIDMode="Static">
                        </asp:TextBox>
                        <input type="button" value="..." class="ButtonBox" onclick="selectCompany()" />
                        <asp:HiddenField ID="hiddenCompanyCode" runat="server" ClientIDMode="Static" />

                    </td>
                </tr>
                <tr>
                    <td class="Label3">
                        <%= Resources.lang.EnterFactoryDate%><em>*</em>
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtFactortTime" runat="server" CssClass="DateTimeBox" MaxLength="50" IsRequired="1"
                            Width="140" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <%--<td class="Label3">价格
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="TextBox" MaxLength="50" IsNumber='1'
                            ClientIDMode="Static"></asp:TextBox>
                    </td>--%>

                    <td class="Label3">MODEL
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtModel" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td class="Label3">标准使用寿命<em>*</em>
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtStandardLife" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"
                            Width="140" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td class="Label3">累计使用寿命<em>*</em>
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtServiceLife" runat="server" CssClass="TextBox" MaxLength="50" IsRequired="1"
                            Width="140" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">机台吨位
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtMachineTonnage" runat="server" CssClass="TextBox" MaxLength="50" Width="140" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td class="Label3">模具吨位
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtMoldTonnage" runat="server" CssClass="TextBox" MaxLength="50" Width="140" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">尺寸
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtSize" runat="server" CssClass="TextBox" MaxLength="50" Width="140" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td class="Label3">模具形式
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtMatrix" runat="server" CssClass="TextBox" MaxLength="50" Width="140" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="Label3">模穴数
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtCavity" runat="server" CssClass="TextBox" MaxLength="50" Width="140" ClientIDMode="Static" IsNumber='1'></asp:TextBox>
                    </td>
                    <td class="Label3">模具＃次
                    </td>
                    <td class="Field3">
                        <asp:TextBox ID="txtMoldTimes" runat="server" CssClass="TextBox" MaxLength="50" Width="140" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                 <td class="Label3">厂家模具编码
                 </td>
                 <td class="Field3">
                     <asp:TextBox ID="txtFactoryMouldCode" runat="server" CssClass="TextBox" MaxLength="50" Width="140" ClientIDMode="Static"></asp:TextBox>
                 </td>
                 <td class="Label3">厂家模具名称
                 </td>
                 <td class="Field3">
                     <asp:TextBox ID="txtFactoryMouldName" runat="server" CssClass="TextBox" MaxLength="50" Width="140" ClientIDMode="Static"></asp:TextBox>
                 </td>
                 </tr>
                <tr>
                    <td class="Label3">
                        <%= Resources.lang.Remark%>
                    </td>
                    <td class="Field3" colspan="3">
                        <asp:TextBox ID="txtRemark" CssClass="TextArea" TextMode="MultiLine" runat="server"
                            ClientIDMode="Static" Width="99%" Height="75"></asp:TextBox>
                    </td>
                </tr>
            </table>
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
            $("#txtStandardLife,#txtServiceLife").keyup(function () {
                getIntVal(this);
            });
        });

        layui.use('upload', function () {
            var $ = layui.jquery, upload = layui.upload;

            //普通图片上传
            var uploadInst = upload.render({
                elem: '#test1',
                accept: 'images',
                exts: 'jpg|jpge|gif|png|bmp',
                size: 1024,//限制文件大小，单位 KB
                url: '<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Handler/UploadHander.ashx?Action=MouldAnormal',
                before: function (obj) {
                    //预读本地文件示例，不支持ie8
                    obj.preview(function (index, file, result) {

                        $('#<%=this.image1.ClientID%>').attr('src', result); //图片链接（base64）
                    });
                },
                done: function (res) {
                    //如果上传失败
                    if (res.code > 0) {
                        return layer.msg('上传失败');
                    }
                    var fileUrl = GetFilePath("MouldAnormal", res.data.FileName);
                    $('#<%=this.image1.ClientID%>').attr('src', fileUrl);
                    var n = 0;
                    if (fileUrl.indexOf('=') > 0) {
                        var n = fileUrl.lastIndexOf("=");
                    } else {
                        var n = fileUrl.lastIndexOf("/");
                    }
                    $("#<%=this.lbFileReady.ClientID%>").html(fileUrl.substring(n + 1, fileUrl.length));
                    //上传成功
                },
                error: function (index, upload) {
                    //演示失败状态，并实现重传
                    var demoText = $('#demoText');
                    demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
                    demoText.find('.demo-reload').on('click', function () {
                        uploadInst.upload();
                    });
                }
            });
        });
        var Flag = 0;
        var Id = '<%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>';


        $("#ddlLine").on("change", function () {

        });

        function Save() {
            var P = $("#<%=this.lbFileReady.ClientID%>").html();
            var errStr = "";
            var equipmentCode = $("#txtEquipmentCode").val();  //模具编码
            var equipmentName = $("#txtEquipmentName").val();  //模具名称
            var supplierCode = $("#<%=this.hdnSupplierCode.ClientID %>").val();  //供应商

            var status = 0;//$("#ddlStatus").val();
            var txtFactoryTime = $("#txtFactortTime").val();
            var txtRemark = $("#txtRemark").val();


            var company = $("#<%=this.hiddenCompanyCode.ClientID %>").val();

            if (errStr != "") {
                alert(errStr);
                return false;
            }

            var entity = {}
            entity.EquipmentId = Id;
            entity.EquipmentCode = equipmentCode;
            entity.EquipmentName = equipmentName;
            entity.EquipmentTypeId = -4; //模具默认-4
            //entity.EquipmentModel = txtEquipmentModel;

            entity.Status = status;
            entity.LineId = -1;
            entity.SequenceNo = -1;
            entity.StationId = -1;
            entity.Position = "";
            entity.Remark = txtRemark;
            entity.VenCode = "";  //生产厂商
            entity.SupplierCode = supplierCode;
            entity.Thick = 0.00;
            entity.WarehouseLocationId = $("#<%=this.HiddenPosition.ClientID %>").val();
            entity.VendorBarcode = "";
            entity.FactoryDate = new Date(0);
            entity.ProduceDate = new Date(0);
            entity.StandarLive = $("#txtStandardLife").val() == "" ? 0 : $("#txtStandardLife").val();
            entity.UseCount = $("#txtServiceLife").val() == "" ? 0 : $("#txtServiceLife").val();
            entity.WarningCount = 0;
            entity.CurPosition = "";
            entity.InOrOut = 1;
            entity.IsClear = 1;
            entity.ItemId = $("#<%=this.hdnItemId.ClientID %>").val();
            entity.Purchase = -1; $("#ddPurchase").val();
            entity.FactoryDate = new Date(Date.parse(txtFactoryTime.replace(/-/g, "/")));
            entity.PictureName = P;
            entity.CompanyCode = company;
            entity.ComponentId = -1;//componentId;
            entity.Price = 0.00;
            entity.Consignee = "";

            entity.CustomName = $("#<%=this.txtCustomName.ClientID %>").val(); //客户名称
            entity.Model = $("#<%=this.txtModel.ClientID %>").val(); //Model
            entity.MachineTonnage = $("#<%=this.txtMachineTonnage.ClientID %>").val(); //机台吨位
            entity.MoldTonnage = $("#<%=this.txtMoldTonnage.ClientID %>").val(); //模具吨位
            entity.Size = $("#<%=this.txtSize.ClientID %>").val(); //尺寸
            entity.Matrix = $("#<%=this.txtMatrix.ClientID %>").val(); //模具形式
            entity.Cavity = parseInt($("#<%=this.txtCavity.ClientID %>").val()) || 0; //模穴数
            entity.MoldTimes = $("#<%=this.txtMoldTimes.ClientID %>").val(); //模具#次

            entity.FactoryMouldCode = $("#<%=this.txtFactoryMouldCode.ClientID %>").val(); //
            entity.FactoryMouldName = $("#<%=this.txtFactoryMouldName.ClientID %>").val(); //

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxEquipment.EquipmentEditNew(entity);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            alert('<%=Resources.Messages.SaveSuccess%>');

            parent.window.UpdateList(equipmentCode);

        }



        var chooseFlag = -1;

        /*选择厂商*/
        function selecFactory() {
            chooseFlag = 35;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*选择供应商*/
        function selectSupplier() {
            chooseFlag = 34;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=34&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*单位*/
        function selectItem() {
            chooseFlag = 1;

            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 400 });
        }
        /*保管部门*/
        function selectDep() {
            chooseFlag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=13&Multiple=false&rnd=" + Math.random(), width: 500, height: 300 });
        }
        /*保管人*/
        function selectBy() {
            chooseFlag = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=12&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*货架*/
        function selectPosition() {
            chooseFlag = 4;
            var searchCondition = " CWhName in('模具仓','模具报废仓')";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=33&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*客户名称*/
        function selectCustomer() {
            chooseFlag = 10;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*模具名称*/
        function selectMouldBom() {
            chooseFlag = 11;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=705&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }
        /*公司列表*/
        function selectCompany() {
            chooseFlag = 712;
            var searchCondition = " TypeId=1";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=712&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
        }


        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);

            } else if (chooseFlag == 4) {

                $("#<%=this.txtPosition.ClientID %>").val(list[0][2]);
                $("#<%=this.HiddenPosition.ClientID %>").val(list[0][0]);
            } else if (chooseFlag == 34) {
                $("#<%=this.txtSupplierName.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnSupplierCode.ClientID %>").val(list[0][1]);
            } else if (chooseFlag == 712) {

                $("#<%=this.hiddenCompanyCode.ClientID %>").val(list[0][1]);
                $("#<%=txtCompanyName.ClientID%>").val(list[0][2]);

            } else if (chooseFlag == 10) {
                $("#<%=this.txtCustomName.ClientID %>").val(list[0][1]);
            }
        }
    </script>
    <script type="text/javascript">
        /*Comment by Hanson.Lei 2016/10/13*/
        $(function () {
            $(".DateTimeBox").attr("readOnly", "readOnly");
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="GridviewContent" runat="server">
    <asp:Panel ID="plContent2" runat="server">
        <div class="ListTableTitle">
            <%=Resources.lang.Item%>&nbsp;<span id="bomCompList"></span>
        </div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="ObjectDataSource1">
            <Columns>
                <%-- To Do --%>
                <asp:BoundField DataField="ItemCode" HeaderText="<%$ Resources:lang, ItemCode %>" />
                <asp:BoundField DataField="ItemName" HeaderText="<%$ Resources:lang, ItemName %>" />
                <asp:BoundField DataField="MoldCavity" HeaderText="标准模穴" />
                <asp:BoundField DataField="UseMoldCavity" HeaderText="使用模穴" />
                <asp:BoundField DataField="ItemSpec" HeaderText="产品规格" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" EnablePaging="true" StartRowIndexParameterName="startRow"
            MaximumRowsParameterName="maxRows" SortParameterName="sortExpression" TypeName="SKT.LeanMES.Equipment.BLL.MoldFixtureItem"
            SelectMethod="GetAll" SelectCountMethod="GetCount">
            <SelectParameters>
                <asp:Parameter Name="searchSettings" Type="Object" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <input type="hidden" id="hdnOperate" name="hdnOperate" value="" />
        <input type="hidden" id="hdnIdString" name="hdnIdString" value="" />
        <script type="text/javascript">
            loadfloatButtons("bomCompList");
            isMultiple = true;
            $(function () {
            /*comment by Hanson Lei 2016-10-12 验证厚度输入类型并保留两位小数(四舍五入) */
<%--                $("#<%=this.txtThick.ClientID%>").blur(function () {
                    var thickVal = $(this).val();
                    if ($.trim(thickVal) != "") {
                        if (!isNaN(thickVal)) { $(this).val(parseFloat(thickVal).toFixed(2)); }
                        //else { $(this).focus(); $(this).val('');}
                    }
                });--%>

                //入场日期设为只读
                $(".DateTimeBox").attr("readonly", "readonly");
            });

            function AddComponent() {
                if (Id == -1) {
                    alert("请先保存信息");
                    return false;
                }

                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldItemEdit.aspx?name=MouldItemEdit&action=add&ID=" + Id + "&cid=-1";
                dialog({ title: "增加模治具产品", src: openWinUrl, width: 700, height: 400 });
            }

            function EditComponent() {

                var idStr = getOneRecordId();
                if (idStr == "") {
                    return false;
                }
                openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Equipment/MouldItemEdit.aspx?name=MouldItemEdit&action=edit&ID=" + Id + "&cid=" + idStr;
                dialog({ title: "编辑模治具产品", src: openWinUrl, width: 700, height: 400 });
            }

            function RemoveComponent() {
                if (Id == -1) {
                    alert("请先保存信息");
                    return false;
                }

                var idStr = getOneRecordId();
                if (idStr == "") {
                    return false;
                }

                //if (!confirm("删除关联产品的记录,会影响SMT投入的过站!")) {
                //    return false;
                //}

                var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMoldFixtureItem.Delete(idStr);
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return false;
                }

                alert("删除成功");
                document.forms[0].submit();
            }

            function refush() {
                document.forms[0].submit();
            }

            function closeOpen() {
                closeDialog();
            }
        </script>
    </asp:Panel>
</asp:Content>
