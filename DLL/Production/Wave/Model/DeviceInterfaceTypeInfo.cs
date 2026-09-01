using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Wave.Model
{
    [Serializable]
    public class DeviceInterfaceTypeInfo
    {
        private int _deviceInterfaceTypeId;
        private string _devicetype;
        private string _brand;
        private string _createby;
        private DateTime? _createtime = DateTime.Now;
        private string _modifyby;
        private DateTime? _modifydatetime = DateTime.Now;
        /// <summary>
        /// 主键
        /// </summary>
        public int DeviceInterfaceTypeId
        {
            set { _deviceInterfaceTypeId = value; }
            get { return _deviceInterfaceTypeId; }
        }
        /// <summary>
        /// 设备类型
        /// </summary>
        public string DeviceType
        {
            set { _devicetype = value; }
            get { return _devicetype; }
        }
        /// <summary>
        /// 品牌型号
        /// </summary>
        public string Brand
        {
            set { _brand = value; }
            get { return _brand; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string CreateBy
        {
            set { _createby = value; }
            get { return _createby; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? CreateTime
        {
            set { _createtime = value; }
            get { return _createtime; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string ModifyBy
        {
            set { _modifyby = value; }
            get { return _modifyby; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime? ModifyDateTime
        {
            set { _modifydatetime = value; }
            get { return _modifydatetime; }
        }
    }
}