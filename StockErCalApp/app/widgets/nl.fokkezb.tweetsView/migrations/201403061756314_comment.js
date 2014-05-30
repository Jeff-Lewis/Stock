var preload_data = [
	{id: 1, content: 'comment 1', image: 'https://31.media.tumblr.com/avatar_c88c727576a0_64.png', tweetId: 2, commentId: 0, userId: 3, createdAt: new Date()},
	{id: 2, content: 'comment 2', image: 'https://24.media.tumblr.com/avatar_07ff40170912_64.png', tweetId: 2, commentId: 1, userId: 2, createdAt: new Date()},
	{id: 4, content: 'comment 4', image: 'https://24.media.tumblr.com/avatar_c36b653e187f_64.png', tweetId: 2, commentId: 2, userId: 4, createdAt: new Date()},
	{id: 5, content: 'comment 5', image: 'https://24.media.tumblr.com/avatar_f5d9af6b1348_64.png', tweetId: 2, commentId: 3, userId: 5, createdAt: new Date()},
	{id: 6, content: 'comment 6', image: 'https://31.media.tumblr.com/1693ac30db931a16b7aee04f4369013b/tumblr_n340qm9XC11qdt6e2o5_500.jpg', tweetId: 2, commentId: 1, userId: 6, createdAt: new Date()},
	{id: 7, content: 'comment 7', image: 'https://31.media.tumblr.com/69c625161369d5bb0022859237b5a04a/tumblr_n340qm9XC11qdt6e2o2_500.jpg', tweetId: 2, commentId: 1, userId: 7, createdAt: new Date()},
	{id: 8, content: 'comment 8', image: 'https://24.media.tumblr.com/6f761ef0727f27dfd51ddf8943503db5/tumblr_n33zvpQpjC1qdt6e2o3_500.jpg', tweetId: 2, commentId: 1, userId: 8, createdAt: new Date()}
];

migration.up = function(migrator) {
	migrator.createTable({
        "columns":
        {
            "id": "integer",
		    "content": "text",
		    "image": "text",
		    "commentId": "integer",
		    "tweetId": "integer",
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
