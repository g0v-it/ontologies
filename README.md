g0v-ap  application profile
=========================

g0v-ap is an general Semantic Web Application defined with [OWL](https://www.w3.org/TR/owl2-primer/) suitable to annotate a government finnantial data with the purpose of supporting  visualization applications (e.g. http://budget.g0v.it/).  

It captures different perspectives of a government budget data like historical trends, cross-department and component breakdown of tax by government. 

g0v-ap is an application profile that builds upon the following RDF vocabularies:: 

- the [W3C RDF Data Cube Vocabulary](https://www.w3.org/TR/vocab-data-cube), to describe the outgoings/incomes accounts observations
- the [FinancialReport Vocabulary](http://linkeddata.center/fr/v1) that extend Data Cube with classes, attributes and bindings about a generic Financtial reports.
- the [Data Catalog Vocabulary](https://www.w3.org/TR/vocab-dcat/) to describe the dataset metadata
- the [SKOS](https://www.w3.org/TR/skos-primer) to describe balance taxonomy.
- the [DCMI Metadata Terms](http://dublincore.org/documents/dcmi-terms/)
- some facilities from [sdmx ontologies](https://sdmx.org/)

g0v-ap also reuses some individual references to linked open data provided by [UK e-gov](https://github.com/alphagov/datagovuk_reference) and by [dbpedia](http://dbpedia.org/).

See [FinancialReport Vocabulary project](https://github.com/linkeddatacenter/fr) for more information and examples. 

This picture summarize the g0v-ap restrictions:

![g0v-ap UML diagram](doc/g0v-ap-uml-diagram.png)
