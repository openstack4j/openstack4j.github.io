---
layout: content
menu: learn
title: Trove (Database as a service)
nav: dbaas
---

# Trove (Database as a service)

Openstack's Trove which is Database as a service on cloud intends to reduce complex and repetitive administrative tasks related to database management and maintenance. Tasks involve operations such as- Database instance deployments, database creation, configuration, periodic backups of database instances, patching. It also involves continuous health monitoring for database instances.

## Database Instance

It is the instantiation of a particular datastore image and version.

**Create Database Instance**

{:.prettyprint .lang-java}
    InstanceCreate instanceCreate = Builders.trove()
                .instanceCreate().name("testInstance").flavor("1")
                .volumeSize(6).build();
    Instance instance = os.trove().instanceService().create(instanceCreate);



## Databases

It is the actual SQL/NoSQL database created on the database instance that can be consumed by the database users or applications.

**List Instance Databases**

To list all the databases present on the database instance see the example below:

{:.prettyprint .lang-java}
    List<? extends Database> databases = os().trove()
                .databaseService().list(databaseInstanceId);

**Create Database**

To create a database see the example below:

{:.prettyprint .lang-java}
    TroveBuilders troveBuilders = new TroveBuilders();
    TroveDatabase database = (TroveDatabase)troveBuilders
                .databaseCreate().name("dbName").build();
    Databases troveDatabases = new Databases();
    List<TroveDatabase> troveDatabaseList = new ArrayList<>();
    troveDatabaseList.add(database);
    troveDatabases.setTroveDatabaseList(troveDatabaseList);
    ActionResponse result = os().trove()
                .databaseService()
                .create(databaseInstanceId, troveDatabases);

**Delete Database**

To delete a database see the example below:

{:.prettyprint .lang-java}
    ActionResponse result = os().trove()
                .databaseService().delete(databaseInstanceId, dbName);



## Database Users

It is a user created for the database. Username-Password pair is used to create a database user.

**List Database Users**

To list all the users for the database see the example below:

{:.prettyprint .lang-java}
    List<? extends DatabaseUser> databaseUsers = os().trove()
                .databaseUsersService().list(databaseInstanceId);

**Create Database User**

To create a user for the database see the example below:

{:.prettyprint .lang-java}
    TroveBuilders troveBuilders = new TroveBuilders();
    TroveDatabaseUser databaseUser = (TroveDatabaseUser)troveBuilders
                .databaseUserCreate().username("userName")
                .password("password").build();
    List<TroveDatabaseUser> troveDatabaseUsers = new ArrayList<>();
    troveDatabaseUsers.add(databaseUser);
    DatabaseUsers databaseUsers = new DatabaseUsers();
    databaseUsers.setTroveDatabaseUserList(troveDatabaseUsers);
    ActionResponse result = os().trove()
                .databaseUsersService()
                .create(databaseInstanceId, databaseUsers);

**Delete Database User**

To delete the database user see the example below:

{:.prettyprint .lang-java}
    ActionResponse result = os().trove()
                .databaseUsersService().delete(databaseId, dbUserName);

**Grant User DB Access**

To grant user access to list of databases

{:.prettyprint .lang-java}
    Databases troveDatabases = new Databases();
    List<TroveDatabase> troveDatabaseList = new ArrayList<>();
    troveDatabaseList.add(database);
    troveDatabases.setTroveDatabaseList(troveDatabaseList);
    ActionResponse actionResponse = os.trove()
                .databaseUsersService()
                .grantUserDBAccess(databaseInstanceId, dbUserName, troveDatabases);

**Revoke User DB Access**

To revoke user access on a particular database

{:.prettyprint .lang-java}
    ActionResponse actionResponse = os.trove()
                .databaseUsersService()
                .revokeUserDBAccess(databaseInstanceId, dbUserName, dbName);



## Flavors

A flavor is similar to a Nova instance flavor. It is specification of CPU and RAM details for the instance that will host and run the databases.

**List Flavors**

To retrieve all the available database instance flavors see the example below:

{:.prettyprint .lang-java}
    List<? extends Flavor> flavors = os().trove().flavorService().list();

**Show Flavor Details**

To retrieve details specific to a flavor see the example below:

{:.prettyprint .lang-java}
    Flavor flavor = os().trove().flavorService().get(flavorId);



## Datastores

A datastore is a RDBMS or a NoSQL database image that trove can manage. A datastore version defines the version of database package installed and is linked to the datastore. For eg - MySQL 5.5.

**List Datastores**

To retrieve all the datastores available to the tenant see the example below:

{:.prettyprint .lang-java}
    List<? extends Datastore> datastores = os().trove()
                .datastoreService().list();

**Show Datastore Details**

To retrieve details specific to a datastore see the example below:

{:.prettyprint .lang-java}
    Datastore datastore = os().trove().datastoreService().get(datastoreId);

**List Datastore Versions**

To list all the available datastore versions see the example below:

{:.prettyprint .lang-java}
    List<? extends DatastoreVersion> datastoreVersions = os().trove()
                .datastoreService().listDatastoreVersions(datastoreId);

**Show Datastore Version Details**

To retrieve details specific to a datastore version see the example below:

{:.prettyprint .lang-java}
    DatastoreVersion datastoreVersion = os().trove()
                .datastoreService()
                .getDatastoreVersion(datastoreId, datastoreVersionId);

