// IAuthenticationService.cs created with MonoDevelop
// User: nicholas at 10:47 PM 4/10/2008

using System;
using CookComputing.XmlRpc;

namespace POSInterfaces
{
    
    
    public interface IAuthenticationService 
    {
        [XmlRpcMethod]
        AuthenticationResponse Authenticate(AuthenticationRequest req);
    }
}
