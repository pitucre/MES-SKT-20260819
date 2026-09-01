/*-------------------------------------------------
// Copyright(C)2016 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:ProductionCollectionInfo.cs
// 文件功能描述：生产采集相关model信息。
// 
// 创建标识：Larry.Lin 2016/08/08
// 
// 
//--------------------------------------------------*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection
{
    

    public class ProductionCollectionInfo
    {
        private string _serialNumber;
        private int _userId;
        private int _stationId;
        private int _resourceId;
        private int _routeId;
        private int _prodOrderId;
        private string _relationNumber;
        private int _statusId;
        

        /// <summary>
        /// 当前扫描序列号
        /// </summary>
        public string SerialNumber
        {
            get { return _serialNumber; }
            set { _serialNumber = value; }
        }
        /// <summary>
        /// 当前用户Id
        /// </summary>
        public int UserId
        {
            get { return _userId; }
            set { _userId = value; }
        }
        /// <summary>
        /// 当前工序Id
        /// </summary>
        public int StationId
        {
            get { return _stationId; }
            set { _stationId = value; }
        }
        /// <summary>
        /// 当前资源Id
        /// </summary>
        public int ResourceId
        {
            get { return _resourceId; }
            set { _resourceId = value; }
        }
        /// <summary>
        /// 当前路由Id
        /// </summary>
        public int RouteId
        {
            get { return _routeId; }
            set { _routeId = value; }
        }
        /// <summary>
        /// 当前工单Id
        /// </summary>
        public int ProdOrderId
        {
            get { return _prodOrderId; }
            set { _prodOrderId = value; }
        }
        /// <summary>
        /// 相关联被绑定序列号
        /// </summary>
        public string RelationNumber
        {
            get { return _relationNumber; }
            set { _relationNumber = value; }
        }
        /// <summary>
        /// 当前过站状态（0：failure;1:pass;2.....）
        /// </summary>
        public int StatusId
        {
            get { return _statusId; }
            set { _statusId = value; }
        }
         
    }
}
