<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/EditMaster.master" AutoEventWireup="true"
    CodeBehind="RMAEdit.aspx.cs" Inherits="SKT.LeanMES.Web.Quality.RMAEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="EditContent" runat="server">
    <div class="infoTips">
        <em>*</em><span>为必填项</span>
    </div>
    <table class="EditeContentTable" width="100%">
        <tr>
            <td class="Label2">
              RMA单号<em>*</em>
            </td>
            <td class="Field2">
                <asp:Label runat="server" ID="txtRmaNo"></asp:Label>
            </td>
            <td class="Label2">
           客户名称<em>*</em>
            </td>
            <td class="Field2">
             <asp:TextBox ID="txtCustomerName" MaxLength="20" runat="server" CssClass="TextBox"
                    IsRequired="1"></asp:TextBox>
                <input  type="button" id="btnSelectCustomer" class="ButtonBox" value="..." onclick="selectCustomer()"  />
                <input type="hidden" value="" runat="server" id="hdnCustomerId" />
            </td>
        </tr>
          <tr>
            <td class="Label2">
             类型<em>*</em>
            </td>
            <td class="Field2" >
                 <asp:DropDownList ID="ddlRmaType" runat="server">
                      <asp:ListItem Value="1">RMA</asp:ListItem>  
                      <asp:ListItem Value="2">DOA</asp:ListItem>  
                </asp:DropDownList>
            </td>
             <td class="Label2">
                产品编码<em>*</em>
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtItemCode" runat="server" CssClass="TextBox" ></asp:TextBox>
                <input  type="button" id="btnSelectItem" class="ButtonBox" value="..." onclick="selectItem()" />
                <input type="hidden" value="" runat="server" id="hdnItemId" />
            </td>
        </tr>
        <tr>
            <td class="Label2">
             数量<em>*</em>
            </td>
            <td class="Field2" >
                <asp:TextBox ID="txtNumber" runat="server" IsNumber='1' IsRequired="1" onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onafterpaste="this.value=this.value.replace(/[^\d.]/g,'')" CssClass="TextBox"></asp:TextBox>
            </td>
             <td class="Label2">
                退货时间<em>*</em>
            </td>
            <td class="Field3">
                 <asp:TextBox ID="txtCancelTime" runat="server" CssClass="DateTimeBox" IsRequired="1" Width="150px" ReadOnly="true"></asp:TextBox>
                
            </td>
        </tr>
        <tr>
         <td class="Label2">
             上传附件
            </td>
            <td class="Field2" colspan="3">
              <input type="file" id="Filedata" name="Filedata" title="上传附件"/><asp:Label runat="server" ID="lblRMAPath"></asp:Label>
                
            </td>
        </tr>
         <tr>
            <td class="Label2">
             备注
            </td>
            <td class="Field2" colspan="3">
               <asp:TextBox ID="txtRemark" runat="server" CssClass="TextArea" MaxLength="200" TextMode="MultiLine" Width="95%"></asp:TextBox>
            </td>
             
        </tr>
         <tr>
            <td class="Label2">
                产品序号导入
            </td>
            <td class="Field2" colspan="3">
                <asp:FileUpload ID="fileBomUrl" ClientIDMode="Static" runat="server" />
                <asp:Button ID="btnUpload" runat="server"  ClientIDMode="Static" OnClick="Upload_Click"
                    Style="display: none;" />
            </td>
        </tr>
    </table>
    <table id="tblExpand" cellspacing="0" cellpadding="4" style="border-width: 0px; width: 100%; border-collapse: collapse; margin-top: 5px;"
        class="EditeContentTable">
        <tr class="ListTableHeader" style="text-align: center">
            <th scope="col" style="width: 8%;">序号</th>
            <th scope="col" style="width: 15%;"> 产品序号 </th>
             <th scope="coh" style="width: 15%;" id="trJcyj">不良描述</th>  
            <th scope="col" style="width: 8%;" id="trLrfs">备注</th>
            <th scope="col" onclick="addDetail1();" style="color: #0066CC; cursor: pointer; width: 5%;">
               <%=IsAdd %>
            </th>
        </tr>
        <tr id="trNewInfo" class="ListTableOddRow">
            <td colspan="8" style="text-align: center;">
                <%=Resources.Messages.HaveNothingData%>
            </td>
        </tr>
    </table>
    <input type="hidden" id="controlId" />
    <input type="hidden" id="hdRmaId" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdStatus" runat="server" value="0"/>
    <input type="hidden" id="hdinspecType" value="-1"/>
  
    <input type="hidden" id="hdnRMAFilePath" runat="server" />
    <script type="text/javascript" src="../Content/js/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="../Content/plugin/jquery-easyui-1.4.2/layer/layer.js"></script>
    <style type="text/css">
        .selectRow td {
            background-color: #C4C4C4;
        }

        .pointer {
            cursor: pointer;
        }
    </style>
    <script language="javascript" type="text/javascript">

        var tab = document.getElementById("tblExpand");
        var selectRowClass = "selectRow";
        var rmaStatus = $("#<%=this.hdStatus.ClientID %>").val();
       
        var index = 1;
        var id = -1;
        $(function () {
            id = $("#<%=this.hdRmaId.ClientID%>").val();
           if (id > 0) {
               SetContorStatus();
            var listArr = GetDetailList();
            if (null != listArr) {
                index = 1;
                for (var i = 0; i < listArr.length; i++) {
                  if (rmaStatus != 0) {
                         addDetailTwo(listArr[i], index);
                  } else {
                       addDetail(listArr[i], index);
                  }
                   
                    index++;
                }
            }
         }
        });

       
        function SetContorStatus() {
            if (rmaStatus != 0) {
                
                $("#<%=this.txtCancelTime.ClientID %>").attr("disabled","disabled");

                $(".ui-datepicker-trigger").hide();
                $("#<%=this.txtCancelTime.ClientID %>").removeClass("hasDatepicker"); 
                $("#<%=this.txtNumber.ClientID %>").attr("disabled","disabled");
                $("#<%=this.txtItemCode.ClientID %>").attr("disabled","disabled");
                $("#<%=this.txtCustomerName.ClientID %>").attr("disabled","disabled");
                $("#<%=this.ddlRmaType.ClientID %>").attr("disabled","disabled");
                $("#Filedata").attr("disabled","disabled");
                $("#btnSelectCustomer").attr("disabled","disabled");
                $("#btnSelectItem").attr("disabled","disabled");
            }
        }


        function GetIndex() {
            var list = $(tab).find("tr");
         
            for (var i = 0; i < list.length; i++) {
                if ($(list[i]).attr("class").indexOf(selectRowClass) > -1) {
                
                    return i;
                }
            }
            return tab.rows.length;
        }

        function addDetail(entity, i) {
            var row, cell;
          
            rowNewIdx = GetIndex();
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";
            $("#trNewInfo").remove();
          

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = i;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording" value="' + entity.SerialNumber + '" MaxLength="50"  style="width:200px;height:25px;"/>'
           
        
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording" value="' + entity.RejectsDesc + '" MaxLength="50"  style="width:200px;height:25px;"/>'
           
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording" value="' + entity.Remark + '" MaxLength="50"  style="width:170px;height:25px;"/>'

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";

          
        }


        
        function addDetailTwo(entity, i) {
            var row, cell;
            rowNewIdx = GetIndex();
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            $("#trNewInfo").remove();

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = i;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = entity.SerialNumber;
           
        
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = entity.RejectsDesc;
           
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = entity.Remark;

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "";

          
        }

           function addDetail1() {
          if (rmaStatus != 0) {
              alert("非待接收状态,不能新增");
              return;
          }
          $("#trNewInfo").remove();
            var row, cell;
            rowNewIdx = GetIndex();
            row = tab.insertRow(rowNewIdx);
            row.className = "ListTableOddRow";

            cell = row.insertCell(0);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = rowNewIdx;

            cell = row.insertCell(1);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording"  MaxLength="50"  style="width:200px;height:25px;"/>'
        
            cell = row.insertCell(2);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording"   MaxLength="50"  style="width:200px;height:25px;"/>'
           
            cell = row.insertCell(3);
            cell.align = "center";
            cell.className = "Field pointer";
            cell.innerHTML = '<input type="text" class="InspectionAccording"  MaxLength="50"  style="width:170px;height:25px;"/>'

            cell = row.insertCell(4);
            cell.align = "center";
            cell.className = "Field";
            cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";

          
        }

        var GetValue = function (data, Id) {
            closeDialog();
            data = data.replace('&gt;', ">");
            data = data.replace('&lt;', "<");


            $("#tblExpand tr").eq(Id).find("td:eq(4) input[type='text']").val(data);

        }
        var Set = function (result) {
            var Id = $(result).parent().parent().find("td:eq(0)").html();
            var openWinUrl = "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>" + "/Quality/InspectionTemplateEditValue.aspx?name=InspectionTemplateEditValue&Id=" + Id;
            dialog({ title: "<%=Resources.Pages.InspectionTemplateEditValue %>", src: openWinUrl, width: 650, height: 350 });

            //var data = "<table>";
            //for (var i = 0; i < length; i++) {

            //}
            //data += "<tr></tr>";
            //data += "<tr></tr>";
            //data += "<tr></tr>";
            //data += "</table>";
            //layer.open({
            //    type: 1,
            //    area: ['45%', '65%'],
            //    shadeClose: true, //点击遮罩关闭
            //    content: data
            //});
        }


        function BindIsPercentage(id) {
            $("#" + id).click(function () {
                id = $(this).attr("id");
                var value = parseInt($("#hd" + id).val());;
                if (value == 1) {
                    value = 0;
                }
                else {
                    value = 1
                }
                $("#hd" + id).val(value);
            });
        }

        function deleteItem(obj) {
            if (typeof (obj) == "number") {
                tab.deleteRow(rowIndex);
            }
            else {
                tab.deleteRow(obj.parentElement.parentElement.rowIndex);
            }
        }

        var rowObj = null;
        var rowIndex = 0;

        var ReqId = '<%=Request.QueryString["ID"] %>';
        $("select").css("width", "140px");

        /*保存数据*/
        function Save() {
            if ($("#<%=this.txtRmaNo.ClientID %>").text() == "")
            {
                alert("RMA单号不能为空，请检查序列号规则是否维护！");
                return;
            }
            var entity = {};
            entity.RmaId = ReqId;
            entity.RmaNo = $("#<%=this.txtRmaNo.ClientID %>").text();
            entity.CancelTime = new Date($("#<%=this.txtCancelTime.ClientID %>").val());
            entity.RTypeId = $("#<%=this.ddlRmaType.ClientID %>").val();
            entity.CustomerId = $("#<%=this.hdnCustomerId.ClientID %>").val();
            entity.MachineTypeId = $("#<%=this.hdnItemId.ClientID %>").val();
            entity.Number = $("#<%=this.txtNumber.ClientID %>").val();
            entity.Remark = $("#<%=this.txtRemark.ClientID %>").val();
            entity.CreateBy = "<%=SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName %>";
             var list = [];
                            for (var i = 0; i < $("#tblExpand tr:gt(0)").length; i++) {
                                var data = $("#tblExpand tr:gt(0)")[i];
                                var en = {};
                                en.SerialNumber = $(data).find("td:eq(1) input").val(),toString().trim();
                                en.RejectsDesc = $(data).find("td:eq(2) input").val();
                                en.Remark= $(data).find("td:eq(3) input").val();
                                if (en.SerialNumber != "") {
                                    list.push(en);
                                }
                                
                            }
           
                            if (list.length == 0) {
                                alert("请添加数据");
                                return;
                            }

                            entity.RmaDetails = JSON.stringify(list);
          

             try {
                if ($("#Filedata").val() != "") {
                    UploadRMA(entity);
                }
                else {
                    entity.FilePath = $("#<%=this.hdnRMAFilePath.ClientID%>").val();  
                    SaveRma(entity);
                    
                }
                
            }
            catch (ex)
            {
                alert(ex);
            }
           
        }

        function SaveRma(entity) {
            var ajax = SKT.LeanMES.Web.Quality.RMAEdit.Edit(JSON.stringify(entity));
            if (ajax.error != null) {
                alert(ajax.error.Message);
                return false;
            }
            alert('<%=Resources.Messages.SaveInSuccess %>');
            parent.window.UpdateList($("#<%=this.txtRmaNo.ClientID %>").val());
            return ajax;
        }

        function selectInspectionTemplateValue() {
            dialog({
                title: "<%=Resources.Common.ChooseWindow %>",
                src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?" +
                    "PageId=74&CallBackFunc=getChooseValueInspectionTemplate&Multiple=true&rnd=" + Math.random(),
                width: 400,
                height: 250
            });
        }



        function GetDetailList() {
            
               var txtRmaNo = $("#<%=this.txtRmaNo.ClientID %>").text();
                if (txtRmaNo == "" ) {
                    return null;
                }
               var ajax = SKT.LeanMES.Web.Quality.RMAEdit.GetDetailList(txtRmaNo);
                
                if (ajax.error != null) {
                    alert(ajax.error.Message);
                    return null;
                }
                return ajax.value;
            }

        var chooseFlag = 0;

        function selectCustomer() {
            chooseFlag = 1;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=10&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }

        function selectItem() {
            chooseFlag = 2;
            dialog({ title: "<%=Resources.Common.ChooseWindow %>", src: "<%=SKT.LeanMES.Web.WebHelper.WebRoot %>/Framework/ChoosePage.aspx?PageId=1&Multiple=false&rnd=" + Math.random(), width: 650, height: 350 });
        }
         function getChooseValue(list) {
            if (chooseFlag == 1) {
                $("#<%=this.txtCustomerName.ClientID %>").val(list[0][1]);
                 $("#<%=this.hdnCustomerId.ClientID %>").val(list[0][0]);
            } else if (chooseFlag == 2) {
                $("#<%=this.txtItemCode.ClientID %>").val(list[0][2]);
                $("#<%=this.hdnItemId.ClientID %>").val(list[0][0]);
            } 
        }

         function UploadRMA(entity)
        {
                var form = new FormData($("#form1")[0]);
                try {
                    $.ajax({
                        type: "POST",  //提交方式  
                        url: "../Handler/UploadHander.ashx?Action=UploadRMA&rnd=" + Math.random(),//路径  
                        data: form,//数据
                        contentType: false, //禁止设置请求类型
                        processData: false, //禁止jquery对DAta数据的处理,默认会处理
                        success: function (data1) {//返回数据根据结果进行相应的处理  
                            $("#<%=this.lblRMAPath.ClientID%>").text(data1.substring(data1.lastIndexOf("/") + 1));
                            $("#<%=this.hdnRMAFilePath.ClientID%>").val(data1);
                            entity.FilePath = data1;
                         
                            SaveRma(entity);
                            parent.refresh();
                        },
                        error: function (xhr, status, error) {
                             
                        }
                    });
                }
                catch (ex) {
                    alert(ex);
                }
          
         }


      ///导入序列号 add by zhi.li 20180628
        function Add() {
            if ($("#fileBomUrl").val() == "") {
                alert("请先浏览导入序号的文件");
                return;
            }
            if ($("#fileBomUrl").val().length > 0) {
                $("#btnUpload").click();
            }
          }

        
        function test(sts) {
            var hdRmaId = '<%=Request.QueryString["ID"] %>'
            if (null != sts) {
                rowNewIdx = GetIndex();
               for (var i = 0; i < sts.length; i++) {
                    if (rmaStatus != 0) {
                        alert("非待接收状态,不能新增");
                        return;
                    }
                 
                    var row, cell;
                    $("#trNewInfo").remove();
                    if (hdRmaId < 0) {
                        rowNewIdx = i + 1;
                    }
                   
                    row = tab.insertRow(rowNewIdx);
                    row.className = "ListTableOddRow";

                    cell = row.insertCell(0);
                    cell.align = "center";
                    cell.className = "Field pointer";
                    if (hdRmaId > 0) {
                        cell.innerHTML=rowNewIdx +=1 ;
                    } else { 
                        cell.innerHTML = rowNewIdx;
                    }
                   

                    cell = row.insertCell(1);
                    cell.align = "center";
                    cell.className = "Field pointer";
                    cell.innerHTML = '<input type="text" class="InspectionAccording" value="' + sts[i]["产品序号"] + '" MaxLength="50"  style="width:200px;height:25px;"/>'


                    cell = row.insertCell(2);
                    cell.align = "center";
                    cell.className = "Field pointer";
                    cell.innerHTML = '<input type="text" class="InspectionAccording" value="' + sts[i]["不良描述"] + '" MaxLength="50"  style="width:200px;height:25px;"/>'

                    cell = row.insertCell(3);
                    cell.align = "center";
                    cell.className = "Field pointer";
                    cell.innerHTML = '<input type="text" class="InspectionAccording" value="' + sts[i]["备注"] + '" MaxLength="50"  style="width:200px;height:25px;"/>'

                    cell = row.insertCell(4);
                    cell.align = "center";
                    cell.className = "Field";
                    cell.innerHTML = "<span style=\"CURSOR: pointer; COLOR: #0000ff;\" onclick=\"deleteItem(this)\"><%= Resources.Buttons.COM_Delete %></span>";
                     
                   rowNewIdx++;
                  
                }
            }
        }


        function Download() {
            return downLoadField('<%=SKT.LeanMES.Web.WebHelper.ExcelTemplateRoot+"序号导入模板.xlsx" %>');
        }
        function downLoadField(fieldPath) {
            window.open(fieldPath);
            return null;
        }
     
    </script>
</asp:Content>
