---
layout: content
menu: learn
title: Object Storage (Swift)
nav: objectstorage
---

# Object Storage (Swift)

Swift is a highly available, distributed, eventually consistent object/blob store. Organizations can use Swift to store lots of data efficiently, safely, and cheaply.

## Account

An account is also known as a project or tenant.  An account is the security profile in which containers and objects live.  Due to the role of an account there are not many management tasks associated with it.

#### Getting the Account Details

To retrieve account details see the example below:

```java
SwiftAccount account = os.objectStorage().account().get();
```

#### Metadata

**Creating or Updating Metadata for an Account**

```java
boolean successful = os.objectStorage().account().updateMetadata(myMetadataMap);
```
 
**Removing Metadata items for an Account**

```java
boolean successful = os.objectStorage().account().deleteMetadata(myMetadataMap);
```

## Containers

A container is essentially a bucket of objects.  Containers can have access security assigned to them, published against a CDN or be shared publicly.

#### Querying for Containers

**Listing all Containers the current Account**

```java
List<? extends SwiftContainer> containers = os.objectStorage().containers().list();
```

**Querying with advanced criteria**

```java
List<? extends SwiftContainer> containers = os.objectStorage()
        .containers()
        .list(ContainerListOptions.create()
              .startsWith("J")
              .limit(100)
              // ...
        );
```

#### Creating a Container

```java
// Simple
os.objectStorage().containers().create("myContainerName");

// Full control
os.objectStorage().containers().create("myContainer", CreateUpdateContainerOptions.create()
        .accessAnybodyRead()
        .accessWrite(acl)
        .metadata(myMeta)
        //...
);
```

#### Updating a Container

Updating a container is very simular to creating one like the above "full control" example.  The only differences is the 
method call.  See brief example:

```java
os.objectStorage().containers().update("myContainer", CreateUpdateContainerOptions);
```

#### Deleting a Container

Note, in order to successfully reemove a container **it must be empty**.  This is not an OpenStack4j policy but a requirement by OpenStack.

```java
os.objectStorage().containers().delete("myContainer");
```

#### Creating Pseudo Directories

Depending on how your deployment is configured this feature may/may not be supported.  Vendors such as Rackspace support this out of the box.  

```java
os.objectStorage().containers().createPath(containerName, "/my/nested/path");
```

#### Metadata

**Fetching Metadata**

```java
Map<String, String> md = os.objectStorage().containers().getMetadata(containerName);
```

**Creating or Updating Metadata**

```java
boolean successful = os.objectStorage().containers().updateMetadata(containerName, myMetadataMap);
```

**Removing Metadata items**

```java
boolean successful = os.objectStorage().containers().deleteMetadata(containerName, myMetadataMap);
```
	
## Objects

Objects are uploaded files, manifestations or pseudo directories.  Objects are associated to a container.

#### Querying for Objects

**Listing all Objects for a Container**

```java
List<? extends SwiftObject> objs = os.objectStorage().objects().list(containerName);
```
	
**Querying with advanced criteria**

```java
List<? extends SwiftObject> objs = os.objectStorage().objects().list(ObjectListOptions.create()
        .startsWith("J")
        .path("/art/digital")
        // ...
);
```

#### Creating Objects

**Simple**

```java
String etag = os.objectStorage().objects().put(containerName, objectName, Payloads.create(someFile));
```

**Advanced**

```java
String etag = os.objectStorage().objects().put(containerName, objectName, 
            Payloads.create(someFile), 
            ObjectPutOptions.create()
                    .path("/some/path")
                    .metadata(md)
                    // ...
            );
```

#### Deleting an Object

```java
os.objectStorage().objects().delete(containerName, objectName);
```

#### Copying an Object

```java
String etag = os.objectStorage().objects().copy(ObjectLocation.create(srcContainer, srcObject)
        ObjectLocation.create(destContainer, destObject)
        );
```

#### Metadata

**Fetching Metadata**

```java
Map<String, String> md = os.objectStorage().objects().getMetadata(containerName, objectName);
```

**Creating or Updating Metadata**

```java
boolean successful = os.objectStorage().objects().updateMetadata(ObjectLocation.create(containerName, objectName), myMetadataMap);
```
