using Quartz;
using Quartz.Impl;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace WebAPI.Job
{
    public class JobScheduler
    {

        /// <summary>
        /// 定时同步频率（分钟）
        /// </summary>
        private static int SyncFrequency = Convert.ToInt32(ConfigurationManager.AppSettings["SyncFrequency"]);

        /// <summary>
        /// 开始执行Job
        /// </summary>
        /// <returns></returns>
        public static async Task StartJob()
        {
            //集团总部才需要执行Job将数据分发到子工厂，子工厂不执行Job
            string GroupHeadquartersFlag = ConfigurationManager.AppSettings["GroupHeadquartersFlag"] ?? string.Empty;   //是否集团总部（1：总部 0：子工厂）
            if (GroupHeadquartersFlag != "1")
            {
                return;
            }

            DateTimeOffset runTime = DateBuilder.EvenMinuteDate(DateTimeOffset.UtcNow);

            //调度器工厂
            ISchedulerFactory _schedulerFactory = new StdSchedulerFactory();
            //调度器
            IScheduler scheduler = await _schedulerFactory.GetScheduler();

            int minute = SyncFrequency <= 0 ? 10 : SyncFrequency;

            #region 同步ERP数据

            //创建一个任务
            IJobDetail jobSyncERP = JobBuilder.Create<SyncJob>().WithIdentity("jobSyncERP", "group").Build();
            //创建一个触发器
            ITrigger trgSyncERP = TriggerBuilder.Create()
                .WithIdentity("trgSyncERP", "group")
                //.WithCronSchedule(cron)   //CRON表达式方式
                //.StartAt(runTime)
                .StartNow()
                .WithSimpleSchedule(x => x.WithIntervalInMinutes(minute).RepeatForever())   //简单方式
                .Build();

            await scheduler.ScheduleJob(jobSyncERP, trgSyncERP);

            #endregion

            //启动
            await scheduler.Start();
        }
    }
}