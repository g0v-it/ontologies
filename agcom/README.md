AGCOM vocabulary
=================

[AGCOM](http://agicom.it/) collects periodic records about the presence of politicians in main TV shows;
the agcom vocabulary describe the terms to annotate AGICOM data.

The namespace for agcom vocabulary is **http://g0v-it.github.io/ontologies/agcom#**

Last Turtle RDF serialization is available in https://g0v-it.github.io/ontologies/agcom/v1.ttl

The agcom vocabulary is a semantic web application that builds upon the following RDF vocabularies:

- the [W3C RDF Data Cube Vocabulary](https://www.w3.org/TR/vocab-data-cube), to describe data observations and statistics.
- the [Data Catalog Vocabulary](https://www.w3.org/TR/vocab-dcat/) to describe the dataset metadata
- the [SKOS](https://www.w3.org/TR/skos-primer) to describe balance taxonomy.
- the [DCMI Metadata Terms](http://dublincore.org/documents/dcmi-terms/)
- some facilities from [sdmx ontologies](https://sdmx.org/)

All specific [SKOS taxonomies](https://www.w3.org/TR/skos-primer/), derived from the [Contratto di appalto servizio di monitoraggio delle trasmissioni televisive delle emittenti nazionali riferito alle aree del pluralismo socio/politico, delle garanzie dell'utente, degli obblighi specifici del servizio pubblico radiotelevisivo - CIG 4977351FF7](https://www.agcom.it/documentazione/documento?p_p_auth=fLw7zRht&p_p_id=101_INSTANCE_ls3TZlzsK0hm&p_p_lifecycle=0&p_p_col_id=column-1&p_p_col_count=1&_101_INSTANCE_ls3TZlzsK0hm_struts_action=%2Fasset_publisher%2Fview_content&_101_INSTANCE_ls3TZlzsK0hm_assetEntryId=4658125&_101_INSTANCE_ls3TZlzsK0hm_type=document) document.

All concepts, when possible, should be linked to the equivalent wikidata concepts.


agicom vocabulary also reuses some individual references to linked open data provided by [UK e-gov](https://github.com/alphagov/datagovuk_reference).

Following metrics are defined:

- speakingTime: the cumulative amount of time a subject directly speaks in a monitored context in a defined period expressed as time duration (i.e. [xsd:duration](http://www.datypic.com/sc/xsd/t-xsd_duration.html))

Following dimensions are defined:

- subject : a person who speaks in a monitored television program expressed as SKOS concepts as a foaf:Person instance
- role: an optional  political or institutional role with which and individual subject makes statements expressed as SKOS concept
- context: the monitored context in which the subject speaks expressed as SKOS concept

Following properties are defined: 

- refPeriod: the observation period in witch the speakingTime metric is calculated, expressed as [time interval](http://reference.data.gov.uk/def/intervals)


In this snippet describes an AGCOM observation as linked data:

```
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix qb: <http://purl.org/linked-data/cube#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix dct: <http://purl.org/dc/terms/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix interval: <http://reference.data.gov.uk/def/intervals/> .
@prefix sdmx-subject: <http://purl.org/linked-data/sdmx/2009/subject#> .
@prefix agcom: <https://g0v-it.github.io/ontologies/agcom#> .
@prefix resource: <http://agcom.linkeddata.cloud/resource/> . 

resource:report_2019_02_1 a qb:DataSet ;
	dct:subject
		sdmx-subject:1.10 ,      # Political and other community activities
		sdmx-subject:1.11 ,      # Time use
		sdmx-subject:3.3.3; 	 # Information society
	agcom:refPeriod <http://reference.data.gov.uk/id/gregorian-month/2019-02> ;
	dct:publisher  resource:AGCOM;
.	
resource:AGCOM a foaf:Organization;
    owl:sameAs <http://www.wikidata.org/entity/Q3630823>
.  
resource:presence_xxxx a qb:Observation;
	qb:dataSet resource:agicom_2019_02_1 ;
	agcom:subject resource:Matteo_Salvini ;
	agcom:role resource:Governo ;
	agcom:context resource:TG1 ;
	agcom:speakingTime "PT2M2.5S"^^xsd:duration 
.
resource:Matteo_Salvini a foaf:Person ;
	owl:sameAs <http://www.wikidata.org/entity/Q1055449> 
.
resource:Governo a skos:Concept ;
	skos:inScheme agcom:ruoli ;
	owl:sameAs <http://www.wikidata.org/entity/Q3773971> 
.
resource:TG1 a skos:Concept ;
	skos:inScheme agcom:programmi ;
	owl:sameAs <http://www.wikidata.org/entity/Q615926> ;
	agcom:emittente resource:RAI1
.
:RAI1 a skos:Concept ;
	skos:inScheme agcom:emittenti ;
	owl:sameAs <http://www.wikidata.org/entity/Q258131> ;
	dct:publisher resource:RAI
.
resource:RAI a skos:Concept ;
	skos:inScheme agcom:editori ;
	owl:sameAs <http://www.wikidata.org/entity/Q19616> 
.
```

## License

(c) 2019 by Enrico Fagnoni at LinkedData.Center

The agicom vocabulary is available under the 
[Creative Commons Attribution 4.0 Unported license](http://creativecommons.org/licenses/by/4.0/). 
In a nutshell, you are free to copy, distribute and transmit the work; 
to remix/adapt the work (e.g. to import the ontology and create specializations of its elements), 
as long as you attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). 
Proper Attribution: Simply include the statement "This work is based on the agcom ontology, developed by Enrico Fagnoni" and link back to http://LinkedData.Center/
