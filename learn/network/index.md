---
layout: content
menu: learn
title: Network (Neutron)
nav: network
---

# Network (Neutron)

Neutron is the Network service for OpenStack. Unlike Nova Networking, Neutron allows you to configure advanced virtual network topologies. An example of this is per-tenant private networks.  

Neutron is broken up into the following abstractions: Networks, Subnets and Routers.   Each has functionality that mimics the physical layers.

## Networks

A network represents a slice of the outside network.  Networks contain subnets, and routers to route traffic between different subnets and networks.
<br>
<br>

#### Create a Network

```java
Network network = os.networking().network()
        .create(Builders.network().name("ext_network").tenantId(tenant.getId()).build());
```

```java
Network network = os.networking().network()
        .create(Builders.network().name("ext_network").tenantId(tenant.getId()).build());
```

#### Querying for Networks

```java
// List the networks which the current tenant has access to
List<? extends Network> networks = os.networking().network().list();
    
// Get a network by ID
Network network = os.networking().network().get("networkId");
```

#### Delete a Network

```java
os.networking().network().delete("networkId");
```

## Subnets

A subnet is a subdivision of an IP Network. The examples below will cover basic subnet management and how we leverage them using OpenStack4j.
<br>
<br>

#### Create a Subnet

```java
Subnet subnet = os.networking().subnet().create(Builders.subnet()
        .name("MySubnet")
        .networkId("networkId")
        .tenantId("tenantId")
        .addPool("192.168.0.1", "192.168.0.254")
        .ipVersion(IPVersionType.V4)
        .cidr("192.168.0.0/24")
        .build());
```

#### Querying for Subnets

```java
// List all subnets which the current authorized tenant has access to
List<? extends Subnet> subnets = os.networking().subnet().list();

// Get a Subnet by ID
Subnet subnet = os.networking().subnet().get("subnetId");
```
	
#### Delete a Subnet

```java
os.networking().subnet().delete("subnetId");
```

## Ports

A port is exactly what you think it is.  It mimics a physical port which is tied to a `network` and can be allocated a fixed ip from a `subnet`.
<br>
<br>

#### Create a Port

In the example below we will create a new port and assign it a fixed IP Address from  the subnet we defined in the above examples.

```java
Port port = os.networking().port().create(Builders.port()
        .name("port-1")
        .networkId("networkId")
        .fixedIp("192.168.0.101", "subnetId")
        .build());
```

#### Updating the Port

```java
Port updatedPort = os.networking().port().update(port.builder().name("port-1-1").build());
```	

#### Querying for Ports

```java
// List all Ports which the current authorized tenant has access to
List<? extends Port> ports = os.networking().port().list();

// Get a Port by ID
Port port = os.networking().port().get("portId");
```
	
#### Delete a Port

```java
os.networking().port().delete("portId");
```
	
## Routers

For outside networks to access VMs, routers between subnets are needed.  Each router has one gateway that is connected to a network and many interfaces that are connected to various subnets.  Like a real world physical router, subnets can access machines on other subnets that are connected to the same router.  More information about routers can be found at [Neutron Concepts](http://docs.openstack.org/kilo/install-guide/install/apt/content/neutron-concepts.html)
<br>
<br>

#### Create a Router

```java
Router router = os.networking().router().create(Builders.router()
        .name("ext_net")
        .adminStateUp(true)
        .externalGateway("networkId")
        .route("192.168.0.0/24", "10.20.20.1")
        .build());
```

#### Update a Router

```java
router = os.networking().router().update(router.toBuilder().name("ext_net2").build());
```
	
#### Toggle Administrative State

```java
Router router = os.networking().router().toggleAdminStateUp("routerId", true);
```
	
#### Attaching / Detaching External Interfaces

```java
// Attach an External Interface
RouterInterface iface = os.networking().router()
        .attachInterface("routerId", AttachInterfaceType.SUBNET, "subnetId");

// Detach an External Interface
RouterInterface iface = os.networking().router()
        .detachInterface("routerId", "subnetId", null);
```

#### Delete a Router

```java
os.networking().router().delete("routerId");
```
	
#### Querying for Routers

```java
List<Router> = os.networking().router().list();

// Get a Router by ID
Router router = os.networking().router().get("routerId");
```
