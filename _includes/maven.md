
If you are a Maven user just add the library as a dependency:

#### Latest Release (Stable)

{:.prettyprint .lang-xml}
	<dependency>
	  <groupId>org.pacesys</groupId>
	  <artifactId>openstack4j</artifactId>
	  <version>{{ site.version }}</version>
	</dependency>

#### Snapshots (Current Development)

**Current Beta Snapshot**

{:.prettyprint .lang-xml}
	<dependency>
	  <groupId>org.pacesys</groupId>
	  <artifactId>openstack4j</artifactId>
	  <version>{{ site.snapshot-version }}</version>
	</dependency>

**Snapshot with Dependencies (all in one jar)**

{:.prettyprint .lang-xml}
	<dependency>
	  <groupId>org.pacesys</groupId>
	  <artifactId>openstack4j</artifactId>
	  <version>{{ site.snapshot-version }}</version>
	  <classifier>withdeps</classifier>
	</dependency>

<br>
<b>NOTE:</b> Snapshots are not sync'd with maven central.  To allow Maven to properly resolve the latest snapshot you will need to add the sonatype repository:
	
{:.prettyprint .lang-xml}
	<repositories>
	    <repository>
	      <id>st-snapshots</id>
	      <name>sonatype-snapshots</name>
	      <url>https://oss.sonatype.org/content/repositories/snapshots</url>
	    </repository>
	</repositories>
	

**Example Maven project setup**

{:.prettyprint .lang-xml}
	<?xml version="1.0" encoding="UTF-8"?>
	<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	  <modelVersion>4.0.0</modelVersion>
	  <groupId>com.mycompany.cloudapp</groupId>
	  <artifactId>my-cloudapp</artifactId>
	  <version>1.0.0-SNAPSHOT</version>
	  <dependencies>
	    <dependency>
	        <groupId>org.pacesys</groupId>
	        <artifactId>openstack4j</artifactId>
		    <version>{{ site.snapshot-version }}</version>
	      </dependency>
	  </dependencies>
	</project>

If you are not familiar with Apache Maven but would like to try it, when we recommend reading [Maven in 5 Minutes](http://maven.apache.org/guides/getting-started/maven-in-five-minutes.html)