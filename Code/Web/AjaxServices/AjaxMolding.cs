using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.LeanMES.Molding.Model;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Web.AjaxServices
{
    /// <summary>
    /// Description:成型管理(加工&烧录).
    /// Author:Hanson.Lei
    /// Data:2017.8.4
    /// </summary>
    public class AjaxMolding
    {
        [AjaxMethod]
        public MaterialMoldingInfo GetMolding(int moldingId)
        {
            try
            {
                return new LeanMES.Molding.BLL.MaterialMolding().Get(moldingId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public List<MaterialProcessInfo> GetListProcess(int orderId)
        {
            try
            {
                return new LeanMES.Molding.BLL.MaterialProcess().Get(orderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public MaterialMoldingMemberInfo GetMoldingMember(int memberId, int ProdOrderId)
        {
            try
            {
                return new LeanMES.Molding.BLL.MaterialMolding().GetMember(memberId, ProdOrderId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public void SaveMolding(MaterialMoldingInfo t)
        {
            try
            {
                if (t == null)
                    throw new Exception("保存失败!");

                t.ModifyBy = AccountController.GetCurrentUser().UserId;
                new LeanMES.Molding.BLL.MaterialMolding().Save(t);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void DeleteProcess(string ids)
        {
            try
            {
                new LeanMES.Molding.BLL.MaterialMolding().Delete(ids);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void DeleteMoldingMember(string ids)
        {
            try
            {
                new LeanMES.Molding.BLL.MaterialMolding().DeleteMember(ids);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public MaterialMoldingMemberInfo CheckMemberSourceGRN(int orderId, int moldingMemberId, string sourceGRN, int StationId)
        {
            try
            {
                return new LeanMES.Molding.BLL.MaterialProcess().CheckMemberSourceGRN(orderId, moldingMemberId, sourceGRN, StationId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public MaterialUnitInfo AddProcess(MaterialProcessInfo t)
        {
            try
            {
                t.SourceMoldingMember.SourceMaterialUnit.SerialNumber = t.SourceMoldingMember.SourceMaterialUnit.SerialNumber.Trim(new char[] { ',' });
                return new LeanMES.Molding.BLL.MaterialProcess().Add(t);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public MaterialUnitInfo GetMaterialUnitBySN(string Serialnumber)
        {
            try
            {
                SKT.LeanMES.Material.BLL.MaterialUnit mu = new LeanMES.Material.BLL.MaterialUnit();
                return mu.GetInfo(Serialnumber);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return null;
        }

        [AjaxMethod]
        public void MaterialBurnEdit(MaterialBurnInfo entity)
        {
            try
            {
                Molding.BLL.MaterialBurn bll = new Molding.BLL.MaterialBurn();
                entity.CreateByName = entity.ModifyByName = AccountController.GetCurrentUser().UserName;
                entity.CreateTime = entity.ModifyTime = DateTime.Now;

                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void MaterialBurnMemberAdd(MaterialBurnMemberInfo entity)
        {
            try
            {
                Molding.BLL.MaterialBurnMember bll = new Molding.BLL.MaterialBurnMember();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void DelMaterialBurnMember(int itemid, int burnId,int MaterialItemId)
        {
            try
            {
                Molding.BLL.MaterialBurnMember bll = new Molding.BLL.MaterialBurnMember();
                bll.Delete(itemid, burnId, AccountController.GetCurrentUser().UserName, MaterialItemId);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public void AddDownLoadinfo(int moldingMemberId)
        {
            //插入下载记录
            LeanMES.Molding.BLL.MaterialMolding bll = new Molding.BLL.MaterialMolding();
            bll.AddBurnSoftDownLoad(moldingMemberId, AccountController.GetCurrentUser().UserName);
        }
    }
}