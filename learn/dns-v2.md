---
layout: content
menu: learn
title: DNS (Designate) V2
nav: dns-v2
---

# DNS Service (Designate) V2

<div class="alert alert-warning"><b>NOTE:</b> The examples in this guide assume <a href="/learn/getting-started/#authenticate" class="alert-link"><b>you have authenticated</b></a></div>

The DNS (Designate) V2 service is a multi-tenant DNSaaS service for OpenStack.

## Zones


#### Creating Zones

```java
Zone zone = os.dns().zones().create(
                Builders.zone()
                    .name(ZONE_NAME)
                    .email(ZONE_EMAIL)
                    .ttl(ZONE_TTL)
                    .description(ZONE_DESCRIPTION)
                    .type(ZONE_TYPE)
                    .build());
```

#### Querying for Zones

**Find all Zones**

```java
List<? extends Zone> zoneList = os.dns().zones().list();
```

**Find a specific Zone**

```java
Zone zone = os.dns().zones().get(<zoneId>);
```

#### Updating a Zone

This example will change the description of the existing zone to `Updated zone description.` by looking up the zone and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

```java    
Zone zone = os.dns().zones().get(<zoneId>);
if (zone != null)
    zone = os.dns().zones().update(zone.toBuilder().description("Updated zone description.").build());
```

#### Deleting a Zone

This example will delete an existing zone specified by UUID

```java
os.dns().zones().delete(zone.getId());
```

## Recordsets

### Creating a Recordset

```java
Recordset recordset = os.dns().recordsets().create(
        Builders.recordset()
                .zoneId(<zoneId>)
                .name(<recordsetName)
                .type(<recordsetType>)
                .records(<records>)
        );
```

#### Querying for Recordsets

**Find all recordsets owned by project**

```java
List<? extends Recordset> recordsetList = os.dns().recordsets().list();
```

**Find all recordsets in a zone**
    
```java
List<? extends Recordset> recordsetListZone = os.dns().recordsets().list(<zoneId>);
```

**Find a specific recordset**

```java	
// Find in a zone by UUID
Recordset recordsetById = os.dns().recordsets().get(<zoneId>,<recordsetId>);
```

#### Updating a Recordset

This example will change the description of the existing recordset to `Updated recordset description.` by looking up the recordset and updating it. The example also shows the fluent nature of the API and how easy you can go to and from a mutable state via `builder`

```java
Recordset recordset = os.dns().recordsets().get(<zoneId>,<recordsetId>);
if (recordset != null)
    recordset = os.dns().recordsets().update(recordset.toBuilder().description("Updated recordset description.").build());
```

#### Deleting a Recordset

This example will delete an existing recordset specified by UUID

```java
os.dns().recordsets().delete(recordset.getId());
```
