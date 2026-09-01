using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text;
using System.Web.UI.WebControls;
using System.Data;
using SKT.LeanMES.Manufacture.BLL;
using SKT.LeanMES.Manufacture.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Manufacture
{
    /*************************************
     *              信息中心
     *              
     * 创建时间：2014-11-13                               
     * 更新时间：
     * 创建人：zhibin.Chen
     * 修改人：
     ************************************/

    public partial class BasicInfo : BasePage
    {
        //搜索字符串
        private string searchString;

        //根据搜索的条件，判断某些信息的数据呈现。
        //1:序列号 ;  2:工单号(包含RMA)  ;  3:箱号  ;   4:型号和版本
        private int radioIndex;

        public int pageSize = 48;

        //数据源方法的类实例
        private InfoCenter infocenter = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxManufacture));
            this.pageTitle.Text = Resources.Pages.InfoCenter;

            try
            {

                if (IsPostBack)
                {
                    infocenter = new InfoCenter();

                    SetSearchStringAndRadioIndex();

                    //根据条件执行数据绑定的调度
                    switch (radioIndex)
                    {
                        case 1:
                            GetProductInfo();
                            GetItemInfo();
                            GetAssembleInfo();
                            GetPackInfo();
                            //GetGetPackingAccessoriesInfo();
                            GetModelInfo();
                            GetFlowPathInfo();
                            GetProductOrderInfo();
                            //GetPanelSN();
                            GetNCCodeRepairInfo();
                            GetDNDtlInfo();
                            GetShowBoardCount(); //显示上料记录
                                                 //GetTestDate();
                            GetRepairReplaseMaterial();
                            break;
                        case 2:
                            GetProductOrderInfo();
                            break;
                        case 3:
                            GetPackInfo();
                            //GetDNDtlInfo();
                            break;
                        case 4:
                            GetModelInfo();
                            break;
                        default:
                            ;
                            break;
                    }
                }
                else
                {
                    //页面初次打开时，默认选中序列号。
                    rdoSerialNumber.Checked = true;
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
            }
        }

        /// <summary>
        /// 获取拼板号
        /// </summary>
        /// <returns></returns>
        protected string GetPanelNo()
        {
            return infocenter == null ? "无" : infocenter.GetPanelNO();
        }

        ///// <summary>
        ///// 获取栈板下的所有序列号
        ///// </summary>
        //protected void GetPanelSN()
        //{
        //    StringBuilder strbuilder = new StringBuilder();
        //    List<InfoCenterInfo> posn = infocenter.GetPanelSN(searchString);
        //    strbuilder.Clear();

        //    if (posn.Count > 0)
        //    {
        //        strbuilder.Append("<ul>");
        //        foreach (InfoCenterInfo ici in posn)
        //        {
        //            strbuilder.AppendFormat("<li>{0}(位置：{1})</li>", ici.SerialNumber, ici.Location);
        //        }
        //        strbuilder.Append("</ul>");

        //        divPOproductlist.InnerHtml = strbuilder.ToString();
        //    }
        //}

        /// <summary>
        /// 设置搜索字符串和搜索条件的代号
        /// </summary>
        protected void SetSearchStringAndRadioIndex()
        {
            if (rdoSerialNumber.Checked)
            {
                searchString = GetSerialNumbr(txtSerialNumber.Value.Trim());
                radioIndex = 1;
            }
            else if (rdoProductOrder.Checked)
            {
                searchString = txtProductOrder.Value.Trim();
                radioIndex = 2;
            }
            else if (rdoBoxNumber.Checked)
            {
                searchString = txtBoxNumber.Value.Trim();
                radioIndex = 3;
            }
            else if (rdoModelNo.Checked)
            {
                searchString = "'" + txtModelNo.Value.Trim() + "' AND ItemRev = '" + txtVersions.Value.Trim() + "'";
                radioIndex = 4;
            }
        }

        /// <summary>
        /// 根据关联的序列号查询出当前产品序列号
        /// </summary>
        /// <param name="searchText"></param>
        /// <returns></returns>
        private string GetSerialNumbr(string searchText)
        {
            SKT.LeanMES.SerialNumber.BLL.SerialNumber bllData = new LeanMES.SerialNumber.BLL.SerialNumber();
            return bllData.GetSNByCSN(searchText);
        }

        /// <summary>
        /// 获取产品信息和历史记录
        /// </summary>
        protected void GetProductInfo()
        {
            /***************************产品简要信息*************************/
            VUnitHistoryInfo vhi = infocenter.GetProductSummaryInfo(searchString);

            StringBuilder strbuilder = new StringBuilder();

            if (vhi != null)
            {
                strbuilder.AppendFormat("<table width='98%'><tr><td width='100px'>{0}：</td><td>", Resources.lang.Station);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.Operation);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Status);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.UnitStatus);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Line);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.LineName);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Staff);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.LoginID);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ItemCode);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.ITEM);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ModelNo);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.ItemName);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ShopOrder);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.ProductionOrder);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.CreateDateTime);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.EnterTimeStr);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.LastUpdateTime);
                strbuilder.AppendFormat("{0}</td></tr></table>", vhi.ExitTimeStr);

                divProductSummaryInfo.InnerHtml = strbuilder.ToString();
            }
            else
            {
                divProductSummaryInfo.InnerHtml = Resources.Messages.NotConformToTheConditionsOfInformation;
            }


            /***************************产品生产记录*************************/
            rptProduct.DataSource = infocenter.GetProductHistory(searchString);
            rptProduct.DataBind();
        }

        /// <summary>
        /// 获取物料列表和使用记录信息
        /// </summary>
        /// <returns></returns>
        protected void GetItemInfo()
        {
            listboxUseItem.DataSource = infocenter.GetUseItemList(searchString, 0);
            listboxUseItem.DataValueField = "ItemID";
            listboxUseItem.DataTextField = "ItemName";
            listboxUseItem.DataBind();

            rptItemTracking.DataSource = infocenter.GetItemUseHistory(searchString);
            rptItemTracking.DataBind();
        }

        /// <summary>
        /// 显示产品上料信息
        /// </summary>
        private void GetShowBoardCount()
        {
            //首先获取成品料号
            VUnitHistoryInfo vhi = infocenter.GetProductSummaryInfo(searchString);
            if (vhi != null)
            {
                TreeNode treeNode = new TreeNode(vhi.ITEM);
                treeNode.SelectAction = TreeNodeSelectAction.None;

                var list = infocenter.GetUseItemList(searchString, 1);

                if (list.Count > 0)
                {
                    foreach (var subItem in list)
                    {

                        TreeNode chileNode = new TreeNode("物料编码:" + @subItem.ItemCode + "物料名称:" + @subItem.ItemName + "规格:" + @subItem.Description);
                        chileNode.SelectAction = TreeNodeSelectAction.None;
                        chileNode.NavigateUrl = subItem.ItemID.ToString();
                        treeNode.ChildNodes.Add(chileNode);

                    }
                }
                treeBoardCount.Nodes.Add(treeNode);
                treeBoardCount.SelectedNodeStyle.Font.Bold = true;
                treeBoardCount.RootNodeStyle.CssClass = "tvroot";
                treeBoardCount.RootNodeStyle.Font.ClearDefaults();
                treeBoardCount.ExpandAll();
            }
        }
                
        /// <summary>
        /// 查询产品组装信息
        /// </summary>
        private void GetAssembleInfo()
        {
            //在线组装条码
            var list = infocenter.GetAssemblesList(searchString);

            //离线组装条码
            var offlineList = infocenter.GetOfflineSNList(searchString);
            if (list.Count > 0)
            {
                TreeNode tnode = new TreeNode("<b>" + list[0].MainItemCode + "</b> - " + @list[0].MainItemName);
                tnode.SelectAction = TreeNodeSelectAction.None;

                foreach (var subItem in list)
                {
                    TreeNode cnode = new TreeNode("<b>" + subItem.ItemCode + "</b> - " + @subItem.ItemName);
                    cnode.SelectAction = TreeNodeSelectAction.None;

                    var snList = subItem.SerialNumber.Split(',');
                    foreach (var sn in snList)
                    {
                        if (sn.Trim() != "")
                        {
                            TreeNode snode = new TreeNode(sn);
                            snode.SelectAction = TreeNodeSelectAction.None;
                            snode.Selected = false;
                            var node = GetSubAssembleNodeInfo(sn);
                            if (node.ChildNodes.Count > 0)
                            {
                                for (int i = node.ChildNodes.Count; i > 0; i--)
                                {
                                    snode.ChildNodes.Add(node.ChildNodes[i - 1]);
                                }
                            }
                            cnode.ChildNodes.Add(snode);
                        }
                    }
                    tnode.ChildNodes.Add(cnode);
                }

                if (offlineList.Count > 0)
                {
                    var hasItemCodeList = offlineList.Where(q => q.ItemCode != "").ToList().Select(q => new { q.ItemCode, q.ItemName }).Distinct();//有ItemCode
                    var noItemCodeList = offlineList.Where(q => q.ItemCode == "").ToList();//没有ItemCode

                    foreach (var hasItemCodeEntity in hasItemCodeList)
                    {
                        TreeNode cnode = new TreeNode("<b>" + hasItemCodeEntity.ItemCode + "</b> - " + @hasItemCodeEntity.ItemName);
                        cnode.SelectAction = TreeNodeSelectAction.None;
                        var ItemCodeList = offlineList.Where(q => q.ItemCode == hasItemCodeEntity.ItemCode).ToList();
                        foreach (var entity in ItemCodeList)
                        {
                            TreeNode snode = new TreeNode(entity.SerialNumber);
                            snode.SelectAction = TreeNodeSelectAction.None;
                            snode.Selected = false;
                            cnode.ChildNodes.Add(snode);

                        }
                        tnode.ChildNodes.Add(cnode);
                    }

                    if (noItemCodeList.Count > 0)
                    {
                        TreeNode cnode = new TreeNode("<b>其他部件条码</b>");
                        cnode.SelectAction = TreeNodeSelectAction.None;
                        foreach (var noItemCodeEntity in noItemCodeList)
                        {
                            TreeNode snode = new TreeNode(noItemCodeEntity.SerialNumber);
                            snode.SelectAction = TreeNodeSelectAction.None;
                            snode.Selected = false;
                            cnode.ChildNodes.Add(snode);
                        }
                        tnode.ChildNodes.Add(cnode);
                    }

                }

                treeAssemble.Nodes.Add(tnode);
                treeAssemble.SelectedNodeStyle.Font.Bold = true;
                treeAssemble.RootNodeStyle.CssClass = "tvroot";
                treeAssemble.RootNodeStyle.Font.ClearDefaults();
                treeAssemble.ExpandAll();
            }
            else
            {
                if (offlineList.Count > 0)
                {
                    TreeNode tnode = new TreeNode("<b>" + offlineList[0].MainItemCode + "</b> - " + @offlineList[0].MainItemName);
                    tnode.SelectAction = TreeNodeSelectAction.None;

                    var hasItemCodeList = offlineList.Where(q => q.ItemCode != "").ToList().Select(q => new { q.ItemCode, q.ItemName }).Distinct();//有ItemCode
                    var noItemCodeList = offlineList.Where(q => q.ItemCode == "").ToList();//没有ItemCode

                    foreach (var hasItemCodeEntity in hasItemCodeList)
                    {
                        TreeNode cnode = new TreeNode("<b>" + hasItemCodeEntity.ItemCode + "</b> - " + @hasItemCodeEntity.ItemName);
                        cnode.SelectAction = TreeNodeSelectAction.None;
                        var ItemCodeList = offlineList.Where(q => q.ItemCode == hasItemCodeEntity.ItemCode).ToList();
                        foreach (var entity in ItemCodeList)
                        {
                            TreeNode snode = new TreeNode(entity.SerialNumber);
                            snode.SelectAction = TreeNodeSelectAction.None;
                            snode.Selected = false;

                            cnode.ChildNodes.Add(snode);

                        }
                        tnode.ChildNodes.Add(cnode);
                    }

                    if (noItemCodeList.Count > 0)
                    {
                        TreeNode cnode = new TreeNode("<b>其他部件条码</b>");
                        cnode.SelectAction = TreeNodeSelectAction.None;
                        foreach (var noItemCodeEntity in noItemCodeList)
                        {
                            TreeNode snode = new TreeNode(noItemCodeEntity.SerialNumber);
                            snode.SelectAction = TreeNodeSelectAction.None;
                            snode.Selected = false;
                            cnode.ChildNodes.Add(snode);
                        }
                        tnode.ChildNodes.Add(cnode);
                    }

                    treeAssemble.Nodes.Add(tnode);
                    treeAssemble.SelectedNodeStyle.Font.Bold = true;
                    treeAssemble.RootNodeStyle.CssClass = "tvroot";
                    treeAssemble.RootNodeStyle.Font.ClearDefaults();
                    treeAssemble.ExpandAll();
                }
            }

        }

        /// <summary>
        /// 获取下级组装信息
        /// </summary>
        /// <param name="serialNumber"></param>
        /// <returns></returns>
        private TreeNode GetSubAssembleNodeInfo(string serialNumber)
        {
            //在线组装条码
            var list = infocenter.GetAssemblesList(serialNumber);

            //离线组装条码
            var offlineList = infocenter.GetOfflineSNList(serialNumber);

            if (list.Count > 0)
            {
                TreeNode tnode = new TreeNode("<b>" + list[0].MainItemCode + "</b> - " + @list[0].MainItemName);
                tnode.SelectAction = TreeNodeSelectAction.None;

                foreach (var subItem in list)
                {
                    TreeNode cnode = new TreeNode("<b>" + subItem.ItemCode + "</b> - " + @subItem.ItemName);
                    cnode.SelectAction = TreeNodeSelectAction.None;

                    var snList = subItem.SerialNumber.Split(',');
                    foreach (var sn in snList)
                    {
                        if (sn.Trim() != "")
                        {
                            TreeNode snode = new TreeNode(sn);
                            snode.SelectAction = TreeNodeSelectAction.None;
                            snode.Selected = false;
                            var node = GetSubAssembleNodeInfo(sn);
                            if (node.ChildNodes.Count > 0)
                            {
                                for (int i = node.ChildNodes.Count; i > 0; i--)
                                {
                                    snode.ChildNodes.Add(node.ChildNodes[i - 1]);
                                }
                            }
                            cnode.ChildNodes.Add(snode);
                        }
                    }
                    tnode.ChildNodes.Add(cnode);
                }

                if (offlineList.Count > 0)
                {
                    var hasItemCodeList = offlineList.Where(q => q.ItemCode != "").ToList().Select(q => new { q.ItemCode, q.ItemName }).Distinct();//有ItemCode
                    var noItemCodeList = offlineList.Where(q => q.ItemCode == "").ToList();//没有ItemCode

                    foreach (var hasItemCodeEntity in hasItemCodeList)
                    {
                        TreeNode cnode = new TreeNode("<b>" + hasItemCodeEntity.ItemCode + "</b> - " + @hasItemCodeEntity.ItemName);
                        cnode.SelectAction = TreeNodeSelectAction.None;
                        var ItemCodeList = offlineList.Where(q => q.ItemCode == hasItemCodeEntity.ItemCode).ToList();
                        foreach (var entity in ItemCodeList)
                        {
                            TreeNode snode = new TreeNode(entity.SerialNumber);
                            snode.SelectAction = TreeNodeSelectAction.None;
                            snode.Selected = false;
                            cnode.ChildNodes.Add(snode);

                        }
                        tnode.ChildNodes.Add(cnode);
                    }

                    if (noItemCodeList.Count > 0)
                    {
                        TreeNode cnode = new TreeNode("<b>其他部件条码</b>");
                        cnode.SelectAction = TreeNodeSelectAction.None;
                        foreach (var noItemCodeEntity in noItemCodeList)
                        {
                            TreeNode snode = new TreeNode(noItemCodeEntity.SerialNumber);
                            snode.SelectAction = TreeNodeSelectAction.None;
                            snode.Selected = false;
                            cnode.ChildNodes.Add(snode);
                        }
                        tnode.ChildNodes.Add(cnode);
                    }

                }
                return tnode;
            }
            else if (offlineList.Count > 0)
            {
                TreeNode tnode = new TreeNode("<b>" + offlineList[0].MainItemCode + "</b> - " + @offlineList[0].MainItemName);
                tnode.SelectAction = TreeNodeSelectAction.None;

                var hasItemCodeList = offlineList.Where(q => q.ItemCode != "").ToList().Select(q => new { q.ItemCode, q.ItemName }).Distinct();//有ItemCode
                var noItemCodeList = offlineList.Where(q => q.ItemCode == "").ToList();//没有ItemCode

                foreach (var hasItemCodeEntity in hasItemCodeList)
                {
                    TreeNode cnode = new TreeNode("<b>" + hasItemCodeEntity.ItemCode + "</b> - " + @hasItemCodeEntity.ItemName);
                    cnode.SelectAction = TreeNodeSelectAction.None;
                    var ItemCodeList = offlineList.Where(q => q.ItemCode == hasItemCodeEntity.ItemCode).ToList();
                    foreach (var entity in ItemCodeList)
                    {
                        TreeNode snode = new TreeNode(entity.SerialNumber);
                        snode.SelectAction = TreeNodeSelectAction.None;
                        snode.Selected = false;

                        cnode.ChildNodes.Add(snode);

                    }
                    tnode.ChildNodes.Add(cnode);
                }

                if (noItemCodeList.Count > 0)
                {
                    TreeNode cnode = new TreeNode("<b>其他部件条码</b>");
                    cnode.SelectAction = TreeNodeSelectAction.None;
                    foreach (var noItemCodeEntity in noItemCodeList)
                    {
                        TreeNode snode = new TreeNode(noItemCodeEntity.SerialNumber);
                        snode.SelectAction = TreeNodeSelectAction.None;
                        snode.Selected = false;
                        cnode.ChildNodes.Add(snode);
                    }
                    tnode.ChildNodes.Add(cnode);
                }

                return tnode;
            }
            else
            {
                return new TreeNode();
            }

        }
        /// <summary>
        /// 获取包装信息
        /// </summary>
        /// <returns></returns>
        protected void GetPackInfo()
        {
            int ispackno = radioIndex == 3 ? 1 : 0;

            /**************************该包装箱的详情****************************/

            ContainerInfo ccp = infocenter.GetPackDetailInfo(searchString, ispackno);

            StringBuilder strbuilder = new StringBuilder();

            if (ccp != null)
            {
                strbuilder.AppendFormat("<table><tr><td>{0}：</td><td>", Resources.lang.Status);
                strbuilder.AppendFormat("{0}</td></tr>", ccp.Status);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Station);
                strbuilder.AppendFormat("{0}</td></tr>", ccp.OPeration);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Staff);
                strbuilder.AppendFormat("{0}</td></tr>", ccp.UserName);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.CreateDateTime);
                strbuilder.AppendFormat("{0}</td></tr>", ccp.CreateDateTime);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.LastUpdateTime);
                strbuilder.AppendFormat("{0}</td></tr>", SKT.Common.Utility.TypeHelper.ToString(ccp.ModifyDateTime));
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Type);
                strbuilder.AppendFormat("{0}</td></tr>", ccp.Name);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Dimension);
                strbuilder.AppendFormat("{0}</td></tr>", ccp.Height + " x " + ccp.Width + " x " + ccp.Depth);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.LoadCapacity);
                strbuilder.AppendFormat("{0}</td></tr>", ccp.Weight);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.MaxLoadCapacity);
                strbuilder.AppendFormat("{0}</td></tr></table>", ccp.MaxFillWeight);

                divPackingDetailInfo.InnerHtml = strbuilder.ToString();
            }
            else
            {
                divPackingDetailInfo.InnerHtml = Resources.Messages.NotConformToTheConditionsOfInformation;
            }

            /**************************该包装箱内包含的产品列表****************************/

            List<InfoCenterInfo> bpp = infocenter.GetInPackProductList(searchString, ispackno);

            if (bpp.Count > 0)
            {
                var palletSN = infocenter.GetBoxNumber();
                //TreeNode tnode = new TreeNode(palletSN, palletSN);
                //tnode.SelectAction = TreeNodeSelectAction.None;
                var packSNList = bpp.Where(q => q.ContainerSN == palletSN).ToList();
                if (packSNList.Count == 0){
                    packSNList = bpp.Where(q => q.BoxSN == palletSN).ToList();
                }

                TreeNode tnode = new TreeNode(palletSN + "( " + packSNList.Count.ToString() + " )", palletSN);
                tnode.SelectAction = TreeNodeSelectAction.None;

                foreach (var packEntity in packSNList)
                {
                    var snList = bpp.Where(q => q.ContainerSN == packEntity.SerialNumber).ToList();

                    TreeNode cnode = new TreeNode(packEntity.SerialNumber + "( " + snList.Count.ToString() + " )", packEntity.SerialNumber);
                    cnode.SelectAction = TreeNodeSelectAction.None;
                    cnode.Selected = packEntity.SerialNumber == searchString ? true : false;

                    foreach (var snEntity in snList)
                    {
                        TreeNode snode = new TreeNode(snEntity.SerialNumber);
                        snode.SelectAction = TreeNodeSelectAction.None;
                        snode.Selected = snEntity.SerialNumber == searchString ? true : false;
                        cnode.ChildNodes.Add(snode);
                    }
                    tnode.ChildNodes.Add(cnode);
                }
                tvBoxPack.Nodes.Add(tnode);
                tvBoxPack.SelectedNodeStyle.Font.Bold = true;
                tvBoxPack.RootNodeStyle.CssClass = "tvroot";
                tvBoxPack.RootNodeStyle.Font.ClearDefaults();
                tvBoxPack.ExpandAll();
            }

            /******************************该包装箱的包装记录******************************/
            rptPacking.DataSource = infocenter.GetPackHistory(searchString, ispackno);
            rptPacking.DataBind();
        }
        
        ///// <summary>
        ///// 获取包装附件信息
        ///// </summary>
        //protected void GetGetPackingAccessoriesInfo()
        //{
        //    rptPackingAccessories.DataSource = infocenter.GetPackingAccessoriesInfo(searchString);
        //    rptPackingAccessories.DataBind();
        //}

        /// <summary>
        /// 获取型号信息
        /// </summary>
        /// <returns></returns>
        protected void GetModelInfo()
        {
            int ismo = radioIndex == 4 ? 1 : 0;
            StringBuilder strbuilder = new StringBuilder();

            /***************************型号简要信息*************************/
            ItemsInfo msi = infocenter.GetModelSummaryInfo(searchString, ismo);

            if (msi != null)
            {
                strbuilder.AppendFormat("<table width='98%'><tr><td width='100px'>{0}：</td><td>", Resources.lang.ModelNo);
                strbuilder.AppendFormat("{0}</td></tr>", msi.ItemName);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.AC_Version);
                strbuilder.AppendFormat("{0}</td></tr>", msi.ItemRev);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.AC_Description);
                strbuilder.AppendFormat("{0}</td></tr>", msi.Description);
                //strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.NCGroupName);
                //strbuilder.AppendFormat("{0}</td></tr>", msi.ItemGroupName);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Type);
                strbuilder.AppendFormat("{0}</td></tr>", msi.ItemType_Choose);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Status);
                strbuilder.AppendFormat("{0}</td></tr></table>", msi.ItemStatus_Choose);

                divModelSummaryInfo.InnerHtml = strbuilder.ToString();
            }
            else
            {
                divModelSummaryInfo.InnerHtml = Resources.Messages.NotConformToTheConditionsOfInformation;
            }


            /***************************型号详细信息*************************/
            ItemsInfo mdi = infocenter.GetModelDetailInfo(searchString, ismo);
            strbuilder.Clear();
            if (mdi != null)
            {
                strbuilder.AppendFormat("<table><tr><td>{0}：</td><td>", Resources.lang.ProjectName);
                strbuilder.AppendFormat("{0}</td></tr>", mdi.ProjectName);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.BomName);
                strbuilder.AppendFormat("{0}</td></tr>", mdi.BomName);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.IsCurrentRev);
                strbuilder.AppendFormat("{0}</td></tr>", GetBoolString(mdi.IsCurrentRev));
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.IsPanel);
                strbuilder.AppendFormat("{0}</td></tr>", GetBoolString(mdi.IsPanel));
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.IsCustomerProvidedSFC);
                strbuilder.AppendFormat("{0}</td></tr>", GetBoolString(mdi.IsCPSFC));
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.IsRohs);
                strbuilder.AppendFormat("{0}</td></tr>", GetBoolString(mdi.IsRoHS));
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.IsTrackableComp);
                strbuilder.AppendFormat("{0}</td></tr>", GetBoolString(mdi.TrackableComp));
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.MaxUsageAsComp);
                strbuilder.AppendFormat("{0}</td></tr>", mdi.MaxUsageAsComp);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.QtyRestriction);
                strbuilder.AppendFormat("{0}</td></tr></table>", mdi.QtyRestriction);

                divModelDetailInfo.InnerHtml = strbuilder.ToString();
            }
            else
            {
                divModelDetailInfo.InnerHtml = Resources.Messages.NotConformToTheConditionsOfInformation;
            }

            /***************************型号分组结构*************************/
            List<ItemsInfo> mgl = infocenter.GetModelGroupList(searchString, ismo);

            if (mgl.Count > 0)
            {
                TreeNode tnode = new TreeNode(infocenter.GetModelGroupName(), infocenter.GetModelGroupName());
                tnode.SelectAction = TreeNodeSelectAction.None;


                string cItemName = radioIndex == 4 ? txtModelNo.Value.Trim() : infocenter.GetModelCurrentName();

                for (int i = 0; i < mgl.Count; i++)
                {
                    TreeNode cnode = new TreeNode(mgl[i].ItemName, mgl[i].ItemID.ToString());
                    cnode.SelectAction = TreeNodeSelectAction.None;
                    cnode.Selected = mgl[i].ItemName == cItemName ? true : false;
                    tnode.ChildNodes.Add(cnode);
                }
                tvmodelgroup.Nodes.Add(tnode);
                tvmodelgroup.SelectedNodeStyle.Font.Bold = true;
                tvmodelgroup.RootNodeStyle.CssClass = "tvroot";
                tvmodelgroup.RootNodeStyle.Font.ClearDefaults();
                tvmodelgroup.ExpandAll();
            }

            /***************************型号分组信息*************************/
            ItemsInfo mdgi = infocenter.GetModelRelyOnInfo(searchString, ismo);
            strbuilder.Clear();
            if (mdgi != null)
            {
                strbuilder.AppendFormat("<table><tr><td>{0}：</td><td>", Resources.lang.ItemGroupName);
                strbuilder.AppendFormat("{0}</td></tr>", mdgi.ItemGroupName);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Description);
                strbuilder.AppendFormat("{0}</td></tr>", mdgi.ItemGroupDesc);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Creator);
                strbuilder.AppendFormat("{0}</td></tr>", mdgi.CreateBy);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.CreateTime);
                strbuilder.AppendFormat("{0}</td></tr></table>", mdi.InsertTime);

                divModelRelyOn.InnerHtml = strbuilder.ToString();
            }
            else
            {
                divModelRelyOn.InnerHtml = Resources.Messages.NotConformToTheConditionsOfInformation;
            }
        }

        /// <summary>
        /// 获取流程信息
        /// </summary>
        /// <returns></returns>
        protected void GetFlowPathInfo()
        {
            InfoCenterInfo ici = infocenter.GetFlowPathInfo(searchString);

            if (ici != null)
            {
                StringBuilder strbuilder = new StringBuilder();

                strbuilder.AppendFormat("<br/><br/><table><tr><td>&nbsp;&nbsp;&nbsp;&nbsp;{0}：</td><td>", Resources.lang.RouterName);
                strbuilder.AppendFormat("{0}</td></tr>", ici.RouterName);
                strbuilder.AppendFormat("<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;{0}：</td><td>", Resources.lang.NextStation);
                strbuilder.AppendFormat("{0}</td></tr>", ici.NextOperation);
                strbuilder.Append("</td></tr></table>");

                divNextFlowPath.InnerHtml = strbuilder.ToString();
            }
            else
            {
                divNextFlowPath.InnerHtml = Resources.Messages.NotConformToTheConditionsOfInformation;
            }
        }

        /// <summary>
        /// 获取工单历史记录，工单详细信息。
        /// </summary>
        /// <returns></returns>
        protected void GetProductOrderInfo()
        {
            int ispo = radioIndex == 2 ? 1 : 0;
            StringBuilder strbuilder = new StringBuilder();

            /************************工单历史***************************/

            List<InfoCenterInfo> icilist = infocenter.GetProductOrderHistory(searchString, ispo);

            if (icilist.Count > 0)
            {
                strbuilder.Append("<table width='60%'>");
                strbuilder.AppendFormat("<tr><td>{0}</td><td>{1}</td></tr>", Resources.lang.OperationTime, Resources.lang.AC_Operate);
                for (int i = 0; i < icilist.Count; i++)
                {
                    strbuilder.AppendFormat("<tr><td>{0}</td>", icilist[i].ProdOrderHistoryTime);
                    strbuilder.AppendFormat("<td>{0}</td></tr>", icilist[i].ProdOrderAction);
                }

                strbuilder.AppendFormat("</table>");

                divProductOrderHistory.InnerHtml = strbuilder.ToString();
            }


            /************************工单详情***************************/

            ProductOrderInfo pod = infocenter.GetProductOrderDetailInfo(searchString, ispo);

            if (pod != null)
            {
                strbuilder.Clear();
                strbuilder.AppendFormat("<table><tr><td>{0}：</td><td>", Resources.lang.Status);
                strbuilder.AppendFormat("{0}</td></tr>", pod.StatusStr);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.CreateDateTime);
                strbuilder.AppendFormat("{0}</td></tr>", pod.CreateTime);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.LastUpdateTime);
                strbuilder.AppendFormat("{0}</td></tr>", SKT.Common.Utility.TypeHelper.ToString(pod.ModifyTime));
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ModelNo);
                strbuilder.AppendFormat("{0}</td></tr>", pod.ItemName);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Quantity);
                strbuilder.AppendFormat("{0}</td></tr>", pod.Qty_to_Build);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Qty_Released);
                strbuilder.AppendFormat("{0}</td></tr>", pod.Qty_Released);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Qty_Done);
                strbuilder.AppendFormat("{0}</td></tr>", pod.Qty_Done);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Qty_Scrapped);
                strbuilder.AppendFormat("{0}</td></tr>", pod.Qty_Scrapped);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ScheduledStartDate);
                strbuilder.AppendFormat("{0}</td></tr>", SKT.Common.Utility.TypeHelper.ToString(pod.Scheduled_Start_Date));
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ScheduledCompletedDate);
                strbuilder.AppendFormat("{0}</td></tr>", SKT.Common.Utility.TypeHelper.ToString(pod.Scheduled_Completed_Time));
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ActualStartDate);
                strbuilder.AppendFormat("{0}</td></tr>", SKT.Common.Utility.TypeHelper.ToString(pod.Actual_Start_Date));
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ActualCompletedDate);
                strbuilder.AppendFormat("{0}</td></tr></table>", SKT.Common.Utility.TypeHelper.ToString(pod.Actual_Completed_Date));

                divProductOrderDetailInfo.InnerHtml = strbuilder.ToString();
            }
            else
            {
                divProductOrderDetailInfo.InnerHtml = Resources.Messages.NotConformToTheConditionsOfInformation;
            }

            /************************工单产品***************************/

            //List<InfoCenterInfo> posn = infocenter.GetProductListByOrderNo(searchString, 0, pageSize, ispo);
            //strbuilder.Clear();

            //if (posn.Count > 0)
            //{
            //    strbuilder.Append("<ul>");
            //    foreach (InfoCenterInfo ici in posn)
            //    {
            //        strbuilder.AppendFormat("<li>{0}</li>", ici.SerialNumber);
            //    }
            //    strbuilder.Append("</ul>");

            //    //divPOproductlist.InnerHtml = strbuilder.ToString();
            //}
        }

        /// <summary>
        /// 查询产品不良维修信息
        /// </summary>
        protected void GetNCCodeRepairInfo()
        {
            rptNCCodeRepair.DataSource = infocenter.GetNCCodeList(searchString);
            rptNCCodeRepair.DataBind();
        }

        /// <summary>
        /// 返回当前是基于什么条件，进行的信息查询。
        /// </summary>
        /// <returns></returns>
        public int GetRadioIndex()
        {
            return radioIndex;
        }

        /// <summary>
        /// 根据当前搜索条件，设置对应的label标示信息。
        /// </summary>
        /// <returns></returns>
        public string GetLabelTitle()
        {
            return radioIndex == 4 ? txtModelNo.Value.Trim() : searchString;
        }

        /// <summary>
        /// 根据数据中的布尔值，返回对应的中文或英文。
        /// </summary>
        /// <param name="bl">布尔值</param>
        /// <returns>是,否，Yes,No</returns>
        public string GetBoolString(bool bl)
        {
            return bl ? Resources.lang.Yes : Resources.lang.No;
        }

        /// <summary>
        /// 获取该工单下产品总个数
        /// </summary>
        /// <returns></returns>
        public int GetProductCountByOrderNo()
        {
            return infocenter == null ? 0 : infocenter.GetProductCountByOrderNo();
        }

        /// <summary>
        /// 获取工单号
        /// </summary>
        /// <returns></returns>
        public string GetProductOrderNo()
        {
            return infocenter == null ? "" : infocenter.GetProductOrderNo(); ;
        }

        /// <summary>
        /// 获取根据产品搜索时的箱号
        /// </summary>
        /// <returns></returns>
        public string GetBoxNumber()
        {
            return infocenter == null ? "" : infocenter.GetBoxNumber();
        }

        /// <summary>
        /// 获取型号分组名称
        /// </summary>
        /// <returns></returns>
        public string GetModelGroupName()
        {
            return infocenter == null ? "" : infocenter.GetModelGroupName(); ;
        }

        /// <summary>
        /// 获取当前查询的型号名称
        /// </summary>
        /// <returns></returns>
        public string GetModelCurrentName()
        {
            return infocenter == null ? "" : infocenter.GetModelCurrentName();
        }

        /// <summary>
        /// 查询出货详情
        /// </summary>
        protected void GetDNDtlInfo()
        {
            StockInfo.WarehouseCpOutStockInfo vhi = infocenter.GetDNInfo(searchString);

            StringBuilder strbuilder = new StringBuilder();
            string Status = "";
            if (vhi != null)
            {
                switch (vhi.Status)
                {
                    case 1:
                        Status = "备货中";
                        break;
                    case 2:
                        Status = "备货完成";
                        break;
                    case 3:
                        Status = "已检验";
                        break;
                    case 4:
                        Status = "已出货";
                        break;
                }
                strbuilder.AppendFormat("<table width='98%'><tr><td width='100px'>{0}：</td><td>", Resources.lang.DNCode);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.DNCode);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.Status);
                strbuilder.AppendFormat("{0}</td></tr>", Status);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.BackERPStatus);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.BackERPStatus);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ClientCode);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.CusCode);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ClientName);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.CusName);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ClientAddress);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.Address);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.SalOrderDate);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.SalOrderDate);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.CreateBy);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.CreateBy);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.CreateDateTime);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.CreateDateTime);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ModifyBy);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.ModifyBy);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.ModifyDateTime);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.ModifyDateTime);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.DNModifyBy);
                strbuilder.AppendFormat("{0}</td></tr>", vhi.FinishBy);
                strbuilder.AppendFormat("<tr><td>{0}：</td><td>", Resources.lang.DNFinishBy);
                strbuilder.AppendFormat("{0}</td></tr></table>", vhi.FinishDateTime);
                // strbuilder.AppendFormat("<tr><td>{0}</td></tr></table>", vhi.CreateDateTime);

                divOutStock.InnerHtml = strbuilder.ToString();
            }
            else
            {
                divOutStock.InnerHtml = Resources.Messages.NotConformToTheConditionsOfInformation;
            }

            Repeater1.DataSource = infocenter.GetDNDtlInfo(searchString);

            Repeater1.DataBind();
        }

        ///// <summary>
        ///// 查询测试数据信息
        ///// </summary>
        //protected void GetTestDate()
        //{
        //    Repeater2.DataSource = infocenter.GetTestDate(searchString);

        //    Repeater2.DataBind();
        //}

        //维修更换物料
        private void GetRepairReplaseMaterial()
        {
            ProductionCollection.Client.ProdCollectionRepair bll = new ProductionCollection.Client.ProdCollectionRepair();
            var entity = new ProductionCollection.Model.NcReplaceMaterialInfo { SN = searchString };
            var list = bll.GetRepairReplaceMaterial(entity);
            if (list != null && list.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                foreach (var item in list)
                {
                    sb.AppendFormat("<tr><td>{0}</td>", item.CreateDateTime == null ? string.Empty : item.CreateDateTime.Value.ToString("yyyy-MM-dd"));
                    sb.AppendFormat("<td>{0}</td>", item.GRN);
                    sb.AppendFormat("<td>{0}</td>", item.ItemCodeBefore);
                    sb.AppendFormat("<td>{0}</td>", item.Num == null ? string.Empty : item.Num.ToString());
                    sb.AppendFormat("<td>{0}</td>", item.DateCodeBefore);
                    sb.AppendFormat("<td>{0}</td>", item.LotCodeBefore);
                    sb.AppendFormat("<td>{0}</td>", item.ReplaceGRN);
                    sb.AppendFormat("<td>{0}</td>", item.ItemCodeAfter);
                    sb.AppendFormat("<td>{0}</td>", item.DateCodeAfter);
                    sb.AppendFormat("<td>{0}</td></tr>", item.LotCodeAfter);
                }
                ltrRepairReplaseMaterial.Text = sb.ToString();
            }
            else
            {
                ltrRepairReplaseMaterial.Text = "<tr><td style=\"text-align:center\" colspan=\"10\">" + Resources.Messages.NotConformToTheConditionsOfInformation + "</td></tr>";
            }
        }
    }
}
