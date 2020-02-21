---
layout: content
menu: learn
title: Images V2 (Glance)
nav: image-v2
---

# Images V2 (Glance)

If you are unfamiliar with an OpenStack image then you can think of it as a "virtual machine template".  Images can also be standard installation media such as ISO images.  

<div class="alert alert-danger"><strong>NOTE:</strong> The <b><i>Image</i></b> objects shown in these examples are not from the "compute" model package but referenced from the <b>org.openstack4j.model.image.v2</b> package.</div>

Detailed information about how to use the Glance calls can be found in the <a href="http://developer.openstack.org/api-ref/image/v2/index.html">OpenStack Glance V2 docs</a>.

## Creating, Reserving and Uploading Images

When an image (template) is created it is in what is known as a reserved state. A reserved state means we have reserved a placeholder but it contains no image data (uploaded media).  The status will be marked as `Queued` when in a reserve state.  
<br>

#### Create an Image

Image will be in queued state until image data is uploaded.

```java
Image image = os.imagesV2().create(
    Builders.imageV2()
        .name("Cirros 0.3.0 x64")
        .containerFormat(ContainerFormat.BARE)
        .visibility(Image.ImageVisibility.PUBLIC)
        .diskFormat(DiskFormat.QCOW2)
        .minDisk(0)
        .minRam(0)
        .build()
);
```

#### Upload Image Data

Payloads can be created with URLs, files, or input streams.

```java
// Create a Payload - we will use URL in this example
Payload<URL> payload = Payloads.create(new URL("https://some/url/cirros-0.3.0-x86_64-disk.img"));

// Get image object to use, or send null
Image image = os.imagesV2().get("imageId");

ActionResponse upload = os.imagesV2.upload(
    image.getId(),
    payload,
    image);
```

#### Download Image data

```java					 
 File file = new File(new URI("file:///some/path/to/image.iso"));
 ActionResponse download = os.imagesV2().download(image.getId(), file);
```

## Updating, Deleting and Querying

#### Updating an Image
Update an image by providing a changed image object, or a json patch object.

**Use Original Image**

```java
Image image = os.imagesV2().update(
    originalImage.toBuilder().
        containerFormat(ContainerFormat.BARE)
        .name("New Name")
        .build()
);
```

**Use Json Patch Operation**

```java
Image updatedImage = os.imagesV2().update("imageId",
    Builders.imageUpdateV2().ops(
        new PatchOperation(
            PatchOperation.OperationType.REPLACE,
            "/container_format",
            ContainerFormat.BARE
        )
    ).build()
);
```

#### Delete an Image

Permanently delete image.

 ```java
os.imagesV2().delete("imageId");
```

#### Querying for Images

Pagination for images is done with url parameters as described <a href ="http://developer.openstack.org/api-ref/image/v2/index.html#show-images">here</a>.

**List all Images**

```java
List<? extends Image> images = os.imagesV2().list();
```

**Get Image by Id**

```java
Image image = os.imagesV2().get("imageId");
```

## Activating, Deactivating and Tagging

You can't download a deactivated image. Additionally, only administrative users can view image locations for deactivated images.

#### Activation and Deactivation

**Deactivate Image**

```java
os.imagesV2().deactivate("imageId");
```

**Activate Image**

```java
os.imagesV2.activate("imageid");
```

#### Image Tags

Image tags are strings.

**Add Tag**

```java
os.imagesV2().updateTag("imageId", "tag");
```

**Remove Tag**

```java
os.imagesV2().deleteTag("imageId", "tag");
```

## Image Memberships

Image memberships are a way to share a private image with other tenants.  Those tenants can also be assigned rights to re-share the private image.  Public images are available but private images require memberships for non-owners to access.

#### Querying Memberships for an Image

**Get All Members**

```java
List<? extends Member> members = os.imagesV2().listMembers("imageId");
```

**Get a Single Member**

```java
Member member = os.imagesV2().getMember("imageId", "memberId");
```

#### Create a Member (authorizing a tenant for a private image)

```java
Member member = os.imagesV2().createMember("imageId", "memberId");
```

#### Updating a Member

```java
Member member = os.imagesV2().updateMember("imageId", "memberId", Member.MemberStatus.ACCEPTED));
```

#### Removing a Member (revoking a tenant)

```java
os.imagesV2().deleteMember("imageId", "memberId");
```

## Tasks

<a href="http://docs.openstack.org/developer/glance/tasks.html">Glance tasks</a> are intended to offer end users a front end to long running asynchronous operations – the type of operation you kick off and don’t expect to finish until you’ve gone to the coffee shop, had a pleasant chat with your barista, had a coffee, had a pleasant walk home, etc.

#### Create Task

Here the json object for input is created using a HashMap, but it can be any valid json object.

```java
// Create json object for input
Map<String, Object> input = new HashMap<String, Object>();

// Fill with the input

// Create task
Task task1 = os.imagesV2().tasks().create(
    Builders.taskBuilder()
        .type("import")
        .input(input)
        .build()
    );
```

#### List Tasks

**List all Tasks**

```java
List<? extends Task> tasks = os.imagesV2().tasks().list();
```

**List all Tasks with Filtering**

```java
Map<String, String> params = new HashMap<String, String>();
params.put("id","taskId");
List<? extends Task> list = os.imagesV2().tasks().list(params);
```

#### Show Task Details

```java
Task task = os.imagesV2().tasks().get("taskId");
```
