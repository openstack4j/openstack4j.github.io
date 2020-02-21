---
layout: content
menu: learn
title: Magnum
nav: magnum
---

# Magnum (Container Infrastructure Management service)

Magnum is an OpenStack API service developed by the OpenStack Containers Team making container orchestration engines such as Docker Swarm, Kubernetes, and Apache Mesos available as first class resources in OpenStack. Magnum uses Heat to orchestrate an OS image which contains Docker and Kubernetes and runs that image in either virtual machines or bare metal in a cluster configuration. 

**NOTE**: The ```os``` used here is an instance of ```org.openstack4j.api.OSClient.OSClientV3```.


## Baymodel

Baymodel acts as a template that defines options such as the container orchestration engine, keypair and image for use when Magnum is creating Bay using the given Baymodel.

**List baymodels**
```java
List<? extends Baymodel> res = os.magnum().listBaymodels();
```

**Creating a baymodel**
```java
Baymodel res = os.magnum().createBaymodel(baymodel);
```

**Delete a baymodel**
```java
Baymodel res = os.magnum().deleteBaymodel(baymodelId);
```

**Show a baymodel**
```java
Baymodel res = os.magnum().showBaymodel(baymodelId);
```

**Update a baymodel**
```java
Baymodel res = os.magnum().updateBaymodel(baymodelId, ops);
```

## Bay

**List bays**
```java
List<? extends Bay> res = os.magnum().listBays();
```

**Create a bay**
```java
Bay res = os.magnum().createBay(bay);
```

**Delete a bay**
```java
ActionResponse res = os.magnum().deleteBay(bayId);
```

**Show a bay**
```java
Bay res = os.magnum().showBay(baymodelId);
```

## Container

**List containers**
```java
List<? extends Container> res = os.magnum().showBay(baymodelId);
```

**Create a container**
```java
Container res = os.magnum().createContainer(container);
```

**Delete a container**
```java
ActionResponse res = os.magnum().deleteContainer(uuid);
```

**Get logs of a container**
```java
String res = os.magnum().getContainerLogs(id);
```

**Start a container**
```java
Container res = os.magnum().startContainer(id);
```

**Stop a container**
```java
Container res = os.magnum().stopContainer(id);
```

**Reboot a container**
```java
Container res = os.magnum().rebootContainer(id);
```

**Pause a container**
```java
Container res = os.magnum().pauseContainer(id);
```

**Unpause a container**
```java
Container res = os.magnum().unpauseContainer(id);
```

**Execute a command in a container**
```java
String res = os.magnum().execCmdInContainer(id, cmd);
```

**Show a container**
```java
Container res = os.magnum().showContainer(id);
```
