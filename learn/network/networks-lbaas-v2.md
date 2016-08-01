---
layout: content
menu: learn
title: LBaaS
nav: network/lbaas-v2
---

# LBaaS V2 (Load Balancer as a Service)

Drive the actual load balancing of requests. Thus, an Openstack operator can choose which back-end technology to use. The long-term vision for the project, however, is to provide a single API that allows a user to seamlessly move between different load balancing technologies should the operator choose to do so.

LBaaS v2 was introduced in Kilo. LBaaS v1 was deprecated in Liberty.

Both implementations use agents. The agents handle the HAProxy configuration and manage the HAProxy daemon. LBaaS v2 adds the concept of listeners to the LBaaS v1 load balancers. LBaaS v2 allows you to configure multiple listener ports on a single load balancer IP address.

**LBaaS System Architecture**

<img src="/assets/img/learn/lbaasv2-diagram.png" height="400px">
<p/>

*Source: [http://docs.openstack.org/mitaka/networking-guide/adv-config-lbaas.html](http://docs.openstack.org/mitaka/networking-guide/adv-config-lbaas.html)

## Load Balancers

The load balancer occupies a neutron network port and has an IP address assigned from a subnet.


### Querying

**List all Load Balancers**

{:.prettyprint .lang-java}
	List<? extends LoadBalancerV2> loadbalancers = os.networking().lbaasV2().loadbalancer().list();

**Listing all Load Balancers with `filters`**

{:.prettyprint .lang-java}
	Map<String,String> filter = new HashMap<String,String>();
	filter.put("name", "lb1");

	List<? extends LoadBalancerV2> loadbalancers = os.networking().lbaasV2().loadbalancer().list(filter);

**Finding a Load Balancer by ID**

{:.prettyprint .lang-java}
	LoadBalancerV2 loadbalancer = os.networking().lbaasV2().loadbalancer().get(loadbalancerId);

### Statistics

**Load Balancer Statistics**

Provides statistics such as `BytesIn`, `BytesOut`, `ActiveConnections` and `TotalConnections` for a specified load balancer

{:.prettyprint .lang-java}
	LoadBalancerV2Stats stats = os.networking().lbaasV2().loadbalancer().stats(loadbalancerId));

### Load Balancer Status Tree

Provides a view of all the objects connected to the loadbalancer, such as `listeners`, `pools`,  `members`, and  `healthmonitor`
{:.prettyprint .lang-java}
	LoadBalancerV2StatusTree lbst = os.networking().lbaasV2().loadbalancer().statusTree(loadbalancerId);

### Creating / Updating / Deleting

**Creating a Load Balancer**

{:.prettyprint .lang-java}
	LoadBalancerV2 loadbalancer = os.networking().lbaasV2().loadbalancer()
                    .create(Builders.loadbalancerV2()
                       .name("loadbalancer1")
                       .description("my loadbalancer")
                       .tenantId(tenantId)
                       .subnetId(subnetId)
                       .address("10.0.0.4")
                       .build());

**Updating a Load Balancer**

{:.prettyprint .lang-java}
	LoadBalancerV2 updated = os.networking().lbaasV2().loadbalancer()
                    .update(loadbalancerId, Builders.loadBalancerV2Update()
                       .description("updated loadbalancer")
                       .name("loadbalancerUpdate")
                       .adminStateUp(true)
                       .build());

**Deleting a Load Balancer**

{:.prettyprint .lang-java}
	ActionResponse resp = os.networking().lbaasV2().loadbalancer().delete(loadbalancerId);

## Listeners

Load balancers can listen for requests on multiple ports. Each one of those ports is specified by a listener.

### Querying

**List all Listeners**

{:.prettyprint .lang-java}
	List<? extends ListenerV2> listeners = os.networking().lbaasV2().listener().list();

**Listing all Listeners with `filters`**

{:.prettyprint .lang-java}
	Map<String,String> filter = new HashMap<String,String>();
	filter.put("name", "listener1");
	List<? extends ListenerV2> listeners = os.networking().lbaasV2().listener().list(filter);


**Finding a Listeners by ID**

{:.prettyprint .lang-java}
	ListenerV2 listener = os.networking().lbaasV2().listener().get(listenerId);


### Creating / Updating / Deleting

**Creating a Listener**

{:.prettyprint .lang-java}
	ListenerV2 listener = os.networking().lbaasV2().listener()
                    .create(Builders.listenerV2()
                       .name("listener1")
                       .description("listener test")
                       .protocol(Protocol.HTTP)
                       .protocolPort(80)
                       .loadBalancerId(loadBalancerId)
                       .connectionLimit(99)
                       .adminStateUp(true)
                       .build());

**Updating a Listener**

{:.prettyprint .lang-java}
	ListenerV2 updated = os.networking().lbaasV2().listener()
                    .update(listenerId, Builders.listenerV2Update()
                       .description("updated listener")
                       .connectionLimit(100)
                       .adminStateUp(false)
                       .build());

 **Deleting a Listener**

{:.prettyprint .lang-java}
	ActionResponse resp = os.networking().lbaasV2().listener().delete(listenerId);

## Pools

A pool holds a list of members that serve content through the load balancer.

### Querying

**List all Pools**

{:.prettyprint .lang-java}
	List<? extends LbPoolV2> pools = os.networking().lbaasV2().lbPool().list();

**Listing all Pools with `filters`**

{:.prettyprint .lang-java}
	Map<String,String> filter = new HashMap<String,String>();
	filter.put("name", "pool1");
	List<? extends LbPoolV2> pools = os.networking().lbaasV2().lbPool().list(filter);


**Finding a Pool by ID**

{:.prettyprint .lang-java}
	LbPoolV2 lbPool = os.networking().lbaasV2().lbPool().get(poolId);

### Creating / Updating / Deleting

**Creating a Pool**

{:.prettyprint .lang-java}
	LbPoolV2 lbPool = os.networking().lbaasV2().lbPool()
                    .create(Builders.lbpoolV2()
                       .name("pool1")
                       .description("pool test")
                       .protocol(Protocol.HTTP)
                       .lbMethod(LbMethod.ROUND_ROBIN)
                       .listenerId(listenerId)
                       .build());

**Updating a Pool**

{:.prettyprint .lang-java}
	LbPoolV2 updated = os.networking().lbaasV2().lbPool()
                    .update(poolId, Builders.lbPoolV2Update()
                       .adminStateUp(true)
                       .lbMethod(LbMethod.LEAST_CONNECTIONS)
                       .description("updated pool")
                       .build());

 **Deleting a Pool**

{:.prettyprint .lang-java}
	ActionResponse resp = os.networking().lbaasV2().lbPool().delete(poolId);


## Members

Members are servers that serve traffic behind a load balancer. Each member is specified by the IP address and port that it uses to serve traffic.

The weight of a member determines the portion of requests or connections it services compared to the other members of the pool.
For example, if member A has a weight of 2 and member B has a weight of 1, then member A will service twice as many requests as
member B. If the weight attribute is not specified, then the member's weight is implicitly set to "1".

All member operations are tied to the pool that the member belongs to.

### Querying

**List all Members for a Pool**

{:.prettyprint .lang-java}
	List<? extends MemberV2> members = os.networking().lbaasV2().lbPool().listMembers(poolId);


**Listing all Members for a Pool with `filters`**

{:.prettyprint .lang-java}
	Map<String,String> filter = new HashMap<String,String>();
	filter.put("name", "member1");
	List<? extends MemberV2> members = os.networking().lbaasV2().lbPool().listMembers(poolId, filter);

**Finding a Member in a Pool by ID**

{:.prettyprint .lang-java}
	MemberV2 member = os.networking().lbaasV2().lbPool().getMember(poolId, memberId);


### Creating / Updating / Deleting

**Creating a Member in a Pool**

Below is an example of creating a new member and adding it to the specified pool via `poolId`

{:.prettyprint .lang-java}
	MemberV2 member = os.networking().lbaasV2().lbPool()
                    .createMember(poolId, Builders.memberV2()
                       .address("10.0.0.17")
                       .protocolPort(80)
                       .subnetId("388c5684-86b0-49ab-90ef-944b1f7328f8")
                       .weight(2)
                       .build());

**Updating a Member**

{:.prettyprint .lang-java}
	MemberV2 updated = os.networking().lbaasV2().lbPool()
                    .updateMember(poolId, memberId, Builders.memberV2Update()
                       .adminStateUp(true)
                       .weight(10)
                       .build());

**Deleting a Member**

{:.prettyprint .lang-java}
	ActionResponse resp = os.networking().lbaasV2().lbPool().deleteMember(poolId, memberId);

## Health Monitors

Members may go offline from time to time and health monitors divert traffic away from members that are not responding properly. Health monitors are associated with pools.

* **PING:** used to ping the members using ICMP.
* **TCP:** used to connect to the members using TCP.
* **HTTP:** used to send an HTTP request to the member.
* **HTTPS:** used to send a secure HTTP request to the member.

### Querying

**List all Health Monitors**

{:.prettyprint .lang-java}
	List<? extends HealthMonitorV2> healthmonitors = os.networking().lbaasV2().healthMonitor().list();

**Listing all Health Monitors with `filters`**

{:.prettyprint .lang-java}
	Map<String,String> filter = new HashMap<String,String>();
	filter.put("id", "350576d8-5015-4d4e-b73f-23df2397e4c4");
	List<? extends HealthMonitorV2> healthmonitors = os.networking().lbaasV2().healthMonitor().list(filter);

**Finding a Health Monitor by ID**

{:.prettyprint .lang-java}
	HealthMonitorV2 hm = os.networking().lbaasV2().healthMonitor().get(healthmoitorId);

### Creating Health Monitors
The examples below are from the LBaaS WIKI and have been applied to OpenStack4j format.  
<br>

{:.prettyprint .lang-java}
HealthMonitorV2 hm = os.networking().lbaasV2().healthMonitor()
                    .create(Builders.healthmonitorV2()
                       .delay(3)
                       .maxRetries(6)
                       .timeout(2)
                       .type(HealthMonitorType.HTTP)
                       .poolId(poolId)
                       .build());

#### **Creating a PING Monitor**

The monitor pings the member to ensure that the member is alive.

The PING monitor is the most basic type of health check. The following configurable properties can be specified:

* **delay:** This is the minimum time in seconds between regular pings of the member.
* **timeout:** Maximum number of seconds for a monitor to wait for a ping reply before it times out. The value must be less than the delay value.
* **max retries:** Number of permissible ping failures before changing the member's status to INACTIVE. Must be a number between 1 and 10.

{:.prettyprint .lang-java}
	HealthMonitorV2 hm = os.networking().lbaasV2().healthMonitor()
                    .create(Builders.healthmonitorV2()
                       .type(HealthMonitorType.PING)
                       .delay(20)
                       .timeout(10)
                       .maxRetries(3)
                       .build());


#### **Creating a TCP Monitor**

A TCP monitor tries to establish a TCP connection to the member to ensure that the member is healthy.

The following configurable properties can be specified for a TCP monitor:

* **delay:** This is the minimum time in seconds between regular connections of the member.
* **timeout:** Maximum number of seconds for a monitor to wait for a connection to be established before it times out. The value must be less than the delay value.
* **max retries:** Number of permissible connection failures before changing the member's status to INACTIVE. Must be a number between 1 and 10.

{:.prettyprint .lang-java}
	HealthMonitorV2 hm = os.networking().lbaasV2().healthMonitor()
                    .create(Builders.healthmonitorV2()
                       .type(HealthMonitorType.TCP)
                       .delay(20)
                       .timeout(10)
                       .maxRetries(3)
                       .build());


#### **Creating an HTTP or HTTPS Monitor**

The HTTP and HTTPS monitor is more intelligent than the TCP monitor. It is capable of processing an HTTP or HTTPS response to
determine the condition of a node. It supports the same basic properties as the TCP monitor and includes the additional
attribute of path that is used to evaluate the HTTP response to a monitor probe.

* **urlPath:** The HTTP path used in the HTTP request used by the monitor to test a member's health. This must be a string beginning with a / (forward slash). The monitor expects a response from the node with an HTTP status code of 200.

{:.prettyprint .lang-java}
	HealthMonitorV2 hm = os.networking().lbaasV2().healthMonitor()
                    .create(Builders.healthmonitorV2()
                       .type(HealthMonitorType.HTTP)
                       .delay(20)
                       .timeout(10)
                       .maxRetries(3)
                       .urlPath("/check")
                       .build());

### Updating

{:.prettyprint .lang-java}
	HealthMonitorV2 updated = os.networking().lbaasV2().healthMonitor()
                    .update(healthmonitorId, Builders.healthMonitorV2Update()
                       .timeout(99)
                       .delay(1)
                       .build());

### Deleting

{:.prettyprint .lang-java}
	ActionResponse resp = os.networking().loadbalancers().healthMonitor().delete(healthMonitorId);
