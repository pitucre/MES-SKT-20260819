/****************************************************************************
*  Author: WeiXia
*  Create Datetime: 2016.9.7
*  Desc: 仓库通用功能js 获取仓库配置数据结果
*  Version: 1.0.0
*  Email: 
****************************************************************************/
var configTypeId = -1;  //配置类型 1：物料条码打印 2：仓库收料 3：是否备料确认 4：发料是否交接 5：入库是否交接 6：供应商是否交期维护
var printChoosePageId = 101; //物料条码打印的数据源
var receiveChoosePageId = 103; //仓库收料的数据源(默认103)
var IsNeedPrepare = 2; //是否需要备料：1:需要  2：不需要，默认不需要
var IsSendConfirm = 2; //发料是否需要交接： 1：需要 2：不需要  默认不需要
var IsStorageConfirm = 2; //入库是否需要交接： 1：需要 2：不需要 默认不需要
var IsSupplierPeriod = 2;//供应商是否交期维护：1：需要 2：不需要 默认不需要
var IsIQCHandoverConfirm = 2;//是否进行IQC交接确认维护：1：需要 2：不需要 默认不需要
var PrintSearchCondition = ""; //物料查询条件
var ReceiveSearchCondition = ""; //收料的数据源查询条件

$(document).ready(function () {
    //查询物料信息
    var ajax = "";
    var entity = "";
    //获取物料条码打印信息
    ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(1);
    entity = $.parseJSON(ajax.value).data[0];
    printChoosePageId = entity.ChoosePageId;
    PrintSearchCondition = entity.SearchCondition;

    //获取物料仓库收料信息
    ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(2);
    entity = $.parseJSON(ajax.value).data[0];
    configTypeId = entity.ConfigTypeId;
    receiveChoosePageId = entity.ChoosePageId;
    ReceiveSearchCondition = entity.SearchCondition;

    //是否备料确认
    ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(3);
    entity = $.parseJSON(ajax.value).data[0];
    IsNeedPrepare = entity.ChoosePageId;

    //发料是否交接
    ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(4);
    entity = $.parseJSON(ajax.value).data[0];
    IsSendConfirm = entity.ChoosePageId;

    //入库是否交接
    ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(5);
    entity = $.parseJSON(ajax.value).data[0];
    IsStorageConfirm = entity.ChoosePageId;

    //供应商是否交期维护
    ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(6);
    entity = $.parseJSON(ajax.value).data[0];
    IsSupplierPeriod = entity.ChoosePageId;

    //是否进行IQC交接确认维护
    ajax = SKT.LeanMES.Web.AjaxServices.AjaxMaterialConfig.GetMaterialSysConfig(9);
    entity = $.parseJSON(ajax.value).data[0];
    IsIQCHandoverConfirm = entity.ChoosePageId;
    
});
