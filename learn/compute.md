---
layout: content
menu: learn
title: Compute (Nova)
---

# Compute Service (Nova)

The Compute (Nova) service provides management to Servers (running virtual machines), VM Management, Flavors and diagnostics. This API streamlines day to day management tasks and makes managing your cloud straight forward with the fluent design.

The OpenStack4j Computer API can fully manage Servers, Flavors, Images, Quota-Sets, Diagnostics, Tenant Usage and more. As the API evolves additional providers and extensions will be covered and documented within the API.
<br>

## Flavors

A flavor in OpenStack are virtual hardware templates.  They define sizes for RAM, disk, number of CPU cores and more.  OpenStack ships with five flavors by default.  Below are some of the management capabilities with Flavors and OpenStack4j.


#### Creating a Flavor

In OpenStack4j flavors can be created with a builder or a service call specifying all the parameters.  Both do the same but the `builder` will give you more flexibility for params you do not wish to set.

**Creating a Flavor with the Builder**

{:.prettyprint .lang-java}
	Flavor flavor = Builders.flavor()
	                        .name("Large Resources Template")
	                        .ram(4096)
	                        .vcpus(6)
	                        .disk(120)
	                        .rxtxFavor(1.2f)
	                        .build();
	
	flavor = os.compute().flavors().create(flavor);

**Creating a Flavor via method parameters**

{:.prettyprint .lang-java}
	Flavor flavor = os.compute().flavors()
	                  .create("name", ram, vcpus, disk, ephemeral, swap, rxtxFactor, isPublic);
	

#### Querying for Flavors

Below are examples of how to query/find Flavors.

{:.prettyprint .lang-java}
	// Find all Flavors
	List<Flavor> flavors = os.compute().flavors().list();
		
	// Find a Flavor by ID
	Flavor flavor = os.compute().flavors().get("flavorId");
	
#### Deleting a Flavor

{:.prettyprint .lang-java}
	os.compute().flavors().delete("flavorId");

## Images (via Nova)

Compute supports basic Image operations which is mainly read only lookups and metadata support.  For full image management please refer to the [Image Service (Glance)](/learn/image).

#### Querying for Images

{:.prettyprint .lang-java}
	// List all Images (detailed @see #list(boolean detailed) for brief)
	List<ComputeImage> images = os.compute().images().list();
		
	// Get an Image by ID
	ComputeImage img = os.compute().images().get("imageId");

#### Deleting an Image

{:.prettyprint .lang-java}
	os.compute().images().delete("imageId");
	
#### MetaData Operations

Metadata is extended key/value based data that can be stored against images.  This can be useful for keeping extra information against a particular image.

{:.prettyprint .lang-java}
	// Get
	Map<String, String> md = os.compute().images().getMetaData("imageId");

	// Set
	Map<String, String> md = os.compute().images().setMetaData("imageId", newMetaMap);

	// Delete Keys
	os.compute().images().deleteMetaData("imageId", "key1", key2", ...//);

## Servers

A server is a running VM instance.  The OpenStack4j supports all major server based operations and actions.  The examples below will cover all the major scenarios that are commonly utilized to manage running servers within the cloud.

#### Boot a Server VM (Create)

Booting a new Server is simple with OpenStack4j.  The two requirements are specifying a [flavor](#flavors) and an [image](#images-via-nova).

{:.prettyprint .lang-java}
	// Create a Server Model Object
	Server server = Builders.server().name("Ubuntu 2").flavor("flavorId").image("imageId").build();

	// Boot the Server
	Server server = os.compute().servers().boot(server);

#### Server Actions

Server actions provide realtime management of a live server.

**Simple Actions**

Simple Server Actions are a single command giving the Server ID and desired action. 

<table class="table table-striped">
<tr><td><strong>PAUSE</strong></td><td>Pause the server</td></tr>
<tr><td><strong>UNPAUSE</strong></td><td>Un-Pause the server</td></tr>
<tr><td><strong>STOP</strong></td><td>Stop the server</td></tr>
<tr><td><strong>START</strong></td><td>Start the server</td></tr>
<tr><td><strong>LOCK</strong></td><td>Lock the server</td></tr>
<tr><td><strong>UNLOCK</strong></td><td>Unlock a locked server</td></tr>
<tr><td><strong>SUSPEND</strong></td><td>Suspend the server</td></tr>
<tr><td><strong>RESUME</strong></td><td>Resume a suspended server</td></tr>
<tr><td><strong>RESCUE</strong></td><td>Rescue the server</td></tr>
<tr><td><strong>UNRESCUE</strong></td><td>Un-Rescue the server</td></tr>
<tr><td><strong>SHELVE</strong></td><td>Shelve the server</td></tr>
<tr><td><strong>SHELVE_OFFLOAD</strong></td><td>Remove a shelved instance from the compute node</td></tr>
<tr><td><strong>UNSHELVE</strong></td><td>Un-Shelve the server</td></tr>
</table>

{:.prettyprint .lang-java}
	// Suspend a Server
	os.compute().servers().action(server.getId(), Action.SUSPEND);

	// Resume a Server
	os.compute().servers().action(server.getId(), Action.RESUME);
	
**Extended Actions**

Reboot a Server
{:.prettyprint .lang-java}
	os.compute().servers().reboot(server.getId(), RebootType.SOFT);

Resize a Server
{:.prettyprint .lang-java}
	os.compute().servers().resize(server.getId(), newFlavor.getId());

Confirm a Resize
{:.prettyprint .lang-java}
	os.compute().servers().confirmResize(server.getId());

Revert a Resize
{:.prettyprint .lang-java}
	os.compute().servers().revertResize(server.getId());
	

#### Create a new Server Snapshot

{:.prettyprint .lang-java}
	String imageId = os.compute().servers().createSnapshot(server.getId(), "Clean State Snapshot");
	
#### Diagnostics

Diagnostics are usage information about the server. Usage includes CPU, Memory and IO. Information is dependant on the hypervisor used by the OpenStack installation. As of right now there is no concrete diagnostic specification which is why the information is variable and in map form (key and value)

{:.prettyprint .lang-java}
	Map<String, ? extends Number> diagnostics = os.compute().servers().diagnostics("serverId");
	
#### Querying for Servers

{:.prettyprint .lang-java}
	// List all Servers
	List<Server> servers = os.compute().servers().list();

	// List all servers (light) ID, Name and Links populated
	List<Server> servers = os.compute().servers().list(false);

	// Get a specific Server by ID
	Server server = os.compute().servers().get("serverId");

#### Delete a Server

{:.prettyprint .lang-java}
	os.compute().servers().delete("serverId");
	
## Quota-Sets and Limits

{:.prettyprint .lang-java}
	// Quota-Set for a specific Tenant
	QuotaSet qs = os.compute().quotaSets().get(tenant.getId());

	// Quota-Set for a specific Tenant and User
	QuotaSet qs = os.compute().quotaSets().get(tenant.getId(), user.getId());

	// Limits (Rate Limit and Absolute)
	Limits limits = os.compute().quotaSets().limits();


## Simple Tenant Usage (os-simple-tenant-usage)

{:.prettyprint .lang-java}
	// Tenant Usage for All Tenants
	List<? extends SimpleTenantUsage> tenantUsages = os.compute().quotaSets().listTenantUsages();

	// Tenant Usage (detailed) for specific Tenant
	SimpleTenantUsage usage = os.compute().quotaSets().getTenantUsage("tenantId");
	
## Extensions

Extensions are add-ons to the core OpenStack deployment. Sometimes it is important to determine if the deployment has an enhanced feature set available. To get a list of installed extensions against Nova see the example below.

{:.prettyprint .lang-java}
	List<Extension> extensions = os.compute().listExtensions();

