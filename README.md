g0v fr-ap: a financial report application profile
=================================================

g0v fr-ap  is a specification based on [Finacial Report Vocabulary](kttp://linkeddata.center/fr/v1) suitable to annotate government financial data 
with the purpose of supporting  visualization applications (e.g. http://budget.g0v.it/).  

It captures different perspectives of a government budget data like historical trends, cross-department and component breakdown of tax by government. 

g0v fr-ap is a semati web application that builds upon the following RDF vocabularies:: 

- the [W3C RDF Data Cube Vocabulary](https://www.w3.org/TR/vocab-data-cube), to describe the outgoings/incomes accounts observations
- the [FinancialReport Vocabulary](http://linkeddata.center/fr/v1) that extends the Data Cube Vocabulary with classes, attributes and bindings about a generic Financtial reports.
- the [Data Catalog Vocabulary](https://www.w3.org/TR/vocab-dcat/) to describe the dataset metadata
- the [SKOS](https://www.w3.org/TR/skos-primer) to describe balance taxonomy.
- the [DCMI Metadata Terms](http://dublincore.org/documents/dcmi-terms/)
- some facilities from [sdmx ontologies](https://sdmx.org/)

g0v fr-ap also reuses some individual references to linked open data provided by [UK e-gov](https://github.com/alphagov/datagovuk_reference) and by [dbpedia](http://dbpedia.org/).

This picture summarize the g0v-ap restrictions:

![g0v-ap UML diagram](doc/g0v-ap-uml-diagram.png)
