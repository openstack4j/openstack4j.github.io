---
layout: content
menu: learn
title: Block Storage (Cinder)
---

# Block Storage (Cinder)

The Block Storage Service is a block-level storage solution that enables you to mount drives to cloud servers to scale storage without paying for more compute resources.  It can also be leveraged as high performance storage to server database or I/O-intensive applications.  

Openstack4j enables you to interact programmatically to fully support management of Volumes, Volume Types and Volume Snapshots

## Volume Types

A volume type is a descriptor for a block storage volume. You can define whatever types meet your business needs, such as SSD, SCSI, SATA, Backup, etc.  You can also provides extra specifications describing extended details about the type. Volumes can be associated to a Volume Type.

#### Listing Volume Types

To retrieve available volume types see the example below:

{:.prettyprint .lang-java}
	List<VolumeType> types = os.blockStorage().volumes().listVolumeTypes();


## Volumes

A volume is a detachable block storage device. You can think of it as an external drive and can only be attached to one instance at a time. Volumes can be created as a simple storage device, reference to an image (bootable or non-bootable such as a ISO), reference to an existing volume or a reference to an existing snapshot.

#### Querying for Volumes

**Listing all Volumes the current tenant making the request has access to**

{:.prettyprint .lang-java}
	List<Volume> volumes = os.blockStorage().volumes().list();

**Getting a Volume by ID**

{:.prettyprint .lang-java}
	Volume volume = os.blockStorage().volumes().get("volumeId");
	
#### Create, Update and Deleting Volumes

**Create a Storage Volume**

{:.prettyprint .lang-java}
	Volume v = os.blockStorage().volumes()
	             .create(Builders.volume()
	                .name("Backup Volume")
	                .description("Simple volume to store backups on")
	                .size(20)
	                .build()
	             );
	
**Create a Bootable Volume from an Image**            

{:.prettyprint .lang-java}
	Volume v = os.blockStorage().volumes()
	             .create(Builders.volume()
	                .name("Ubuntu 12.04 LTS")
	                .description("Bootable install volume")
	                .imageRef("imageId")
	                .bootable(true)
	                .build()
	             );

**Updating the name and description of a Volume**

{:.prettyprint .lang-java}
	os.blockStorage().volumes().update("volumeId", "New Name", "New Description");
	
**Deleting a Volume**

{:.prettyprint .lang-java}
	os.blockStorage().volumes().delete("volumeId");
	
## Snapshots

A snapshot is a point in time copy of the data that is contained in a volume.  See the examples below on managing snapshots with OpenStack4j.

#### Querying for Snapshots

**Listing all Snapshots the current tenant making the request has access to**

{:.prettyprint .lang-java}
	List<VolumeSnapshot> snapshots = os.blockStorage().snapshots().list();

**Getting a Snapshot by ID**

{:.prettyprint .lang-java}
	Snapshot snapshot = os.blockStorage().snapshots().get("snapshotId");

#### Creating a Snapshot

When creating a Snapshot make note that the Volume Identifier is required.  All other fields are optional. If the volume identifier is not defined then a `NullPointerException` will be thrown.

{:.prettyprint .lang-java}
	Snapshot snapshot = os.blockStorage().snapshots()
	                      .create(Builders.volumeSnapshot()
	                         .name("Snapshot 2014-01-01 - Before Upgrade")
	                         .description("Snapshot before we migrate data to v2")
	                         .volume("volumeId")
	                         .build()
	                      );
	
#### Updating a Snapshot

Since a snapshot is a frozen copy of a point in time OpenStack only allows for updating the name and description. See the example below

{:.prettyprint .lang-java}
	os.blockStorage().snapshots().update("snapshotId", "New Name", "New Description");
	
#### Deleting a Snapshot

{:.prettyprint .lang-java}
	os.blockStorage().snapshots().delete("snapshotId");