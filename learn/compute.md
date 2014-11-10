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
	List<? extends Image> images = os.compute().images().list();
		
	// Get an Image by ID
	Image img = os.compute().images().get("imageId");

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
	ServerCreate sc = Builders.server().name("Ubuntu 2").flavor("flavorId").image("imageId").build();

	// Boot the Server
	Server server = os.compute().servers().boot(sc);
	
**Personalities**

When you create a new VM/Server you can also override various files or lay down additional files that will be available when the VM is running.  For example you may want to override the `/etc/passwd` file with a default set of users and passwords. Below takes the example above but overrides the `/etc/motd`

{:.prettyprint .lang-java}
	// Create a Server Model Object
	ServerCreate sc = Builders.server()
	                          .name("Ubuntu 2")
	                          .flavor("flavorId")
	                          .image("imageId")
	                          .addPersonality("/etc/motd", "Welcome to the new VM! Restricted access only")
	                          .build();

	// Boot the Server
	Server server = os.compute().servers().boot(sc);
	
**Booting from an existing Volume vs Image**

When creating a server you typically boot from an Image to install the operating system.  There are other scenarios where you may have a volume that you would like attached to the new server and have the boot process use that volume.  See the example below:

{:.prettyprint .lang-java}
    BlockDeviceMappingBuilder blockDeviceMappingBuilder = Builders.blockDeviceMapping() 
                                                                  .uuid(volumeId)
                                                                  .deviceName("/dev/vda")
                                                                  .bootIndex(0);

    ServerCreate sc = Builders.server().name("Server").blockDevice(blockDeviceMappingBuilder.build());
    Server server = os.compute().servers().boot(sc);

**Note:** The device name unfortunatelly matters, and even worse - it depends on the hypervisor you use. In our experience - for KVM it is /dev/vda, for Xen it is /dev/xvda.

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

A snapshot is merely a pointer to a point in time.  This can be handy if you are doing a risky upgrade or migration and need a quick way to revert back.  You can take a snapshot and then proceed with your migrations.  If the migrations fail you can quickly revert back to created snapshot.

{:.prettyprint .lang-java}
	String imageId = os.compute().servers().createSnapshot(server.getId(), "Clean State Snapshot");

#### Floating IP Addresses

A floating Ip address is an address that is part of a pool.  Compute allows you to allocate or deallocate address from a pool against a server instance.  Below are the operational examples for floating ip addresses.

**Getting a List of available Pool Names**

{:.prettyprint .lang-java}
	List<String> pools = os.compute().floatingIps().getPoolNames();

**List floating IP addresses**

{:.prettyprint .lang-java}
	List<FloatingIP> ips = os.compute().floatingIps().list();
	
**Allocate a floating IP address from a pool**

{:.prettyprint .lang-java}
	FloatingIP ip = os.compute().floatingIps().allocateIP("pool");

**Deallocate a floating IP address**

{:.prettyprint .lang-java}
	os.compute().floatingIps().deallocateIP("floatingIp_id");
	
**Add a floating IP address to a server**

{:.prettyprint .lang-java}
	ActionResponse r = os.compute().floatingIps().addFloatingIP(server, "192.168.0.250", "50.50.2.3");

**Add a floating IP address to a server if Neutron is installed**

{:.prettyprint .lang-java}
    NetFloatingIP netFloatingIP = os.networking().floatingip().get(ipId);
    Server server = os.compute().servers().get(serverId);
    ActionResponse = osClient.compute().floatingIps().addFloatingIP(server, netFloatingIP.getFloatingIpAddress());	
	
**Remove a floating IP address from a server**

{:.prettyprint .lang-java}
	ActionResponse r = os.compute().floatingIps().removeFloatingIP(server, "50.50.2.3");

#### Metadata

**Creating Metadata during Create**	

{:.prettyprint .lang-java}
     // Can fluently add adhoc items
     ServerCreate sc = Builders.server()
                                  .image("0f4a93c6-a08c-4cf3-9fec-abe968f06892")
                                  .addMetadataItem("Group", "MyGroup")
                                  .addMetadataItem("Serial", "232432")
                                  .name("Test Server")
                                  .build();

     // Or set the actual Map 
     ServerCreate sc = Builders.server()
                                  .image("0f4a93c6-a08c-4cf3-9fec-abe968f06892")
                                  .addMetadata(someMap)
                                  .name("Test")
                                  .build();

**Management Examples**

{:.prettyprint .lang-java}
	// Grabbing just the Metadata
	Map<String, String> md = os.compute().servers().getMetadata(serverId);

	// Updating or Replace metadata items
	Map<String, String> md = os.compute().servers().updateMetadata(serverId, inboundMapofMD);

	// Remove a Metadata item
	os.compute().servers().deleteMetadataItem(serverId, metadataKey);

#### VNC and Console Output

OpenStack provides the ability to grab the tail of the console log based on the specified `number of lines`. See the example below on grabbing the last 50 lines of a running servers console.

**Console Output**

{:.prettyprint .lang-java}
	String consoleOutput = os.compute().servers().getConsoleOutput("serverId", 50);

You can also grab the VNC connection URL based on two VNC types that OpenStack offers, `novnc` and `xvpvnc`.  See the example below on obtaining the connection information for VNC.  The returned class contains the request `type` and the `url` used to connect.

**VNC Console**

{:.prettyprint .lang-java}
	VNCConsole console = os.compute().servers().getVNCConsole("serverId", Type.NOVNC);


	
#### Diagnostics

Diagnostics are usage information about the server. Usage includes CPU, Memory and IO. Information is dependent on the hypervisor used by the OpenStack installation. As of right now there is no concrete diagnostic specification which is why the information is variable and in map form (key and value)

{:.prettyprint .lang-java}
	Map<String, ? extends Number> diagnostics = os.compute().servers().diagnostics("serverId");
	
#### Querying for Servers

{:.prettyprint .lang-java}
	// List all Servers
	List<? extends Server> servers = os.compute().servers().list();

	// List all servers (light) ID, Name and Links populated
	List<? extends Server> servers = os.compute().servers().list(false);

	// Get a specific Server by ID
	Server server = os.compute().servers().get("serverId");

#### Delete a Server

{:.prettyprint .lang-java}
	os.compute().servers().delete("serverId");
	
## Keypairs

A keypair is a name and public key.  This is also known as an SSH key. Below are various examples in managing Keypair's.
<br><br>

#### Querying for Keypair's

Keypair's have no identifier like other OpenStack object.  Keypair's are queried by their name which is unique.  See the examples below on listing and getting keypair's by name.
<br>

{:.prettyprint .lang-java}
	// Get all Keypairs the current account making the request has access to
	List<Keypair> kps = os.compute().keypairs().list();
		
	// Get a Keypair by Name
	Keypair kp = os.compute().keypairs().get("admin-kp");

#### Creating and Deleting Keypair's

See the examples below on how to create, generate and delete keypair's
<br>

**Creating a Keypair with a pre-generated public key**

{:.prettyprint .lang-java}
	Keypair kp = os.compute().keypairs().create("my-keypair", publicKey);
	
**Creating a Keypair with a compute generated public key**

{:.prettyprint .lang-java}
	Keypair kp = os.compute().keypairs().create("my-keypair", null);
	
**Deleting a Keypair**

{:.prettyprint .lang-java}
	os.compute().keypairs().delete("my-keypair");

## Security Groups and Rules

Security groups are sets of IP filter rules that are applied to a servers networking.  They are tenant specific and tenant members can edit the rules for their group and add new rule sets.  Commonly new users fail to set the appropriate security group when launching a server instance.  As a result, the user is unable to contact the server on the network.  Below are examples on how to query, create and modify security groups and rules.

Security groups are an extension and typically installed by default.  If for some reason your OpenStack deployment does not have this extension then you may encounter an exception since the API endpoints will not exist.
<br>
<br>

#### Querying for Security Groups

Below are examples on querying for security groups as well as finding groups associated with a particular server instance.

**Listing all Security Groups that the tenant has access to**

{:.prettyprint .lang-java}
	List<? extends SecGroupExtension> sg = os.compute().securityGroups().list();
		
**Finding all Security Groups assigned to a server instance**

{:.prettyprint .lang-java}
	List<? extends SecGroupExtension> sg = os.compute().securityGroups().listServerGroups("serverId");

**Get a Security Group by ID**

{:.prettyprint .lang-java}
	SecGroupExtension group = os.compute().securityGroups().get("securityGroupId");
	

#### Creating, Updating and Deleting Security Groups

A security group is basic by nature so is very easy to create.  Rules are can then be created and then associated with a security group. Below are examples on how to create, update and delete a security group. 


**Creating a Security Group**

{:.prettyprint .lang-java}
	SecGroupExtension group = os.compute().securityGroups().create("Minimal Access Group", "Permits ICMP and SSH");

**Updating a Security Group**

{:.prettyprint .lang-java}
	SecGroupExtension group = os.compute().securityGroups().update("securityGroupId", "New Name", "New Description");
	
**Deleting a Security Group**

{:.prettyprint .lang-java}
	os.compute().securityGroups().delete("securityGroupId");

#### Security Group Rules

A security group rule is the actual filter which is associated to a security group.  A security group can have many rules.  A rule defines a protocol, port range, CIDR address and reference to the group. 

**Creating a Security Rule**

{:.prettyprint .lang-java}
	// Permit Port 80 against an existing Group for anyone
	Rule rule = client.compute().securityGroups()
	                  .createRule(Builders.secGroupRule()
				        .parentGroupId(group.getId())
					    .protocol(IPProtocol.TCP)
					    .cidr("0.0.0.0/0")
					    .range(80, 80).build()
				       ));

**Deleting a Security Rule**

{:.prettyprint .lang-java}
	os.compute().securityGroups().deleteRule("ruleId");
	


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
	List<? extends Extension> extensions = os.compute().listExtensions();

