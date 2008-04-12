// AuthenticationServiceTest.cs created with MonoDevelop
// User: nicholas at 7:45 PM 4/11/2008

using System;
using NUnit.Framework;

using POSInterfaces;

namespace Services
{
    
    
    [TestFixture()]
    public class AuthenticationServiceTest
    {
        AuthenticationService auth;
        
        [SetUp]
        public void SetUp()
        {
            auth = new AuthenticationService();
        }
        [Test()]
        public void AuthenticationResultTrue()
        {
            AuthenticationRequest aq = new AuthenticationRequest();
            aq.UserName = "Default";
            aq.Password = "Password";
            aq.Domain = "localhost";
            
            AuthenticationResponse ar = auth.Authenticate(aq);
            Assert.IsTrue(ar.Result);
        }
    }
}
