---
layout: content
menu: learn
title: Working with Model Objects
nav: getting-started
---

# Working with Model Objects

A model object is an object that is returned by any of the service APIs or an object required by the APIs for create and update operations.  A model object is always decorated by the `ModelEntity` interface.

<div class="alert alert-success"><strong>ALL Model Objects</strong> are Serializable and supported by a concrete interface</div>

## Buildable

Any model object that is also decorated as a `Buildable` will always have an associated Builder and will always be able to be transformed into a builder for modifications.  

Here are some examples:

**Creating a new Model Object**

```java
Tenant tenant = Builders.identityV2().tenant().name("My Tenant").description("low usage tenant").build();

Image image = Builders.image().name("Ubuntu 12.04 LTS").diskFormat(DiskFormat.QCOW2).minDisk(1024).build();

Router router = Builders.router()
        .name("ext_net")
        .tenant(tenant)
        .adminStateUp(true)
        .route("10.0.1.0/24", "10.1.1.1")
        .build();
```
	
**Updating a Model Object that was retrieved or previously created (built)**

```java
tenant.builder().name("New Tenant Name");

image.builder().name("New Image Name").minRam(2048);

router.builder().tenantId("newTenantId");
```

As you can see in the above examples any `Buildable` can be created via `Builders` and mutated via `Object.builder()`
