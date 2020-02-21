---
layout: content
menu: learn
title: Compute / Servers
nav: compute/servers
---
# Servers

A server is a running VM instance.  The OpenStack4j supports all major server based operations and actions.  The examples below will cover all the major scenarios that are commonly utilized to manage running servers within the cloud.

### Boot a Server VM (Create)

Booting a new Server is simple with OpenStack4j.  The two requirements are specifying a [flavor](#flavors) and an [image](#images-via-nova).

```java
// Create a Server Model Object
ServerCreate sc = Builders.server().name("Ubuntu 2").flavor("flavorId").image("imageId").build();

// Boot the Server
Server server = os.compute().servers().boot(sc);
```
	
**Personalities**

When you create a new VM/Server you can also override various files or lay down additional files that will be available when the VM is running.  For example you may want to override the `/etc/passwd` file with a default set of users and passwords. Below takes the example above but overrides the `/etc/motd`

```java
// Create a Server Model Object
ServerCreate sc = Builders.server()
        .name("Ubuntu 2")
        .flavor("flavorId")
        .image("imageId")
        .addPersonality("/etc/motd", "Welcome to the new VM! Restricted access only")
        .build();

// Boot the Server
Server server = os.compute().servers().boot(sc);
```
	
**Booting from an existing Volume vs Image**

When creating a server you typically boot from an Image to install the operating system.  There are other scenarios where you may have a volume that you would like attached to the new server and have the boot process use that volume.  See the example below:

```java
BlockDeviceMappingBuilder blockDeviceMappingBuilder = Builders.blockDeviceMapping() 
        .uuid(volumeId)
        .deviceName("/dev/vda")
        .bootIndex(0);

ServerCreate sc = Builders.server().name("Server").blockDevice(blockDeviceMappingBuilder.build());
Server server = os.compute().servers().boot(sc);
```

**Note:** The device name unfortunatelly matters, and even worse - it depends on the hypervisor you use. In our experience - for KVM it is /dev/vda, for Xen it is /dev/xvda.

### Server Actions

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

```java
// Suspend a Server
os.compute().servers().action(server.getId(), Action.SUSPEND);

// Resume a Server
os.compute().servers().action(server.getId(), Action.RESUME);
```
	
**Extended Actions**

Reboot a Server
```java
os.compute().servers().reboot(server.getId(), RebootType.SOFT);
```

Resize a Server
```java
os.compute().servers().resize(server.getId(), newFlavor.getId());
```

Confirm a Resize
```java
os.compute().servers().confirmResize(server.getId());
```

Revert a Resize
```java
os.compute().servers().revertResize(server.getId());
```	

### Create a new Server Snapshot

A snapshot is merely a pointer to a point in time.  This can be handy if you are doing a risky upgrade or migration and need a quick way to revert back.  You can take a snapshot and then proceed with your migrations.  If the migrations fail you can quickly revert back to created snapshot.

```java
String imageId = os.compute().servers().createSnapshot(server.getId(), "Clean State Snapshot");
```

### Metadata

**Creating Metadata during Create**	

```java
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
```

**Management Examples**

```java
// Grabbing just the Metadata
Map<String, String> md = os.compute().servers().getMetadata(serverId);

// Updating or Replace metadata items
Map<String, String> md = os.compute().servers().updateMetadata(serverId, inboundMapofMD);

// Remove a Metadata item
os.compute().servers().deleteMetadataItem(serverId, metadataKey);
```

### VNC and Console Output

OpenStack provides the ability to grab the tail of the console log based on the specified `number of lines`. See the example below on grabbing the last 50 lines of a running servers console.

**Console Output**

```java
String consoleOutput = os.compute().servers().getConsoleOutput("serverId", 50);
```

You can also grab the VNC connection URL based on two VNC types that OpenStack offers, `novnc` and `xvpvnc`.  See the example below on obtaining the connection information for VNC.  The returned class contains the request `type` and the `url` used to connect.

**VNC Console**

```java
VNCConsole console = os.compute().servers().getVNCConsole("serverId", Type.NOVNC);
```
	
### Diagnostics

Diagnostics are usage information about the server. Usage includes CPU, Memory and IO. Information is dependent on the hypervisor used by the OpenStack installation. As of right now there is no concrete diagnostic specification which is why the information is variable and in map form (key and value)

```java
Map<String, ? extends Number> diagnostics = os.compute().servers().diagnostics("serverId");
```
	
### Querying for Servers

```java
// List all Servers
List<? extends Server> servers = os.compute().servers().list();

// List all servers (light) ID, Name and Links populated
List<? extends Server> servers = os.compute().servers().list(false);

// Get a specific Server by ID
Server server = os.compute().servers().get("serverId");
```

### Delete a Server

```java
os.compute().servers().delete("serverId");
```
