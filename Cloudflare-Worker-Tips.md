## Notes for building and using CloudFlare Workers

### Converting an old CloudFlare Service Worker to Worker ES Module  
CloudFlare's baseline guidance can be found at (https://developers.cloudflare.com/workers/learning/migrate-to-module-workers/)  

#### If you are using mKV stores, simply prepend env. to the beginning of each request, since global bindings are no longer permitted.  
  Example:  
  ```await accesslogs.list({ prefix: "someevent" })```  
  Becomes  
  ```await env.accesskeys.list({ prefix: "someevent" })```  

### Make use of environment variables (found under Settings) to store configuration variables  