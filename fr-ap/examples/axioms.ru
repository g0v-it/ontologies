############################################################################
# This rules implements an example of a g0v fr-ap reasoner
############################################################################
PREFIX fr: <http://linkeddata.center/botk-fr/v1#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
PREFIX qb: <http://purl.org/linked-data/cube#>
PREFIX sdmx-attribute:	<http://purl.org/linked-data/sdmx/2009/attribute#>
PREFIX dct: <http://purl.org/dc/terms/>


#############################################################################
# Skos reasoning
# Assumptions:
#  data expose all skos:broader relations
#  data expose all fr:Fact and fr:FinancialReport types
##############################################################################
INSERT { ?concept a skos:Concept } 
WHERE {  
	{ [] fr:concept|skos:narrower|skos:broader ?concept }
	UNION
	{ ?concept skos:inScheme [] }
	
	FILTER NOT EXISTS {?concept a skos:Concept}
};

INSERT { ?fr a skos:ConceptScheme, qb:DataSet } 
WHERE {  
	?fr a fr:FinancialReport
	
	FILTER NOT EXISTS {?fr a skos:ConceptScheme, qb:DataSet}
}; 


INSERT { ?fact a qb:Observation } 
WHERE {  
	?fact a fr:Fact
	
	FILTER NOT EXISTS {?fact a qb:Observation}
}; 


INSERT { ?broader_concept skos:narrower ?narrow_concept} 
WHERE {  
	?narrow_concept skos:broader ?broader_concept
	
	FILTER NOT EXISTS {?broader_concept skos:narrower ?narrow_concept}
};

INSERT { ?concept  skos:inScheme ?scheme } 
WHERE {  
	{ ?x qb:dataSet ?scheme; fr:concept ?concept }
	UNION
	{ ?x qb:dataSet ?scheme; fr:concept/skos:broader* ?concept }
	
	FILTER NOT EXISTS {?concept  skos:inScheme ?scheme}
};


INSERT { ?scheme skos:hasTopConcept ?concept} 
WHERE {  
	?concept  skos:inScheme ?scheme.
	?scheme a fr:FinancialReport .
	FILTER NOT EXISTS {?concept skos:broader []}
	
	FILTER NOT EXISTS {?scheme skos:hasTopConcept ?concept}
};


#############################################################################
# Infer defaults
##############################################################################
INSERT { ?fact fr:amount 0.000 } 
WHERE {  
	?fact a fr:Fact .
	
	FILTER NOT EXISTS {?fact fr:amount []}
};


INSERT { ?fact fr:refPeriod ?ref_period} 
WHERE {  
	?fact a fr:Fact; qb:dataSet/fr:refPeriod ?ref_period.
	
	FILTER NOT EXISTS {?fact fr:refPeriod []}
};


INSERT { ?fact sdmx-attribute:unitMeasure ?unit} 
WHERE {  
	?fact a fr:Fact; qb:dataSet/sdmx-attribute:unitMeasure ?unit.
	
	FILTER NOT EXISTS {?fact sdmx-attribute:unitMeasure []}
};

#############################################################################
# Infer financial report components
##############################################################################

INSERT { 
	?component a fr:Component, qb:Observation ; 
	fr:concept ?concept ;
	qb:dataSet ?scheme
} 
WHERE {
	?concept a skos:Concept; 
		skos:inScheme ?scheme ;
		skos:narrower [] .
	BIND( IRI( CONCAT( STR(?concept), "_component")) as ?component )
	
	FILTER NOT EXISTS {?component a fr:Component}
};


INSERT { ?factOrComponent fr:isPartOf ?component } 
WHERE {
	?concept a skos:Concept; skos:broader ?broaderConcept.
	?factOrComponent fr:concept ?concept .
	?component fr:concept ?broaderConcept .
	
	FILTER NOT EXISTS {?factOrComponent fr:isPartOf ?component}
};


INSERT { ?component fr:hasPart ?factOrComponent }
WHERE {
	?factOrComponent fr:isPartOf ?component
	FILTER NOT EXISTS {?component fr:hasPart ?factOrComponent}
};

	
INSERT { ?component fr:amount ?totalAmount }
WHERE {
	SELECT ?component ( SUM(?amount) AS ?totalAmount)
	WHERE {
		?component a fr:Component; fr:hasPart* ?fact .
		?fact a fr:Fact;fr:amount ?amount .
		
		FILTER NOT EXISTS {?component fr:amount []}
	} GROUP BY ?component
}
