## Tips for integrating Cloudflare Access Zero Trust with Azure AD/Entra ID tenants

#### Granting Access using Azure AD/Entra ID groups
1. In Entra ID, open the Groups Management menu blade (https://entra.microsoft.com/#view/Microsoft_AAD_IAM/GroupsManagementMenuBlade/~/AllGroups).  
2. Find the desired group and copy the "Object Id" value.
3. In Cloudflare Access, edit the desired Application or Access Group.
4. For the Include Selector, choose "Azure Groups."  
5. For the value field, paste the Object Id from step 2.
