// IAuthenticationService.cs created with MonoDevelop
// User: nicholas at 10:47 PM 4/10/2008

using System;

namespace POSInterfaces
{
    
    
    public interface IAuthenticationService
    {
        AuthenticationResponse Authenticate(AuthenticationRequest req);
    }
}
