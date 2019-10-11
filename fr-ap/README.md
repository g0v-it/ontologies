g0v fr-ap: a financial report application profile
=================================================

g0v fr-ap is a profile of the [Financial Report Vocabulary](http://linkeddata.center/botk-fr/v1) suitable to annotate government data.  

It captures different perspectives of a government financial report (e.g. a budget) like historical trends, cross-department and component breakdown of tax by government. 


g0v fr-ap is a semantic web application that builds upon the following RDF vocabularies: 

- the [W3C RDF Data Cube Vocabulary](https://www.w3.org/TR/vocab-data-cube), to describe data observations and statistics.
- the [Financial Report Vocabulary](http://linkeddata.center/botk-fr/v1) that extends the Data Cube Vocabulary with classes, attributes and bindings about a generic financial reports.
- the [SKOS](https://www.w3.org/TR/skos-primer) to describe the taxonomy used to structure the financial report.
- the [DCMI Metadata Terms](http://dublincore.org/documents/dcmi-terms/) to add metadata and commetary
- some facilities from [sdmx ontologies](https://sdmx.org/)

g0v fr-ap also reuses some individual references to linked open data provided by [UK e-gov](https://github.com/alphagov/datagovuk_reference) and by 
[Currency EU vocabulary](http://publications.europa.eu/resource/authority/currency).


## Axioms

g0v fr-ap adds some restrictions to the fr ontology:

- the financial report structure is described by a taxonomy of related concepts (skos:ConceptScheme) ;
- fr:concept MUST be considered as a an inverse functional property 
- a fact exposes exactly a fr:amount property, if not provided, *fr:amount 0.000* must be inferred ;
- the fr:amount of a component is always the sum of the amounts of underlining facts ;
- concepts in a financial report can be linked to concepts in other financial reports using skos:closeConcept property

Corollaries:

- the taxonomy has a hierarchical tree structure;
- the taxonomy and the financial report structural share the same structure
- each fact is related to a leaf of the taxonomy tree;
- the components of a financial report can be inferred from facts and taxonomy
- skos:closeConcept property allows to infer the fact history and trends.

Semantic relationships are crucial to the definition of concepts. However, next to these structured characterizations, concepts sometimes have to be further defined using human-readable ("informal") documentation:

- each financial report should have a dct:title 
- the source document from witch the financial concept is derived should be annotated with dct:source attribute
- each financial report short description should annotated with dct:description
- each financial report detailed description should annotated with dct:abstract
- each concept has should have at least a skos:prefLabel attribute
- each concept short description should annotated with skos:definition
- each concept detailed description should annotated with skos:scopeNote


This picture summarize the g0v fr-ap restrictions and conventions:

![g0v-ap UML diagram](doc/fr-ap-uml-diagram.png)


This snippet (in RDF turtle format) describes a provisional financial report as linked data with FR:

```turtle
@prefix fr: <http://linkeddata.center/botk-fr/v1#>.
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix qb: <http://purl.org/linked-data/cube#> .
@prefix sdmx-attribute: <http://purl.org/linked-data/sdmx/2009/attribute#> .
@prefix : <#>.

:2018_budget_report a fr:FinancialReport ;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2019-01-01T00:00:00/P1Y> ;
	sdmx-attribute:unitMeasure <http://publications.europa.eu/resource/authority/currency/EUR> .
	
:ABCD1_fact a fr:Fact;
	fr:concept :ABCD1 ;
	qb:dataSet :2018_budget_report ;
	fr:amount 200000000000.00	.

:ABCD2_fact a fr:Fact;
	fr:concept :ABCD2 ;
	qb:dataSet :2018_budget_report ;
	fr:amount 881493000.00	.
	
:ABCD1 skos:broader :ABCD .
:ABCD2 skos:broader :ABCD .
:ABCD skos:broader :ABC .
:ABC skos:broader :AB .
:AB skos:broader :A .

```

A reasoner that is able to understand g0v fr-ap should able to infer these properties:

```turtle
:ABCD1_fact a qb:Observation;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> ;
	fr:isPartOf :ABCD_component .
	
:ABCD2_fact a qb:Observation;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> ;
	fr:isPartOf :ABCD_component .

:ABCD_component a qb:Observation, fr:Component;
   fr:concept :ABCD;
	qb:dataSet :2018_budget_report ;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> ;
   fr:hasPart :facx_x, :fact_y ;
	fr:amount 2881493000.00	;
   fr:isPartOf :ABC_component .
   
:ABC_component a qb:Observation, fr:Component;
   fr:concept :ABC;
	qb:dataSet :2018_budget_report ;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> ;
   fr:hasPart :component_1 ;
	fr:amount 2881493000.00	;
   fr:isPartOf :AB:component .
   
:AB:component a qb:Observation, fr:Component;
   fr:concept :AB;
	qb:dataSet :2018_budget_report ;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> ;
   fr:hasPart :component_2 ;
	fr:amount 2881493000.00	;
   fr:isPartOf :A_component .
   
:A_component a qb:Observation, fr:Component;
   fr:concept :A;
	qb:dataSet :2018_budget_report ;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> ;
	fr:amount 2881493000.00	.
    
:ABCD a skos:Concept ; skos:inScheme :018_budget_report ; skos:narrower :ABCD1, :ABCD2 .
:ABC a skos:Concept ; skos:inScheme :018_budget_report ; skos:narrower :ABCD .
:AB a skos:Concept ; skos:inScheme :018_budget_report ; skos:narrower :ABC .
:A a skos:Concept ; skos:inScheme :018_budget_report ; skos:narrower :AB .

:2018_budget_report a qb:DataSet, skos:ConceptScheme; 
	skos:hasTopConcept :A  .

```


## How to use fr-ap

If you want to write an application that analyzes/visualizes financial reports, you could run a three step process:

1. first you have to transform the financial report in RDF linked data according to fr ontology;
2. then you reason about data inferring the missing RDF statements;
3. Last, if needed, you can transform the financial information as requested by your selected visualization/analysis tool;


In this picture shows the typical workflow:

![dataflow](doc/g0v-budget-dataflow.png)

A more complete solution could requires RDF quadstore and a platform providing a SPARQL endpoint. 


With [Docker](https://docker.com), you can create and test an example knowledge base 
using LinkedData.Center [SDaaS platform](https://github.com/linkeddatacenter/sdaas-ce) as reasoner:

To reason about [example data](examples/data.ttl), open a console in fr-ap directory and type:

```
docker run -d -p 8080:8080 -v $PWD/examples:/workspace --name kb linkeddatacenter/sdaas-ce
docker exec -ti kb sdaas -f fr.reasoner --reboot
```

logs info and debug traces will be created in `examples/.cache` directory.

To query the resulting knowledge graph point a browser to http://localhost:8080/sdaas#query

Try executing:

```
PREFIX fr: <http://linkeddata.center/botk-fr/v1#>
SELECT * WHERE {
  ?fact fr:amount ?amount; fr:isPartOf  ?part_of
}
```


Free the docker resources with the `docker rm -f kb` command.
