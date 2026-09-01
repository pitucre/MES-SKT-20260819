using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

// General Information about an assembly is controlled through the following 
// set of attributes. Change these attribute values to modify the information
// associated with an assembly.
[assembly: AssemblyTitle("SKTMAX LeanMES 8.6")]
[assembly: AssemblyDescription("SKTMAX LeanMES 8.6")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("SKTMAX Information Technology Co., Ltd.")]
[assembly: AssemblyProduct("SKTMAX LeanMES 8.6")]
[assembly: AssemblyCopyright("Copyright ©2022 SKTMAX All Right Reserved")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]

// Setting ComVisible to false makes the types in this assembly not visible 
// to COM components.  If you need to access a type in this assembly from 
// COM, set the ComVisible attribute to true on that type.
[assembly: ComVisible(false)]

// The following GUID is for the ID of the typelib if this project is exposed to COM
[assembly: Guid("BFB250CD-5DFA-4959-BCAF-8783554F9051")] 

// Version information for an assembly consists of the following four values:
//
//      Major Version
//      Minor Version 
//      Build Number
//      Revision
//
// You can specify all the values or you can default the Revision and Build Numbers 
// by using the '*' as shown below:

[assembly: AssemblyVersion("8.5.6")]
[assembly: AssemblyFileVersion("8.5.6")]
[assembly: log4net.Config.XmlConfigurator(ConfigFile = "log4net.config", ConfigFileExtension = "config", Watch = true)]

//8.5.1.1: 发布时间：2017-08-05 13:00
/*
 *      1、新增 老化功能  
 *      2、修复 拼板功能  
 *      3、完善 成品入库及查询功能 
 *      4、完善 仓库盘点
*/
//8.5.1.2: 发布时间：2017-08-14 19:00
/*
 *      1、新功能IQC细项录入
 *      2、新功能SMT包装
 *      3、仓库备料增加库位显示（目前库位显示还有问题）
 *      4、物料调拨在“新增调拨申请单”页面删除“库存数量”列
 *      5、修复上料投入工位带出工单选择窗口中，工单对应的产线不是工单排程时绑定的产线（不显示线别）
 *      6、SMT上料查询点查看系统报错
 *      7、新增物料历史操作明细记录功能
 *      8、SMT上料扫描飞达时，系统自动把小写转换为大写
*/
//8.5.6.1: 发布时间：2022-06-10 09:41
/*
 *      1、发布打印服务1.0.0.9增加电子秤自动发送称重指令支持
 *      2、电子秤参数设置页面增加参数“发送指令”
 *      3、货位货架导入增加产品是否唯一
 *      4、修复不良代码模板导入
 *      5、修复RMA的序号导入模板导入
 *      6、移植爱都项目'W02 物料齐套检查报表'
 *      7、把巨湾项目IPQC UI功能移植到8.5.6
 *      8、移植常荣项目点料机接口到8.5.6标准版
 *      9、启益项目SMT物料核对及DIP物料核对功能移植到8.5.6
 *      10、启益项目SMT上料核对报表跟DIP上料核对报表移植到8.5.6
 *      11、移植拓邦项目急料导入功能及模板下载功能到标准版
 *      12、华星项目PDA上的产成品领料出库功能移植到8.5.6
 *      13、罗思韦尔项目路由里的扣料面别移植到8.5.6
 *      14、罗思韦尔项目上料替换功能移植到8.5.6
*/
