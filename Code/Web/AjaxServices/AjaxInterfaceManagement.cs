using AjaxPro;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Wave.BLL;
using SKT.LeanMES.Wave.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class Entity
    {
        public string Name { get; set; }
    }
    public class AjaxInterfaceManagement
    {
        /// <summary>
        /// 获取设备类型
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<DeviceInterfaceTypeInfo> GetDeviceType()
        {
            DeviceInterfaceType bll = new DeviceInterfaceType();
            try
            {
                return bll.GetDeviceType();
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        /// <summary>
        /// 根据设备类型获取品牌型号
        /// </summary>
        /// <param name="deviceType">设备类型</param>
        /// <returns></returns>
        [AjaxMethod]
        public List<DeviceInterfaceTypeInfo> GetBrandType(string deviceType)
        {
            DeviceInterfaceType bll = new DeviceInterfaceType();
            try
            {
                return bll.GetBrandType(new DeviceInterfaceTypeInfo { DeviceType = deviceType });
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        /// <summary>
        /// 新增、编辑设备接口
        /// </summary>
        /// <param name="entity"></param>
        [AjaxMethod]
        public void Edit(DeviceInterfaceInfo entity)
        {
            DeviceInterface bll = new DeviceInterface();
            try
            {
                entity.ModifyBy = AccountController.GetCurrentUser().UserName;
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取测试结果位置数据
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>

        [AjaxMethod]
        public IList<DeviceInterfaceTestPositionInfo> GetDeviceInterfaceTestPositionList(DeviceInterfaceTestPositionInfo entity)
        {
            try
            {
                DeviceInterfaceTestPosition bll = new DeviceInterfaceTestPosition();
                return bll.GetAll(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        #region 设备接口类型型号维护


        [AjaxMethod]
        public DeviceInterfaceTypeInfo GetDeviceInterfaceTypeInfo(DeviceInterfaceTypeInfo entity)
        {
            try
            {
                DeviceInterfaceType bll = new DeviceInterfaceType();
                return bll.GetDeviceInterfaceTypeInfo(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public void DeviceInterfaceTypeEdit(DeviceInterfaceTypeInfo entity)
        {
            try
            {
                DeviceInterfaceType bll = new DeviceInterfaceType();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        #endregion

        [AjaxMethod]
        public InterfaceManagementListInfo GetInterfaceManagementById(int ID)
        {
            InterfaceManagementListInfo t = new InterfaceManagementListInfo();
            try
            {
                string cmdTxt = string.Format("SELECT [ID],[DeviceType],[BrandType],[Split],[FileType],[CreateBy],[CreateTime],[modifyBy],[modifyTime],OKStr,NGStr FROM [dbo].[Prod_InterfaceManagementList] WHERE ID={0}", ID);
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    t.ID = Convert.ToInt32(dt.Rows[i][0]);
                    t.DeviceType = dt.Rows[i][1].ToString();
                    t.BrandType = dt.Rows[i][2].ToString();
                    t.Split = dt.Rows[i][3].ToString();
                    t.FileType = dt.Rows[i][4].ToString();
                    t.OKStr = dt.Rows[i][9].ToString();
                    t.NGStr = dt.Rows[i][10].ToString();
                    return t;
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return t;
        }

        /// <summary>
        /// 获取设备类型
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<Entity> GetEquipmentType()
        {
            List<Entity> entity = new List<Entity>();
            try
            {
                string cmdTxt = string.Format("SELECT DeviceType FROM dbo.Prod_DeviceInterfaceType  GROUP BY DeviceType");
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Entity t = new Entity();
                    t.Name = dt.Rows[i][0].ToString();
                    entity.Add(t);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;

        }

        /// <summary>
        /// 根据设备类型获取品牌型号
        /// </summary>
        /// <param name="deviceType">设备类型</param>
        /// <returns></returns>
        [AjaxMethod]
        public dynamic GetEquipmentBrandType(string deviceType)
        {
            List<Entity> entity = new List<Entity>();
            try
            {
                string cmdTxt = string.Format("SELECT DISTINCT Brand FROM dbo.Prod_DeviceInterfaceType  WHERE  DeviceType='{0}'", deviceType);
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    for (int k = 0; k < 1; k++)
                    {
                        Entity t = new Entity();
                        t.Name = dt.Rows[i][k].ToString();
                        entity.Add(t);
                    }
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;
        }

        [AjaxMethod]
        public void EquipmentEdit(InterfaceManagementListInfo entity)
        {
            try
            {
                InterfaceManagement bll = new InterfaceManagement();
                if (entity.ID == -1) //add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                }
                else // update selected record
                {
                    entity.CreateBy = "";
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                }
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        
        #region 设备详情
        /// <summary>
        /// 加载设备详情内容类别
        /// </summary>
        /// <returns></returns>
        [AjaxMethod]
        public List<Entity> GetContentALL()
        {
            List<Entity> entity = new List<Entity>();
            try
            {
                string cmdTxt = string.Format("SELECT ContentDefine FROM dbo.Basic_Interface_Content GROUP BY ContentDefine");
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Entity t = new Entity();
                    t.Name = dt.Rows[i][0].ToString();
                    entity.Add(t);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;

        }



        [AjaxMethod]
        public void InterfaceManagementDefEdit(InterfaceManagementDefInfo entity)
        {
            try
            {
                InterfaceManagement bll = new InterfaceManagement();
                if (entity.ID == -1) //add new one record
                {
                    entity.CreateBy = AccountController.GetCurrentUser().UserName;
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                }
                else // update selected record
                {
                    entity.CreateBy = "";
                    entity.ModifyBy = AccountController.GetCurrentUser().UserName;

                }
                bll.InterfaceManagementDefUpdateOrSave(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public InterfaceManagementDefInfo GetInterfaceManagementDefById(int ID)
        {
            InterfaceManagementDefInfo t = new InterfaceManagementDefInfo();
            try
            {
                string cmdTxt = string.Format("SELECT [ID],[Rows],[Contents],[InterfaceManagementId],[Segment] FROM [dbo].[Prod_InterfaceManagementDef] WHERE ID={0}", ID);
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    t.ID = Convert.ToInt32(dt.Rows[i][0]);
                    t.Rows = Convert.ToInt32(dt.Rows[i][1]);
                    t.Contents = dt.Rows[i][2].ToString();
                    t.InterfaceManagementId = Convert.ToInt32(dt.Rows[i][3]);
                    t.Segment = Convert.ToInt32(dt.Rows[i][4]);
                    return t;
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return t;
        }

        [AjaxMethod]
        public List<Entity> GetSegment()
        {
            List<Entity> entity = new List<Entity>();
            try
            {
                for (int i = 1; i <= 20; i++)
                {
                    Entity e = new Entity();
                    e.Name = "第" + i + "段";
                    entity.Add(e);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;

        }
        #endregion

        [AjaxMethod]
        public List<Entity> GetFileType()
        {
            List<Entity> entity = new List<Entity>();
            try
            {
                string cmdTxt = string.Format("SELECT FileType FROM dbo.Basal_FileType  GROUP BY FileType");
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Entity t = new Entity();
                    t.Name = dt.Rows[i][0].ToString();
                    entity.Add(t);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;

        }
        [AjaxMethod]
        public List<Entity> GetDecollator()
        {
            List<Entity> entity = new List<Entity>();
            try
            {
                string cmdTxt = string.Format("SELECT Decollator FROM dbo.Basal_Decollator  GROUP BY Decollator");
                DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Entity t = new Entity();
                    t.Name = dt.Rows[i][0].ToString();
                    entity.Add(t);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return entity;

        }


        [AjaxMethod]
        public List<string> GetSplitTitle(string FileName, string SplitChar)
        {
            char[] chars = SplitChar.ToCharArray();

            return FileName.Split(chars).ToList();
        }
    }
}