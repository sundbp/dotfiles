" first we set the HTTP proxy "
NetworkSystemSettings
  useHTTPProxy: true;
  httpProxyServer: '127.0.0.1';
  httpProxyPort: 8123.

" next we Gofer in PatriksImageTools "
Gofer new
  url: 'http://ss3.gemstone.com/ss/ConfigurationOfPatrik';
  package: 'ConfigurationOfPatrik';
  load.

Transcript open.
Transcript show: 'Setup HTTP proxy settings and loaded PatriksImkageTools'; cr.
Transcript show: 'Now use the functionality of the image tools to build your image'; cr.
Transcript show: 'e.g. ConfigurationOfPatrik buildEmptyDevImage.'; cr.

Workspace open.

