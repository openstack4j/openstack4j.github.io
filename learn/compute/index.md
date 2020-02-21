---
layout: content
menu: learn
title: Compute (Nova)
nav: compute
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

```java
Flavor flavor = Builders.flavor()
        .name("Large Resources Template")
        .ram(4096)
        .vcpus(6)
        .disk(120)
        .rxtxFavor(1.2f)
        .build();

flavor = os.compute().flavors().create(flavor);
```

**Creating a Flavor via method parameters**

```java
Flavor flavor = os.compute().flavors()
        .create("name", ram, vcpus, disk, ephemeral, swap, rxtxFactor, isPublic);
```	

#### Querying for Flavors

Below are examples of how to query/find Flavors.

```java
// Find all Flavors
List<Flavor> flavors = os.compute().flavors().list();
    
// Find a Flavor by ID
Flavor flavor = os.compute().flavors().get("flavorId");
```

#### Deleting a Flavor

```java
os.compute().flavors().delete("flavorId");
```

## Images (via Nova)

Compute supports basic Image operations which is mainly read only lookups and metadata support.  For full image management please refer to the [Image Service (Glance)](/learn/image).
	
#### MetaData Operations

Metadata is extended key/value based data that can be stored against images.  This can be useful for keeping extra information against a particular image.

```java
// Get
Map<String, String> md = os.compute().images().getMetaData("imageId");

// Set
Map<String, String> md = os.compute().images().setMetaData("imageId", newMetaMap);

// Delete Keys
os.compute().images().deleteMetaData("imageId", "key1", key2", ...//);
```

## Quota-Sets and Limits

```java
// Quota-Set for a specific Tenant
QuotaSet qs = os.compute().quotaSets().get(tenant.getId());

// Quota-Set for a specific Tenant and User
QuotaSet qs = os.compute().quotaSets().get(tenant.getId(), user.getId());

// Limits (Rate Limit and Absolute)
Limits limits = os.compute().quotaSets().limits();
```

## Simple Tenant Usage (os-simple-tenant-usage)

```java
// Tenant Usage for All Tenants
List<? extends SimpleTenantUsage> tenantUsages = os.compute().quotaSets().listTenantUsages();

// Tenant Usage (detailed) for specific Tenant
SimpleTenantUsage usage = os.compute().quotaSets().getTenantUsage("tenantId");
```

## Extensions

Extensions are add-ons to the core OpenStack deployment. Sometimes it is important to determine if the deployment has an enhanced feature set available. To get a list of installed extensions against Nova see the example below.

```java
List<? extends Extension> extensions = os.compute().listExtensions();
```
