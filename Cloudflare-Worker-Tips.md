## Notes for building and using CloudFlare Workers

### Converting an old CloudFlare Service Worker to Worker ES Module  
CloudFlare's baseline guidance can be found at (https://developers.cloudflare.com/workers/learning/migrate-to-module-workers/)  

#### If you are using variables, simply prepend env. to the beginning of each request, since global bindings are no longer permitted.  
  Example:  
  ```await accesslogs.list({ prefix: "someevent" })```  
  Becomes  
  ```await env.accesskeys.list({ prefix: "someevent" })```  

### Make use of environment variables (found under Settings) to store configuration variables  
  Under Settings -> Variables, add configuration details that can be utilized within your Workers.  
  #### Additionally, you can choose to encrypt sensitive values; use them just like a normal value within your code.  
  Example:  
  Create an encrypted variable called, "secret" and assign an API key and use it directly within your code  
  ```const secretKeyEnc = new TextEncoder().encode(env.secret)```
