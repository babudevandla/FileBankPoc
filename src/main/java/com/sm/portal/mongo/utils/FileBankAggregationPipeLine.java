package com.sm.portal.mongo.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.client.AggregateIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Projections;
import com.mongodb.client.model.Sorts;

public class FileBankAggregationPipeLine {


	private final List<Document> stages = new ArrayList<Document>();
    
	
	Document out = null;
	String collectionname = null;
	String db=null;
	public FileBankAggregationPipeLine(String collectionname) {
		this.collectionname = collectionname;
		this.db = null;
	}
	public FileBankAggregationPipeLine(String db,String collectionname) {
		this.collectionname = collectionname;
		this.db = db;
	}
	public String getDb() {
		return db;
	}
	
	public FileBankAggregationPipeLine(){}
	/*
	public <U> Iterator<U> aggregate(Class<U> target) {
		
		return null;
	}

	
	public <U> Iterator<U> aggregate(Class<U> target, AggregationOptions options) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public <U> Iterator<U> aggregate(Class<U> target,
			AggregationOptions options, ReadPreference readPreference) {
		// TODO Auto-generated method stub
		return null;
	}
*/
/*	
	public <U> Iterator<U> aggregate(String collectionName, Class<U> target,
			AggregationOptions options, ReadPreference readPreference) {
		// TODO Auto-generated method stub
		return null;
	}

	
	public FileBankAggregationPipeLine geoNear(GeoNear geoNear) {
		// TODO Auto-generated method stub
		return null;
	}
*/
	
	public AggregateIterable<Document> aggregate(MongoDatabase database){
		if(this.out!=null)
			this.stages.add(out);
		String aggregateString = stages.stream().sequential().map(document->document.toJson()).collect(Collectors.joining(",")); 
		
		MongoCollection<Document> collection = database.getCollection(collectionname);
		return collection.aggregate(stages).allowDiskUse(true);		
	}
	
	public List<Document> getAggregationStages(){
		if(this.out!=null)
			this.stages.add(out);
		String aggregateString = stages.stream().sequential().map(document->document.toJson()).collect(Collectors.joining(",")); 
		return stages;
	}
	
	public FileBankAggregationPipeLine group(Document groupedDoc) {
		Document document = new Document("$group",groupedDoc);
		stages.add(document);
		return this;
	}
	public FileBankAggregationPipeLine out(String outputcollection) {
		this.out = new Document("$out", outputcollection);
		return this;
	}
		
	public FileBankAggregationPipeLine limit(int count) {
		stages.add(new Document("$limit", count));
		return this;
	}

	// this should not be added to the list as this should be the last element in the pipeline array
	public FileBankAggregationPipeLine lookup(String from, String localField,String foreignField, String as) {
		Document lookupDefinition = Document.parse("{from:'"+from+"',localField:'"+localField+"',foreignField:'"+foreignField+"',as:'"+as+"'}");
		stages.add(new Document("$lookup",lookupDefinition));		
		return this;
	}

	
	public FileBankAggregationPipeLine match(Document matchdocument) {
		Document document = new Document("$match",matchdocument);
		stages.add(document);
		return this;
	}
		
	public FileBankAggregationPipeLine project(String... field) {
		Document document = new Document();
		Bson projections = Projections.include(field);
		document.append("$project", projections);
		stages.add(document);
		return null;
	}

	
	public FileBankAggregationPipeLine skip(int count) {
		stages.add(new Document("$skip", count));
		return this;
	}
	public FileBankAggregationPipeLine sortDesc(String... fieldNames) {
		Document sort = new Document("$sort",Sorts.descending(fieldNames));
		stages.add(sort);
		return this;
	}
	
	public FileBankAggregationPipeLine sortAsc(String... fieldNames) {
		Document sort = new Document("$sort",Sorts.ascending(fieldNames));
		stages.add(sort);
		return this;
	}

	
	public FileBankAggregationPipeLine unwind(String field) {
		Document unwind = new Document("$unwind","$"+field);
		stages.add(unwind);
		return this;
	}


}
