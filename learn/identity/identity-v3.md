---
layout: content
menu: learn
title: Identity (Keystone) V3
description: Learn how to authenticate and use Keystone with OpenStack4j 3.x Java Library
nav: identity-v3
---

# Identity Service (Keystone) V3

<div class="alert alert-warning"><b>NOTE:</b> The examples in this guide assume <a href="/learn/getting-started/#authenticate" class="alert-link"><b>you have authenticated</b></a></div>

The Identity (Keystone) V3 service provides the central directory of users, groups, region, service, endpoints, role management and authorization. This API is responsible for authenticating and providing access to all the other OpenStack services. The API also enables administrators to configured centralized access policies, users, domains and projects.

**NOTE**: The ```os``` used here is an instance of ```org.openstack4j.api.OSClient.OSClientV3```.

## Regions

OpenStack4j supports the ability to switch from one region to another within the same client.  If you have a regional deployment (example: West and East coast) and would like to target certain calls to specific region see the sample below:

###  Switch to another region

{:.prettyprint .lang-java}

    // Switch to East Coast
    os.useRegion("EastRegion");
    List<? extends Server> eastServers = os.compute().servers().list();

    // Switch to West Coast
    os.useRegion("WestRegion");
    List<? extends Server> westServers = os.compute().servers().list();

    // Switch to Default - No region specified
    os.removeRegion();

The examples below will show basic Region operations

#### Creating a Region
{:.prettyprint .lang-java}

	Region region = os.identity().regions()
	                                .create(Builders.regions()
	                                .id("EastRegion")
	                                .description("Region for east coast")
	                                .build());
															
#### Querying for Regions

**Find all Regions**
{:.prettyprint .lang-java}
	List<? extends Region> regionList = os.identity().regions().list();
	
**Find a specific Region**
{:.prettyprint .lang-java}
	//Find by ID
	Region region = os.identity().regions().get("EastRegion");
	
#### Updating a region

This example will change the description of `EastRegion` from `Region for east coast` to `East coast region` by looking up the region and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

{:.prettyprint .lang-java}
	Region region = os.identity().regions().get("EastRegion");
	if (region != null)
	  region = os.identity().regions().update(region.toBuilder().description("East coast region").build());

#### Deleting a Region

This example will delete the `EastRegion` we have been working with

{:.prettyprint .lang-java}
	os.identity().regions().delete(region.getId());


    
## Domains

The examples below will show basic Domain operations

#### Creating a Domain
{:.prettyprint .lang-java}
	Domain domain = os.identity().domains().create(Builders.domain()
                .name("domainName")
                .description("This is a new domain.")
                .enabled(true)
                .build());
															
#### Querying for Domains

**Find all Domains**
{:.prettyprint .lang-java}
	List<? extends Domain> domainList = os.identity().domains().list();
	
**Find a specific Domain**
{:.prettyprint .lang-java}
	//Find by ID
	Domain domain = os.identity().domains().get("domainId");
	
#### Updating a Domain

This example will change the enabled-status of the domain from `true` to `false` by looking up the domain and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

{:.prettyprint .lang-java}
	Domain domain = os.identity().domains().get("domainId");
	if (domain != null)
	  domain = os.identity().domains().update(domain.toBuilder().enabled(false).build());

#### Deleting a Domain

This example will delete the Domain we have been working with

{:.prettyprint .lang-java}
	os.identity().domains().delete(domain.getId());
	

## Projects

The examples below will show basic Project operations

#### Creating a Project
{:.prettyprint .lang-java}
	Project project = os.identity().projects().create(Builders.project()
                .name("projectName")
                .description("This is a new project.")
                .enabled(true)
                .build());
															
#### Querying for Projects

**Find all Projects**
{:.prettyprint .lang-java}
	List<? extends Project> projectList = os.identity().projects().list();
	
**Find a specific Project**
{:.prettyprint .lang-java}
	//Find by ID
	Project project = os.identity().projects().get("projectId");
	
	//Find by Name and Domain
	Project project = os.identity().projects().getByName("projectName","projectDomainId");
	
	//Find by Name accross all Domains
	List<? extends Project> projectList = os.identity().projects().getByName("projectName");
	
#### Updating a Project

This example will change the enabled-status of the project from `true` to `false` by looking up the domain and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

{:.prettyprint .lang-java}
	Project project = os.identity().projects().get("projectId");
	if (project != null)
	  project = os.identity().projects().update(project.toBuilder().enabled(false).build());

#### Deleting a Project

This example will delete the Project we have been working with

{:.prettyprint .lang-java}
	os.identity().projects().delete(project.getId());	
	    
    
## Users

The examples below will show basic User operations

#### Creating a User
{:.prettyprint .lang-java}
	User user = os.identity().users().create(Builders.user()
	                                            .name("Foobar")
	                                            .description("A new user.")
	                                            .password("secret")
	                                            .email("foobar@example.org")
	                                            .domainId("domainId")
	                                            .build());
															
#### Querying for Users

**Find all Users**
{:.prettyprint .lang-java}
	List<? extends User> userList = os.identity().users().list();
	
**Find a specific User**
{:.prettyprint .lang-java}
	//Find by ID
	User user = os.identity().users().get("userId");
	
	//Find by name and domain
	User user = os.identity().users().getByName("userName", "userDomainId");
	
	// Find user by name across all domains
	List<? extends Users> userList = os.identity().users().getByName("userName");
	
**List Roles for User**
{:.prettyprint .lang-java}
	//In a Domain
	List<? extends Role> domainUserRolesList = os.identity().users().listDomainUserRoles("userId", "domainId");
	
	//In a Project
	List<? extends Role> projectUserRolesList = os.identity().users().listProjectUserRoles("userId", "projectId");
	
**List Groups for User**
{:.prettyprint .lang-java}
	List<? extends Group> userGroupsList = os.identity().users().listUserGroups("userId");

	
#### Updating a User

This example will change the email of the user `Foobar` from `foobar@example.org` to `foobar@openstack.com` by looking up the user and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

{:.prettyprint .lang-java}
	User user = os.identity().users().get("userId");
	if (user != null)
	  user = os.identity().users().update(user.toBuilder().email("foobar@openstack.com").build());

#### Deleting a User

This example will delete the User `Foobar` we have been working with

{:.prettyprint .lang-java}
	os.identity().users().delete(user.getId());
	
	
## Groups

The examples below will show basic Group operations

#### Creating a Group
{:.prettyprint .lang-java}
	Group group = os.identity().groups().create(Builders.group()
	                                                .name("myGroup")
	                                                .description("A new group.")
	                                                .domainId("domainId")
	                                                .build());
															
#### Querying for Groups

**Find all Groups**
{:.prettyprint .lang-java}

	List<? extends Group> groupList = os.identity().groups().list();
	
**Find a specific Group**
{:.prettyprint .lang-java}

	//Find by ID
	Group group = os.identity().groups().get("groupId");
	
	//Find by Name
	List<? extends Group> groupList = os.identity().groups().getByName("groupName")

**List the Users in a Group**
{:.prettyprint .lang-java}

	List<? extends User> userGroupList = os.identity().groups().listGroupUsers("groupId");	

### Group management
{:.prettyprint .lang-java}

	// Add user to group
	os.identity().groups().addUserToGroup("groupId", "userId");
	
	// Check if a user is a member of a group
	os.identity().groups().checkGroupUser("groupId", "userId");
	
	// Remove user from group
	os.identity().groups().removeUserFromGroup("groupId", "userId");
	
#### Updating a Group

This example will change the description of the group from `A new group.` to `admin-group` by looking up the group and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

{:.prettyprint .lang-java}

	Group group = os.identity().groups().get("groupId");
	if (group != null)
	  group = os.identity().groups().update(group.toBuilder().description("admin-group").build());

#### Deleting a Group

This example will delete the Group `myGroup` we have been working with

{:.prettyprint .lang-java}

	os.identity().groups().delete(group.getId());	
	

## Role Management

The examples below will show basic Role and role management operations

#### Creating a Role
{:.prettyprint .lang-java}

	Role role = os.identity().roles().create(Builders.role()
	                                            .name("developer")
	                                            .build());
															
#### Querying for Roles

**Find all Roles**
{:.prettyprint .lang-java}
	List<? extends Role> roleList = os.identity().roles().list();
	
**Find a specific Role**
{:.prettyprint .lang-java}

	//Find by ID
	Role role = os.identity().roles().get("roleId");
	
	//Find by Name
	List<? extends Role> roleList = os.identity().roles().getByName("roleName")

### Role assignments

This example will show how to grant and revoke roles to/from a user and group in both project and domain contexts.

**To a User**
{:.prettyprint .lang-java}

	//Grant a role to a user in a project
	ActionResponse grantProjectRole = os.identity().roles().grantProjectUserRole("projectId", "userId", "roleId");
	
	//Check if a user has a specific role in a project
	ActionResponse checkProjectRole = os.identity().roles().checkProjectUserRole("projectId", "userId", "roleId");
	
	//Revoke a role from a user in a project
	ActionResponse revokeProjectRole = os.identity().roles().revokeProjectUserRole("projectId", "userId", "roleId");
	
	//Grant a role to a user in a domain
	ActionResponse grantDomainRole = os.identity().roles().grantDomainUserRole("domainId", "userId", "roleId");
	
	//Check if a user has a specific role in a domain
	ActionResponse checkDomainRole = os.identity().roles().checkDomainUserRole("domainId", "userId", "roleId");
	
	//Revoke a role from a user in a domain
	ActionResponse revokeDomainRole = os.identity().roles().revokeDomainUserRole("domainId", "userId", "roleId");

**To a Group**
{:.prettyprint .lang-java}

	//Grant a role to a group in a project
	ActionResponse grantProjectRole = os.identity().roles().grantProjectGroupRole("projectId", "groupId", "roleId");
	
	//Check if a group has a specific role in a project
	ActionResponse checkProjectRole = os.identity().roles().checkProjectGroupRole("projectId", "groupId", "roleId");
	
	//Revoke a role from a group in a project
	ActionResponse revokeProjectRole = os.identity().roles().revokeProjectGroupRole("projectId", "groupId", "roleId");
	
	//Grant a role to a group in a domain
	ActionResponse grantDomainRole = os.identity().roles().grantDomainGroupRole("domainId", "groupId", "roleId");
	
	//Check if a group has a specific role in a domain
	ActionResponse checkDomainRole = os.identity().roles().checkDomainGroupRole("domainId", "groupId", "roleId");
	
	//Revoke a role from a group in a domain
	ActionResponse revokeDomainRole = os.identity().roles().revokeDomainGroupRole("domainId", "groupId", "roleId");
	
#### Updating a Role

This example will change the name of the role from `developer` to `admin-role` by looking up the role and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

{:.prettyprint .lang-java}

	Role role = os.identity().roles().get("roleId");
	if (role != null)
	  role = os.identity().roles().update(role.toBuilder().name("admin-role").build());

#### Deleting a Role

This example will delete the Role we have been working with

{:.prettyprint .lang-java}

	os.identity().roles().delete(role.getId());	
	

## Policies

The examples below will show basic Policy operations

#### Creating a Policy
{:.prettyprint .lang-java}
	Policy policy = os.identity().policies().create(Builders.policy()
	                                                    .blob("{'foobar' : 'role:admin-user'}")
	                                                    .type("application/json")
	                                                    .projectId("projectId")
	                                                    .userId("userId")
	                                                    .build());
															
#### Querying for Policies

**Find all Policies**
{:.prettyprint .lang-java}
	List<? extends Policy> policyList = os.identity().policies().list();
	
**Find a specific Policy**
{:.prettyprint .lang-java}
	//Find by ID
	Policy policy_byId = os.identity().policies().get("policyId");
	
#### Updating a Policy

This example will change the blob of the policy from `{'foobar': 'role:admin-user'}` to `{'foobar': 'role:demo-user'}` by looking up the policy and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

{:.prettyprint .lang-java}
	Policy policy = os.identity().policies().get("policyId");
	if (policy != null)
	  policy = os.identity().policies().update(policy.toBuilder().blob("{'foobar': 'role:demo-user'}").build());

#### Deleting a Policy

This example will delete the Policy we have been working with

{:.prettyprint .lang-java}
	os.identity().policies().delete(policy.getId());	


## Services and Endpoints

The examples below will show basic Services & Endpoints operations

#### Creating a Service 
{:.prettyprint .lang-java}
	Service service = os.identity().serviceEndpoints().create(Builders.service()
	                                                            .type("serviceType")
	                                                            .name("serviceName")
	                                                            .description("A new service.")
	                                                            .enabled(true)
	                                                            .build());
															
#### Querying for Services

**Find all Services**
{:.prettyprint .lang-java}
	List<? extends Service> serviceList = os.identity().serviceEndpoints().list();
	
**Find a specific Service**
{:.prettyprint .lang-java}
	//Find by ID
	Service service = os.identity().serviceEndpoints().get("serviceId");	

#### Updating a Service
This example will change the description of the service from `"A new service."` to `"Identity V3 Service"` by looking up the service and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`.

{:.prettyprint .lang-java}
	Service service = os.identity().services().get("serviceId");
	if (service != null)
	  service = os.identity().services().update(service.toBuilder().description("Identity V3 Service").build());
	
#### Deleting a Service
This example will delete the Service we have been working with

{:.prettyprint .lang-java}
	os.identity().services().delete(service.getId());

#### Creating a Endpoint for a Service
This example will create a Endpoint for a Service specified by its identifier.

{:.prettyprint .lang-java}	
	Endpoint endpoint = os.identity().serviceEndpoints().createEndpoint(Builder().endpoint()
	                                                                        .name("endpointName")
	                                                                        .url(new URL( "http", "devstack.openstack.stack", 5000, "/v3"))
	                                                                        .iFace(Facing.ADMIN).regionId("regionId")
	                                                                        .serviceId("serviceId")
	                                                                        .enabled(true)
	                                                                        .build());

#### Querying for Endpoints
**Find all available Endpoints**
{:.prettyprint .lang-java}
	List<? extends Endpoint> endpointList = os.identity().serviceEndpoints().listEndpoints()

**Find a specific Endpoint**
{:.prettyprint .lang-java}
	Endpoint endpoint = os.identity().serviceEndpoints().getEndpoint("endpointId")

#### Updating a Endpoint
This example will change the url of the endpoint from `http://devstack.openstack.stack:5000/v3` to `http://openstack.stack:5000/v3` by looking up the endpoint and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

{:.prettyprint .lang-java}
	Endpoint endpoint = os.identity().services().getEndpoint("endpointId");
	if (endpoint != null)
	  endpoint = os.identity().services().updateEndpoint(endpoint.toBuilder().url(new URL( "http", "openstack.stack", 5000, "/v3")).build()); 

#### Deleting a Endpoint
{:.prettyprint .lang-java}
	os.identity().serviceEndpoints().deleteEndpoint("endpointId");


## Credentials

The examples below will show basic Credential operations

#### Creating a Credential
{:.prettyprint .lang-java}
	Credential credential = os.identity().credentials().create(Builders.credential()
	                                            .blob("{\"access\":\"181920\",\"secret\":\"secretKey\"}")
	                                            .type("ec2")
	                                            .projectId("projectId")
	                                            .userId("userId")
	                                            .build());

#### Querying for Credentials

**Find all Credentials**
{:.prettyprint .lang-java}
	List<? extends Credential> credentialList = os.identity().credentials().list();

**Find a specific Credential**
{:.prettyprint .lang-java}
	//Find by ID
	Credential credential = os.identity().credentials().get("credentialId");

#### Updating a Credential

This example will change the BLOB of the Credential from `{\"access\":\"181920\",\"secret\":\"secretKey\"}` to `{\"access\":\"181920\",\"secret\":\"updatedSecretKey\"}` by looking up the credential and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

{:.prettyprint .lang-java}
	Credential credential = os.identity().credentials().get("credential id");
	if (credential != null)
	    credential = os.identity().credentials().update(credential.toBuilder()
	                                .blob("{\"access\":\"181920\",\"secret\":\"updatedSecretKey\"}")
	                                .build());

#### Deleting a Credential

This example will delete the Credential we have been working with

{:.prettyprint .lang-java}
	os.identity().credentials().delete("credentialId");
	


