using System;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using System.Data;
using System.IO;
using SDYC.Data.Table;
namespace SDYC.Data
{
    internal sealed class NoSqlFactory : DbProviderFactory
    {
        // Fields
        public static readonly NoSqlFactory Instance = new NoSqlFactory();

        // Methods
        private NoSqlFactory()
        {
        }
        public override DbConnection CreateConnection()
        {
            return new NoSqlConnection(base.ToString());
        }
    }
   

}
