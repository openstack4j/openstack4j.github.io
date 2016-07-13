---
layout: content
menu: learn
title: Multiple Threads using a single Client
nav: getting-started
---

# Using the Same Client Between Threads

Many users have asked how they utilize a singleton client in their applications between multiple threads.  Due to sessions being thread scoped we have listed an example allowing re-wiring of a token to instantiate a lightweight client (no re-authentication needed) in an alternate thread.

When using Identity V2:
{:.prettyprint .lang-java}
	// Grab the access from the client in the thread that did the authentication
	Access access = os.getAccess();

	// Spawn off a thread giving it the access
	myThreadExecutor.submit(new MyRunnableOrCallable(access));

	// Example of the Runnable or other object invoked in a new thread
	public class MyRunnable implements Runnable {
	     private OSClient clientV2;

	     public MyRunnable(Access access) {
	          clientV2 = OSFactory.clientFromAccess(access);
	     }

	    public void run() { 
	        // can now use the client :)
	    }
	}

When using Identity V3:
{:.prettyprint .lang-java}
	// Grab the token from the client in the thread that did the authentication
	Token token = os.getToken();

	// Spawn off a thread giving it the access
	myThreadExecutor.submit(new MyRunnableOrCallable(token));

	// Example of the Runnable or other object invoked in a new thread
	public class MyRunnable implements Runnable {
	     private OSClientV3 clientV3;

	     public MyRunnable(Access access) {
	          clientV3 = OSFactory.clientFromToken(token);
	     }

	    public void run() {
	        // can now use the client :)
	    }
	}


