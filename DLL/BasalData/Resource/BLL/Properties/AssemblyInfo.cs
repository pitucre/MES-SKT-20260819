using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

// General Information about an assembly is controlled through the following 
// set of attributes. Change these attribute values to modify the information
// associated with an assembly.
[assembly: AssemblyTitle("SKT.LeanMES.Resource.BLL")]
[assembly: AssemblyDescription("")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("sz-skt")]
[assembly: AssemblyProduct("SKT.LeanMES.Resource.BLL")]
[assembly: AssemblyCopyright("Copyright ©sz-skt 2015")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]

// Setting ComVisible to false makes the types in this assembly not visible 
// to COM components.  If you need to access a type in this assembly from 
// COM, set the ComVisible attribute to true on that type.
[assembly: ComVisible(false)]

// The following GUID is for the ID of the typelib if this project is exposed to COM
[assembly: Guid("d35bbec4-5d47-4f56-94ea-8d1d8b7295cd")]

// Version information for an assembly consists of the following four values:
//
//      Major Version
//      Minor Version 
//      Build Number
//      Revision
//
// You can specify all the values or you can default the Build and Revision Numbers 
// by using the '*' as shown below:
// [assembly: AssemblyVersion("1.0.*")]
[assembly: AssemblyVersion("1.2.*")]
//[assembly: AssemblyFileVersion("1.0.0.0")]

/*
 * 升级记录
 * 
 * 版本： 1.1
 * 时间： 2016-06-18
 * 修改人：Alen Liu 
 * 修改内容： 
 *  1、修改数据库视图：vwResourceMember
 *  2、修改Resource.cs的GetAll方法，增加ResTypeName和ResTypeId属性
 *  
 * 版本： 1.2
 * 时间： 2016-06-20
 * 修改人： Alen Liu
 * 修改标识： Alen Liu 2016-06-20
 * 修改内容： 
 *  1、Resource.cs文件的GetInfo方法增加ResTypeName和ResTypeId属性;
 *  2、Line.cs文件修改EditLine方法，在增加线别的时候增加线别license数量的判断与控制;
 *  3、Line.cs文件修改EditLine方法，增加生产时段字段维护；
 */