## Note for converting an old CloudFlare Worker to Worker ES  
CloudFlare's baseline guidance can be found at (https://developers.cloudflare.com/workers/learning/migrate-to-module-workers/)  

### If you are using KV stores, simply prepend env. to the beginning of each request, since global bindings are no longer permitted.  
  Example:  
  ```await accesslogs.list({ prefix: "someevent" })```  
  Becomes  
  ```await env.accesskeys.list({ prefix: "someevent" })```  
