<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true" CodeBehind="AccessoryAndItemRelationImport.aspx.cs" Inherits="SKT.LeanMES.Web.AccessoryManagement.AccessoryAndItemRelationImport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <%=Resources.Messages.WithAsteriskIsRequired %>
    </div>
    <table width="100%" class="EditeContentTable">
         <tr>
               <td class="Label2">导入文件<em>*</em>
                </td>
                <td class="Field2">
                    <asp:FileUpload ID="fuPickList" Width="52%" runat="server" onchange="uploadFile(this.value)" />
                    <asp:LinkButton ID="linkUploadFile" runat="server" OnClick="linkUploadFile_Click"></asp:LinkButton>
                </td>
        </tr>
        <tr>
                <td class="Label2">导入模板<em></em>
                </td>
                <td class="Field2">
                     <input id="btnEmpty" type="button" value="导入规则说明" onclick="ShowRule()" />
                    <a href="<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Content/Template/产品辅料导入模板.xlsx"   target="_blank" title="模板下载">模板下载</a>
                </td>
        </tr>
    </table>
    <style type="text/css">
        fieldset {
            border: #2491BF solid 1px;
        }

        legend {
            font-size: 13px;
            font-weight: bold;
            color: #296AA0;
            background-repeat: no-repeat;
            height: 24px;
            padding-top: 2px;
            padding-left: 5px;
        }
    </style>
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <script type="text/javascript">
        function uploadFile(filePath) {
            if (filePath != "") {
                if (filePath.length > 0) {
                    var str = '';
                    var postback = $('#<%= linkUploadFile.ClientID %>').attr('href');
                    var funcStartIndex = postback.indexOf('\'');
                    var funcEndIndex = postback.indexOf('\',');
                    if (funcStartIndex != -1 && funcEndIndex != -1) {
                        var str = postback.substring(funcStartIndex + 1, funcEndIndex);
                        __doPostBack(str, '');
                    } else {
                        return false;
                    }
                }
            }
        }
        //导入成功后台调用前端方法
        function ShowErrorPackRelation(entity) {
            var succ = 0;
            var err = 0;
            var hav = 0;
            if (entity.length > 0) {
                for (var i = 0; i < entity.length; i++) {
                    if (entity[i].IsTrue == 0) {
                        err = err + 1;
                    }
                    if (entity[i].IsTrue == 1) {
                        succ = succ + 1;
                    }
                    if (entity[i].IsTrue == 2) {
                        hav = hav + 1;
                    }
                }
            }
            var hint = "导入成功" + succ + "条记录，辅料物料列表不存在的记录有" + err + "条,产品辅料记录已存在的有" + hav + "条。";
            layer.confirm(hint, {
                skin: 'layui-layer-bai', closeBtn: 0, area: ['430px'],
                btn: ['确认', '返回'] //按钮
            }, function () {
                parent.window.UpdateList("");
            }, function () {
                parent.window.UpdateList("");
            });
            //layer.alert(hint, { skin: 'layui-layer-bai', closeBtn: 0, area: ['430px'], });
            //alert("导入Excel成功，但导入成功的" + succ + "条，辅料物料列表不存在" + err + ",产品辅料记录存在的" + hav + "。");
            //parent.window.UpdateList("");
        }

        function ShowRule() {
            var hint = "1、导入Excel的第一行必须是表头行</br>";
            hint += "2、第一列必须有一列为编号列</br>";
            hint += "3、第二列必须产品编码</br>";
            hint += "4、第三列必须辅料料号</br>";
            layer.alert(hint, { skin: 'layui-layer-bai', closeBtn: 0,area: ['430px'], });
        }
    </script>
</asp:Content>
