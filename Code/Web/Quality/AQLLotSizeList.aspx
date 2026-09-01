<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="AQLLotSizeList.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.AQLLotSizeList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <style type="text/css" >
        .divcss5 table
        {
            background: #CCC;
        }
        .divcss5 table td
        {
            background: #FFF;
            text-align: center;
            height: 28px;
        }
    </style>
    <div class="divcss5">
        <table width="100%" border="0" cellspacing="1" cellpadding="0">
            <asp:Repeater runat="server" ID="rptAQLLotSize">
                <HeaderTemplate>
                    <tr border="1px">
                        <td rowspan="2" style="width: 250px;">
                            <span>批量</span>
                        </td>
                        <td colspan="4">
                            <span>特殊检验水平</span>
                        </td>
                        <td colspan="3">
                            <span>一般检验水平</span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            S-1
                        </td>
                        <td>
                            S-2
                        </td>
                        <td>
                            S-3
                        </td>
                        <td>
                            S-4
                        </td>
                        <td>
                            I
                        </td>
                        <td>
                            II
                        </td>
                        <td>
                            III
                        </td>
                    </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <%#Eval("LotSizeName")%>
                        </td>
                        <td>
                            <%#Eval("Audit_S1")%>
                        </td>
                        <td>
                            <%#Eval("Audit_S2")%>
                        </td>
                        <td>
                            <%#Eval("Audit_S3")%>
                        </td>
                        <td>
                            <%#Eval("Audit_S4")%>
                        </td>
                        <td>
                            <%#Eval("Audit_I")%>
                        </td>
                        <td>
                            <%#Eval("Audit_II")%>
                        </td>
                        <td>
                            <%#Eval("Audit_III")%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>
</asp:Content>
