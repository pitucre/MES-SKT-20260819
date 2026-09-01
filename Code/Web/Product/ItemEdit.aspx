<%@ Page Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="True"
    CodeBehind="ItemEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Product.ItemEdit" Title="Edit Item" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="Server">
    <div class="wrap_tb" style="min-width: 435px; min-height: 455px; overflow: auto;">
        <ul class="tb">
            <li class="current">基本信息</li>
            <li>资格证书</li>
            <li class="hide">打印文档</li>
            <li>扩展信息</li>
        </ul>
        <div class="tb_c">
            <div class="infoTips">
                <%=Resources.Messages.WithAsteriskIsRequired %>
            </div>
            <div>
                <table class="EditeContentTable" width="100%">
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.ItemCode%><em>*</em>
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" IsRequired='1' Width="250px"></asp:TextBox><span
                                class="Tips"><%=String.Format(Resources.lang.CanInputCharacter,100)%></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.ItemsName %><em>*</em>
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtItemsName" runat="server" CssClass="TextBox" IsRequired='1' Width="250px"></asp:TextBox><span
                                class="Tips"><%=String.Format(Resources.lang.CanInputCharacter,300)%></span>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.Revision%><em>*</em>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtVersion" runat="server" CssClass="NumericBox50" Text="1.0" Width="60px"></asp:TextBox>
                            <span class="Tips"><%=String.Format(Resources.lang.CanInputCharacter,10)%></span>
                        </td>
                        <td class="Label2">
                            <%=Resources.lang.AsCurrentRevision %>
                        </td>
                        <td class="Field2">
                            <asp:CheckBox ID="ckbCurrentVer" runat="server" Text="<%$Resources:lang,CurrentRevision %>"
                                Checked="true" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">产品规格
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtLabelItemModel" runat="server" CssClass="TextBox" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.ItemType %>
                        </td>
                        <td class="Field2">
                            <SKTControl:ItemGroupDDL ID="ddlItemGroup" runat="server" Width="150px">
                            </SKTControl:ItemGroupDDL>
                        </td>
                        <td class="Label2">
                            <%=Resources.lang.ItemStatus %>
                        </td>
                        <td class="Field2">
                            <asp:DropDownList ID="ddlItemStatus" runat="server" Width="150px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="height: 39px">
                        <td class="Label2"><%=Resources.lang.IsSMT %></td>
                        <td class="Field2">
                            <asp:CheckBox ID="chkIsSMT" runat="server" ClientIDMode="Static" />
                        </td>
                        <td class="Label2 IsSmtCss"><%=Resources.lang.ProductFace %>
                        </td>
                        <td class="Field2 IsSmtCss">
                            <asp:DropDownList ID="ddlProductionFace" runat="server" Width="178px">
                                <asp:ListItem Value="1" Text="<%$Resources:lang,tbFace %>"></asp:ListItem>
                                <asp:ListItem Value="2" Text="<%$Resources:lang,twoFaceTB %>"></asp:ListItem>
                                <asp:ListItem Value="3" Text="<%$Resources:lang,twoFaceBT %>"></asp:ListItem>
                            </asp:DropDownList>
                        </td>

                    </tr>
                    <tr>
                        <td class="Label2">采集模式
                        </td>
                        <td class="Field2">
                            <asp:DropDownList ID="ddlAcquisitionMode" runat="server">
                                <asp:ListItem Value="2">批次</asp:ListItem>
                                <asp:ListItem Value="1">单件</asp:ListItem>

                            </asp:DropDownList>
                            <span>是否高级批次</span>
                            <asp:DropDownList ID="ddlIsSeniorBatch" runat="server">
                                <asp:ListItem Value="1">是</asp:ListItem>
                                <asp:ListItem Value="0">否</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">每批次数量<em>*</em>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtLotSize" runat="server" CssClass="NumericBox50" Width="60px"
                                Text="1" IsRequired='1' onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                                onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"></asp:TextBox><span class="Tips">只能输入数值</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.CustomerName %>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtCustomer" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                                type="button" id="btnSelectCustomer" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseCustomer %>"
                                onclick="selectCustomer();" />
                            <asp:HiddenField ID="hdnCustomerId" runat="server" Value="-1" />
                        </td>
                        <td class="Label2">
                            <%=Resources.lang.InProject %>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtProject" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                                type="button" id="btnSelectProject" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseProject %>"
                                onclick="selectProject();" />
                            <asp:HiddenField ID="hdnProjectId" runat="server" Value="-1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.CustomerPartNumber %>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtCPN" runat="server" CssClass="TextBox"></asp:TextBox>
                        </td>
                        <td class="Label2">
                            <%=Resources.lang.CustomerPartRevision %>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtCPR" runat="server" CssClass="NumericBox50" Text="1.0" Width="60px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.ProductSourceType%>
                        </td>
                        <td class="Field2">
                            <asp:DropDownList ID="ddlItemType" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td class="Label2"><%=Resources.lang.IQCType%>
                        </td>
                        <td class="Field2">
                            <asp:DropDownList ID="ddlIQCType" runat="server" ClientIDMode="Static" Width="80px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.PartUnit%>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtUnits" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                                type="button" id="Button2" class="ButtonBox" value="..." title="选择单位" onclick="selectDictory();" />
                        </td>
                        <td class="Label2">
                            <%=Resources.lang.MinPackageQty%>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtMinPackQty" runat="server" CssClass="NumericBox50" Width="60px"
                                Text="1" IsNumber='1' onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2"></td>
                        <td class="Field2"></td>
                        <td class="Label2"><%=Resources.lang.MinFinisheProdcut%>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="qcMinNum" runat="server" Text="0" IsNumber='1' CssClass="NumericBox50" Width="60px" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>

                        <td class="Label2">是否拼板
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:CheckBox ID="chkIsPanel" runat="server" ClientIDMode="Static" />
                        </td>
                    </tr>
                    <tr id="trIsPanelPrint" style="display: none">
                        <td class="Label2">是否打印拼板
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:CheckBox ID="chkPrintPanelSN" runat="server" ClientIDMode="Static" />
                        </td>
                    </tr>
                    <tr id="trIsPanel" style="display: none">
                        <td class="Label2">拼板类型
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtPanelQty" runat="server" CssClass="NumericBox50" Text="1" IsRequired='1'
                                IsNumber='1'></asp:TextBox>
                            x
                            <asp:TextBox ID="txtChildQty" runat="server" CssClass="NumericBox50" Text="1"
                                IsRequired='1' IsNumber='1'></asp:TextBox>例如：4 X 6 其中4表示该PCB拼板行数目，6表示拼板列数目，故此拼板中子板总数目即为24 
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">产品BOM
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtItemBom" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                                type="button" runat="server" id="btnSelectItemBom" class="ButtonBox" value="..."
                                title="<%=Resources.lang.ChooseBom %>" onclick="selectBom();" />
                            <asp:HiddenField ID="hdnBomId" runat="server" Value="-1" />
                        </td>
                        <td class="Label2">产品路由
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtRouter" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                                type="button" id="btselRouter" runat="server" class="ButtonBox" value="..." title="选择路由"
                                onclick="selectRouter();" />
                            <asp:HiddenField ID="hdnRouterId" runat="server" Value="-1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2"><%=Resources.lang.DefaultWarehouse %>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtLabelFirmware" runat="server" CssClass="TextBox"></asp:TextBox>
                        </td>
                        <td class="Label2">发料方式</td>
                        <td class="Field2">
                            <asp:DropDownList ID="ddlIssueWay" runat="server" ClientIDMode="Static" Width="80px">
                                <asp:ListItem Value="1" Text="<%$Resources:lang,DefaultKey %>"></asp:ListItem>
                                <asp:ListItem Value="2" Text="<%$Resources:lang,MinimumBatch %>"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">是否可超发
                        </td>
                        <td class="Field2">
                            <asp:CheckBox ID="chbIsItemOver" runat="server" ClientIDMode="Static" />
                        </td>
                        <td class="Label2"><%=Resources.lang.ProductionPriority %><em>*</em>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtPriority" runat="server" CssClass="NumericBox50" MaxLength="2"
                                Text="0" IsRequired='1' onkeyup="this.value=this.value.replace(/[^\d.]/g,'')"
                                onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"></asp:TextBox><span class="Tips">范围0~99(默认为0)</span>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">投入站
                        </td>
                        <td class="Field2">
                            <asp:DropDownList ID="InputStationDrop" runat="server" ClientIDMode="Static" Width="80px">
                                <asp:ListItem Value="-1">=请选择=</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">产出站
                        </td>
                        <td class="Field2">
                            <asp:DropDownList ID="YieldStationDrop" runat="server" ClientIDMode="Static" Width="80px">
                                <asp:ListItem Value="-1">=请选择=</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.DataCollectionOnAss%>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtDataType" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                                type="button" id="btnAssDataType" class="ButtonBox" value="..." title="<%=Resources.lang.ChooseDataType %>"
                                onclick="selectDataType();" />
                            <asp:HiddenField ID="hdnDataTypeID" runat="server" Value="-1" />
                        </td>
                        <td class="Label2">大类
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtCategoryOne" runat="server" CssClass="TextBox" ReadOnly="true"
                                ClientIDMode="Static"></asp:TextBox><input type="button" id="btnSelectCategory" class="ButtonBox"
                                    value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectCategory(1);" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">中类
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtCategoryTwo" runat="server" CssClass="TextBox" ReadOnly="true"
                                ClientIDMode="Static"></asp:TextBox><input type="button" id="Button1" class="ButtonBox"
                                    value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectCategory(2);" />
                        </td>
                        <td class="Label2">小类
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtCategoryThree" runat="server" CssClass="TextBox" ReadOnly="true"
                                ClientIDMode="Static"></asp:TextBox><input type="button" id="Button3" class="ButtonBox"
                                    value="..." title="<%=Resources.lang.ChooseItem %>" onclick="selectCategory(3);" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">是否MSD物料
                        </td>
                        <td class="Field2">
                            <asp:CheckBox ID="chkIsMSD" runat="server" ClientIDMode="Static" />
                        </td>
                        <td class="Label2">所属工厂
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtFactoryName" runat="server" CssClass="TextBox" ReadOnly="true"
                                ClientIDMode="Static"></asp:TextBox><input type="button" id="Button4" class="ButtonBox"
                                    value="..." title="<%=Resources.lang.FactoryCode %>" onclick="selectFactoryCode(47);" />
                            <asp:HiddenField ID="hdnSite" runat="server" Value="-1" />
                        </td>
                    </tr>
                    <tr class="isMsd" style="display: none;">
                        <td class="Label2">湿度等级
                        </td>
                        <td class="Field2">
                            <asp:DropDownList ID="ddlMSL" runat="server" ClientIDMode="Static" Width="80px">
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">暴露时长(小时)
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="labFloorLife"></asp:Label>
                            <asp:TextBox ID="txtFloorLife" runat="server" CssClass="TextBox hide" ClientIDMode="Static" ReadOnly="True"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="isMsd" style="display: none;">
                        <td class="Label2">烘烤次数
                        </td>
                        <td class="Field2">
                            <asp:Label runat="server" ID="labBakeCount"></asp:Label>
                            <asp:TextBox ID="txtBakeCount" runat="server" CssClass="TextBox hide" ClientIDMode="Static" ReadOnly="True"></asp:TextBox>
                        </td>
                        <td class="Label2"></td>
                        <td class="Field2"></td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%= Resources.lang.MaskGroup%>
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtMask" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                                type="button" id="btnMask" class="ButtonBox" value="..." title="" onclick="selectMask();" />
                            <asp:HiddenField ID="txtMaskID" runat="server" Value="-1" />
                        </td>
                        <td class="Label2">存储期限(天)
                        </td>
                        <td class="Field2">


                            <asp:TextBox ID="txtShelfLife" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">老化方式
                        </td>
                        <td class="Field2">
                            <asp:DropDownList runat="server" ID="txtAgeingType" ClientIDMode="Static">
                                <asp:ListItem Value="-1" Selected="True">=请选择=</asp:ListItem>
                                <asp:ListItem Value="0">产品</asp:ListItem>
                                <asp:ListItem Value="1">老化架</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">老化时长(小时)
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtAgeingTime" runat="server"
                                onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" value="0" IsNumber='1' onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')"></asp:TextBox>

                        </td>

                    </tr>
                    <tr>
                        <td class="Label2">ABC等级</td>
                        <td class="Field2">
                            <asp:DropDownList runat="server" ID="ddlItemABC" ClientIDMode="Static">
                                <asp:ListItem Value="" Selected="True">=请选择=</asp:ListItem>
                                <asp:ListItem Value="A">A</asp:ListItem>
                                <asp:ListItem Value="B">B</asp:ListItem>
                                <asp:ListItem Value="C">C</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">保质期方案</td>
                        <td class="Field2">
                            <asp:TextBox ID="txtItemExpirationDate" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox><input
                                type="button" id="" class="ButtonBox" value="..." title="" onclick="selectExpirationDate();" />
                            <asp:HiddenField ID="HiddenExpirationDate" runat="server" Value="-1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.IsShipmentReport %>

                        </td>
                        <td class="Field2">
                            <asp:CheckBox ID="cbIsShipmentReport" runat="server" ClientIDMode="Static" />
                        </td>
                        <td class="Label2">
                            <%=Resources.lang.IsLaboratoryReport %>

                        </td>
                        <td class="Field2">
                            <asp:CheckBox ID="cbIsUpTestExport" runat="server" ClientIDMode="Static" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">颜色
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtColor" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                        </td>
                        <td class="Label2">材质
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtTextureOfMaterial" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">阻燃等级
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtFlameRetardantLevel" runat="server" CssClass="TextBox" ClientIDMode="Static"></asp:TextBox>
                        </td>
                        <td class="Label2">料把
                        </td>
                        <td class="Field2">
                            <asp:CheckBox ID="chbIsMaterialHandle" runat="server" ClientIDMode="Static" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">可超量完工类型
                        </td>
                        <td class="Field2">
                            <asp:DropDownList runat="server" ID="ddlOverFinshType" ClientIDMode="Static" Enabled="false">
                                <asp:ListItem Value="-1" Selected="True">=请选择=</asp:ListItem>
                                <asp:ListItem Value="0">不可超量</asp:ListItem>
                                <asp:ListItem Value="1">固定数量</asp:ListItem>
                                <asp:ListItem Value="2">比例</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="Label2">完工超额量
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtOverQty" runat="server" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" value="0" IsNumber='1' onafterpaste="this.value=this.value.replace(/[^\d]/g,'')" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">完工超额比例
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtOverRate" runat="server" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" value="0" IsNumber='1' onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')" Enabled="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">原料料号
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtMaterialPartNumber" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                            <input type="button" id="btnSelectMaterialPartNumber" class="ButtonBox" value="..." title="选择原料料号" onclick="selectMaterialPartNumber();" />
                            <asp:HiddenField ID="hdnMaterialPartNumberId" runat="server" Value="-1" />
                        </td>
                        <td class="Label2">料把料号
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtMaterialHandleNumber" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                            <input type="button" id="btnSelectMaterialHandleNumber" class="ButtonBox" value="..." title="选择料把料号" onclick="selectMaterialHandleNumber();" />
                            <asp:HiddenField ID="hdnMaterialHandleNumberId" runat="server" Value="-1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">碎料料号
                        </td>
                        <td class="Field2">
                            <asp:TextBox ID="txtScrapMaterialNumber" runat="server" CssClass="TextBox" Enabled="false"></asp:TextBox>
                            <input type="button" id="btnSelectScrapMaterialNumber" class="ButtonBox" value="..." title="选择碎料料号" onclick="selectScrapMaterialNumber();" />
                            <asp:HiddenField ID="hdnScrapMaterialNumberId" runat="server" Value="-1" />
                        </td>
                    </tr>
                    <tr>
                        <td class="Label2">
                            <%=Resources.lang.Description %>
                        </td>
                        <td class="Field2" colspan="3">
                            <asp:TextBox ID="txtItemDesc" runat="server" CssClass="TextArea" TextMode="MultiLine"
                                Width="98%" Height="80px"></asp:TextBox><span class="Tips"><%=String.Format(Resources.lang.CanInputCharacter,200)%></span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="clear5">
            </div>
        </div>
        <div>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                <%=Resources.lang.AvailableCertification%>
                            </div>
                            <div id="avilableCerList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="lbAvilableCerList" runat="server" Height="300px" Width="253px" SelectionMode="Multiple"
                                    CssClass="Padd7"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                    <td align="center" valign="middle">
                        <div style="width: 90px; text-align: center">
                            <input type="button" class="rightButton" onclick="assignCert();" title="<%=Resources.lang.AssignCertification %>" />
                            <br />
                            <br />
                            <br />
                            <input type="button" class="leftButton" onclick="deleteCert();" title="<%=Resources.lang.DeleteCertification %>" />
                        </div>
                    </td>
                    <td align="center" valign="top">
                        <div style="width: 253px;">
                            <div class="divHeader" style="text-align: left">
                                <img src="../Content/images/icon/list.png" style="vertical-align: middle;">
                                <%=Resources.lang.RequiredCertification %>
                            </div>
                            <div id="assignCerList" style="display: block; margin-top: -7px; margin-left: -3px;">
                                <asp:ListBox ID="lbAssignCerList" runat="server" Height="300px" Width="253px" SelectionMode="Multiple"
                                    CssClass="Padd7"></asp:ListBox>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div style="display: none;">
            <div style="text-align: center; position: relative; height: 288px;">
                <div style="width: 273px; float: left; position: absolute; top: 5px; left: 5px;">
                    <div style="text-align: center;">
                        <strong>
                            <%=Resources.lang.AvailableDocument%></strong>
                    </div>
                    <div id="Div1">
                        <asp:ListBox ID="lbAvailableDocList" runat="server" Height="250px" Width="270px"
                            SelectionMode="Multiple" CssClass="TextArea"></asp:ListBox>
                    </div>
                </div>
                <div style="width: 50px; float: left; text-align: center; position: absolute; top: 5px; left: 340px;">
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <input type="button" value=" >> " class="SearchButton" onclick="assignPrintDoc();"
                        title="<%=Resources.lang.AssignDocument %>" />
                    <br />
                    <br />
                    <br />
                    <input type="button" value=" << " class="SearchButton" onclick="deletePrintDoc();"
                        title="<%=Resources.lang.DeleteDocument %>" />
                </div>
                <div style="width: 273px; float: left; position: absolute; top: 5px; right: 5px;">
                    <div style="text-align: center;">
                        <strong>
                            <%=Resources.lang.PrintDocument %></strong>
                    </div>
                    <div id="Div2" style="display: block;">
                        <asp:ListBox ID="lbPrintDocList" runat="server" Height="250px" Width="270px" SelectionMode="Multiple"></asp:ListBox>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <table id="tblExtensionInfos" class="EditeContentTable" width="100%">
                <tr id="trNewInfo">
                    <td colspan="4" style="text-align: center;">
                        <%=Resources.lang.NoExtendedInfos %>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <input type="hidden" value="-1" id="hdnCategoryOne" />
    <input type="hidden" value="-1" id="hdnCategoryTwo" />
    <script type="text/javascript">
        $(document).ready(function () {
            if ($("#chkIsPanel").prop("checked")) {
                $("#trIsPanel").show();
                $("#trIsPanelPrint").show();
            }

            $("#chkIsPanel").click(function () { chkIsPanelClick() });

            $("#<%=this.chkIsMSD.ClientID%>").click(function () {
                if (this.checked) {
                    $(".isMsd").show();
                } else {
                    $(".isMsd").hide();
                }
            });

            if ($("#chkIsSMT").prop("checked")) {
                $(".IsSmtCss").show();
            } else {
                $(".IsSmtCss").hide();
            }

            $("#chkIsSMT").click(function () {
                if ($("#chkIsSMT").prop("checked")) {
                    $(".IsSmtCss").show();
                } else {
                    $(".IsSmtCss").hide();
                }
            });


            $("#txtFloorLife,#txtBakeCount,#txtShelfLife").bind("keyup", function () {
                getIntVal(this);
            });

            $("#ddlMSL").bind("change", function () {
                getMSLInfo(this.value);
            });

            if ($("#<%=this.chkIsMSD.ClientID%>").is(":checked")) {
                $(".isMsd").show();
            }
        })

        function Save() {
            debugger
            var userName = '<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>';
            var itemId = '<%=ItemId %>';

            //选择保质期方案时，存储期限不能为0
            var expirationDateId = $("#<%=this.HiddenExpirationDate.ClientID%>").val();
            var txtShelfLifeValue = $("#<%=this.txtShelfLife.ClientID%>").val();
            if (expirationDateId > 0) {
                if (txtShelfLifeValue <= 0) {
                    alert("请填写存储期限");
                    $("#<%=this.txtShelfLife.ClientID%>").focus();
                    return;
                }
            }

            //产品基础数据
            var txtItemCode = $("#<%=this.txtItemCode.ClientID%>").val().trim();
            var txtItemsName = $("#<%=this.txtItemsName.ClientID%>").val().trim();
            var txtVersion = $("#<%=this.txtVersion.ClientID%>").val();
            var ddlItemGroup = $("#<%=this.ddlItemGroup.ClientID%>").val();
            var hdnProjectId = $("#<%=this.hdnProjectId.ClientID%>").val();
            var hdnCustomerId = $("#<%=this.hdnCustomerId.ClientID%>").val();
            var txtCPN = $("#<%=this.txtCPN.ClientID%>").val();
            var txtCPR = $("#<%=this.txtCPR.ClientID%>").val();
            var ddlItemStatus = $("#<%=this.ddlItemStatus.ClientID%>").val();
            var ddlItemType = $("#<%=this.ddlItemType.ClientID%>").val();
            var hdnRouterId = $("#<%=this.hdnRouterId.ClientID%>").val();
            var hdnBomId = $("#<%=this.hdnBomId.ClientID%>").val();
            var txtLotSize = $("#<%=this.txtLotSize.ClientID%>").val();
            var ckbCurrentVer = ($("#<%=this.ckbCurrentVer.ClientID%>").is(":checked"));
            var txtItemDesc = $("#<%=this.txtItemDesc.ClientID%>").val();
            var packQty = $("#<%=this.txtMinPackQty.ClientID%>").val();
            var qcMinNum = $("#<%=this.qcMinNum.ClientID%>").val();
            var txtUnit = $("#<%=this.txtUnits.ClientID%>").val();
            var ddlIqcType = $("#<%=this.ddlIQCType.ClientID %>").val();
            var txtLabelItemModel = $("#<%=this.txtLabelItemModel.ClientID %>").val().trim();
            var txtLabelFirmware = $("#<%=this.txtLabelFirmware.ClientID %>").val();
            var putStation = $("#<%=this.InputStationDrop.ClientID %>").val();
            var yieldStation = $("#<%=this.YieldStationDrop.ClientID %>").val();
            var categoryOne = $("#<%=this.txtCategoryOne.ClientID %>").val();
            var categoryTwo = $("#<%=this.txtCategoryTwo.ClientID %>").val();
            var categoryThree = $("#<%=this.txtCategoryThree.ClientID %>").val();
            var chkIsMSD = $("#<%=this.chkIsMSD.ClientID%>").is(":checked");
            var txtMSL = $("#<%=this.ddlMSL.ClientID%>").find("option:selected").text();
            var txtFloorLife = $("#<%=this.txtFloorLife.ClientID%>").val();
            var txtShelfLife = txtShelfLifeValue; //$("#<%=this.txtShelfLife.ClientID%>").val();
            var txtBakeCount = $("#<%=this.txtBakeCount.ClientID%>").val();
            var txtSite = $("#<%=this.hdnSite.ClientID%>").val();
            var txtMaskID = $("#<%=this.txtMaskID.ClientID%>").val();
            var ddlItemABC = $("#<%=this.ddlItemABC.ClientID%>").val();
            var IssueWay = $("#<%=this.ddlIssueWay.ClientID%>").val();
            var ddlProductionFace = $("#<%=this.ddlProductionFace.ClientID%>").val();
            var txtPriority = $("#<%=this.txtPriority.ClientID%>").val();
            var ddlAcquisitionMode = $("#<%=this.ddlAcquisitionMode.ClientID%>").val();
            var ddlIsSeniorBatch = $("#<%=this.ddlIsSeniorBatch.ClientID%>").val();
            var txtColor = $("#<%=this.txtColor.ClientID%>").val();
            var txtTextureOfMaterial = $("#<%=this.txtTextureOfMaterial.ClientID%>").val();
            var txtFlameRetardantLevel = $("#<%=this.txtFlameRetardantLevel.ClientID%>").val();
            var isMaterialHandle = $("#<%=this.chbIsMaterialHandle.ClientID%>").is(":checked");
            var ddlOverFinshType = $("#<%=this.ddlOverFinshType.ClientID%>").val();
            var txtOverQty = $("#<%=this.txtOverQty.ClientID%>").val();
            var txtOverRate = $("#<%=this.txtOverRate.ClientID%>").val();
            var MaterialPartNumberCode = $("#<%=this.txtMaterialPartNumber.ClientID%>").val();
            var MaterialHandleNumberCode = $("#<%=this.txtMaterialHandleNumber.ClientID%>").val();
            var ScrapMaterialNumberCode = $("#<%=this.txtScrapMaterialNumber.ClientID%>").val();
            if (txtItemCode.length > 100) {
                alert("产品编码不可超过100字符");
                return;
            }
            if (txtItemsName.length > 300) {
                alert("产品名称不可超过300字符");
                return;
            }
            if (txtVersion.length > 10) {
                alert("版本不可超过10字符");
                return;
            }
            if (ddlAcquisitionMode == 2 && ddlIsSeniorBatch == -1) {
                alert("批次产品需要选择是否是高级批次，请选择！");
                return;
            }
            if (ddlAcquisitionMode == 1) {
                ddlIsSeniorBatch = 0;
            }
            //数据收集
            var hdnDataTypeID = $("#<%=this.hdnDataTypeID.ClientID%>").val();

            //资格证书
            var lbAssignCerList = $("#<%=this.lbAssignCerList.ClientID%> option").length;
            var cerListString = "";
            if (lbAssignCerList > 0) {
                $("#<%=this.lbAssignCerList.ClientID%> option").each(function () {

                    cerListString += $(this).val() + ",";
                });
            }
            cerListString = cerListString.substring(0, cerListString.length - 1);

            //打印文档
            var lbPrintDocList = $("#<%=this.lbPrintDocList.ClientID%> option").length;
            var printDocListString = "";
            if (lbPrintDocList > 0) {
                $("#<%=this.lbPrintDocList.ClientID%> option").each(function () {
                    printDocListString += $(this).val() + ",";
                });
            }
            printDocListString = printDocListString.substring(0, printDocListString.length - 1);
            var errStr = "";
            var type = "^[0-9]*$";
            var re = new RegExp(type);
            if (packQty.match(re) == null) {
                alert("请输入0或者正整数!");
                return;
            }
            if (qcMinNum.match(re) == null) {
                alert("请输入0或者正整数!");
                return;
            }


            //验证必填项
            if (isNull(txtItemCode)) {
                errStr += "<%=Resources.Messages.ItemCodeIsRequired %>\n";
            }
            if (isNull(txtItemsName)) {
                errStr += "<%=Resources.Messages.ItemNameIsRequired %>\n";
            }
            if (isNull(txtVersion)) {
                errStr += "<%=Resources.Messages.ItemRevisionIsRequired %>\n";
            }
            if (isNull(txtLotSize)) {
                errStr += "<%=Resources.Messages.LotSizeIsRequired %>\n";
            }
            if (!isNumber(txtLotSize) && !isDecimal(txtLotSize)) {
                errStr += "<%=Resources.Messages.LotSizeIsNumerical %>\n";
            }

            if (!isNull(errStr)) {
                alert(errStr);
                return false;
            }

            //保存数据
            var entity = {};
            entity.ItemID = itemId;
            entity.ItemName = txtItemsName;
            entity.ItemCode = txtItemCode;
            entity.ItemRev = txtVersion;
            entity.Description = txtItemDesc;
            entity.CPN = txtCPN;
            entity.CustomerID = hdnCustomerId;
            entity.CPR = txtCPR;
            entity.Status = ddlItemStatus;
            entity.ProjectID = hdnProjectId;
            entity.ItemType = ddlItemType;
            entity.RouterID = hdnRouterId;
            entity.BomId = hdnBomId;
            entity.LotSize = txtLotSize;
            entity.MaxUsageAsComp = 0.0;
            entity.QtyRestriction = 0;
            entity.QtyMultiplier = 0.0;
            entity.IsCurrentRev = ckbCurrentVer;
            entity.IsPanel = false;
            entity.IsPrintPanel = false;
            entity.IsCPSFC = false;
            entity.IsRoHS = false;
            entity.DCORemoval = -1;
            entity.DCOAssembly = hdnDataTypeID;
            entity.DCOInveRec = -1;
            entity.RecInveWhenAss = false;
            entity.VMGroup = -1;
            entity.TrackableComp = false;
            entity.ItemGroupID = ddlItemGroup;
            entity.CreateBy = userName;
            entity.ModifyBy = userName;
            entity.Remark = "";
            entity.MinPackQty = parseFloat(packQty);
            //成品最小数量
            entity.QcMinNum = parseFloat(qcMinNum);

            entity.IQCType = ddlIqcType;
            entity.Units = txtUnit;
            entity.SteelId = -1;
            entity.ParentNumber = 0;
            entity.ChildrenNumber = 0;
            entity.ItemModel = txtLabelItemModel;
            entity.LabelFirmware = txtLabelFirmware;
            //2016-01-17陆文元新增两个字段
            entity.IsNeedPrint = 0;
            entity.IsVendorPrint = 0;

            entity.PutStation = putStation; //投入站
            entity.YieldStation = yieldStation; //产出站

            entity.CategoryOne = categoryOne;
            entity.CategoryTwo = categoryTwo;
            entity.CategoryThree = categoryThree;
            entity.IsMSD = chkIsMSD;
            entity.MSL = $("#<%=this.ddlMSL.ClientID%>").val() == "-1" ? "" : txtMSL;
            entity.FloorLife = txtFloorLife == "" ? 0 : txtFloorLife;
            entity.BakeCount = txtBakeCount == "" ? 0 : txtBakeCount;
            entity.ShelfLife = txtShelfLife == "" ? 0 : txtShelfLife;
            entity.Site = txtSite;
            entity.MaskId = txtMaskID;
            /*保存老化信息*/
            entity.AgeingType = $("#<%=this.txtAgeingType.ClientID%>").val();
            entity.AgeingTime = parseFloat($("#<%=this.txtAgeingTime.ClientID%>").val());

            entity.ABCClass = ddlItemABC;
            entity.IssueWay = IssueWay;
            entity.ExpirationDateId = $("#<%=this.HiddenExpirationDate.ClientID%>").val();
            entity.IsNeedPrint = 1;
            entity.ProductionFace = ddlProductionFace;
            entity.Priority = txtPriority;
            entity.AcquisitionMode = ddlAcquisitionMode;
            entity.IsSeniorBatch = ddlIsSeniorBatch;
            entity.Colour = txtColor;
            entity.TextureOfMaterial = txtTextureOfMaterial;
            entity.FlameRetardantLevel = txtFlameRetardantLevel;
            entity.IsSmt = $("#<%=this.chkIsSMT.ClientID%>").is(":checked");
            entity.IsMaterialHandle = isMaterialHandle;
            entity.OverFinshType = ddlOverFinshType;
            entity.OverQty = txtOverQty == "" ? 0 : parseInt(txtOverQty);
            entity.OverRate = txtOverRate == "" ? 0 : parseFloat(txtOverRate);
            entity.MaterialPartNumberCode = MaterialPartNumberCode;
            entity.MaterialHandleNumberCode = MaterialHandleNumberCode;
            entity.ScrapMaterialNumberCode = ScrapMaterialNumberCode;
            if (entity.AgeingType != -1) {
                if (entity.AgeingTime == "0" || entity.AgeingTime == "") {
                    alert("老化时长必须大于0");
                    return false;
                }
            }
            if ($("#chkPrintPanelSN").prop("checked")) {
                entity.IsPanelPrint = true;
            }
            //是否拼版如果没有check,则是否打印拼版也为false
            if ($("#chkIsPanel").prop("checked")) {
                entity.IsPanel = true;
                entity.ParentNumber = $("#<%=this.txtPanelQty.ClientID %>").val();
                entity.ChildrenNumber = $("#<%=this.txtChildQty.ClientID %>").val();
            } else {
                entity.IsPanelPrint = false;
            }

            //是否是供应商打印
            if ($("#chbIsItemOver").prop("checked")) {
                entity.IsItemOver = true;
            }
            if ($("#cbIsShipmentReport").prop("checked")) {
                entity.IsShipmentReport = true;
            }
            if ($("#cbIsUpTestExport").prop("checked")) {
                entity.IsUpTestExport = true;
            }
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.ItemEdit(entity, cerListString, printDocListString);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            //保存扩展信息
            var extIds = new Array();
            $("input[class='ExtId']").each(function () {
                extIds.push($(this).val());
            });
            var extFieldsIds = new Array();
            $("input[class='ExtFieldsId']").each(function () {
                extFieldsIds.push($(this).val());
            });
            var extFieldValues = new Array();
            $("input.ExtFieldValue").each(function () {
                if ($(this).attr("type") == "radio") {
                    if ($(this).is(":checked")) {
                        extFieldValues.push($(this).val().toString());
                    } else {
                        extFieldValues.push("null");
                    }
                } else {
                    if ($(this).val() != null && $(this).val() != "") {
                        extFieldValues.push($(this).val().toString());
                    } else {
                        extFieldValues.push("null");
                    }
                }
            });
            var extIdStrs = extIds.join(',') + ',';
            var extFieldsIdStrs = extFieldsIds.join(',') + ',';
            var extFieldValueStrs = extFieldValues.join(',') + ',';
            var extAjax = SKT.LeanMES.Web.AjaxServices.AjaxBaseExt.BaseExtInfoListEdit(extIdStrs, extFieldsIdStrs, extFieldValueStrs, itemId, "Basal_Item");
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert("<%=Resources.Messages.SaveInSuccess %>");
            parent.window.UpdateList(txtItemCode);
        }

        var chooseFlag = 0;

        function assignCert() {
            var selectedCert = $("#<%=this.lbAvilableCerList.ClientID %> option:selected").length;
            if (selectedCert <= 0) {
                alert("<%=Resources.Messages.QualificationCertificatinIsRequired %>");
                return false;
            }
            $("#<%=this.lbAvilableCerList.ClientID %> option").each(function () {
                if ($(this).attr("selected")) {
                    $("#<%=this.lbAssignCerList.ClientID %>").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }

        function deleteCert() {
            var selectedCert = $("#<%=this.lbAssignCerList.ClientID %> option:selected").length;
            if (selectedCert <= 0) {
                alert("<%=Resources.Messages.QualificationCertificatinIsRequired %>");
                return false;
            }
            $("#<%=this.lbAssignCerList.ClientID %> option").each(function () {
                if ($(this).attr("selected")) {
                    $("#<%=this.lbAvilableCerList.ClientID %>").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }
        /*选择客户*/
        function selectCustomer() {
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }
        /*选择项目*/
        function selectProject() {
            chooseFlag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=9&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }
        /*选择数据类型*/
        function selectDataType() {
            chooseFlag = 3;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=2&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }
        //选择路由
        function selectRouter() {
            chooseFlag = 4;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=22&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }

        /*选择Bom*/
        function selectBom() {
            chooseFlag = 5;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=108&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }
        /*选择单位*/
        function selectDictory() {
            chooseFlag = 6;
            var searchCondition = " DicProperty ='Unit' ";
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=3&PageCondition=" + searchCondition + "&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }
        /*选择钢网*/
        function selectMesh() {
            chooseFlag = 7;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=48&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }
        /*选择保质期方案*/
        function selectExpirationDate() {
            chooseFlag = 8;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=610&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }
        /*选择原料料号*/
        function selectMaterialPartNumber() {
            chooseFlag = 9;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }
        /*选择料把料号*/
        function selectMaterialHandleNumber() {
            chooseFlag = 10;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }
        /*选择碎料料号*/
        function selectScrapMaterialNumber() {
            chooseFlag = 11;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 600, height: 350 });
        }
        function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtCustomer.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnCustomerId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 2) {
                $("#<%=this.txtProject.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnProjectId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 3) {
                $("#<%=this.txtDataType.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnDataTypeID.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 4) { //路由，应该把对应的站点绑定到投入产出下拉框
                $("#<%=this.txtRouter.ClientID %>").val(list[0][1]);
                $("#<%=this.hdnRouterId.ClientID %>").val(list[0][0]);
                if (list[0][0] != -1) {
                    BindStation(list[0][0]);
                }
            }
            else if (chooseFlag == 5) {
                if (list[0][2] == "") {
                    $("#<%=this.txtItemBom.ClientID %>").val(list[0][1]);
                }
                else {
                    $("#<%=this.txtItemBom.ClientID %>").val(list[0][1] + "(" + list[0][2] + ")");
                }
                $("#<%=this.hdnBomId.ClientID %>").val(list[0][0]);
            }
            else if (chooseFlag == 6) {
                $("#<%=this.txtUnits.ClientID %>").val(list[0][1]);
            } else if (chooseFlag == 8) {
                $("#<%=this.txtItemExpirationDate.ClientID %>").val(list[0][1]);
                $("#<%=this.HiddenExpirationDate.ClientID%>").val(list[0][0]);
            } else if (chooseFlag == 9) {
                $("#<%=this.txtMaterialPartNumber.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnMaterialPartNumberId.ClientID %>").val(list[0][0]);
            } else if (chooseFlag == 10) {
                $("#<%=this.txtMaterialHandleNumber.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnMaterialHandleNumberId.ClientID %>").val(list[0][0]);
            } else if (chooseFlag == 11) {
                $("#<%=this.txtScrapMaterialNumber.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnScrapMaterialNumberId.ClientID %>").val(list[0][0]);
            }
            chooseFlag = 0;
        }
        //绑定投入站产出站
        function BindStation(routerId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxProduct.GetLayout(parseInt(routerId));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            } else {
                if (!ajax.value) {
                    alert("未找到路由详情信息，请先设计好路由！");
                    $("#<%=this.txtRouter.ClientID %>").val("");
                    $("#<%=this.hdnRouterId.ClientID %>").val(-1);
                    $("#InputStationDrop option:gt(0),#YieldStationDrop option:gt(0)").remove();
                    return false;
                }
                BindDrop("InputStationDrop", ajax.value);
                BindDrop("YieldStationDrop", ajax.value);
            }
        }

        ///weilin.liu
        function BindDrop(dropId, routerInfo) {
            var ddl = $("#" + dropId);
            $(ddl).empty();
            opt = $("<option></option>").text("=请选择=").val("-1");
            ddl.append(opt);
            if (!routerInfo.R_JSON && !routerInfo.RouterJson) {
                return false;
            }
            //旧的路由数据
            if (routerInfo.R_JSON) {
                var result = eval("[" + routerInfo.R_JSON + "]");
                $(result[0].OperationNode).each(function (key) {
                    id = result[0].OperationNode[key].OperationID;
                    name = result[0].OperationNode[key].OperationName;
                    if (id != "-10" && id != "-20") {
                        opt = $("<option></option>").text(name).val(id);
                        ddl.append(opt);
                    }
                });
            }
            else {  //新的路由数据
                var result = eval("[" + routerInfo.RouterJson + "]");
                $.each(result[0], function (i, o) {
                    if (o.type == "rect") {
                        id = o.value;
                        name = o.text;
                        if (id != "-10" && id != "-20") {
                            opt = $("<option></option>").text(name).val(id);
                            ddl.append(opt);
                        }
                    }
                });
            }
        }
        function assignPrintDoc() {
            var docList = $("#<%=this.lbAvailableDocList.ClientID %> option:selected").length;
            if (docList <= 0) {
                alert("<%=Resources.Messages.PrintDocumentIsRequired %>");
                return false;
            }

            $("#<%=this.lbAvailableDocList.ClientID %> option").each(function () {
                if ($(this).attr("selected")) {
                    $("#<%=this.lbPrintDocList.ClientID %>").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }

        function deletePrintDoc() {
            var docList = $("#<%=this.lbPrintDocList.ClientID %> option:selected").length;
            if (docList <= 0) {
                alert("<%=Resources.Messages.PrintDocumentIsRequired %>");
                return false;
            }

            $("#<%=this.lbPrintDocList.ClientID %> option").each(function () {
                if ($(this).attr("selected")) {
                    $("#<%=this.lbAvailableDocList.ClientID %>").append("<option value=\"" + $(this).val() + "\">" + $(this).text() + "</option>");
                    $(this).remove();
                }
            });
        }

        function chkIsPanelClick() {
            if ($("#chkIsPanel").prop("checked")) {
                $("#trIsPanel").show();
                $("#trIsPanelPrint").show();
            } else {
                $("#trIsPanel").hide();
                $("#trIsPanelPrint").hide();
            }
        }

        /*加载扩展字段信息*/
        function loadExtsionInfos() {
            var itemId = '<%= Request.QueryString["ID"] %>';
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxBaseExt.GetExtsionInfoListByItemId(itemId, "Basal_Item");
            if (ajax.error != null) {
                return false;
            }

            var list = ajax.value;
            if (list != null && list != undefined && list.length > 0) {
                /*显示扩展字段信息*/
                var r = "";
                var listLength = list.length;
                for (var i = 0; i < listLength; i++) {
                    if (i % 2 == 0) {
                        r += "<tr>";
                    }
                    r += "<td class='Label2'><label id='lblExtFieldDescription" + i + "' name='ExtFieldDescription'>" + list[i].ExtFieldDescription + "</label>";
                    r += "<input type='hidden' id='txtExtId" + i + "' class='ExtId' value='" + (list[i].ExtId == null ? -1 : list[i].ExtId) + "' /><input type='hidden' id='txtExtFieldsId" + i + "' class='ExtFieldsId' value='" + list[i].ExtFieldsId + "' /><input type='hidden' id='txtSequence" + i + "' class='Sequence' value='" + list[i].Sequence + "' />";
                    r += "</td><td class='Field2'>";
                    //字段类型为布尔
                    if (list[i].ExtFieldType == "bit" || list[i].ExtFieldType == "bool") {
                        if (list[i].ExtFieldValue == "true" || list[i].ExtFieldValue == "True") {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' checked='checked' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='false";
                        } else if (list[i].ExtFieldValue == "false" || list[i].ExtFieldValue == "False") {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' value='false' checked='checked";
                        } else {
                            r += "<%=Resources.lang.Yes %><input type='radio' id='radExtFieldValue" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' class='ExtFieldValue' value='true' />&nbsp;&nbsp;&nbsp;&nbsp;<%=Resources.lang.No %><input type='radio' id='radExtFieldValue" + i + "" + i + "' tag='radExtFields' name='radExtFields" + list[i].ExtFieldName + "' value='false";
                        }
                    } else if (list[i].ExtFieldType == "datetime") { //字段类型为时间
                        r += "<input type='text' id='txtExtFieldValue" + i + "' name='dateExtFields' class='ExtFieldValue' readonly value='";
                        if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                            r += list[i].ExtFieldValue;
                        }
                    } else if (list[i].ExtFieldType == "int") {
                        r += "<input type='text' id='txtExtFieldValue" + i + "' name='intExtFields' class='ExtFieldValue'  value='";
                        if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                            r += list[i].ExtFieldValue;
                        }
                    } else { //字段类型为字符
                        r += "<input type='text' id='txtExtFieldValue" + i + "' name='txtExtFields' class='ExtFieldValue' value='";
                        if (list[i].ExtFieldValue != null && list[i].ExtFieldValue != undefined && list[i].ExtFieldValue != "") {
                            r += list[i].ExtFieldValue;
                        }
                    }

                    r += "' /></td>";
                    if (i % 2 == 0 && i == listLength - 1) {
                        r += "<td class='Label2'></td><td class='Field2'></td></tr>";
                    } else if (i % 2 != 0) {
                        r += "</tr>";
                    } else {
                        r += "";
                    }
                }
                $("#trNewInfo").remove();
                $("#tblExtensionInfos").append(r);
            } else {
                $("#tblExtensionInfos tr").remove();
                $("#tblExtensionInfos").append("<tr><td colspan='4' style='text-align:center;'><font color='red'><%=Resources.lang.NoExtendedInfos %>！</font></td>");
            }

            //对于子页面动态生成html标签，对语言变量重新赋值，目的，可以重新进入方法体执行翻译，执行完后会调用模板翻译方法，如果有子页面没有模板页情况可单独再调用方法
            var lang = $("#hfMESLang").val();
            if (lang != "zh-cn") {
                isInitLang = false;
            }

        }

        $(function () {
            loadExtsionInfos();
            $("input[name='dateExtFields']").datepicker({
                showHms: false
            });
            $("input[name='intExtFields']").change(function () {
                if (!this.value.match(/^(?:[\+\-]?\d+(?:\.\d+)?|\.\d*?)?$/)) {
                    this.value = "";
                    alert("只能输入数字");
                    this.focus();
                }
            });
            changeRadioClass();

            $("#txtAgeingType").bind("change", function () {

                if ($(this).val() == -1) {

                    $("#<%=this.txtAgeingTime.ClientID%>").val(0);
                }
            });


        });

        function changeRadioClass() {
            $('input[tag="radExtFields"]').click(function () {
                $(this).attr('class', 'ExtFieldValue');
                $(this).siblings().removeClass();
            });
        }

        var chooseFlagCategory = 0;
        function selectCategory(flag) {
            chooseFlagCategory = flag;
            var pageCondition = "";
            var parentId = -1;

            if (flag == 1) {
                pageCondition = "ParentId = -1";
            }
            else if (flag == 2) {
                parentName = $("#txtCategoryOne").val();
                if (parentName == "") {
                    alert("请先选择产品大类！");
                    return false;
                }
                pageCondition = "ParentName='" + parentName + "'";

            }
            else if (flag == 3) {
                parentName = $("#txtCategoryTwo").val();
                if (parentName == "") {
                    alert("请先选择产品中类！");
                    return false;
                }
                pageCondition = "ParentName='" + parentName + "'";
            }
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=110&CallBackFunc=getCategoryValue&PageCondition=" + escape(pageCondition) + "&Multiple=false&rnd=" + Math.random(), width: 550, height: 350 });
        }

        function selectFactoryCode(Flag) {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=47&CallBackFunc=getFactoryInfo&Multiple=false&rnd=" + Math.random(), width: 550, height: 350 });
        }

        function getFactoryInfo(list) {
            $("#<%=this.hdnSite.ClientID%>").val(list[0][1]);
            $("#<%=this.txtFactoryName.ClientID%>").val(list[0][2]);
        }

        function getCategoryValue(list) {
            if (chooseFlagCategory == 1) {
                $("#txtCategoryOne").val(list[0][2]);
                $("#txtCategoryTwo").val("");
                $("#txtCategoryThree").val("");
            }
            else if (chooseFlagCategory == 2) {
                $("#txtCategoryTwo").val(list[0][2]);
                $("#txtCategoryThree").val("");
            }
            else if (chooseFlagCategory == 3) {
                $("#txtCategoryThree").val(list[0][2]);
            }
        }

        function getMSLInfo(mslId) {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxMSD.GetMSLInfo(mslId);
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            else {
                var entity = ajax.value;
                if (entity != null) {
                    $("#<%=this.labFloorLife.ClientID%>").text(entity.FloorLife);
                    $("#<%=this.labBakeCount.ClientID%>").text(entity.BakeCount);

                    $("#<%=this.txtFloorLife.ClientID%>").val(entity.FloorLife);
                    $("#<%=this.txtBakeCount.ClientID%>").val(entity.BakeCount);
<%--                $("#<%=this.txtShelfLife.ClientID%>").val(entity.ShelfLife);--%>

                }
            }
        }

        /**
        *选择掩码组信息
        **/
        function selectMask() {
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=24&CallBackFunc=getMaskInfo&Multiple=false&rnd=" + Math.random(), width: 550, height: 350 });
        }

        /**
        *设置掩码组信息
        **/
        function getMaskInfo(list) {
            $("#<%=this.txtMask.ClientID %>").val(list[0][1]);
            $("#<%=this.txtMaskID.ClientID %>").val(list[0][0]);
        }
    </script>
</asp:Content>
