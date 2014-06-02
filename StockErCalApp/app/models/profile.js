exports.definition = {
	config: {
		columns: {
		    "id": "int",
		    // "profileId": "int",
		    "beat": "int",
		    "miss": "int",
		    "rank": "int",
		    "success": "int",
		    "failure": "int",
		    "userId": "int",
		    "bullism": "int",
		    "username": "string",
		    "avatar": "string",
		    "createdAt": "datetime"
		},
		adapter: {
			type: "sql",
			collection_name: "profile",
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