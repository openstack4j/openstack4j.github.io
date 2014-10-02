---
layout: content
menu: learn
title: Getting Started
description: Learn how to setup and use OpenStack4j within 5 minutes
---

# Getting Started

This chapter will guide you through setup and some basic examples to get you going.  For advance API coverage please refer to each topic within the overall guide.

## Setting Up Your Environment

### Maven Configuration

{% capture md %}
{% include maven.md %}
{% endcapture %}
{{ md | markdownify }}

### Non-Maven Users

If you do not use Maven you can download from one of the links below and add the library to your class path.

<table class="table table-striped">
  <tr><th><strong>Version</strong></th><th><strong>Type</strong></th><th><strong>Link</strong></th></tr>
  <tr><td>{{ site.version }}</td><td>Stable/Release</td><td><a class="btn btn-success btn-small" href="/downloads/openstack4j-{{ site.version }}.jar" target="_blank">Download</a></td></tr>
  <tr><td>{{ site.snapshot-version }}</td><td>Beta/Latest Features</td><td><a class="btn btn-warning btn-small" href="https://oss.sonatype.org/content/repositories/snapshots/org/pacesys/openstack4j/{{ site.snapshot-version }}/" target="_blank">Download</a></td></tr>
  <tr><td>{{ site.withdeps-version }}</td><td>Single Jar (With Dependencies)</td><td><a class="btn btn-warning btn-small" href="https://oss.sonatype.org/content/repositories/snapshots/org/pacesys/openstack4j/{{ site.snapshot-version }}/" target="_blank">Download</a></td></tr>

</table>
<br>

#### Required Runtime Dependencies

OpenStack4j requires some runtime dependencies in order to run.  The easiest is to use the "-withdeps" version which has everything included.  Otherwise refer to pom for most recent changes. In a later release we will be adding a slight modular approach allowing options to use Jersey 1 vs 2 and possibly another popular connector.  For now refer to the needed dependencies for runtime if your not using the "-withdeps" jar.

<table class="table table-striped">
  <tr><th><strong>Name</strong></th><th><strong>Version</strong></th></tr>
  <tr><td>Jersey</td><td>2.0</td></tr>
  <tr><td>Jackson</td><td>1.9.13</td></tr>
  <tr><td>Gauva</td><td>14.01+</td></tr>
  <tr><td>JSR-305</td><td>NA</td></tr>
</table>

## Lets Play!

Let's test your OpenStack deployment with the API.  For advance coverage of the API please refer to the service of interest on the left navigation pane.
<br><br>

### Authenticate

Creating and authenticating against OpenStack is extremely simple. Below is an example of authenticating which will result with the authorized OSClient. OSClient allows you to invoke Compute, Identity, Neutron operations fluently.

In the example below we are specifying the OpenStack deployment endpoint to connect to, user credentials to authenticate and the default tenant we would like to be in context of.
<br>

#### Version 2 Authentication

{:.prettyprint .lang-java}
	OSClient os = OSFactory.builder()
	                       .endpoint("http://127.0.0.1:5000/v2.0")
	                       .credentials("admin","sample")
	                       .tenantName("admin")
	                       .authenticate();
						

#### Version 3 Authentication

{:.prettyprint .lang-java}
	OSClient os = OSFactory.builderV3()
	                       .endpoint("http://127.0.0.1:5000/v3")
	                       .credentials("admin","sample")
	                       .domainName("example-domain")
	                       .authenticate();

### Run some Queries

Now that we have successfully authenticated and have a client we will show you a few basic examples of grabbing data from the various services.  These are high level and for full CRUD and management calls please refer to each individual service guide.

{:.prettyprint .lang-java}
	// Find all Users
	List<? extends User> users = os.identity().users().list();
	
	// List all Tenants
	List<? extends Tenant> tenants = os.identity().tenants().list();
	
	// Find all Compute Flavors
	List<? extends Flavor> flavors = os.compute().flavors().list();
	
	// Find all running Servers
	List<? extends Server> servers = os.compute().servers().list();
	
	// Suspend a Server
	os.compute().servers().action("serverId", Action.SUSPEND);
	
	// List all Networks
	List<? extends Network> networks = os.networking().network().list();
	
	// List all Subnets
	List<? extends Subnet> subnets = os.networking().subnet().list();
	
	// List all Routers
	List<? extends Router> routers = os.networking().router().list();
	
	// List all Images (Glance)
	List<? extends Image> images = os.images().list();
	
	// Download the Image Data
	InputStream is = os.images().getAsStream("imageId");

As you can see in the examples above we have exercised a small portion of the following services (Identity, Computer, Network and Image).