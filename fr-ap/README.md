g0v fr-ap: a financial report application profile
=================================================

g0v fr-ap is a specification based on [Financial Report Vocabulary](http://linkeddata.center/botk-fr/v1) suitable to annotate government data 
with the purpose of supporting budget visualization applications (e.g. http://budget.g0v.it/).  

It captures different perspectives of a government budget data like historical trends, cross-department and component breakdown of tax by government. 


g0v fr-ap is a semantic web application that builds upon the following RDF vocabularies: 

- the [W3C RDF Data Cube Vocabulary](https://www.w3.org/TR/vocab-data-cube), to describe data observations and statistics.
- the [Financial Report Vocabulary](http://linkeddata.center/botk-fr/v1) that extends the Data Cube Vocabulary with classes, attributes and bindings about a generic financial reports.
- the [Data Catalog Vocabulary](https://www.w3.org/TR/vocab-dcat/) to describe the dataset metadata
- the [SKOS](https://www.w3.org/TR/skos-primer) to describe balance taxonomy.
- the [DCMI Metadata Terms](http://dublincore.org/documents/dcmi-terms/)
- some facilities from [sdmx ontologies](https://sdmx.org/)

g0v fr-ap also reuses some individual references to linked open data provided by [UK e-gov](https://github.com/alphagov/datagovuk_reference) and by 
[Currency EU vocabulary](http://publications.europa.eu/resource/authority/currency).


## Axioms

g0v fr-ap add these restrictions to the fr contology:

- the financial report is a taxonomy of related concepts (skos:ConceptScheme) ;
- fr:concept is an inverse functional property 
- a fact exposes exacly a fr:amount, if not provided 0.000 must be inferred ;
- the fr:amount of a component is the sum of the amounts its parts ;
- concepts can be related with other concepts using skos:closeConcept property
- two concepts related through  skos:closeConcept property must be in different skos:Scheme

Corollaries:

- the taxonomy has a hierarchical tree structure;
- the taxonomy and financial report structural components has equivalent hierarchical structure
- each financial report fact is related to a leaf of the taxonomy tree;
- the components of a Financial Report can be derived from its facts and concept tassonomy
- close concepts allows to infer the fact history and trend.


## Documentary and other conventions

Semantic relationships are crucial to the definition of concepts,. However, next to these structured characterizations, concepts sometimes have to be further defined using human-readable ("informal") documentation:

- each financial report should have at least a dct:title and a dct:source attribute
- each concept has should have at least a skos:prefLabel attribute
- each financial report short description should annotated with dct:description
- each financial report detailed description should annotated with dct:abstract
- each concept short description should annotated with skos:definition
- each concept detailed description should annotated with skos:scopeNote


This picture summarize the g0v fr-ap restrictions and conventions:

![g0v-ap UML diagram](doc/fr-ap-uml-diagram.png)


This snippet (in RDF turtle format) describes a provisional financial report as linked data with FR:

```
@prefix fr: <http://linkeddata.center/botk-fr/v1#>.
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix qb: <http://purl.org/linked-data/cube#> .
@prefix : <#>.

:2018_budget_report a fr:FinancialReport ;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> .
	
:facx_x a fr:Fact;
	fr:concept :ABCD1 ;
	qb:dataSet :2018_budget_report ;
	fr:amount 200000000000.00	.

:facx_y a fr:Fact;
	fr:concept :ABCD2 ;
	qb:dataSet :2018_budget_report ;
	fr:amount 881493000.00	.
	
:ABCD1 skos:broader :ABCD .
:ABCD2 skos:broader :ABCD .
:ABCD skos:broader :ABC .
:ABC skos:broader :AB .
:AB skos:broader :A .

```

A reasoner that is able to understand g0v fr-ap should able to infer these properies:

```

:facx_x a qb:Observable;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> ;
	fr:isPartOf :component_1 .
	
:facx_y a qb:Observable;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> ;
	fr:isPartOf :component_1 .

:component_1 a qb:Observable, fr:Component;
   fr:concept :ABCD;
	qb:dataSet :2018_budget_report ;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> ;
   fr:hasPart :facx_x, :fact_y ;
	fr:amount 2881493000.00	;
   fr:isPartOf :component_2 .
   
:component_2 a qb:Observable, fr:Component;
   fr:concept :ABC;
	qb:dataSet :2018_budget_report ;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> ;
   fr:hasPart :component_1 ;
	fr:amount 2881493000.00	;
   fr:isPartOf :component_3 .
   
:component_3 a qb:Observable, fr:Component;
   fr:concept :AB;
	qb:dataSet :2018_budget_report ;
	fr:refPeriod <http://reference.data.gov.uk/id/gregorian-interval/2018-01-01T00:00:00/P1Y> ;
	fr:unit <http://publications.europa.eu/resource/authority/currency/EUR> ;
   fr:hasPart :component_2 ;
	fr:amount 2881493000.00	;
   fr:isPartOf :component_4 .
   
:component_4 a qb:Observable, fr:Component;
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

If you want to write an application that analyzes/visualizes budget data, first you have to transform the finantial report in RDF linked 
data according to fr ontology (if not already provided in this ontology). 
Then you reason about data inferring the missing RDF statements (see axioms directory as example). 
After reasoning you should verify the integrity of the resulting Knowledge Base (see tests).

Last, you transform the financial information as requested by your selected visualization/analysis tool. 



In this picture shows the typical workflow:

![dataflow](doc/g0v-budget-dataflow.png)

A more complete solution could requires RDF quadstore and a platform providing a SPARQL endpoint. 


With [Docker](https://docker.com), you can create and test an example knowledge base running the 
run_tests.sdaas with the [LinkedData.Center SDaaS platform](https://github.com/linkeddatacenter/sdaas-ce):

- the directory [examples](examples/data) provides some data examples serialized as RDF turtle.
- the directory [axioms](examples/axioms) provides axioms espressed as SPARQL construct.
- the directory [tests](examples/tests/) provides some sparql query to verify the integrity of a knowledge base respect g0v-ap application profile

Open a console in fr-ap directory and type:


```
docker run -d -p 8080:8080 -v $PWD/.:/workspace --name kb linkeddatacenter/sdaas-ce
docker exec -ti kb sdaas -f examples/build.sdaas --reboot
```

logs info and debug traces will be created in `.cache` directory.
To access the knowledge base point a browser to http://localhost:8080/sdaas

todo:
	The provided example also generates in the *distrib* directory the *data.ttl* file suitable to be visualized with the [LODMAP2D](https://github.com/linkeddatacenter/LODMAP2D) web application.
	In complex application you probably need  to provide an  API layer to the knowledge base to feed your application.

Free the docker resources with the `docker rm -f kb` command.
