---
layout: content
menu: learn
title: LBaaS
nav: network/lbaas
---

<div class="alert alert-info" style="margin-top:20px;"><b>DRAFT:</b> This documentation is currently in draft form and is in the process of being completed.  Not all functionality has been documented and will be completed soon.</div>

# LBaaS (Load Balancer as a Service)

drive the actual load balancing of requests. Thus, an Openstack operator can choose which back-end technology to use. The long-term vision for the project, however, is to provide a single API that allows a user to seamlessly move between different load balancing technologies should the operator choose to do so.

**LBaaS System Architecture**

<img src="https://wiki.openstack.org/w/images/2/21/Lbaas_arch.JPG" height="400px">
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

### Health Monitor Linking

The following examples show how to associate and disassociate health monitors against a pool.

{:.prettyprint .lang-java}
	// Associating a health monitor
	HealthMonitor monitor = os.networking().loadbalancers().lbPool().associateHealthMonitor(lbPoolId, healthMonitorId);

	// Disassociate a health monitor
	ActionResponse resp = os.networking().loadbalancers().lbPool().disAssociateHealthMonitor(lbPoolId, healthMonitorId);
<br>

## Members

The members of a pool are responsible for servicing the requests received through the vip's virtual IP. The load-balancing method 
is used to distribute requests or connections between the pool members.

The weight of a member determines the portion of requests or connections it services compared to the other members of the pool.
For example, if member A has a weight of 2 and member B has a weight of 1, then member A will service twice as many requests as
member B. If the weight attribute is not specified, then the member's weight is implicitly set to "1".



