---
layout: content
menu: learn
title: LBaaS
nav: network/lbaas-v1
---

# LBaaS (Load Balancer as a Service)

drive the actual load balancing of requests. Thus, an Openstack operator can choose which back-end technology to use. The long-term vision for the project, however, is to provide a single API that allows a user to seamlessly move between different load balancing technologies should the operator choose to do so.

**LBaaS System Architecture**

<img src="/assets/img/learn/lbaas.jpg" height="400px">
<p/>

*Source: [https://wiki.openstack.org/wiki/Neutron_LBaaS_Arch](https://wiki.openstack.org/wiki/Neutron_LBaaS_Arch)

## Pools

A pool is a container of a set of members to which the traffic is load-balanced. The pool construct is a way to share several configuration attributes between members that belong to the same pool. For example health monitors are configured on the pool, and all members of the same pool, will be monitored using these health monitors.

### Querying

**List all Pools for the current Tenant**

{:.prettyprint .lang-java}
	List<? extends LbPool> list = os().networking().loadbalancers().lbPool().list();

**Listing all Pools for the current Tenant with `filters`**

{:.prettyprint .lang-java}
    Map<String, String> filter = Maps.newHashMap();
    filter.put("name", "web_pool");

	List<? extends LbPool> pools = os.networking().loadbalancers().lbPool().list(filter);

**Finding a Pool by ID**

{:.prettyprint .lang-java}
	LbPool pool = os().networking().loadbalancers().lbPool().get(id);

### Creating / Updating / Deleting

**Creating a Pool**

{:.prettyprint .lang-java}
    LbPool pool = os.networking().loadbalancers().lbPool()
                    .create(Builders.lbPool()
                       .name("web_pool")
                       .protocol(Protocol.HTTP)
                       .lbMethod(LbMethod.ROUND_ROBIN)
                       .subnetId(subnetId)
                       .build());

**Updating a Pool**

{:.prettyprint .lang-java}
    LbPool updated = os.networking().loadbalancers().lbPool()
                       .update(poolId, Builders.lbPoolUpdate()
                           .name("new_web_pool_name")
                           .description("Pool for Webservers")
                           .lbMethod(LbMethod.LEAST_CONNECTIONS)
                           .build());

 **Deleting a Pool**

{:.prettyprint .lang-java}
	ActionResponse resp = os.networking().loadbalancers().lbPool().delete(poolId);

### Statistics

Provides statistics such as `BytesIn`, `BytesOut`, `ActiveConnections` and `TotalConnections` for a specified Pool

{:.prettyprint .lang-java}
	LbPoolStats stats = os.networking().loadbalancers().lbPool().stats(poolId);



## Members

The members of a pool are responsible for servicing the requests received through the vip's virtual IP. The load-balancing method
is used to distribute requests or connections between the pool members.

The weight of a member determines the portion of requests or connections it services compared to the other members of the pool.
For example, if member A has a weight of 2 and member B has a weight of 1, then member A will service twice as many requests as
member B. If the weight attribute is not specified, then the member's weight is implicitly set to "1".

### Querying

**List all Members for the current Tenant**

{:.prettyprint .lang-java}
	List<? extends Member> list = os().networking().loadbalancers().member().list();

**Listing all Members for the current Tenant with `filters`**

{:.prettyprint .lang-java}
    Map<String, String> filter = Maps.newHashMap();
    filter.put("status", "ACTIVE");

	List<? extends Member> members = os.networking().loadbalancers().member().list(filter);

**Finding a Member by ID**

{:.prettyprint .lang-java}
	Member member = os().networking().loadbalancers().member().get(id);

### Creating / Updating / Deleting

**Creating a Member**

Below is an example of creating a new member and adding it to the specified pool via `poolId`

{:.prettyprint .lang-java}
    Member member = os.networking().loadbalancers().member()
                      .create(Builders.member()
                         .address("192.168.0.22")
                         .poolId(poolId)
                         .protocolPort(80)
                         .weight(1)
                         .build());

**Updating a Member**

{:.prettyprint .lang-java}
    Member updated = os.networking().loadbalancers().member()
                       .update(memberId, Builders.memberUpdate()
                           .weight(2)
                           .adminStateUp(true)
                           .build());

**Deleting a Member**

{:.prettyprint .lang-java}
	ActionResponse resp = os.networking().loadbalancers().member().delete(memberId);



## VIP

A VIP is the primary load balancing configuration object that specifies the virtual IP address and port on which client traffic is
received, as well as other details such as the load balancing method to be use, protocol, etc. This entity is sometimes known in
LB products under the name of a "virtual server", a "vserver" or a "listener".

### Querying

**List all VIPs for the current Tenant**

{:.prettyprint .lang-java}
	List<? extends Vip> list = os().networking().loadbalancers().vip().list();

**Listing all VIPs for the current Tenant with `filters`**

{:.prettyprint .lang-java}
    Map<String, String> filter = Maps.newHashMap();
    filter.put("name", "some VIP");

	List<? extends Vip> vips = os.networking().loadbalancers().vip().list(filter);

**Finding a VIP by ID**

{:.prettyprint .lang-java}
	Vip vip = os().networking().loadbalancers().vip().get(id);

### Creating / Updating / Deleting

**Creating a VIP**

{:.prettyprint .lang-java}
    Vip vip = os.networking().loadbalancers().vip()
                .create(Builders.vip()
                   .name("web_vip")
                   .tenantId(tenantId)
                   .subnetId(subnetId)
                   .poolId(poolId)
                   .protocol(Protocol.HTTP)
                   .protocolPort(80)
                   .build());

**Updating a VIP**

{:.prettyprint .lang-java}
    Vip updated = os.networking().loadbalancers().vip()
                    .update(vipId, Builders.vipUpdate()
                        .sessionPersistence(Builders.sessionPersistence()
                                .cookieName("webapp-cookie")
                                .type("HTTP_COOKIE")
                                .build())
                        .connectionLimit(10)
                        .build());

**Deleting a VIP**

{:.prettyprint .lang-java}
	ActionResponse resp = os.networking().loadbalancers().vip().delete(vipId);


## Health Monitors

A health monitor is used to determine whether or not back-end members of the VIP's pool are usable for processing a request. A
pool can have several health monitors associated with it. There are different types of health monitors supported by the OpenStack
LBaaS service:

* **PING:** used to ping the members using ICMP.
* **TCP:** used to connect to the members using TCP.
* **HTTP:** used to send an HTTP request to the member.
* **HTTPS:** used to send a secure HTTP request to the member.

### Querying

**List all Health Monitors for the current Tenant**

{:.prettyprint .lang-java}
	List<? extends HealthMonitor> list = os().networking().loadbalancers().healthMonitor().list();

**Listing all Health Monitors for the current Tenant with `filters`**

{:.prettyprint .lang-java}
    Map<String, String> filter = Maps.newHashMap();
    filter.put("name", "some monitor");

	List<? extends HealthMonitor> hm = os.networking().loadbalancers().healthMonitor().list(filter);

**Finding a Health Monitor by ID**

{:.prettyprint .lang-java}
	HealthMonitor vip = os().networking().loadbalancers().healthMonitor().get(id);

### Creating Health Monitors

The examples below are from the LBaaS WIKI and have been applied to OpenStack4j format.  
<br>

#### **Creating a PING Monitor**

The monitor pings the member to ensure that the member is alive.

The PING monitor is the most basic type of health check. The following configurable properties can be specified

* **delay:** This is the minimum time in seconds between regular pings of the member.
* **timeout:** Maximum number of seconds for a monitor to wait for a ping reply before it times out. The value must be less than the delay value.
* **max retries:** Number of permissible ping failures before changing the member's status to INACTIVE. Must be a number between 1 and 10.

{:.prettyprint .lang-java}
    HealthMonitor mon = os.networking().loadbalancers().healthMonitor()
                          .create(Builders.healthMonitor()
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
    HealthMonitor mon = os.networking().loadbalancers().healthMonitor()
                          .create(Builders.healthMonitor()
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
    HealthMonitor mon = os.networking().loadbalancers().healthMonitor()
                          .create(Builders.healthMonitor()
                             .type(HealthMonitorType.HTTP)
                             .delay(20)
                             .timeout(10)
                             .maxRetries(3)
                             .urlPath("/check")
                             .build());

### Deleting

{:.prettyprint .lang-java}
	ActionResponse resp = os.networking().loadbalancers().healthMonitor().delete(healthMinotirId);


### Associating Health Monitors to a Pool

The following examples show how to associate and disassociate health monitors against a pool.

{:.prettyprint .lang-java}
	// Associating a health monitor
	HealthMonitor monitor = os.networking().loadbalancers().lbPool().associateHealthMonitor(lbPoolId, healthMonitorId);

	// Disassociate a health monitor
	ActionResponse resp = os.networking().loadbalancers().lbPool().disAssociateHealthMonitor(lbPoolId, healthMonitorId);
