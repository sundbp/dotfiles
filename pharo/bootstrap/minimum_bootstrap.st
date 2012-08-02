" first we set the HTTP proxy "
NetworkSystemSettings
  useHTTPProxy: true;
  httpProxyServer: '127.0.0.1';
  httpProxyPort: 8123.

" next we get PatriksImageTools "
Metacello new
  configuration: 'PatriksImageTools';
  repository: 'github://sundbp/PatriksImageTools:master/packages';
  fetch.

Transcript open.
Transcript show: 'Setup HTTP proxy settings and loaded PatriksImageTools'; cr.
Transcript show: 'Now use the functionality of the image tools to build your image'; cr.
Transcript show: 'e.g. ConfigurationOfPatrik buildCommangerImage.'; cr.

Workspace open.

