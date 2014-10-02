---
layout: content
menu: learn
title: Telemetry (Ceilometer)
---

# Telemetry (Ceilometer)

Telemetry (Ceilometer) provides metering and statistics.  It is proficient in collecting of metering data, in terms of CPU and network costs.  Ceilometer can establish metering across all the current OpenStack core components.  

## Meters

A meter is a category of measurements.  Think of it as a metric on KPI.  For a full list of meters please refer to the (OpenStack Ceilometer Meter WIKI)[http://docs.openstack.org/developer/ceilometer/measurements.html#dynamically-retrieving-the-meters-via-ceilometer-client]

#### List available Meters

To retrieve all known meters see the example below:

{:.prettyprint .lang-java}
	List<? extends Meter> meters = os.telemetry().meters().list();
	


## Samples

A sample represents a single numeric datapoint, driving a Meter that represents changes in that value over time.  Samples are then used to compute statistics which is provides a summary of average, min, max and counts.

#### List Samples for a Meter

To obtain a list of current Sample Data you must provide the meter name you wish to query for.  See the example below:

{:.prettyprint .lang-java}
	List<? extends Sample> samples = os.telemetry().meters().samples("cpu_util");


	
## Statistics

Statistics are computed based on samples. They can be computed against all current samples for a paticular meter, time range and grouping.  

#### Get all computed Statistics for a Meter 

The example below will query for all samples and compute the statistics against them for the specified meter.

{:.prettyprint .lang-java}
	List<? extends Statistics> stats = os.telemetry().meters().statistics("cpu_util");

#### Get computed Statistics for a Meter based on a Time Period

To get a computation based on a query you can pass in the period.  The period is defined in seconds.  See the example below

{:.prettyprint .lang-java}
	List<? extends Statistics> stats = os.telemetry().meters().statistics("cpu_util", 320);
