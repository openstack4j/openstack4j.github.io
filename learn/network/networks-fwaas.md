---
layout: content
menu: learn
title: FWaaS
nav: network/fwaas
---

# FWaaS (Firewall as a Service)

The Firewall-as-a-Service (FWaaS) plug-in within OpenStack adds perimeter firewall management to Networking. FWaaS uses iptables to apply firewall policy to all Networking routers within a project. FWaaS supports one firewall policy and logical firewall instance per project.

Whereas security groups operate at the instance-level, FWaaS operates at the perimeter to filter traffic at the neutron router.

#### **Firewall Associations**

To get an idea on how a firewall is created it's best to understand it's associations.  A Firewall is associated to a firewall policy and a policy is associated to rules. 

<img src="https://docs.google.com/drawings/d/sDqBqvZPGu0-OblnGWa9HrQ/image?w=667&h=74&rev=57&ac=1">
<br>
<br>

## Firewalls

A firewall represents a logical firewall resource that a tenant can instantiate and manage. A firewall is associated with one [firewall policy](#firewall-policies).

### Querying

**List all Firewalls for the current Tenant**

{:.prettyprint .lang-java}
	List<? extends Firewall> list = os().networking().firewalls().firewall().list();

**Listing all Firewalls for the current Tenant with `filters`**

{:.prettyprint .lang-java}
    Map<String, String> filter = Maps.newHashMap();
    filter.put("name", "some firewall");

	List<? extends Firewall> rules = os.networking().firewalls().firewall().list(filter);

**Finding a Firewall by ID**

{:.prettyprint .lang-java}
	Firewall fw = os().networking().firewalls().firewall().get(id);

### Creating / Updating / Deleting

**Creating a Firewall**

{:.prettyprint .lang-java}
	Firewall fw = os.networking().firewalls().firewall()
                    .create(Builders.firewall()
                             .name("My Firewall")
                             .description("A robust firewall")
                             .policy(policyId)
                             .tenantId(tenantId)
                             .build());

**Updating a Firewall**

{:.prettyprint .lang-java}
	Firewall fw = os.networking().firewalls().firewall()
                    .update(firewallId, Builders.firewallUpdate()
                           .name("Name Change")
                           .policy(newPolicyId)
                           .build());

**Deleting a Firewall**

{:.prettyprint .lang-java}
	ActionResponse resp = os.networking().firewalls().firewall().delete(firewallId);
<br>

## Firewall Policies

Represents an ordered collection of firewall rules. A firewall policy can be shared across tenants. 
Thus it can also be made part of an audit workflow wherein the firewall_policy can be audited by the relevant entity that is 
authorized (and can be different from the tenants which create or use the firewall policy)

### Querying

**List all Firewall Policies for the current Tenant**

{:.prettyprint .lang-java}
	List<? extends FirewallPolicy> list = os().networking().firewalls().firewallpolicy().list();

**Listing all Firewall Policies for the current Tenant with `filters`**

{:.prettyprint .lang-java}
    Map<String, String> filter = Maps.newHashMap();
    filter.put("name", "some policy");

	List<? extends FirewallRule> rules = os.networking().firewalls().firewallpolicy().list(filter);

**Finding a Firewall Rule by ID**

{:.prettyprint .lang-java}
	FirewallPolicy firewallPolicy = os().networking().firewalls().firewallpolicy().get(id);

### Creating / Updating / Deleting

**Creating a Firewall Policy**

{:.prettyprint .lang-java}
	FirewallPolicy create = Builders.firewallPolicy()
			        .name("Test-Firewall-Policy").description("Test-Firewall-Policy")
			        .shared(Boolean.TRUE).audited(Boolean.FALSE)
			        .firewallRules(Arrays.asList(ruleId))
			        .tenantId(tenantID)
			        .build();

	FirewallPolicy result = os().networking().firewalls().firewallpolicy().create(create);

**Updating a Firewall Policy**

{:.prettyprint .lang-java}
	FirewallPolicyUpdate update = Builders.firewallPolicyUpdate()
				        .name("Test-Firewall-Policy-Update")
				        .shared(Boolean.FALSE).audited(Boolean.FALSE)
				        .firewallRules(Arrays.asList(ruleId))
				        .description("Test-Firewall-Policy-Update")
				        .build();

	FirewallPolicy result = os().networking().firewalls().firewallpolicy().update(policyId, update);


**Inserting a Firewall Rule into a Firewall Policy**

{:.prettyprint .lang-java}
	FirewallPolicy result = os().networking().firewalls().firewallpolicy()
        			    .insertFirewallRuleInPolicy(firewallPolicyId, 
								firewallRuleId, 
								ruleInsertStrategyType, 
								insertAfterOrBeforeRuleId);

**Removing a Firewall Rule from a Firewall Policy**

{:.prettyprint .lang-java}
	FirewallPolicy result = os().networking().firewalls().firewallpolicy()
						 .removeFirewallRuleFromPolicy(firewallPolicyId, firewallRuleId);

**Deleting a Firewall Policy**

{:.prettyprint .lang-java}
	ActionResponse resp = os().networking().firewalls().firewallpolicy().delete(policyId);
<br>

## Firewall Rules

Firewall rules is exactly how it sounds. It's the actual rule governing ingress and egress traffic and whether it's permitted or
denied.

### Querying

**Listing all Firewall Rules for the current Tenant**

{:.prettyprint .lang-java}
	List<? extends FirewallRule> rules = os.networking().firewalls().firewallrule().list();

**Listing all Firewall Rules for the current Tenant with `filters`**

{:.prettyprint .lang-java}
    Map<String, String> filter = Maps.newHashMap();
    filter.put("name", "mysql");

	List<? extends FirewallRule> rules = os.networking().firewalls().firewallrule().list(filter);

**Finding a Firewall Rule by ID**

{:.prettyprint .lang-java}
	FirewallRule rule = os.networking().firewalls().firewallrule().get(ruleId);

### Creating / Updating / Deleting

**Creating a new Firewall Rule**

{:.prettyprint .lang-java}
    FirewallRule rule = os.networking().firewalls().firewallrule()
			      .create(Builders.firewallRule()
			                .name("MySQL")
			                .protocol(IPProtocol.TCP)
			                .destinationPort("3306")
			                .action(FirewallRuleAction.ALLOW)
			                .build()
			             );

**Updating a Firewall Rule**

{:.prettyprint .lang-java}
	FirewallRule updated = os.networking().firewalls().firewallrule()
				 .update(ruleId, Builders.firewallRuleUpdate().description("New Desc").build());


**Deleting a Firewall Rule**

{:.prettyprint .lang-java}
	ActionResponse resp = os.networking().firewalls().firewallrule().delete(ruleId);
<br>



