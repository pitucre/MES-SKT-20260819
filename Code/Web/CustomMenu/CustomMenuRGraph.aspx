<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomMenuRGraph.aspx.cs" MasterPageFile="~/Masters/Masters.master" Inherits="SKT.LeanMES.Web.CustomMenu.CustomMenuRGraph" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        table
        {
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 12px;
            cursor: default;
            padding: 0px;
            border-collapse: collapse;
        }
        table tr td
        {
            padding-left: 3px;
            border: 1px solid #d3d3d3;
            border: 1px solid #d3d3d3 !important;
            font-family: Verdana, 微软雅黑,黑体, 宋体;
            font-size: 12px;
            padding-top: 3px;
            padding-bottom: 3px;
            text-align: center;
            overflow: auto;
        }
        
        #xbarTb-header tr td
        {
            line-height: 15px;
        }
        #xbarTb-content tr td
        {
            line-height: 15px;
            min-width: 20px;
        }
        #processUl li
        {
            height: 24px;
            line-height: 24px;
            border-bottom: 1px dashed #D3D3D3;
        }
        #processUl span
        {
            margin-right: 5px;
            float: right;
            color: blue;
            margin-left: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <%=InitPage() %>
</asp:Content>