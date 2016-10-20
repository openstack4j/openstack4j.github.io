# Trove (Database as a service)

## Databases
#### List Instance Databases

To list all the databases present on the database instance see the example below:

{:.prettyprint .lang-java}
    List<? extends Database> databases = osv2().trove()
                .databaseService().list(databaseInstanceId);

#### Create Database

To create a database see the example below:

{:.prettyprint .lang-java}
    TroveBuilders troveBuilders = new TroveBuilders();
    TroveDatabase database = (TroveDatabase)troveBuilders
                .databaseCreate().name("dbName").build();
    Databases troveDatabases = new Databases();
    List<TroveDatabase> troveDatabaseList = new ArrayList<>();
    troveDatabaseList.add(database);
    troveDatabases.setTroveDatabaseList(troveDatabaseList);
    ActionResponse result = osv2().trove()
                .databaseService()
                .create(databaseInstanceId, troveDatabases);

#### Delete Database

To delete a database see the example below:

{:.prettyprint .lang-java}
    ActionResponse result = osv2().trove()
                .databaseService().delete(databaseInstanceId, dbName);



## Database Users
#### List Database Users

To list all the users for the database see the example below:

{:.prettyprint .lang-java}
    List<? extends DatabaseUser> databaseUsers = osv2().trove()
                .databaseUsersService().list(databaseInstanceId);

#### Create Database User

To create a user for the database see the example below:

{:.prettyprint .lang-java}
    TroveBuilders troveBuilders = new TroveBuilders();
    TroveDatabaseUser databaseUser = (TroveDatabaseUser)troveBuilders
                .databaseUserCreate().username("dbName")
                .password("password").build();
    List<TroveDatabaseUser> troveDatabaseUsers = new ArrayList<>();
    troveDatabaseUsers.add(databaseUser);
    DatabaseUsers databaseUsers = new DatabaseUsers();
    databaseUsers.setTroveDatabaseUserList(troveDatabaseUsers);
    ActionResponse result = osv2().trove()
                .databaseUsersService()
                .create(databaseInstanceId, databaseUsers);

#### Delete Database User

To delete the database user see the example below:

{:.prettyprint .lang-java}
    ActionResponse result = osv2().trove()
                .databaseUsersService().delete(databaseId, "dbUserName");



## Flavors
#### List Flavors

To retrieve all the available database instance flavors see the example below:

{:.prettyprint .lang-java}
    List<? extends Flavor> flavors = osv2().trove().flavorService().list();

#### Show Flavor Details

To retrieve details specific to a flavor see the example below:

{:.prettyprint .lang-java}
    Flavor flavor = osv2().trove().flavorService().get(flavorId);



## Datastores
#### List Datastores

To retrieve all the datastores available to the tenant see the example below:

{:.prettyprint .lang-java}
    List<? extends Datastore> datastores = osv2().trove()
                .datastoreService().list();

#### Show Datastore Details

To retrieve details specific to a datastore see the example below:

{:.prettyprint .lang-java}
    Datastore datastore = osv2().trove().datastoreService().get(datastoreId);

#### List Datastore Versions

To list all the available datastore versions see the example below:

{:.prettyprint .lang-java}
    List<? extends DatastoreVersion> datastoreVersions = osv2().trove()
                .datastoreService().listDatastoreVersions(datastoreId);

#### Show Datastore Version Details

To retrieve details specific to a datastore version see the example below:

{:.prettyprint .lang-java}
    DatastoreVersion datastoreVersion = osv2().trove()
                .datastoreService()
                .getDatastoreVersion(datastoreId, datastoreVersionId);

