<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScheduleAllot.aspx.cs" Inherits="SKT.LeanMES.Web.Schedule.ScheduleAllot" MasterPageFile="~/Masters/ViewMaster.master"%>

<asp:Content ContentPlaceHolderID="viewcontent" runat="server">

    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">作业编号</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblWorkSEQ"></asp:Label>
            </td>
            <td class="Label2">工单号码</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblOrderNO"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="Label2">计划生产数量</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblPlanQty"></asp:Label>
            </td>
            <td class="Label2">已分配数量</td>
            <td class="Field2">
                <asp:Label runat="server" ID="lblAllotQty"></asp:Label>
            </td>
        </tr>
    </table>

    <div class="divHeader">排程分配明细</div>
    <table class="ListTable" width="100%">
        <tr class="ListTableHeader">
            <th style="width:28%">班次</th>
            <th style="width:28%">数量</th>
            <th style="width:28%">线体</th>
            <th style="width:8%"><div onclick="addAllot()" style="width:50%;margin:0px auto;border:solid 1px blue;color:Blue; cursor:pointer">新增</div></th>
            <th style="width:8%">状态</th>
        </tr>
    </table>

    <div style="overflow:auto;height:300px;width:100%">
        <table class="ListTable" width="100%" id="tbScheduleAllotList">
    
        </table>
    </div>

    <script type="text/javascript">
        var Id = <%= Request.QueryString["Id"] == null ? -1 : Convert.ToInt32(Request.QueryString["Id"].ToString())%>
        var user = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
        var $objtxt;
        var $objhid;

        var planQty = <%=PlanQty %>;
        var allotQty = 0;
        var IsKitting = <%=IsKitting %>;
        var IsPublish = <%=IsPublish %>;

        $(document).ready(function()
        {
            getScheduleAllotList();
        })

        //增加一个分配
        function addAllot() {

            if(IsKitting != 2)
            {
                alert('该排程还未齐套！');
                return false;
            }

            if(IsPublish == 2)
            {
                alert('该排程已分配并发布完毕！');
                return false;
            }

            $(".ListTableEmptyDataRow").remove();

            var html = "<tr  class='ListTableOddRow'>";

            html += "<td style='width:28%'><input type='text' class='TextBox' name='shift' disabled='disabled' /><input type='button' value='...' onclick='selShift(this)' class='ButtonBox'/><input type='hidden' style='display:none' IsRequired='1'/><em>*</em></td>";
            html += "<td style='width:28%'><input type='text' class='TextBox' name='qty' IsRequired='1' IsNumber='1'/><em>*</em></td>";
            html += "<td style='width:28%'><input type='text' class='TextBox' name='line'disabled='disabled'  /><input type='button' value='...' onclick='selLine(this)' class='ButtonBox'/><input type='hidden' style='display:none' IsRequired='1'/><em>*</em></td>";
            html += "<td style='width:8%'><div onclick='deleteAllot(this)' style='width:50%;margin:0px auto;color:Blue; cursor:pointer'>删除</div></td>";
            html += "<td style='width:8%'></td>"
            html += "</tr>";

            $("#tbScheduleAllotList").append(html);
        }

        function selShift(obj)
        {
            dialog({ title: "<%=Resources.Pages.ShiftList %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=49&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
            $objtxt = $(obj).prev();
            $objhid = $(obj).next();
        }

        
        function selLine(obj)
        {
            dialog({ title: "<%=Resources.Pages.Resource_LineList %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=21&Multiple=false&rnd=" + Math.random(), width: 600, height: 300 });
            $objtxt = $(obj).prev();
            $objhid = $(obj).next();
        }

        function getChooseValue(list)
        {
            $objtxt.val(list[0][1]);
            $objhid.val(list[0][0]);
        }

        //删除一个分配
        function deleteAllot(obj) {
            $(obj).parent().parent().remove();
        }

        //保存分配信息
        function Save() {
            var shift = "";
            var line = "";
            var qty = "";
            allotQty = 0;

            if($("#tbScheduleAllotList td").length > 1)
            {
                $("#tbScheduleAllotList tr").each(function()
                {
                    shift += $(this).find("[name='shift']").next().next().val() + ",";
                    qty += $(this).find("[name='qty']").val() + ",";
                    line += $(this).find("[name='line']").next().next().val() + ",";

                    allotQty = allotQty + parseFloat($(this).find("[name='qty']").val());
                })
            }

            if($("#tbScheduleAllotList td").length > 1 && (allotQty <= 0 || allotQty > planQty))
            {
                alert("分配数量必须小于等于排程总数量，并且大于零！")
                return false;
            }

            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.ScheduleAllot(Id, shift, qty, line, user)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }

            alert("分配成功！");
            parent.window.UpdateList("");
        }

        //获取已分配列表
        function getScheduleAllotList() {
            var ajax = SKT.LeanMES.Web.AjaxServices.AjaxSchedule.GetScheduleAllotList(Id)
            if (ajax.error != null) {
                alert(ajax.error.Message)
                return false;
            }
            var html = "";
            var list = ajax.value;

            if(list.length > 0)
            {
                var disabled = "";

                for(var i = 0 ; i < list.length; i++)
                {
                    if(list[i].IsPublish)
                    {
                        disabled = "disabled='disabled'";
                    }

                    html += "<tr class='ListTableOddRow'>";
                    html += "<td style='width:28%'><input disabled='disabled'  type='text' class='TextBox' name='shift' value='"+ list[i].Shift +"'/><input  "+disabled+" type='button' value='...' onclick='selShift(this)' class='ButtonBox'/><input type='hidden' value='"+list[i].ShiftId.toString()+"' style='display:none' IsRequired='1'/><em>*</em></td>";
                    html += "<td style='width:28%'><input "+disabled+" type='text' class='TextBox' name='qty'  value='"+ list[i].Qty +"' IsRequired='1' IsNumber='1'/><em>*</em></td>";
                    html += "<td style='width:28%'><input disabled='disabled' type='text' class='TextBox' name='line'  value='"+ list[i].Line +"'/><input  "+disabled+" type='button' value='...' onclick='selLine(this)' class='ButtonBox'/><input type='hidden' value='"+list[i].LineId.toString()+"' style='display:none' IsRequired='1'/><em>*</em></td>";
                    
                    if(list[i].IsPublish)
                    {
                        html += "<td style='width:8%'></td>"; 
                        html += "<td style='width:8%;color:green'>已发布</td>";
                    }else
                    {
                        html += "<td style='width:8%'><div onclick='deleteAllot(this)' style='width:50%;margin:0px auto;color:Blue; cursor:pointer'>删除</div></td>";
                        html += "<td style='width:8%'>未发布</td>";
                    }

                    html += "</tr>";
                }

                $("#tbScheduleAllotList").html(html);
            }
            else
            {
                html += "<tr class='ListTableEmptyDataRow'><td colspan='5'>暂无分配</td></tr>";
                $("#tbScheduleAllotList").html(html);
            }
        }

    </script>

</asp:Content>

