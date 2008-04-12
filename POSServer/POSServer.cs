// POSServer.cs created with MonoDevelop
// User: nicholas at 6:56 PM 4/11/2008

using System;
using System.Runtime.Remoting;

namespace POSServer
{
    
    
    public class POSServer
    {
        static void Main(string[] args)
        {
            System.Runtime.Remoting.RemotingConfiguration.Configure("POSServer.exe.config", false);
            Console.ReadLine();
        }
    }
}
