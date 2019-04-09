AUDITEL vocabulary
=================

AUDITEL is a private consortium that collects data about italian TV shows audience.

The namespace for auditel terms is **https://g0v-it.github.io/ontologies/auditel#**

Last Turtle RDF serialization is available in https://g0v-it.github.io/ontologies/auditel/v1.ttl

The auditel vocabulary is a semantic web application that builds upon the following RDF vocabularies:

- the [W3C RDF Data Cube Vocabulary](https://www.w3.org/TR/vocab-data-cube), to describe data observations and statistics.
- the [Data Catalog Vocabulary](https://www.w3.org/TR/vocab-dcat/) to describe the dataset metadata
- the [SKOS](https://www.w3.org/TR/skos-primer) to describe balance taxonomy.
- the [DCMI Metadata Terms](http://dublincore.org/documents/dcmi-terms/)
- some facilities from [sdmx ontologies](https://sdmx.org/)

auditel vocabulary also reuses some individual references to linked open data provided by [UK e-gov](https://github.com/alphagov/datagovuk_reference) and from [AGCOM vocabulary](https://g0v-it.github.io/ontologies/agcom/)

Following metrics is observed in AUDITEL data:

- audience: estimation of the average number of listening people
- share: the percentage of listeners
- rating: the percentage of potential audience

in following dimensions:

- context: the auditel monitored context expressed as SKOS concept, same as agcom:context

Following properties are defined: 

- refPeriod: the observation period , expressed as [time interval](http://reference.data.gov.uk/def/intervals). Same as agcom:refPeriod


In this snippet describes an AUDITEL observation as linked data:

```
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix void: <http://rdfs.org/ns/void#> .
@prefix dct: <http://purl.org/dc/terms/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix interval: <http://reference.data.gov.uk/def/intervals/> .
@prefix sdmx-subject: <http://purl.org/linked-data/sdmx/2009/subject#> .
@prefix agcom: <https://g0v-it.github.io/ontologies/agcom#> .
@prefix auditel: <https://g0v-it.github.io/ontologies/auditel#> .
@prefix resource: <http://agcom.linkeddata.cloud/resource/> . 
resource:auditel_2018 a qb:DataSet ;
	dct:subject
        sdmx-subject:1.11 ,      # Time use
        sdmx-subject:2.1 ; 	 # Macroeconomic statistics
	auditel:refPeriod <http://reference.data.gov.uk/id/gregorian-year/2018> ;
	dct:publisher  resource:AUDITEL;
.
resource:AUDITEL a foaf:Organization;
    owl:sameAs <http://www.wikidata.org/entity/3629499>
.
resource:rating_xxx a qb:Observation;
	qb:dataSet resource:auditel_2018 ;
	auditel:context agcom:RAI1 ;
	auditel:audience 1832532 ;
	auditel:share 0.1586 ;
	auditel:rating 0.0313 
.	
```
