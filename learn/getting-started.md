---
layout: content
menu: learn
title: Getting Started
description: Learn how to setup and use OpenStack4j within 5 minutes
nav: getting-started
---

# Getting Started

This chapter will guide you through setup and some basic examples to get you going.  For advance API coverage please refer to each topic within the overall guide.

## Maven Configuration

{% capture md %}
{% include maven.md %}
{% endcapture %}
{{ md | markdownify }}

## Non-Maven Users

If you do not use Maven you can download from one of the links below and add the library to your class path.

<table class="table table-striped">
  <tr><th><strong>Version</strong></th><th><strong>Type</strong></th><th><strong>Link</strong></th></tr>
  <tr><td>{{ site.version }}</td><td>Stable/Release</td><td><a class="btn btn-success btn-small" href="http://search.maven.org/#artifactdetails%7Corg.pacesys%7Copenstack4j%7C{{ site.version }}%7Cjar" target="_blank">Download</a></td></tr>
  <tr><td>{{ site.snapshot-version }}</td><td>Beta/Latest Features</td><td><a class="btn btn-warning btn-small" href="https://oss.sonatype.org/content/repositories/snapshots/org/pacesys/openstack4j/{{ site.snapshot-version }}/" target="_blank">Download</a></td></tr>
  <tr><td>{{ site.withdeps-version }}</td><td>Single Jar (With Dependencies)</td><td><a class="btn btn-warning btn-small" href="https://oss.sonatype.org/content/repositories/snapshots/org/pacesys/openstack4j/{{ site.snapshot-version }}/" target="_blank">Download</a></td></tr>
  <tr><td>2.20</td><td>Maintenance</td><td><a class="btn btn-warning btn-small" href="https://oss.sonatype.org/content/repositories/snapshots/org/pacesys/openstack4j/2.20/" target="_blank">Download</a></td></tr>
</table>
<br>

### Required Runtime Dependencies

OpenStack4j requires some runtime dependencies in order to run.  The easiest is to use the "-withdeps" version which has everything included.  Otherwise refer to pom for most recent changes. In a later release we will be adding a slight modular approach allowing options to use Jersey 1 vs 2 and possibly another popular connector.  For now refer to the needed dependencies for runtime if your not using the "-withdeps" jar.

#### OpenStack4j 3.0.x Global Dependencies

<table class="table table-striped">
  <tr><th><strong>Name</strong></th><th><strong>Version</strong></th></tr>
  <tr><td>openstack4j-core</td><td>3.0.0</td></tr>
  <tr><td>jackson-annotations</td><td>2.4.0</td></tr>
  <tr><td>jackson-core</td><td>2.4.1.1</td></tr>
  <tr><td>jackson-databind</td><td>2.4.1.3</td></tr>
  <tr><td>guava</td><td>17.0</td></tr>
</table>

#### OpenStack4j 3.0.x Connector Specific Dependencies
<br>
**JERSEY**

<table class="table table-striped">
  <tr><th><strong>Name</strong></th><th><strong>Version</strong></th></tr>
  <tr><td>hk2-api</td><td>2.3.0-b05</td></tr>
  <tr><td>hk2-locator</td><td>2.3.0-b05</td></tr>
  <tr><td>hk2-utils</td><td>2.3.0-b05</td></tr>
  <tr><td>jackson-jaxrs-base</td><td>2.3.2</td></tr>
  <tr><td>jackson-jaxrs-json-provider</td><td>2.3.2</td></tr>
  <tr><td>javax.annotation-api</td><td>1.2</td></tr>
  <tr><td>javax.inject</td><td>2.3.0-b05</td></tr>
  <tr><td>javax.ws.rs-api</td><td>2.0</td></tr>
  <tr><td>jersey-client</td><td>2.10.1</td></tr>
  <tr><td>jersey-common</td><td>2.10.1</td></tr>
  <tr><td>jersey-guava</td><td>2.10/1</td></tr>
  <tr><td>jersey-media-json-jackson</td><td>2.11</td></tr>
  <tr><td>openstack4j-jersey2</td><td>3.0.0</td></tr>
</table>

**HTTPCLIENT**

<table class="table table-striped">
  <tr><th><strong>Name</strong></th><th><strong>Version</strong></th></tr>
  <tr><td>commons-logging</td><td>1.1.3</td></tr>
  <tr><td>httpclient</td><td>4.3.1</td></tr>
  <tr><td>httpcore</td><td>4.3</td></tr>
  <tr><td>openstack4j-httpclient</td><td>3.0.0</td></tr>
</table>

**OKHTTP**

<table class="table table-striped">
  <tr><th><strong>Name</strong></th><th><strong>Version</strong></th></tr>
  <tr><td>okhttp</td><td>2.1.0</td></tr>
  <tr><td>okio</td><td>1.0.1</td></tr>
  <tr><td>openstack4j-okhttp</td><td>3.0.0</td></tr>
</table>

#### OpenStack4j 3.0.x Runtime Dependencies

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

Creating and authenticating against OpenStack is extremely simple. Below is an example of authenticating which will result with the authorized OSClientV2 or OSClientV3 - depending on the Keystone version.
The OSClientV2/OSClientV3 allows you to invoke Compute, Identity V2/V3, Neutron operations fluently.

In the example below we are specifying the OpenStack deployment endpoint to connect to, user credentials to authenticate and the default tenant we would like to be in context of.
<br>

Since OpenStack4j both version 3.0.0 version 2 and 3 of the Identity API are supported.

#### Version 2 Authentication
<div class="alert alert-warning"><b>NOTE: </b>   OpenStack4j 3.0.0 introduced some breaking changes.
<br/> The Identity V2 API is no longer available with the OSClient but only with the new <b>OSClientV2</b>.<br>
</b></a></div>

In previous OpenStack4j versions (2.x) V2 authentication was done by:
{:.prettyprint .lang-java}

    import org.openstack4j.api.OSClient;
    import org.openstack4j.openstack.OSFactory;

    OSClient os = OSFactory.builder()
                .endpoint("http://127.0.0.1:5000/v2.0")
                .credentials("admin", "test")
                .tenantName("admin")
                .authenticate();

V2 authentication in OpenStack4j 3.x is done the following way:

{:.prettyprint .lang-java}

    import org.openstack4j.api.OSClient.OSClientV2;
    import org.openstack4j.openstack.OSFactory;

	OSClientV2 os = OSFactory.builderV2()
	                       .endpoint("http://127.0.0.1:5000/v2.0")
	                       .credentials("admin","sample")
	                       .tenantName("admin")
	                       .authenticate();


#### Version 3 Authentication
<div class="alert alert-warning"><b>NOTE: </b>   OpenStack4j 3.0.0 introduced some breaking changes.
<br/> The Identity V3 API is only available with the new <b>OSClientV3</b>.<br>
</b></a></div>

{:.prettyprint .lang-java}

    import org.openstack4j.api.OSClient.OSClientV3;
    import org.openstack4j.openstack.OSFactory;
    import org.openstack4j.model.common.Identifier;

    # use Identifier.byId("domainId") or Identifier.byName("example-domain")
	Identifier domainIdentifier = Identifier.byId("domainId");

    # unscoped authentication
    # as the username is not unique across domains you need to provide the domainIdentifier
	OSClientV3 os = OSFactory.builderV3()
	                       .endpoint("http://127.0.0.1:5000/v3")
	                       .credentials("admin","sample", domainIdentifier)
	                       .authenticate();

    # project scoped authentication
    OSClientV3 os = OSFactory.builderV3()
                        .endpoint("http://127.0.0.1:5000/v3")
                        .credentials("admin", "secret", Identifier.byName("example-domain"))
                        .scopeToProject(Identifier.byId(projectIdentifier))
                        .authenticate();

    # domain scoped authentication
    # using the unique userId does not require a domainIdentifier
    OSClientV3 os = OSFactory.builderV3()
                        .endpoint("http://127.0.0.1:5000/v3")
                        .credentials("userId", "secret")
                        .scopeToDomain(Identifier.byId(domainIdentifier))
                        .authenticate();
			
    # Scoping to a project just by name isn't possible as the project name is only unique within a domain. 
    # You can either use this as the id of the project is unique across domains  			
    OSClientV3 os = OSFactory.builderV3()
                        .endpoint("http://127.0.0.1:5000/v3")
                        .credentials("userId", "secret")
                        .scopeToProject(Identifier.byName(projectName), Identifier.byName(domainName))
                        .authenticate();
    
    # Or alternatively
    OSClientV3 os = OSFactory.builderV3()
                        .endpoint("http://127.0.0.1:5000/v3")
                        .credentials("userId", "secret")
                        .scopeToDomain(Identifier.byName(domainName))
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
