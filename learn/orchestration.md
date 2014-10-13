---
layout: content
menu: learn
title: Orchestration (Heat)
---

# Orchestration (Heat)

Orchestration (Heat) is a service that you can use to orchestrate multiple composite cloud applications. Using OpenStack4j you can control Stacks, Templates, Resources and Events. 

## Stacks

A stack is a model that holds a template, parameters and other meta data related to it's purpose.  See some of the examples below on common stack usages found within the API.

#### Creating a Stack

To create and launch a stack see the example below:

**Using a Builder**

{:.prettyprint .lang-java}
	Stack stack = os.heat().stacks().create(Builders.stack()
                                              .name("Stack Name")
                                              .jsonTemplate(template)
                                              .parameters(params)
                                              .timeoutMins(5).build());


**Calling with arguments**

{:.prettyprint .lang-java}
    Stack stack = os.heat().stacks().create(name, template, params, disableRollback, timeoutMins);

#### Deleting a Stack

{:.prettyprint .lang-java}
    os.heat().stacks().delete(stackName, id);

#### Finding details about a Stack

{:.prettyprint .lang-java}
    Stack stack = os.heat().stacks().getDetails(stackName, id);

#### List available Stacks

{:.prettyprint .lang-java}
    List<? extends Stack> stacks = os.heat().stacks().list();

## Templates

OpenStack4j supports template validation which allows you to test acceptance when creating a stack.


#### Template Validation

There are two ways to validate a template.  You can validate the template in String form or as a Template object.

**Input as a String**

{:.prettyprint .lang-java}
   String result = os.heat().templates().validateTemplate(templateString);

**Input as a Template**

{:.prettyprint .lang-java}
    String result = os.heat().templates().validateTemplate(template);

	
## Resources

Below are methods for finding resources associated with Stacks

#### Finding a Resource

{:.prettyprint .lang-java}
    Resource resource = os.heat().resources().show(stackName, id, resourceName);

#### Listing Resources for a Given Stack

{:.prettyprint .lang-java}
    List<? extends Resource> resources = os.heat().resources().list(stackName, id);


## Events

Events are useful for detecting errors or deployment problems within a Stack. Below are examples of the events API for Heat services.

#### Listing Events for a Stack

**All Events for a Stack**

{:.prettyprint .lang-java}
    List<? extends Event> events = os.heat().events().list(stackName, id);

**All Events for a Stack and corresponding Resource**

{:.prettyprint .lang-java}
    List<? extends Event> events = os.heat().events().list(stackName, id, resourceName);

#### Looking up an Event

{:.prettyprint .lang-java}
    Event event = os.heat().events().show(stackName, id, resourceName, eventId);

