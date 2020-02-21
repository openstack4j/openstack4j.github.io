
If you are a Maven user just add the library as a dependency:

### Latest Release (Stable)

Starting with version **3.0.0+** OpenStack4j now has the ability to choose the underlying connection framework.  By default the API's are configured to use the Jersey 2 connector.  See optional configuration scenarios below:

#### Default Setup (Using Jersey2 as the connector choice)

```xml
<dependency>
  <groupId>com.github.openstack4j.core</groupId>
  <artifactId>openstack4j</artifactId>
  <version>{{ site.version }}</version>
</dependency>
```

**With Dependencies (all in one jar)**

```xml
<dependency>
  <groupId>com.github.openstack4j.core</groupId>
  <artifactId>openstack4j</artifactId>
  <version>{{ site.version }}</version>
  <classifier>withdeps</classifier>
</dependency>
```

<br>

Using version **3.0.0+** of OpenStack4j offers support for the Identity (Keystone) V3 API.

#### Default Setup (Using Jersey2 as the connector choice)

```xml
<dependency>
  <groupId>com.github.openstack4j.core</groupId>
  <artifactId>openstack4j</artifactId>
  <version>{{ site.version }}</version>
</dependency>
```

**With Dependencies (all in one jar)**

```xml
<dependency>
  <groupId>com.github.openstack4j.core</groupId>
  <artifactId>openstack4j</artifactId>
  <version>{{ site.version }}</version>
  <classifier>withdeps</classifier>
</dependency>
```

<br>

#### Using a Connector of Your Choice

**1. Declare the openstack4j core dependency in your POM**

```xml
<dependency>
  <groupId>com.github.openstack4j.core</groupId>
  <artifactId>openstack4j-core</artifactId>
  <version>{{ site.version }}</version>
</dependency>
```

**2. Declare a connector**

```xml
<dependency>
  <groupId>com.github.openstack4j.core.connectors</groupId>
  <artifactId>[ connector artifactId ]</artifactId>
  <version>{{ site.version }}</version>
</dependency>
```

<div class="alert alert-info connectors"><b>Valid artifactId's are:</b> <code>openstack4j-jersey2</code>, <code>openstack4j-resteasy</code>, <code>openstack4j-okhttp</code>, <code>openstack4j-http-connector</code> and <code>openstack4j-httpclient</code></div>

### Snapshots (Current Development)

Usage of snapshots is the same as above except for the `version` tag.  Copy any of the *stable* declarations above that suit your environment and replace the version tag with `{{ site.snapshot-version }}`.

#### Snapshot Dependencies Repository Configuration

Snapshots are not sync'd with maven central.  To allow Maven to properly resolve the latest snapshot you will need to add the sonatype repository:

```xml
<repositories>
  <repository>
    <id>st-snapshots</id>
    <name>sonatype-snapshots</name>
    <url>https://oss.sonatype.org/content/repositories/snapshots</url>
  </repository>
</repositories>
```

**Example Maven project setup**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.mycompany.cloudapp</groupId>
  <artifactId>my-cloudapp</artifactId>
  <version>1.0.0-SNAPSHOT</version>
  <dependencies>
    <dependency>
      <groupId>com.github.openstack4j.core</groupId>
      <artifactId>openstack4j</artifactId>
      <version>{{ site.snapshot-version }}</version>
    </dependency>
  </dependencies>
</project>
```

If you are not familiar with Apache Maven but would like to try it, when we recommend reading [Maven in 5 Minutes](http://maven.apache.org/guides/getting-started/maven-in-five-minutes.html)
