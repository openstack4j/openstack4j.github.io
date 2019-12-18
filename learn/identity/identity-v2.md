---
layout: content
menu: learn
title: Identity (Keystone) V2
description: Learn how to authenticate and use Keystone with OpenStack4j Java Library
nav: identity-v2
---

# Identity Service (Keystone) V2

<div class="alert alert-warning"><b>NOTE:</b> The examples in this guide assume <a href="/learn/getting-started/#authenticate" class="alert-link"><b>you have authenticated</b></a></div>

<div class="alert alert-warning"><b>NOTE: </b>   OpenStack4j 3.0.0 introduced some breaking changes.
<br/> The legacy Identity V2 API now uses the class <b>OSClientV2</b> in place of the class OSClient.<br>
</b></a></div>

The Identity (Keystone) V2 service provides the central directory of users, tenants, service endpoints and authorization. This API is responsible for authenticating and providing access to all the other OpenStack services. The API also enables administrators to configure centralized access policies, users and tenants.

The ```os``` used in the following examples refers to an instance of ```org.openstack4j.api.OSClient.OSClientV2```.

## Regions

OpenStack4j supports the ability to switch from one region to another within the same client.  If you have a regional deployment (example: West and East coast) and would like to target certain calls to specific region see the sample below:

{:.prettyprint .lang-java}
    // Switch to East Coast
    os.useRegion("EastRegion");
    List<? extends Server> eastServers = os.compute().servers().list();

    // Switch to West Coast
    os.useRegion("WestRegion");
    List<? extends Server> westServers = os.compute().servers().list();

    // Switch to Default - No region specified
    os.removeRegion();

## Tenants

In OpenStack user interfaces and documentation, a group of users is referred to as a ``project`` or `tenant`. Users must be associated with at least one tenant and can belong to many.
<br>

#### Creating Tenant

This example will create a new Tenant called ABC Corp. Once created the Tenant could then be assigned to users who have access to the resources within this tenant.

{:.prettyprint .lang-java}
	Tenant tenant = os.identity().tenants()
	                  .create(Builders.identityV2().tenant()
	                                .name("ABC Corp")
	                                .description("ABC Corporation Tenant")
	                                .build());

#### Querying for Tenants

The examples below are ways to find tenants.

**Find all Tenants**

{:.prettyprint .lang-java}
	List<? extends Tenant> tenants = os.identity().tenants().list();

**Find a specific Tenant**

{:.prettyprint .lang-java}
	// Find by ID
	Tenant tenant = os.identity().tenants().get("tenantId");

	// Find by Name
	tenant = os.identity().tenants().getByName("ABC Corp");


#### Updating a Tenant

This example will change the name of `ABC Corp` to `ABC Corporation` by looking up the tenant and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

{:.prettyprint .lang-java}
	Tenant tenant = os.identity().tenants().get("tenantId");
	if (tenant != null)
	  tenant = os.identity().tenants().update(tenant.builder().name("ABC Corporation").build());

#### Deleting a Tenant

This example will delete the `ABC Corporation` tenant we have been working with

{:.prettyprint .lang-java}
	os.identity().tenants().delete(tenant.getId());

## User and Role Management

Users and Roles are essentially associated to one another which is why we've covered this in one section.
<br>

#### Create a Tenant, User and Associate a Role

This example covers the most common use case in user management.  We will create a new Tenant, User and Associate the user to a role.  The tenant since it will be the first tenant assigned to the user will automatically become the users default tenant as per OpenStacks documentation.  OpenStack ships with two roles (member and admin).  In this example we will assign the member role which is a non-superuser role.

{:.prettyprint .lang-java}
	// Create the Tenant
	Tenant abcTenant = os.identity().tenants().create(Builders.identityV2().tenant().name("ABC Corporation").build());

	// Create a User associated to the ABC Corporation tenant
	User john = os.identity().users()
	              .create(Builders.identityV2().user()
	                                .name("johndoe")
	                                .password("password")
	                                .email("jdoe@abccorp.com")
	                                .tenant(abcTenant).build());

	// Associate the Member role to the John Doe
	Role memberRole = os.identity().roles().getByName("Member");
	os.identity().roles().addUserRole(abcTenant.getId(), john.getId(), memberRole.getId());

#### Querying for Users and Roles

Below are common examples to locate users and roles

{:.prettyprint .lang-java}
	// Find all Users
	List<? extends User> users = os.identity().users().list();

	// Find all Users for a Tenant
	List<? extends User> users = os.identity().users().listTenantUsers("tenantId");

	// List a Users Global Roles
	List<? extends Role> roles = os.identity().users().listRoles("userId");

	// List User Roles on a Tenant
	List<? extends Role> roles = os.identity().users().listRolesOnTenant("userId", "tenantId");

	// Find all Global Roles
	List<? extends Role> roles = os.identity().roles().list();

	// Get a User by ID
	User user = os.identity().users().get("userId");

	// Get a Role by ID
	Role role = os.identity().roles().get("roleId");

	// Get a Role by Name
	Role role = os.identity().roles().getByName("Member");


#### Update a User

The example below shows how to update a user

{:.prettyprint .lang-java}
	// Lookup an existing User
	User jdoe = User john = os.identity().users().get("userId");

	// Change the user John's email address
	jdoe = os.identity().users().update(jdoe.builder().email("newemail@abccorp.com").build());

**Toggle Enabled State**

{:.prettyprint .lang-java}
    // Disable John Doe from having access
	User jdoe = os.identity().users().enableUser("userId", false);

**Change a User Password**

{:.prettyprint .lang-java}
    // You must be authenticated with administrative rights to do this operation
	os.identity().users().changePassword("userId", "newPassword");

#### Delete a User or Role

The examples below show how to delete a user and a role

{:.prettyprint .lang-java}
	// Delete a Role
	os.identity().roles().delete("roleId");

	// Delete a User
	os.identity().users().delete("userId");

#### Conclusion

The above examples should help you understand the basic management of users and roles.  There are many other API operations that have not been listed in this guide.  To see all possibilities please review to the [JavaDoc](https://javadoc.io/doc/com.github.openstack4j.core/openstack4j-core).


## Services and Endpoints

Services and Endpoints are typically not used a lot unless you are in charge of the deployment.  Most plugins will automatically associate the service and endpoint information when installed.  We cover this in the API of OpenStack4j to be current with all major Identity operations.

Below are various examples of Service and Endpoint Management.

{:.prettyprint .lang-java}
	// Lets cut down our method chaining and pre-assign the ServiceManagerService API
	ServiceManagerService sm = os.identity().services();

	// List Services
	List<Service> services = sm.list();

	// List Endpoints
	List<? extends ServiceEndpoint> ep = sm.listEndpoints();

	// Create a Service and Endpoint
	Service service = sm.create("Name", "Type", "Description");
	ServiceEndpoint sep = sm.createEndpoint("region", service.getId(), "pubURL", "admURL", "intURL");

	// Get a Service by ID
	Service service = sm.get("serviceId");

	// Delete a Service
	sm.delete("serviceId");

	// Delete a Endpoint
	sm.deleteEndpoint("endpointId");


## Extensions

Extensions are add-ons to the core OpenStack deployment.  Sometimes it is important to determine if the deployment has an enhanced feature set available.  To get a list of installed extensions see the example below.

{:.prettyprint .lang-java}
	List<? extends Extension> extensions = os.identity().listExtensions();

## Token Endpoints

Token Endpoints are authorized accessible endpoints through the Identity service.  For example Compute (Nova) is an endpoint. The example below will return a list of all the authorized endpoints for the current authorized user.

{:.prettyprint .lang-java}
	List<? extends Endpoint> endpoints = os.identity().listTokenEndpoints();



