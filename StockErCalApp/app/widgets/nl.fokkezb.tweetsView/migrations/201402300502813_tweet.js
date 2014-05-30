var preload_data = [
	{id: 1, content: 'tweet 1', image: 'https://31.media.tumblr.com/avatar_c88c727576a0_64.png', cmtCount: 1, stockId: 2, userId: 3, createdAt: new Date()},
	{id: 2, content: 'tweet 2', image: 'https://24.media.tumblr.com/avatar_07ff40170912_64.png', cmtCount: 12, stockId: 2, userId: 1, createdAt: new Date()},
	{id: 3, content: 'tweet 3', image: 'http://assets.tumblr.com/images/default_avatar/cube_open_64.png', cmtCount: 123, stockId: 2, userId: 2, createdAt: new Date()},
	{id: 4, content: 'tweet 4', image: 'https://24.media.tumblr.com/avatar_c36b653e187f_64.png', cmtCount: 1234, stockId: 2, userId: 4, createdAt: new Date()},
	{id: 5, content: 'tweet 5', image: 'https://24.media.tumblr.com/avatar_f5d9af6b1348_64.png', cmtCount: 12345, stockId: 2, userId: 5, createdAt: new Date()},
	{id: 6, content: 'tweet 6', image: 'https://31.media.tumblr.com/1693ac30db931a16b7aee04f4369013b/tumblr_n340qm9XC11qdt6e2o5_500.jpg', cmtCount: 123456, stockId: 2, userId: 6, createdAt: new Date()},
	{id: 7, content: 'tweet 7', image: 'https://31.media.tumblr.com/69c625161369d5bb0022859237b5a04a/tumblr_n340qm9XC11qdt6e2o2_500.jpg', cmtCount: 1234567, stockId: 2, userId: 7, createdAt: new Date()},
	{id: 8, content: 'tweet 8', image: 'https://24.media.tumblr.com/6f761ef0727f27dfd51ddf8943503db5/tumblr_n33zvpQpjC1qdt6e2o3_500.jpg', cmtCount: 12345678, stockId: 2, userId: 8, createdAt: new Date()}
];

migration.up = function(migrator) {
	migrator.createTable({
        "columns":
        {
            "id": "integer",
		    "content": "text",
		    "image": "text",
		    "cmtCount": "integer",
		    "stockId": "integer",
		    "userId": "integer",
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
