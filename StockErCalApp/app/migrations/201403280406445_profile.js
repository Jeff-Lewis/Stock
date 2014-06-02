var preload_data = [
	{id: 1, beat: 1, miss: 1, rank: 2, success: 1, failure: 3, userId: 1, bullism: 1, username: "user1", avatar: 'https://31.media.tumblr.com/avatar_c88c727576a0_64.png', createdAt: new Date()},
	{id: 2, beat: 10, miss: 1, rank: 20, success: 10, failure: 30, userId: 2, bullism: 0, username: "user2", avatar: 'https://31.media.tumblr.com/1693ac30db931a16b7aee04f4369013b/tumblr_n340qm9XC11qdt6e2o5_500.jpg', createdAt: new Date()},
];

migration.up = function(migrator) {
	migrator.createTable({
        "columns":
        {
            "id": "integer",
            // "profileId": "integer",
		    "beat": "integer",
		    "miss": "integer",
		    "rank": "integer",
		    "success": "integer",
		    "failure": "integer",
		    "userId": "integer",
		    "bullism": "integer",
		    "username": "text",
		    "avatar": "text",
		    "createdAt": "timestamp"
        }
    });
    
    for (var i = 0; i < preload_data.length; i++) { 
	    migrator.insertRow(preload_data[i]);
    }
};

migration.down = function(migrator) {
	migrator.dropTable();
};
