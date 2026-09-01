<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="MaterialdoApplyView.aspx.cs" Inherits="SKT.LeanMES.Web.Material.MaterialdoApplyView" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
	<style type="text/css">
        .rbl tr td
        {
            padding: 5px;
            margin: 3px;
            cursor:pointer;
            border:1px solid #ffffff;
            vertical-align:middle;
        }
        .rbl tr td:hover
        {
            padding: 5px;
            margin: 3px;
            cursor:pointer;
            border:1px solid #d3d3d3;
            background:#f1f1f1;
            vertical-align:middle;
        }
    </style>
	<table width="100%" class="EditeContentTable">
        <tr>
            <td class="Label2">
                领料单
            </td>
            <td class="Field2">
				<asp:Label ID="lblApplyNO" runat="server" Text=""></asp:Label>
            </td>
			<td class="Label2">
                领料类型
            </td>
            <td class="Field2">
				<asp:Label ID="lblApplyType" runat="server" Text=""></asp:Label>
            </td>
        </tr>
         <tr>
            <td class="Label2">
                部门
            </td>
            <td class="Field2">
				<asp:Label ID="lblDepartName" runat="server" Text=""></asp:Label>
            </td>
			<td class="Label2">
                仓库
            </td>
            <td class="Field2">
				<asp:Label ID="lblWareHouse" runat="server" Text=""></asp:Label>
            </td>
        </tr>
		 <tr>
            <td class="Label2">
                领料状态
            </td>
            <td class="Field2">
				<asp:Label ID="lblStatusName" runat="server" Text=""></asp:Label>
            </td>
			<td class="Label2">
                使用日期
            </td>
            <td class="Field2">
				<asp:Label ID="lblUseDate" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
	<div class="wrap_tb">
        <ul class="tb">
            <li class="current">物料备料信息</li>
            <li>GRN备料信息</li>
        </ul>
        <!--物料备料信息-->
        <div class="tb_c" id="userInfo_tb">
			<asp:GridView ID="GridView1" runat="server" CssClass="gridTable" OnRowDataBound="GridView1_RowDataBound" style="table-layout:fixed;word-wrap:break-word;word-break:break-all" AutoGenerateColumns="false">
				<Columns>
					<asp:BoundField DataField="ItemCode" HeaderText="物料编码"  />
					<asp:BoundField DataField="ItemName" HeaderText="物料名称" />
					<asp:BoundField DataField="ApplyQty" HeaderText="未备料数量" />
					<asp:BoundField DataField="ApplyQty" HeaderText="备料数量" />
					<asp:BoundField DataField="StockQty" HeaderText="已备数量" />
				</Columns>
				<RowStyle CssClass="ListTableOddRow" />
				<HeaderStyle CssClass="ListTableHeader" />
			</asp:GridView>
		 </div>
		<!--GRN备料信息 -->
        <div id="userRole_tb">
			<asp:GridView ID="GridView2" runat="server" CssClass="gridTable"  style="table-layout:fixed;word-wrap:break-word;word-break:break-all" AutoGenerateColumns="false" OnRowDataBound="GridView2_RowDataBound">
				<Columns>
					<asp:BoundField DataField="SerialNumber" HeaderText="GRN"  />
					<asp:BoundField DataField="ItemCode" HeaderText="物料编码"  />
					<asp:BoundField DataField="ItemName" HeaderText="物料名称" />
					<asp:BoundField DataField="BalanceQty" HeaderText="剩余数量" /> 
					<asp:BoundField DataField="CWhCode" HeaderText="仓库" /> 
					<asp:BoundField DataField="cBarCode" HeaderText="库位" /> 
                    <asp:BoundField DataField="LotCode" HeaderText="批次号"  />
					<asp:BoundField DataField="DateCode" HeaderText="生产日期" />
					<asp:BoundField DataField="VendorCode" HeaderText="供应商" /> 
					<asp:BoundField DataField="createby2" HeaderText="创建人" /> 
					<asp:BoundField DataField="storagedate" HeaderText="入库时间" /> 
				</Columns>
				<RowStyle CssClass="ListTableOddRow" />
				<HeaderStyle CssClass="ListTableHeader" />
			</asp:GridView>
		</div>
    </div>
</asp:Content>
