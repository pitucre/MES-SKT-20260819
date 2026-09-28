using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LeanMES.OrderControl.Job;
using LeanMES.OrderControl.Utility;
using Quartz;
using Quartz.Impl;

namespace LeanMES.OrderControl
{
    /// <summary>
    /// LeanMES 注塑机订单数量控制系统
    /// </summary>
    class Program
    {
        private static IScheduler _scheduler;

        static void Main(string[] args)
        {
            // 检查命令行参数
            if (args.Length > 0)
            {
                switch (args[0])
                {
                    case "--check-status":
                        RunStatusChecker().Wait();
                        return;
                    case "--test-machines":
                        RunMachineTester().Wait();
                        return;
                }
            }

            Console.Title = "LeanMES 注塑机订单数量控制系统";
            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.WriteLine("╔══════════════════════════════════════════════════════════════╗");
            Console.WriteLine("║           LeanMES 注塑机订单数量控制系统 v1.0               ║");
            Console.WriteLine("║                                                            ║");
            Console.WriteLine("║  支持设备: 恩格尔(Engel) / 海天(Haitian) / 德马格(Demag)    ║");
            Console.WriteLine("║  通信协议: EUROMAP 63 / OPC UA                             ║");
            Console.WriteLine("╚══════════════════════════════════════════════════════════════╝");
            Console.ResetColor();
            Console.WriteLine();

            try
            {
                // 初始化日志
                Logger.Write("系统启动中...");
                Logger.Write($"数据库连接: {ConfigurationManager.AppSettings["MESConnString"]?.Split(';')[0]}");
                Logger.Write($"检查间隔: {ConfigurationManager.AppSettings["OrderControlInterval"]} 秒");

                // 启动Quartz调度器
                StartScheduler().Wait();

                Logger.Write("系统启动成功，开始监控订单数量...");
                Console.WriteLine();
                Console.WriteLine("按 [ESC] 键退出系统...");
                Console.WriteLine();

                // 保持程序运行
                while (true)
                {
                    if (Console.KeyAvailable)
                    {
                        var key = Console.ReadKey(true);
                        if (key.Key == ConsoleKey.Escape)
                        {
                            break;
                        }
                    }
                    System.Threading.Thread.Sleep(100);
                }
            }
            catch (Exception ex)
            {
                Logger.Write($"系统启动失败: {ex.Message}", false);
                Console.WriteLine($"系统启动失败: {ex.Message}");
            }
            finally
            {
                // 停止调度器
                StopScheduler().Wait();
                Logger.Write("系统已停止");
                Console.WriteLine("系统已停止，按任意键退出...");
                Console.ReadKey();
            }
        }

        /// <summary>
        /// 启动Quartz调度器
        /// </summary>
        private static async Task StartScheduler()
        {
            // 创建调度器
            ISchedulerFactory schedFactory = new StdSchedulerFactory();
            _scheduler = await schedFactory.GetScheduler();
            await _scheduler.Start();

            // 获取检查间隔
            int intervalSeconds = 30;
            int.TryParse(ConfigurationManager.AppSettings["OrderControlInterval"], out intervalSeconds);

            // 创建订单控制Job
            IJobDetail orderControlJob = JobBuilder.Create<JobOrderControl>()
                .WithIdentity("OrderControlJob", "OrderGroup")
                .WithDescription("订单数量控制 - 达到目标数量自动停止注塑机")
                .Build();

            // 创建触发器
            ITrigger trigger = TriggerBuilder.Create()
                .WithIdentity("OrderControlTrigger", "OrderGroup")
                .WithDescription("订单控制触发器")
                .StartNow()
                .WithSimpleSchedule(x => x
                    .WithIntervalInSeconds(intervalSeconds)
                    .RepeatForever()
                    .WithMisfireHandlingInstructionNextWithRemainingCount())
                .Build();

            // 调度Job
            await _scheduler.ScheduleJob(orderControlJob, trigger);

            Logger.Write($"Quartz调度器已启动，订单控制Job每 {intervalSeconds} 秒执行一次");
        }

        /// <summary>
        /// 停止Quartz调度器
        /// </summary>
        private static async Task StopScheduler()
        {
            if (_scheduler != null && !_scheduler.IsShutdown)
            {
                await _scheduler.Shutdown(true);
                Logger.Write("Quartz调度器已停止");
            }
        }

        /// <summary>
        /// 运行状态检测
        /// </summary>
        private static async Task RunStatusChecker()
        {
            Console.WriteLine("========================================");
            Console.WriteLine("  Injection Machine Status Checker");
            Console.WriteLine("========================================");
            Console.WriteLine();

            var checker = new StatusChecker();
            await checker.CheckAndSave();

            Console.WriteLine();
            Console.WriteLine("Done!");
        }

        /// <summary>
        /// 运行注塑机测试
        /// </summary>
        private static async Task RunMachineTester()
        {
            var tester = new MachineTester();
            await tester.TestAll();

            Console.WriteLine();
            Console.WriteLine("Press any key to exit...");
            try { Console.ReadKey(); } catch { }
        }
    }
}
