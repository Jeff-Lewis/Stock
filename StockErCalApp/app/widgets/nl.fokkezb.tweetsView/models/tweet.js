exports.definition = {
	config: {
		columns: {
		    "id": "int",
		    "content": "string",
		    "image": "string",
		    "cmtCount": "int",
		    "stockId": "int",
		    "userId": "int",
		    "createdAt": "datetime"
		},
		adapter: {
			type: "sql",
			collection_name: "tweet",
		}
	},
	extendModel: function(Model) {
		_.extend(Model.prototype, {
			// extended functions and properties go here
		});

		return Model;
	},
	extendCollection: function(Collection) {
		_.extend(Collection.prototype, {
			// extended functions and properties go here
		});

		return Collection;
	}
};