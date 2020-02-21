---
layout: content
menu: learn
title: Compute / Floating IP DNS
nav: compute
---

# Floating IP DNS Extension

The floating IP DNS extension (os-floating-ip-dns) allows you to manage DNS records associated by the floating IPs extension.  Requests are dispatched to a DNS driver selected at startup.  

For more information see: [http://docs.openstack.org/api/openstack-compute/2/content/ext-os-floating-ip-dns.html](http://docs.openstack.org/api/openstack-compute/2/content/ext-os-floating-ip-dns.html)
<br>
<br>

### Managing Domains

**Lists registered DNS domains published by the DNS drivers**

```java
List<? extends DomainEntry> domains = os.compute().floatingIPDNS().domains().list();
```
	
**Creating or Updating a Public Domain Entry**

```java
DomainEntry domain = os.compute().floatingIPDNS().domains().createPublic("openstack4j.com", "project1");
```

**Creating or Updating a Private Domain Entry**

```java
DomainEntry domain = os.compute().floatingIPDNS().domains().createPrivate("openstack4j.com", "zone1");
```

**Deleting a Domain Entry**

```java
ActionResponse resp = os.compute().floatingIPDNS().domains().delete("openstack4j.com");
```

### Managing DNS Entries

**Finds a unique DNS entry for a specified domain and name**

```java
List<? extends DNSEntry> entries = os.compute().floatingIPDNS()
        .entries().listByName("openstack4j.com", "name");
```

**Lists DNS entries for a specified domain and IP**

```java
List<? extends DNSEntry> entries = os.compute().floatingIPDNS()
        .entries().listByIP("openstack4j.com", "10.0.0.200");
```

**Creating a DNS Entry**

```java
DNSEntry entry = os.compute().floatingIPDNS()
        .entries().create("openstack4j.com", "name", "10.0.0.200", DNSRecordType.A);
```
	
**Modifying a records IP Address**

```java
DNSEntry entry = os.compute().floatingIPDNS()
        .entries().modifyIP("openstack4j.com", "name", "10.0.0.201");
```

**Deleting a DNS Entry**

```java
ActionResponse resp = os.compute().floatingIPDNS()
        .entries().delete("openstack4j.com", "name");
```
