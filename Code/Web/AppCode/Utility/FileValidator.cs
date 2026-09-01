using NPOI.SS.Formula.Functions;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.AppCode.Utility
{
    /// <summary>
    /// 文件验证器
    /// </summary>
    public static class FileValidator
    {
        // 获取webconfig下配置的文件类型

        // 允许的扩展名列表
        //public static readonly HashSet<string> AllowedExtensions = new HashSet<string>
        //{
        //    ".jpg", ".jpeg", ".png", ".gif",
        //    ".doc", ".docx", ".pdf",
        //    ".xls", ".xlsx", ".txt"
        //};

        public static readonly HashSet<string> AllowedExtensions = new HashSet<string>(ConfigurationManager.AppSettings["AllowedExtensions"].Split('|').Select(x => x.Trim().ToLower()).ToList());

        // 文件签名（Magic Numbers）验证规则
        private static readonly Dictionary<string, List<byte[]>> FileSignatures = new Dictionary<string, List<byte[]>>
        {
            { ".jpg", new List<byte[]> { new byte[] { 0xFF, 0xD8, 0xFF } } }, // JPEG
            { ".jpeg", new List<byte[]> { new byte[] { 0xFF, 0xD8, 0xFF } } },
            { ".png", new List<byte[]> { new byte[] { 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A } } },
            { ".gif", new List<byte[]> { new byte[] { 0x47, 0x49, 0x46, 0x38 } } }, // GIF8
            { ".doc", new List<byte[]> { new byte[] { 0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1 } } }, // DOC (OLE)
            { ".docx", new List<byte[]> { new byte[] { 0x50, 0x4B, 0x03, 0x04 } } }, // ZIP格式（DOCX是ZIP包）
            { ".pdf", new List<byte[]> { new byte[] { 0x25, 0x50, 0x44, 0x46 } } }, // %PDF
            { ".xls", new List<byte[]> { new byte[] { 0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1 } } }, // XLS (OLE)
            { ".xlsx", new List<byte[]> { new byte[] { 0x50, 0x4B, 0x03, 0x04 } } }, // ZIP格式（XLSX是ZIP包）
            { ".txt", new List<byte[]> { } } // 文本文件无固定签名
        };


        /// <summary>
        /// 验证文件名称是否存在非法字符
        /// </summary>
        /// <param name="fileName"></param>
        /// <returns></returns>
        public static bool ValidateFileName(string fileName)
        {

            char[] invalidChars = Path.GetInvalidFileNameChars();
            return fileName.IndexOfAny(invalidChars) >= 0;
        }


        /// <summary>
        /// 验证文件扩展名是否合法
        /// </summary>
        /// <param name="fileName"></param>
        /// <returns></returns>
        public static bool IsAllowed(string fileName)
        {
            var extension = Path.GetExtension(fileName).ToLower();
            if (!AllowedExtensions.Contains(extension))
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// 验证文件是否合法
        /// </summary>
        /// <param name="fileName">文件名（用于获取扩展名）</param>
        /// <param name="fileBytes">文件内容的字节数组</param>
        /// <param name="errorMessage">错误信息（验证失败时返回）</param>
        /// <returns>是否通过验证</returns>
        public static bool ValidateFile(string fileName, byte[] fileBytes, out string errorMessage)
        {
            errorMessage = string.Empty;

            var extension = Path.GetExtension(fileName).ToLower();

            // 验证扩展名
            if (!IsAllowed(fileName))
            {
                errorMessage = $"不支持的文件类型: {extension}";
                return false;
            }

            // 验证文件签名
            if (FileSignatures.TryGetValue(extension, out var signatures) && signatures.Count > 0)
            {
                // 获取该类型所需的最小签名长度
                int signatureLength = signatures.Max(s => s.Length);

                // 检查文件内容长度是否足够
                if (fileBytes.Length < signatureLength)
                {
                    errorMessage = "文件内容不完整或已损坏";
                    return false;
                }

                // 提取文件头字节
                var headerBytes = fileBytes.Take(signatureLength).ToArray();

                // 检查是否匹配任一签名
                if (!signatures.Any(signature => headerBytes.Take(signature.Length).SequenceEqual(signature)))
                {
                    errorMessage = "文件内容与扩展名不匹配";
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// 验证上传文件路径是否合法
        /// </summary>
        /// <param name="parameter"></param>
        /// <returns></returns>
        public static bool ValidatePathParameter(string parameter)
        {
            if (string.IsNullOrWhiteSpace(parameter))
                return false;

            // 禁止路径遍历字符
            if (parameter.Contains("..") ||
                parameter.Contains("~") ||
                parameter.IndexOfAny(Path.GetInvalidPathChars()) >= 0)
                return false;

            // 禁止绝对路径
            if (Path.IsPathRooted(parameter))
                return false;

            return true;
        }
    }

}