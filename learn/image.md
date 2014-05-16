---
layout: content
menu: learn
title: Images (Glance)
---

# Images (Glance)

If you are unfamiliar with an OpenStack image then you can think of it as a "virtual machine template".  Images can also be standard installation media such as ISO images.  

<div class="alert alert-danger"><strong>NOTE:</strong> The <b><i>Image</i></b> objects shown in these examples are not from the "compute" model package but referenced from the <b>org.openstack4j.model.image</b> package.</div>

## Creating, Reserving and Uploading Images

If an image (template) is created without uploading the media then it is what is known as a reserved state. A reserved state means we have reserved a placeholder but it contains no image data (uploaded media).  The status will be marked as `Queued` when in a reserve state.   OpenStack4j will automatically change a create operation into a reserve operation if the image data/media is not defined.
<br>
<br>

#### Create and Upload an Image in a single call

To create and upload the image media in a single call see the example below:

{:.prettyprint .lang-java}
	// Create a Payload - we will use URL in this example
	Payload<URL> payload = Payloads.create(new URL("https://some/url/cirros-0.3.0-x86_64-disk.img"));
	
	Image image = os.images().create(Builders.image()
	                .name("Cirros 0.3.0 x64")
	                .isPublic(true)
	                .containerFormat(ContainerFormat.BARE)
	                .diskFormat(DiskFormat.QCOW2)
	                .build()
	                ), payload);

#### Reserve an Image

{:.prettyprint .lang-java}
	Image image = os.images().reserve(Builders.image()
	                .name("Cirros 0.3.0 x64")
	                .isPublic(true)
	                .build());
	
	
#### Uploading Image Data

To upload image data/media see the examples below.

**Uploading an Updating an image object already assigned**

{:.prettyprint .lang-java}
	image = os.images().upload(image.getId(), 
	                           Payloads.create(new File("/path/to/vmimage.img")), 
	                           image.builder().containerFormat(ContainerFormat.BARE).diskFormat(DiskFormat.QCOW2));
	

**Uploading only the image data without updating**

{:.prettyprint .lang-java}
	os.images().upload("imageId", Payloads.create(new File("/path/to/vmimage.img"), null);
	
## Updating, Deleting and Querying

#### Updating an Image

To update an image like changing it's name or other template data see the example below.

{:.prettyprint .lang-java}
	os.images().update(image.toBuilder()
	           .name("New VM Image Name").minDisk(1024).property("personal-distro", "true"));
	
#### Delete an Image

To permanently delete an image see the example below.

 {:.prettyprint .lang-java}
	os.images().delete("imageId");

#### Querying for Images

{:.prettyprint .lang-java}
	// List all Images
	List<? extends Image> images = os.images().list();
		
	// Get an Image by ID
	Image image = os.images().get("imageId");
	


## Image Memberships

Image memberships are a way to share a private image with other tenants.  Those tenants can also be assigned rights to re-share the private image.  Public images are available but private images require memberships for non-owners to access.

**Finding all Memberships for an Image**

{:.prettyprint .lang-java}
	List<? extends ImageMember> members = os.images().listMembers("imageId");
		
**Adding a Member (authorizing a tenant for a private image)**

{:.prettyprint .lang-java}
	os.images().addMember("imageId", "tenantId");
	
**Removing a Member (revoking a tenant)**

{:.prettyprint .lang-java}
	os.images().removeMember("imageId", "tenantId");
	

