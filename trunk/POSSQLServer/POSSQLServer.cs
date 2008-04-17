// POSSQLServer.cs created with MonoDevelop
// User: nicholas at 9:17 PM 4/16/2008

using System;
using Mono.Data.Sqlite;

namespace POSSQLServer
{
    
    
    public class POSSQLServer
    {
        Mono.Data.Sqlite.SqliteConnection sqlcon;
        public POSSQLServer()
        {
            sqlcon = new SqliteConnection();
           
        }
    }
}
