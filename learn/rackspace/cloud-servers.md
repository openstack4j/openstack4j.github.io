---
layout: content
menu: learn
title: Cloud Servers
nav: cloud-servers
---

Quickstart for Cloud Servers
============================

Rackspace Cloud Servers allows you to allocate and deallocate compute resources.
It is based on OpenStack Compute (Nova), a community-led open-source platform.

Concepts
========
To use this service effectively, you should understand how these key ideas are used in this context:

server
	A computer that provides explicit services to the client software running on that system.
    A server is a virtual machine (VM) instance in the Cloud Servers environment.
    To create a server, you must specify a name, flavor reference, and image reference.

image
    The type of operating system you want to use.
    You can choose from pre-defined images or create your own custom images.

flavor
    A resource configuration for a server.
    Each flavor is a unique combination of disk, memory, vCPUs, and network bandwidth.
    You can choose from pre-defined flavors.

network
    The virtual space where your servers live. Rackspace has two default networks:
    PublicNet, which is the Internet; ServiceNet, which is our internal network.
    Although you can create as many isolated networks as you want,
    the default configuration is for servers to be connected to
    both PublicNet (for public Internet connectivity) and ServiceNet (for internal connectivity with your other servers).

Authenticate to gain access to the service
==========================================
To use this service you have to authenticate first. To do this, you will need your Rackspace username, and one of the following:

* your Rackspace account password
* your Rackspace API key

Your username and password are the ones you use to login to the Cloud Control Panel at http://mycloud.rackspace.com/.

To find your API key, first navigate to the Cloud Control Panel, then click on your username at the top right corner, and then finally click on Account Settings. You will be taken to a page that shows your settings. Under Login Details, you can show or reset your API key.

Once you have these pieces of information, you can pass them into the SDK:

```java
List<? extends Extension> extensions = os.compute().listExtensions();
```
