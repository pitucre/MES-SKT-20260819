using System;

namespace SKT.LeanMES.ESOP.Model
{
    [Serializable]
    public class ESOPTreeInfo
    {
        private int nodeId;
        private int parentId;
        private string nodeName;
        public ESOPTreeInfo()
        {
        }
        public ESOPTreeInfo(int nodeId, int parentId, string nodeName)
        {
            this.NodeID = nodeId;
            this.ParentID = parentId;
            this.NodeName = nodeName;
        }
        public int NodeID
        {
            get { return this.nodeId; }
            set { this.nodeId = value; }
        }

        public int ParentID
        {
            get { return this.parentId;}
            set{this.parentId=value;}
        }

        public string NodeName
        {
            get { return this.nodeName; }
            set { this.nodeName = value; }
        }

    }
}
