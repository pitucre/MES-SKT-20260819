using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;

namespace SKT.LeanMES.Web.Utility
{
    /// <summary>
    /// Mask相关通用操作
    /// </summary>
    public class MaskHelper
    {
        /// <summary>
        /// 掩码转换为规则表达式
        /// </summary>
        /// <param name="strMask"></param>
        /// <returns></returns>
        public static string MaskToRegularExpression(string strMask)
        {  
            string strRegular="^";
            string strSingle="";
            //循环字符串，把每个字符翻译成规则表达式
            for (int i = 0; i < strMask.Trim().Length; i++)
            {
                strSingle=strMask[i].ToString();
                switch (strSingle)
                {
                    case "@":
                        strRegular += "[a-zA-Z]";
                        break;
                    case "#":
                        strRegular += "[0-9]";
                        break;
                    case "^":
                        strRegular += "[0-9A-F]";
                        break;
                    case "?":
                        strRegular += "[a-zA-Z0-9]";
                        break;
                    case ".":
                        strRegular += "..";
                        break;
                    case "*":
                        strRegular += "*";
                        break;
                    case "\\":
                        strRegular += "\\";
                        break;
                    default:
                        strRegular += strSingle;
                        break;
                }                    
            }
            strRegular += "$";
            return strRegular;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="paramString"></param>
        /// <returns></returns>
        public static string BuildRegularExpression(String paramString)
        {
            if (paramString == null)
                return null;
            StringBuilder localStringBuffer = new StringBuilder(paramString.Length);
            localStringBuffer.Append("^");
            for (int i = 0; i < paramString.Length; i++)
            {
                char c = paramString[i];
                switch (c)
                {
                    case '*':
                        localStringBuffer.Append(".*");
                        break;
                    case '@':
                        localStringBuffer.Append("[a-zA-Z]");
                        break;
                    case '?':
                        localStringBuffer.Append("[a-zA-Z0-9]");
                        break;
                    case '#':
                        localStringBuffer.Append("[0-9]");
                        break;
                    case '^':
                        localStringBuffer.Append("[0-9A-F]");
                        break;
                    case '.':
                        localStringBuffer.Append(".");
                        break;
                    case '\\':
                        localStringBuffer.Append(c);
                        i++;
                        if (i >= paramString.Length)
                            continue;
                        localStringBuffer.Append(paramString[i]);
                        break;
                    case '$':
                    case '(':
                    case ')':
                    case '+':
                    case '[':
                    case ']':
                    case '{':
                    case '|':
                    case '}':
                        localStringBuffer.Append('\\');
                        break;
                    default:
                        localStringBuffer.Append(c);
                        break;
                }
            }
            localStringBuffer.Append("$");
            return localStringBuffer.ToString();
        }
    }
}