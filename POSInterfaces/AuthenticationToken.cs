// AuthenticationToken.cs created with MonoDevelop
// User: nicholas at 10:47 PM 4/10/2008

using System;

namespace POSInterfaces
{
    
    
    public struct AuthenticationToken
    {
        public int TTL;
        public DateTime Created;
        public string Value;
        public string Domain;
    }
}
