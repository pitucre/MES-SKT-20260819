<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/ViewMaster.master" AutoEventWireup="true" CodeBehind="OrganizationTree.aspx.cs" Inherits="SKT.LeanMES.Web.Organization.OrganizationTree" %>
<asp:Content ID="Content1" ContentPlaceHolderID="viewcontent" runat="server">
    <link href="../Content/plugin/jqTree/img/mask.css" rel="stylesheet" type="text/css" />
    <link href="../Content/plugin/jqTree/img/saas.css" rel="stylesheet" type="text/css" />
    <script src="../Content/plugin/jqTree/Js/saas.js" type="text/javascript"></script>
    <script src="../Content/plugin/jqTree/Js/jqDnR.js" type="text/javascript"></script>
    <div style="padding:3px; position:relative; height:25px;"><div style=" position:absolute; top:8px; left:3px; font-weight:bold;"><img src="../Content/images/icon/openrouter.png" style="vertical-align:middle;" />选择上级部门</div><div style=" position:absolute; top:3px; right:0px;"><input type="button" value="选择" class="SearchButton" onclick="getChooseValue()"/></div></div>
    <div style="width: 100%; border-top: 1px solid #d3d3d3;border-bottom: 1px solid #d3d3d3; padding:0px;">
        <ul id="browser" class="treeview filetree" style=" overflow:auto;">
        </ul>
    </div>
    
    <script type="text/javascript">
        $(document).ready(function () {
            initOrganization();
            $("#browser").height($(window).height() - 38);
        });

        function ShowDetail(t) {
            //alert(t);
        }

        function initOrganization() {
            $('#browser').html("");
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxOrganization.GetAll();
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }

            var data = AjaxPro.toJSON(ajax.value);
            $('#browser').showTree({ data: $.parseJSON(data), showCheckbox: false })
        }

        function getChooseValue() {
            var parentId = "";
            var parentDepartName = "";
            var parentDepartNo = "";
            $(".treeview  input[type='checkbox']").each(function () {
                if ($(this)[0].checked) {
                    parentId = $(this).val();
                    parentDepartName = $(this).next().html();
                    parentDepartNo = $(this).next().attr("DepartNo");
                    return;
                }
            });
            if (parentId == "") {
                alert("请选择部门!");
                return false;
            }
            parent.getChooseValue(parentId, parentDepartName, parentDepartNo);
        }

        function GetDepartmentMemeber(s) { 
        }
    </script>
</asp:Content>
