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

### Required Runtime Dependencies

OpenStack4j requires some runtime dependencies in order to run.  The easiest is to use the "-withdeps" version which has everything included.  Otherwise refer to pom for most recent changes. In a later release we will be adding a slight modular approach allowing options to use Jersey 1 vs 2 and possibly another popular connector.  For now refer to the needed dependencies for runtime if your not using the "-withdeps" jar.

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

### FAQ

#### Logging ####
Logging of HTTP communication can be enabled via
{:.prettyprint .lang-java}

    OSFactory.enableHttpLoggingFilter(true);

#### Resolver ####

Once authenticated, OpenStack services obtain their respective endpoint from a catalog using a default Resolver.
This logic can be overridden by defining a custom ServiceVersionResolver

{:.prettyprint .lang-java}

    // define custom ServiceVersionResolver
    final ServiceVersionResolver resolver = new ServiceVersionResolver() {
        @Override
        public Service resolve(ServiceType type, SortedSet<? extends Service> services) {
            // resolver logic; possibly ext. default logic
            return endpoint;
        }
    };

    // apply resolver to client
    OSClient.withConfig(Config.newConfig().withResolver(resolver))

#### Endpoint URL Resolver ####

Resolving and endpoint URL is by default based on the Service Type and Facing perspective. The default logic can be overridden by a custom EndpointURLResolver

{:.prettyprint .lang-java}

    // define a custom EndpointURLResolver
    final EndpointURLResolver endpointUrlResolver = new EndpointURLResolver() {
      @Override
      public String findURLV3(URLResolverParams arg0) {
        // logic for V3
        return null;
      }

      @Override
      public String findURLV2(URLResolverParams arg0) {
        // logic for V2
        return null;
      }
    };

    // apply resolver to client
    OSClient.withConfig(Config.newConfig().withEndpointURLResolver(resolver));
