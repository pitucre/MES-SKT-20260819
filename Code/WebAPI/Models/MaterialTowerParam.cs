using System;
using System.Collections.Generic;
using System.Text;

namespace WebAPI.Models
{

    /// <summary>
    /// 料塔操作接口入参
    /// </summary>
    public class MaterialTowerInParam
    {
        /// <summary>
        /// 设备IP
        /// </summary>
        public string IP { get; set; }
        /// <summary>
        /// 料塔设备编码
        /// </summary>
        public string ID { get; set; }
        /// <summary>
        /// 物料编码（可为空） 
        /// </summary>
        public string Materiel { get; set; }
        /// <summary>
        /// 回调接口
        /// </summary>
        public string ReIp { get; set; }
        /// <summary>
        /// 层号
        /// </summary>
        public string LayerNo { get; set; }
        /// <summary>
        /// 储位号 
        /// </summary>
        public string PositionNo { get; set; }
        /// <summary>
        /// 预转层号（可为空，存料指令时有效）
        /// </summary>
        public string NextLayerNo { get; set; }
        /// <summary>
        /// 预转储位号（可为空，存料指令时有效）
        /// </summary>
        public string NextPositionNo { get; set; }
    }


    /// <summary>
    /// 料塔操作接口参数
    /// </summary>
    public class MaterialTowerParam
    {
        /// <summary>
        /// 设备IP
        /// </summary>
        public string IP { get; set; }
        /// <summary>
        /// 料塔设备编码
        /// </summary>
        public string ID { get; set; }
        /// <summary>
        /// 层号
        /// </summary>
        public string LayerNo { get; set; }
        /// <summary>
        /// 储位号 
        /// </summary>
        public string PositionNo { get; set; }
        /// <summary>
        /// 物料编码（可为空） 
        /// </summary>
        public string Materiel { get; set; }
        /// <summary>
        /// 操作类型（按类型分接口，暂时写死） 【1.存料;2.取料;3.清除料塔有料;4.清空所有储位;5.查询所有储位有无料;6.查询真实有无料;7.测试;】
        /// </summary>
        public string OPType { get; set; }
        /// <summary>
        /// 指令执行状态（按类型分接口，暂时写死） 【0.待处理;1.正常完成;2.设备报警;3.取消操作;4.取消失败;5.取消成功;6.存料有料（MES无料，实际料塔有料） ;7.取料无料（MES有料，实际料塔无料）;】
        /// </summary>
        public string Status { get; set; }
        /// <summary>
        /// 预转层号（可为空，存料指令时有效）
        /// </summary>
        public string NextLayerNo { get; set; }
        /// <summary>
        /// 预转储位号（可为空，存料指令时有效）
        /// </summary>
        public string NextPositionNo { get; set; }
    }
    /// <summary>
    /// 
    /// </summary>
    public class InternalMaterialTowerParam : MaterialTowerParam
    {
        /// <summary>
        /// 30个随机字符0-9 a-f A-F 
        /// </summary>
        public string MakeRand
        {
            get
            {
                //内网环境写死，确保有值存在
                return OPType + "-" + Guid.NewGuid().ToString();
            }
        }
        /// <summary>
        /// 校验码（ApiKey+ID+MakeRand）MD5加密，ApiKey为料塔提供的固定字符串;ID为设备编码
        /// </summary>
        public string Sign
        {
            get
            {
                //内网环境写死，确保有值存在
                return Guid.NewGuid().ToString();
            }
        }
        /// <summary>
        /// 服务号（唯一，MES生成）
        /// </summary>
        public string ServerNo
        {
            get
            {
                return Materiel + "_" + Guid.NewGuid();
            }
        }
    }

    /// <summary>
    /// 料塔操作接口返回参数
    /// </summary>
    public class MaterialTowerResponse
    {
        /// <summary>
        /// 料塔设备编码
        /// </summary>
        public string ID { get; set; }
        /// <summary>
        /// 30个随机字符0-9 a-f A-F 
        /// </summary>
        public string MakeRand { get; set; }
        /// <summary>
        /// 服务号（唯一，MES生成）
        /// </summary>
        public string ServerNo { get; set; }
        /// <summary>
        /// 校验码（ApiKey+ID+MakeRand）MD5加密，ApiKey为料塔提供的固定字符串;ID为设备编码
        /// </summary>
        public string Sign { get; set; }
        /// <summary>
        /// 错误信息
        /// </summary>
        public string error { get; set; }
        /// <summary>
        /// 料塔层号
        /// </summary>
        public string LayerNo { get; set; }
        /// <summary>
        /// 料塔储位号
        /// </summary>
        public string PositionNo { get; set; }
        /// <summary>
        /// 状态码【0.正常;1.下达存入操作指令（该料位有料）记录或下达取出操作指令（该料位无料）记录 ;2.设备报警;3.错误指令（没有记录） ;4.该层电机正在操作;5.该服务号层错误（不在正常范围内） ;
        /// 6.该服务号料位号错误  ;7.该服务号操作类型错误 ;8.下达存入操作指令（有层在运行不能执行存操作） ;9.下达取出操作指令（非在取状态下执行取操作） ;10.下达设备物料清空操作指令（只能有一条记录） ;
        /// 11.下达询问层、料位数量指令（只能有一条记录） ;12.下达存入操作指令（有层在运行）;13.下达设备物料清空操作指令（有层在运行）;14.当前手动模式;15.设备ID错误或者检验码错误 ;】 
        /// </summary>
        public string Status { get; set; }
        /// <summary>
        /// 物料编码（查询真实有无料时，此时Materiel字段标识有无料，0无料，1有料））
        /// </summary>
        public string Materiel { get; set; }
    }
    /// <summary>
    /// 设备结构信息
    /// </summary>
    public class MeterialLayers
    {
        /// <summary>
        /// 设备编码
        /// </summary>
        public string MeterialID { get; set; }
        /// <summary>
        /// 层号
        /// </summary>
        public string LayNo { get; set; }
        /// <summary>
        /// 仓储位
        /// </summary>
        public string PositoinNo { get; set; }

        /// <summary>
        /// 完整编码
        /// </summary>
        public string CompleteNo
        {
            get
            {
                return MeterialID + "-" + LayNo + "-" + PositoinNo;
            }
        }

    }
}