# Stories #
| Name | Description | Owner | Status | Dependancy |
|:-----|:------------|:------|:-------|:-----------|
| SASL Library| We need to create our own SASL library for use in authentication. It should implement at a minimum DIGEST-MD5 | jspenderg | In-Progress | N/A        |
| Basic xmlrcp remoting server | This should be a basic husk that we can fill with services for the remote clients to use | nicholasrperez | Complete | N/A        |
| AuthenticationService | Basic authentication service that authenticates the client against the server and returns an authentication token that should be used for subsequent api calls | nicholasrperez | In-Progress | SASL Library |
| nAnt Build Scripts | We should be able to compile the application without the aid of monodevelop. To do this, we need nAnt build scripts. We will do them by hand at first, and then look at writing a translater for monodevelop project files (which are XML) to nAnt build files | nicholasrperez | Complete | N/A        |
| CruiseControl.NET Setup | Continuous integration server setup, building the project with nAnt | nicholasrperez | Complete | nAnt Build Scripts |
| Hosting Server | We need to setup and configure a server somewhere offsite to act as our continuous integration server. | nicholasrperez | Complete | N\A        |
| CruiseControl.NET Dashboard | See if we can coax the ccnet dashboard stuff to run under mono's xsp web server | nicholasrperez | In-Progress | CruiseControl.NET Setup |