---
layout: content
menu: learn
title: Compute / Security Groups & Rules
nav: compute
---

# Security Groups and Rules

Security groups are sets of IP filter rules that are applied to a servers networking.  They are tenant specific and tenant members can edit the rules for their group and add new rule sets.  Commonly new users fail to set the appropriate security group when launching a server instance.  As a result, the user is unable to contact the server on the network.  Below are examples on how to query, create and modify security groups and rules.

Security groups are an extension and typically installed by default.  If for some reason your OpenStack deployment does not have this extension then you may encounter an exception since the API endpoints will not exist.
<br>
<br>

## Security Groups

### Querying for Security Groups

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
	

### Creating, Updating and Deleting Security Groups

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

## Security Group Rules

A security group rule is the actual filter which is associated to a security group.  A security group can have many rules.  A rule defines a protocol, port range, CIDR address and reference to the group. 

### Creating a Security Rule

{:.prettyprint .lang-java}
	// Permit Port 80 against an existing Group for anyone
	Rule rule = client.compute().securityGroups()
	                  .createRule(Builders.secGroupRule()
				        .parentGroupId(group.getId())
					    .protocol(IPProtocol.TCP)
					    .cidr("0.0.0.0/0")
					    .range(80, 80).build()
				       ));

### Deleting a Security Rule

{:.prettyprint .lang-java}
	os.compute().securityGroups().deleteRule("ruleId");
	


