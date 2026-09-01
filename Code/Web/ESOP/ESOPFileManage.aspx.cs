using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using SKT.LeanMES.ESOP.BLL;
using SKT.Common.Model;
using SKT.LeanMES.ESOP.Model;

namespace SKT.LeanMES.Web.ESOP
{
    public partial class ESOPFileManage : BasePage
    {
        public StringBuilder fileNodes = new StringBuilder();

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEsop));
            if (!IsPostBack)
            {
                ESOPFile tree = new ESOPFile();
                SearchSettings search = new SearchSettings();
                List<ESOPTreeInfo> list = tree.GetAllESOPTree(0, -1, "", search);
                int i = 0;
                fileNodes.Append("[");
                string id, pid;
                foreach (ESOPTreeInfo info in list)
                {
                    id = info.ParentID == 0 ? "p" + info.NodeID.ToString() : info.NodeID.ToString();
                    pid = info.ParentID == 0 ? info.ParentID.ToString() : "p" + info.ParentID.ToString();
                    fileNodes.Append("{'id':'" + id + "','text':'" + info.NodeName + "','pId':'" + pid + "'}");
                    i++;
                    if (i != list.Count)
                    {
                        fileNodes.Append(",");
                    }
                }
                fileNodes.Append("]");
            }
        }
    }
}