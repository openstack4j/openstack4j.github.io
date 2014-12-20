---
layout: content
menu: learn
title: Compute / Keypairs
nav: compute
---

# Keypairs

A keypair is a name and public key.  This is also known as an SSH key. Below are various examples in managing Keypair's.
<br>

### Querying for Keypair's

Keypair's have no identifier like other OpenStack object.  Keypair's are queried by their name which is unique.  See the examples below on listing and getting keypair's by name.
<br>

{:.prettyprint .lang-java}
	// Get all Keypairs the current account making the request has access to
	List<Keypair> kps = os.compute().keypairs().list();
		
	// Get a Keypair by Name
	Keypair kp = os.compute().keypairs().get("admin-kp");

### Creating and Deleting Keypair's

See the examples below on how to create, generate and delete keypair's
<br>

**Creating a Keypair with a pre-generated public key**

{:.prettyprint .lang-java}
	Keypair kp = os.compute().keypairs().create("my-keypair", publicKey);
	
**Creating a Keypair with a compute generated public key**

{:.prettyprint .lang-java}
	Keypair kp = os.compute().keypairs().create("my-keypair", null);
	
**Deleting a Keypair**

{:.prettyprint .lang-java}
	os.compute().keypairs().delete("my-keypair");


