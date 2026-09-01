using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace LeanMES.FileMonitor
{
    internal class Log
    {
        private static readonly object signal = new object();
        internal static void info(String message)
        {

            DateTime now = DateTime.Now;
            String prefix = "["+now.Year + "-" + now.Month + "-" + now.Day + " " + now.Hour + ":" + now.Minute + ":" + now.Second + "]   ";
            message = prefix + message;
            String preDir = "log\\" + now.Year +"-"+ now.Month + "\\";
            if (!Directory.Exists(preDir))
            {
                try
                {
                    Directory.CreateDirectory(preDir);
                }
                catch (Exception err)
                {
                    Console.WriteLine(err.Message);
                }
            }
            lock (signal)
            {
                using (
                    
                    StreamWriter sw = new StreamWriter(preDir + now.Year + "-" + now.Month + "-" + now.Day + ".log", true))
                {
                    sw.WriteLine(message);
                    sw.Close();
                }
            }
            Console.WriteLine(message);

        }

    }
}
