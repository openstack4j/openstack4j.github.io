---
layout: content
menu: learn
title: What is OpenStack4j?
description: OpenStack4J is an open source library to manage OpenStack deployments
---

# What is OpenStack4j?

OpenStack4j is an open source library that helps you manage an OpenStack deployment.  It is a fluent based API giving you full control
over the various OpenStack services.  

OpenStack4j is broken out into several major API abstractions as Java libraries. 

<table class="table table-striped">
<tr><td><div class="imageLabel"><span class="glyphicon glyphicon-lock"></span> Identity</div></td><td>The Identity (Keystone) service provides the central directory of users, tenants, service endpoints and authorization.  This API is responsible for
	authenticating and providing access to all the other OpenStack services.  The API also enables administrators to configured centralized policies, users and tenants.</td></tr>
<tr><td><div class="imageLabel"><span class="glyphicon glyphicon-cog"></span> Compute</div></td><td>The Compute (Nova) service provides management to Servers (running virtual machines), VM Management, Flavors and diagnostics.  The API streamlines day to day management tasks and makes managing your cloud straight forward with the fluent design.</td></tr>
<tr><td><div class="imageLabel"><span class="glyphicon glyphicon-cloud-upload"></span> Image</div></td><td>The Image (Glance) service provides discovery, registration and delivery services for disk and server images.  Stored images can be used as a template for quickly booting new running instances via the Compute service.</td></tr>
<tr><td><div class="imageLabel"><span class="glyphicon glyphicon-signal"></span> Network</div></td><td>The Network (Neutron) service provides "network connectivity as a service" between interface devices managed by other OpenStack service, mainly Nova.  The API allows users to create their own networks and then attach interfaces to them.  The OpenStack4j implementation supports Routers, Ports, Subnets and Interface management.</td></tr>
<tr><td><div class="imageLabel"><span class="glyphicon glyphicon-hdd"></span> Block Storage</div></td><td>The Block Storage (Cinder) Service is a block-level storage solution that enables you to mount drives to scale storage.  OpenStack4j implementation fully supports all major operations.</td></tr>
<tr><td><div class="imageLabel"><span class="glyphicon glyphicon-stats"></span> Telemetry</div></td><td>Telemetry (Ceilometer) delivers metering and statistic measurements against OpenStack core components.  This is ideal for customer billing, account and reporting of resources. OpenStack4j implementation fully supports all major operations.</td></tr>
</table>

# Why should I use OpenStack4j?

OpenStack is a large system to manage. We have made it easy by providing a simplistic fluent API and intelligent error handling.  Some of the areas we have
focussed on to make your experience with OpenStack easy with less boiler-plate code are:

<table class="table table-striped">
<tr><td><div class="imageLabel"><span class="glyphicon glyphicon-ok"></span> Expected Results</div></td><td>All API calls that return a single object will be null if no data is found. Calls that return a List/Collection will return an empty list if not found.</td></tr>
<tr><td><div class="imageLabel"><span class="glyphicon glyphicon-pencil"></span> Fluent Interface</div></td><td>All calls are fluent by nature. To shorten fluent calls an interface can be assigned during the chain to shorten the calls.</td></tr>
<tr><td><div class="imageLabel"><span class="glyphicon glyphicon-tower"></span> Concrete API</div></td><td>All APIs are interface defined as well as corresponding models and builders. No need to ever refer to the implementation. Implementations are always defined within an "internal" package.</td></tr>
<tr><td><div class="imageLabel"><span class="glyphicon glyphicon-list"></span> Deployment Tested</div></td><td>All APIs have been tested and are used in various OpenStack environments.  This includes small and large multi-node deployments.  The main test focus has been around Havana and Grizzly releases of OpenStack.</td></tr>
<tr><td><div class="imageLabel"><span class="glyphicon glyphicon-warning-sign"></span> Exception Handling</div></td>
<td>
Exceptions will never be thrown for <strong><font color="red">404 (Not Found)</font></strong> See above for standards. Based on the OpenStack specifications of errors all exceptions extends a common unchecked ResponseException. Server and Client exceptions also have an enumerated type fully classifying the exact reason for failure. 
<p><br>
All Exceptions are unchecked and are broken up into 5 categories (All extend ResponseException):
<ul>
<li><strong>ServerResponseException</strong> - thrown if error codes are between 500 and 600.</li>
<li><strong>ClientResponseException</strong> - thrown if error codes are between 400 and 499 excluding 404.</li>
<li><strong>AuthenticationException</strong> - Credentials or initial login failure</li>
<li><strong>ConnectionException</strong> - I/O or HTTP based communication failure</li>
<li><strong>ResponseException</strong> - Base exception is for all other failures (communication).</li>
</ul>
</p>
</td>
</tr>
</table>