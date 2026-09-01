using SKT.Common.DAL.Marshal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Kanban.Builtin
{
    public partial class KanbanList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxClient));
            if (!IsPostBack)
            {
                GetGlobalWelcomeWords();
                //GetCalcs();
            }

            if (Request.QueryString["Action"] == "setwlc")
            {
                SetGlobalWelcomeWords();
            }

        }


        /// <summary>
        /// 从数据字典获取看板全局欢迎词
        /// </summary>
        protected void GetGlobalWelcomeWords()
        {
            /* var cmdTxt = " SELECT TOP 1 [Description] FROM dbo.SYS_DictionaryData WHERE Name = 'KB_GLOBAL_WLSPEECH' ";
             DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, cmdTxt, null);
             if (dt.Rows.Count > 0)
             {
                 this.txtGlobalWelcText.Text = dt.Rows[0]["Description"].ToString();
             }*/
            //update by weixia  on 2018.5.5
            var cmdTxt = " SELECT  WelcomeMsg FROM  [dbo].[Kanban_Welcome]  WHERE  [KanbanTypeId] = -1 ";
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.ReportConnString, cmdTxt, null);
            if (dt.Rows.Count > 0)
            {
                this.txtGlobalWelcText.Text = dt.Rows[0]["WelcomeMsg"].ToString();
            }

        }

        /// <summary>
        /// 从数据字典获取看板全局欢迎词
        /// </summary>
        protected void GetCalcs()
        {
            var cmdTxt = " SELECT [Description] FROM dbo.SYS_DictionaryData WHERE Name IN('txtKBCalc1','txtKBCalc2','txtKBCalc3') order by Name asc";
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.ReportConnString, cmdTxt, null);
            if (dt.Rows.Count > 0)
            {
                this.txtKBCalc1.Text = dt.Rows[0]["Description"].ToString();
                this.txtKBCalc2.Text = dt.Rows[1]["Description"].ToString();
                this.txtKBCalc3.Text = dt.Rows[2]["Description"].ToString();
            }
        }

        private void SetGlobalWelcomeWords()
        {
            var wlWords = Request.QueryString["w"];
            wlWords = Server.UrlDecode(wlWords);//全局欢迎词
            var typeId = Request.QueryString["typeId"];
            var workLineId = Request.QueryString["lineworkId"];
            var welcomeMsg = Server.UrlDecode(Request.QueryString["welcomeMsg"]);
            var userName = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;


            /* var cmdTxt = @"IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.SYS_DictionaryData WHERE Name = 'KB_GLOBAL_WLSPEECH')
 BEGIN
     INSERT INTO dbo.SYS_DictionaryData(Name,DicProperty,Code,Value,Description) 
     VALUES('KB_GLOBAL_WLSPEECH','KB_GLOBAL_WLSPEECH','KB','KB_GLOBAL_WLSPEECH',@Description)
 END 
 ELSE
 BEGIN
     UPDATE dbo.SYS_DictionaryData SET [Description] = @Description WHERE Name = 'KB_GLOBAL_WLSPEECH' AND Code='KB'
 END";*/
            var cmdTxt = @"IF NOT EXISTS(SELECT 1 FROM  [dbo].[Kanban_Welcome] WHERE  KanbanTypeId = -1)
BEGIN 
    INSERT  INTO [Kanban_Welcome](KanbanTypeId, LineWorkId, WelcomeMsg, CreateBy)
	VALUES(-1,-1,@Description,@userName)
END 
ELSE 
BEGIN 
   UPDATE [Kanban_Welcome] SET WelcomeMsg = @Description WHERE KanbanTypeId = -1 
END 
IF NOT EXISTS(SELECT 1 FROM  [dbo].[Kanban_Welcome] WHERE  KanbanTypeId = @TypeId AND LineWorkId = @LineWorkId AND KanbanTypeId != -1)
BEGIN 
    INSERT  INTO [Kanban_Welcome](KanbanTypeId, LineWorkId, WelcomeMsg, CreateBy)
	VALUES(@TypeId,@LineWorkId,@msg,@userName)
END 
ELSE 
BEGIN 
   UPDATE [Kanban_Welcome] SET WelcomeMsg = @msg WHERE  KanbanTypeId = @TypeId AND LineWorkId = @LineWorkId
END";
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@Description",SqlDbType.NVarChar,500),
                new SqlParameter("@userName",SqlDbType.NVarChar,20),
                new SqlParameter("@TypeId",SqlDbType.NVarChar,50),
                new SqlParameter("@LineWorkId",SqlDbType.NVarChar,50),
                new SqlParameter("@msg",SqlDbType.NVarChar,50)
            };
            parms[0].Value = wlWords;
            parms[1].Value = userName;
            parms[2].Value = typeId;
            parms[3].Value = workLineId;
            parms[4].Value = welcomeMsg;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, cmdTxt, parms);

            Response.Write("设置看板欢迎词成功！");
            Response.End();
        }

        private void SetCalc()
        {
            var wlWords = Request.QueryString["w"];
            var name = Request.QueryString["name"];
            wlWords = Server.UrlDecode(wlWords);//汉字解码

            var cmdTxt = @"IF NOT EXISTS(SELECT TOP 1 1 FROM dbo.SYS_DictionaryData WHERE Name = @name)
BEGIN
	INSERT INTO dbo.SYS_DictionaryData(Name,DicProperty,Code,Value,Description) 
	VALUES(@name,@name,'KB',@name,@Description)
END 
ELSE
BEGIN
	UPDATE dbo.SYS_DictionaryData SET [Description] = @Description WHERE Name = @name AND Code='KB'
END";
            SqlParameter[] parms = new SqlParameter[] {
                new SqlParameter("@Description",SqlDbType.NVarChar,50),
                new SqlParameter("@name",SqlDbType.VarChar,50)
            };
            parms[0].Value = wlWords;
            parms[1].Value = name;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, cmdTxt, parms);

            Response.Write("设置看板计算公式说明成功！");
            Response.End();
        }
    }
}