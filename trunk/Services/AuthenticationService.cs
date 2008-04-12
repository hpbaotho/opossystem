// AuthenticationService.cs created with MonoDevelop
// User: nicholas at 6:39 PM 4/11/2008

using System;
using System.Runtime.Remoting;

using POSInterfaces;
using CookComputing.XmlRpc;

namespace Services
{
    public class AuthenticationService : MarshalByRefObject, IAuthenticationService
    {
        
        public AuthenticationService()
        {
        }
        
        [XmlRpcMethod]
        public AuthenticationResponse Authenticate (AuthenticationRequest req)
        {
            AuthenticationToken at =  new AuthenticationToken();
            at.Created = DateTime.Now;
            at.TTL = 3600;
            at.Value = "AUTHENTICATIONTOKEN";
            at.Domain = "localhost";
            
            AuthenticationResponse ar = new AuthenticationResponse();
            ar.Result = true;
            ar.Token = at;
            
            return ar;
        }
    }
}
