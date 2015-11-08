---
layout: pages
menu: changelog
title: Changelog
description: OpenStack4j - Java cloud management for OpenStack - Release Changelog
---

### 2.0.8

**Released:** Nov 7, 2015 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#208)

##### Enhancements/Improvements

* Issue #492 - Telemetry Events API - Thank you - @iviireczech
* Issue #500 - Use Enums instead of String for sourceType and destinationType in block mappings

##### Fixes

* Issue #489 - Race Condition in DefaultEndpointURLResolver - Thank you - @rvesselinov
* Issue #501 - Avoid using printStackTrace() for exception logging


### 2.0.7

**Released:** Oct 28, 2015 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#207)

##### Enhancements/Improvements

* Issue #479 - Support for Identity V3 - Thank you - @auhlig
* Issue #474 - NetQuotaService does not accept/return security_group and security_group_rule quota - Thank you @abareghi
* Issue #390 - Support for newest Service Versions

##### Fixes

* Issue #485 - Not returning sub-directories under a directory in Swift - Thank you - @sbcd90
* Issue #470 - Create (boot) server call fails against DevStack due to optional parameters in JSON payload in the request
* Issue #458 - java.lang.NullPointerException when getting servers list - Thank you @symcssn
* Issue #448 - RACKSPACE: Unable to Find Supported Services

### 2.0.6

**Released:** Oct 5, 2015 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#206)

##### Enhancements/Improvements

* Issue #450 - Make configDrive() accessible from Server Create builder - Thank you - @imclem

##### Fixes

* Issue #459 - NPE from keystone v3 re-auths - Thank you - @symcssn
* Issue #446 - DLPayload does not return proper response to allow proper handling - Thank you @symcssn
* Issue #444 - OSAuthenticator.authenticateV3 does not reauthenticate properly - Thank you @symcssn

### 2.0.5

**Released:** Aug 23, 2015 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#205)

##### Enhancements/Improvements

* Issue #439 - Add query parameters to delete and put options for large objects - Thank you - @frsyuki
* Issue #438 - Add support for RAX API key authentication extension - Thank you - @frsyuki
* Issue #437 - Add support to list available zone list - Thank you - @csm1sh
* Issue #436 - New commands for blockVolume - Thank you - @pompinis
* Issue #431 - Added docker container format - Thank you - @maseev

##### Fixes

* Issue #424 - Create server error through blockDeviceMappingBuilder
* Issue #410 - Create instance boot from image（create a new volume）

### 2.0.4

**Released:** July 14, 2015 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#204)

##### Enhancements/Improvements

* [Issue #392](https://github.com/gondor/openstack4j/issues/392) - Allow HttpClient interceptor to allow for custom configuration prior to client creation
* [Issue #366](https://github.com/gondor/openstack4j/issues/366) - Identity v3 scoped auth token
* [Issue #358](https://github.com/gondor/openstack4j/issues/358) - Create OSClient from auth_token
* [Issue #352](https://github.com/gondor/openstack4j/issues/352) - Ability to set Proxy information within OpenStack4j Config
* [Issue #350](https://github.com/gondor/openstack4j/issues/350) - Add support to determine if Ceilometer is installed
* [Issue #349](https://github.com/gondor/openstack4j/issues/349) - Update LBaaS to use Enums instead of String values
* [Issue #348](https://github.com/gondor/openstack4j/issues/348) - Neutron (FwaaS) Firewall Policy API & Test Cases (Completed API)
* [Issue #343](https://github.com/gondor/openstack4j/issues/343) - Add filter support when listing Volume and Volume Snapshot
* [Issue #340](https://github.com/gondor/openstack4j/issues/340) - Support for Network Extension: Firewall As a Service (FwaaS)
* [Issue #337](https://github.com/gondor/openstack4j/issues/337) - Enhancement Request: ability to fetch ALL metadata for objects/containers
* [Issue #332](https://github.com/gondor/openstack4j/issues/332) - Refactor HttpClient Connector to use singleton of the Apache HttpClient 

##### Fixes

* [Issue #420](https://github.com/gondor/openstack4j/issues/420) - Bug fix for the get_files. The key should be the file name
* [Issue #418](https://github.com/gondor/openstack4j/issues/418) - Bugs regarding updating object metadata
* [Issue #414](https://github.com/gondor/openstack4j/issues/414) - FlavorServiceImpl.listExtraSpecs NullPointerException
* [Issue #413](https://github.com/gondor/openstack4j/issues/413) - ObjectStorageObjectServiceImpl.get(ObjectLocation) throws NPE 
* [Issue #412](https://github.com/gondor/openstack4j/issues/412) - httpclient connector leaks connections on failed authentication attempts and eventually hangs
* [Issue #411](https://github.com/gondor/openstack4j/issues/411) - [Partial Fix] Connection leak from usage of BaseOpenStackService.Invocation.executeWithResponse()
* [Issue #403](https://github.com/gondor/openstack4j/issues/403) - The KeystoneServiceEndpoint miss @JsonRootName("endpoint")
* [Issue #401](https://github.com/gondor/openstack4j/issues/401) - NullPointerException from listing operation and authentication operation
* [Issue #397](https://github.com/gondor/openstack4j/issues/397) - FloatingIPServiceImpl.create don't need floatingIp.getPortId()
* [Issue #394](https://github.com/gondor/openstack4j/issues/394) - HttpClient connection leak when processing Server Errors
* [Issue #393](https://github.com/gondor/openstack4j/issues/393) - The FlavorServiceImpl.removeTenantAccess method error
* [Issue #391](https://github.com/gondor/openstack4j/issues/391) - FlavorServiceImpl.getSpec /flavors/%s/os-extra_specs/%s/ uri error
* [Issue #376](https://github.com/gondor/openstack4j/issues/376) - Deserialization error with HttpURL connector 
* [Issue #373](https://github.com/gondor/openstack4j/issues/373) - Connection leak when using HttpClient connector
* [Issue #365](https://github.com/gondor/openstack4j/issues/365) - Compute: Add/Remove SecGroup 500 exception not caught.
* [Issue #360](https://github.com/gondor/openstack4j/issues/360) - Connection leak when using HttpClient connector
* [Issue #357](https://github.com/gondor/openstack4j/issues/357) - ObjectService.list(containerDoesNotExist) throws NullPointerException
* [Issue #356](https://github.com/gondor/openstack4j/issues/356) - Requests to Swift hang after 2nd request
* [Issue #336](https://github.com/gondor/openstack4j/issues/336) - Exception when deleting an unexisting Glance image
* [Issue #333](https://github.com/gondor/openstack4j/issues/333) - Default value set to 0 for NetSecurityGroupRules : port range
* [Issue #327](https://github.com/gondor/openstack4j/issues/327) - SwiftAccount account = os.objectStorage().account().get()
* [Issue #314](https://github.com/gondor/openstack4j/issues/314) - EofSensorInputStream throws JsonParseException for 404s. Also, inconsistent behavior of how 404s are handled

### 2.0.3

**Released:** April 17, 2015 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#203)

##### Enhancements/Improvements

* [Issue #322](https://github.com/gondor/openstack4j/issues/322) - Add MIGRATING to the Server Status Enumeration
* [Issue #321](https://github.com/gondor/openstack4j/issues/321) - Option to add headers in requests, esp. 'X-newest' in GET requests in swift
* [Issue #316](https://github.com/gondor/openstack4j/issues/316) - Expose error code in ActionResponse
* [Issue #308](https://github.com/gondor/openstack4j/issues/308) - Add PENDING_CREATE to Neutron Network State Enumeration
* [Issue #294](https://github.com/gondor/openstack4j/issues/294) - NetQuota : updateForTenant support request
* [Issue #272](https://github.com/gondor/openstack4j/issues/272) - Quota-Set for Block Storage 
* [Issue #267](https://github.com/gondor/openstack4j/issues/267) - Configuring connection pooling feature for underlying client connectors

##### Fixes

* [Issue #326](https://github.com/gondor/openstack4j/issues/326) - BlockStorageVolumeBuilder : allow availability_zone to be set
* [Issue #329](https://github.com/gondor/openstack4j/issues/329) - Update default quotaSet shows exception
* [Issue #325](https://github.com/gondor/openstack4j/issues/325) - Volumes metadata is not set due to wrong parameter name sent from OS4j 
* [Issue #323](https://github.com/gondor/openstack4j/issues/323) - Setting external gateway to router in api returns not authorized, but the same is allowed via CLI
* [Issue #307](https://github.com/gondor/openstack4j/issues/307) - Unable to catch assign floating IP error
* [Issue #295](https://github.com/gondor/openstack4j/issues/295) - Exception while updating quota for tenant
* [Issue #292](https://github.com/gondor/openstack4j/issues/292) - CreatePort command not working properly

### 2.0.2

**Released:** March 18, 2015 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#202)

##### Enhancements/Improvements

* [Issue #290](https://github.com/gondor/openstack4j/issues/290) - Update OKHttp Connector to version 2.3.0
* [Issue #289](https://github.com/gondor/openstack4j/issues/289) - AbsoluteLimit: `maxServerGroups` and `maxServerGroupMembers` are missing
* [Issue #284](https://github.com/gondor/openstack4j/issues/284) - Extending ceilometer alarms functionality (thank you @e3ky)
* [Issue #278](https://github.com/gondor/openstack4j/issues/278) - Filtering of Attached Interfaces
* [Issue #264](https://github.com/gondor/openstack4j/issues/264) - Keystone v3 Authentication for Project Scope
* [Issue #258](https://github.com/gondor/openstack4j/issues/258) - Reset VM State support
* [Issue #255](https://github.com/gondor/openstack4j/issues/255) - HttpURLConnection connector option (thank you @krishnabrucelee)
* [Issue #247](https://github.com/gondor/openstack4j/issues/247) - Support to update Quotas for Tenant and Class
* [Issue #233](https://github.com/gondor/openstack4j/issues/233) - Ability to set criteria on Ceilometer Statistics
* [Issue #217](https://github.com/gondor/openstack4j/issues/217) - Support to build a shared network (thank you @octupszhang)
* [Issue #216](https://github.com/gondor/openstack4j/issues/216) - Telemetry API doesn't support alarms (thank you @e3ky)
* [Issue #216](https://github.com/gondor/openstack4j/issues/216) - Add support for Sahara data processing (thank you @ekasitk)
* [Issue #208](https://github.com/gondor/openstack4j/issues/208) - Support for LBaaS (Load-balancer as a service) (thank you @liujunpengwork)
* [Issue #203](https://github.com/gondor/openstack4j/issues/203) - Support Host aggregates (thank you @liujunpengwork)
* [Issue #187](https://github.com/gondor/openstack4j/issues/187) - Support for Volume Transfer
* [Issue #183](https://github.com/gondor/openstack4j/issues/183) - Heat: Nested templates (Files & Env) support for a Stack (thank you @magixyu)

##### Fixes

* [Issue #286](https://github.com/gondor/openstack4j/issues/286) - Error while downloading the object from container
* [Issue #285](https://github.com/gondor/openstack4j/issues/285) - ResetAction not working against a Server
* [Issue #282](https://github.com/gondor/openstack4j/issues/282) - Quota set volume & gigabytes is always 0 and instances and do not update
* [Issue #281](https://github.com/gondor/openstack4j/issues/281) - NeutronError while detaching interface is not caught
* [Issue #277](https://github.com/gondor/openstack4j/issues/277) - Option to clear gateway once set
* [Issue #268](https://github.com/gondor/openstack4j/issues/268) - RouterExternal flag missing in NetworkBuilder interface
* [Issue #263](https://github.com/gondor/openstack4j/issues/263) - Not closing response when 404 happens
* [Issue #262](https://github.com/gondor/openstack4j/issues/262) - Creating a Port by using an existing as a template (cloning) fails
* [Issue #261](https://github.com/gondor/openstack4j/issues/261) - Unable to pass SampleCriteria as a parameter in sample() method
* [Issue #257](https://github.com/gondor/openstack4j/issues/257) - VM Migration Exception (ActionResponse fault)
* [Issue #249](https://github.com/gondor/openstack4j/issues/249) - Unable to capture Create Subnet Error
* [Issue #241](https://github.com/gondor/openstack4j/issues/241) - HttpClient Connector: Assign/Remove floating IP to the server throws JsonMappingException
* [Issue #237](https://github.com/gondor/openstack4j/issues/237) - Rackspace URL for images are incorrectly determined
* [Issue #236](https://github.com/gondor/openstack4j/issues/236) - HP Cloud: Failed to create network port
* [Issue #234](https://github.com/gondor/openstack4j/issues/234) - Volumes cannot be used on HP Cloud
* [Issue #227](https://github.com/gondor/openstack4j/issues/227) - OSFactory.clientFromAccess(access) doesn't fetch admin scoped tenant/users
* [Issue #226](https://github.com/gondor/openstack4j/issues/226) - Creating Network on HP Cloud fails
* [Issue #225](https://github.com/gondor/openstack4j/issues/225) - NullPointerException in HttpExecutor when ServiceLoader finds no HttpExecutorService
* [Issue #222](https://github.com/gondor/openstack4j/issues/222) - ObjectStorage: file download
* [Issue #220](https://github.com/gondor/openstack4j/issues/220) - NetworkType enum doesn't support "vxlan" value
* [Issue #211](https://github.com/gondor/openstack4j/issues/211) - NullPointerException: Find Tenant By Name
* [Issue #201](https://github.com/gondor/openstack4j/issues/201) - Find a specific Tenant using getByName function raise exception

### 2.0.1

**Released:** Jan 11, 2015 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#201)

#### Enhancements/Improvements

* [Issue #182](https://github.com/gondor/openstack4j/issues/182) - os-availability-zone support
* [Issue #177](https://github.com/gondor/openstack4j/issues/177) - Heat: Nested template support - Thanks @magixyu
* [Issue #175](https://github.com/gondor/openstack4j/issues/175) - Implement os-floating-ip-dns resource
* [Issue #174](https://github.com/gondor/openstack4j/issues/174) - Neutron: Ability to set DNS Nameserver and Host Route within SubnetBuilder  
* [Issue #173](https://github.com/gondor/openstack4j/issues/173) - Ceilometer: Ability to specify 'project' in obtaining samples using SampleCriteria
* [Issue #171](https://github.com/gondor/openstack4j/issues/171) - Upload volume to image  
* [Issue #169](https://github.com/gondor/openstack4j/issues/169) - Update a neutron network
* [Issue #165](https://github.com/gondor/openstack4j/issues/165) - volume migrate and force delete support  
* [Issue #164](https://github.com/gondor/openstack4j/issues/164) - Interface attachment support

#### Fixes

* [Issue #181](https://github.com/gondor/openstack4j/issues/181) - Can't get VNCConsoleURL using RestEasy connector
* [Issue #172](https://github.com/gondor/openstack4j/issues/172) - ClassCastException with HttpClient-2.0.1 connecter while downloading image
* [Issue #163](https://github.com/gondor/openstack4j/issues/163)  - State vs Status in the NeutronPort
* [Issue #161](https://github.com/gondor/openstack4j/issues/161)  - Issue with attaching a Volume
* [Issue #160](https://github.com/gondor/openstack4j/issues/160) - Adding users to a tenant is not working

### 2.0.0

**Released:** Dec 9, 2014 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#200)

#### Enhancements/Improvements

* [Issue #155](https://github.com/gondor/openstack4j/issues/155) - Add flag to allow for Legacy endpoint handling (has broken some users)
* [Issue #154](https://github.com/gondor/openstack4j/issues/154) - Ceilometer - Support query criteria when retrieving samples
* [Issue #152](https://github.com/gondor/openstack4j/issues/152) - Add ability to dynamically change Endpoint URL for NAT Firewalls
* [Issue #150](https://github.com/gondor/openstack4j/issues/150) - Heat - ability to retreive raw JSON/Yaml template for a Stack
* [Issue #145](https://github.com/gondor/openstack4j/issues/145) - Enabled wire logging for HttpClient based connectors
* [Issue #128](https://github.com/gondor/openstack4j/issues/128) - Heat - ability to update a Stack
* [Issue #125](https://github.com/gondor/openstack4j/issues/125) - Compute - update a server (instance) name
* [Issue #120](https://github.com/gondor/openstack4j/issues/120) - Compute - flavor extra spec support for scheduler hints
* [Issue #114](https://github.com/gondor/openstack4j/issues/114) - Support for SPICE Html5 console
* PR    #107 - Server group support - Thank you @octupszhang
* [Issue #105](https://github.com/gondor/openstack4j/issues/105) - Full server metadata support
* [Issue #102](https://github.com/gondor/openstack4j/issues/102) - Support for backup server action
* [Issue #101](https://github.com/gondor/openstack4j/issues/101) - Limits for Cinder and Neutron
* [Issue #98](https://github.com/gondor/openstack4j/issues/98) - API Support for Object Store (Swift)
* [Issue #87](https://github.com/gondor/openstack4j/issues/87) - Software Configuration support for HEAT
* [Issue #85](https://github.com/gondor/openstack4j/issues/85) - Support for os-migrations extension
* [Issue #83](https://github.com/gondor/openstack4j/issues/83) - Live server migration
* [Issue #79](https://github.com/gondor/openstack4j/issues/79) - Support for OKHttp connector
* [Issue #77](https://github.com/gondor/openstack4j/issues/77) - Log4j and SLF4j Plugin support
* [Issue #71](https://github.com/gondor/openstack4j/issues/71) - Support for other connector choices (Jersey2, Resteasy, HttpClient)
* [Issue #70](https://github.com/gondor/openstack4j/issues/70) - Upgrade Jersey from 2.0 to 2.10.1
* [Issue #69](https://github.com/gondor/openstack4j/issues/69) - Break out our current connector (Jersey) into a sub-module to offer various connector choices
* [Issue #67](https://github.com/gondor/openstack4j/issues/67) - Upgrade Jackson 1 to Jackson 2
* [Issue #33](https://github.com/gondor/openstack4j/issues/33) - Ability to specify a custom socket factory and host name verifier

#### Fixes

* [Issue #148](https://github.com/gondor/openstack4j/issues/148) - Compute: Creating a key-pair without specifying public key does not return auto-created private key
* [Issue #147](https://github.com/gondor/openstack4j/issues/147) - API version is not set in service URL when using HTTPS
* [Issue #146](https://github.com/gondor/openstack4j/issues/146) - Bad request when using HTTPS
* [Issue #142](https://github.com/gondor/openstack4j/issues/142) - Creating a volume from ImageRef returns volume object without populating original reference
* [Issue #135](https://github.com/gondor/openstack4j/issues/135) - Deleting Non-existent KeyPair yields: Can not deserialize instance of java.lang.String out of START_OBJECT token
* [Issue #134](https://github.com/gondor/openstack4j/issues/134) - JDK 1.6 compatibility support option with Jersey 2 connector
* [Issue #131](https://github.com/gondor/openstack4j/issues/131) - Regression: Error adding a floating IP
* [Issue #130](https://github.com/gondor/openstack4j/issues/130) - NPE when creating a new Network
* [Issue #129](https://github.com/gondor/openstack4j/issues/129) - Unable to add a user to a tenant using RestEasy connector
* [Issue #127](https://github.com/gondor/openstack4j/issues/127) - Strange return value for Server.getOsExtendedVolumesAttached
* [Issue #117](https://github.com/gondor/openstack4j/issues/117) - SecGroupExtension.Rule.IPProtocol can be null instead of ANY or UNRECOGNIZED
* [Issue #116](https://github.com/gondor/openstack4j/issues/116) - Some methods in Service classes return void instead of ActionResponse
* [Issue #115](https://github.com/gondor/openstack4j/issues/115) - Method waitForServerStatus throws NPE
* [Issue #113](https://github.com/gondor/openstack4j/issues/113) - Return value for deallocateIP is void instead of ActionResponse
* [Issue #111](https://github.com/gondor/openstack4j/issues/111) - Writer errors when using the resteasy-connector
* [Issue #106](https://github.com/gondor/openstack4j/issues/106) - ActionResponse status is incorrect for addFloatingIP
* [Issue #103](https://github.com/gondor/openstack4j/issues/103) - Issue when updating a port in network
* [Issue #97](https://github.com/gondor/openstack4j/issues/97) - Yaml based template ignored in Stack creation
* [Issue #95](https://github.com/gondor/openstack4j/issues/95) - Easy determination within an Image to determine if it's a snapshot of a volume
* [Issue #93](https://github.com/gondor/openstack4j/issues/93) - Error listing images (Error reading entity from input stream)
* [Issue #92](https://github.com/gondor/openstack4j/issues/92) - Problems in deserializing an object (Heat Stack)
* [Issue #91](https://github.com/gondor/openstack4j/issues/91) - Implementation of the method "getHosts()" in the class availabilityZoneList
* [Issue #90](https://github.com/gondor/openstack4j/issues/90) - Volume Status "downloading" not recognized
* [Issue #75](https://github.com/gondor/openstack4j/issues/75) - NPE in NeutronNetwork
* [Issue #20](https://github.com/gondor/openstack4j/issues/20) - Glance - creating a large image throws out of memory error

### 1.0.2

**Released:** Oct 1, 2014 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#102)

#### Enhancements/Improvements

* Heat Orchestration Support
* [Issue #65](https://github.com/gondor/openstack4j/issues/65) - Instance rebuild with options support
* [Issue #56](https://github.com/gondor/openstack4j/issues/56) - Set userdata when creating a server
* [Issue #34](https://github.com/gondor/openstack4j/issues/34), [Issue #27](https://github.com/gondor/openstack4j/issues/27) - Support for HP Cloud / Identity V3 authentication
* [Issue #45](https://github.com/gondor/openstack4j/issues/45) - Seamless retry/auto-renew support when a token has expired. Will re-execute original request after renewal
* [Issue #15](https://github.com/gondor/openstack4j/issues/15) - Ability to specify a Region to call against
* [Issue #26](https://github.com/gondor/openstack4j/issues/26) - Ability to set Availibility Zone to a Server
* [Issue #19](https://github.com/gondor/openstack4j/issues/19) - Boot and Wait for Server to become ACTIVE based upon max wait time
 

#### Fixes
* [Issue #58](https://github.com/gondor/openstack4j/issues/58) - Server status "SHUTOFF" showing as UNRECOGNIZED enum value on query
* [Issue #50](https://github.com/gondor/openstack4j/issues/50) - List of SecurityGroupRule returns null
* [Issue #49](https://github.com/gondor/openstack4j/issues/49) - Listing of servers error in some environments
* [Issue #18](https://github.com/gondor/openstack4j/issues/18) - Network Facing Perspectives to determine endpoint resolution
* [Issue #5](https://github.com/gondor/openstack4j/issues/5), #47 PR - Availability Zones listing

### 1.0.1

**Released:** June 6, 2014 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#101)

* Block Storage (Cinder) support
* Floating IP/Pools support in Compute
* VNC and Console Output support in Compute -> Servers
* Personality support on Compute -> Server -> Create
* Security Group & Rules in Compute
* Keypair support
* Floating IP in Network
* Security Groups & Rules in Network
* Telemetry (Ceilometer) support

### 1.0.0

**Released:** April 2, 2014 :: [Changelog on GitHub](https://github.com/gondor/openstack4j/blob/master/CHANGELOG.md#100)

* Initial public release
