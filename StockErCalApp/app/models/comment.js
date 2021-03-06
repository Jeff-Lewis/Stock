exports.definition = {
	config: {
		columns: {
		    "id": "int",
		    // "commentId": "int",
		    "content": "string",
		    "image": "string",
		    "tweetId": "int",
		    "commentId": "int",
		    "userId": "int",
		    "createdAt": "datetime"
		},
		adapter: {
			type: "sql",
			collection_name: "comment",
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