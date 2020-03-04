'use strict';
console.log('Loading hello world function');

const mysql = require('mysql');

var pool  = mysql.createPool({
    host     : process.env.RDS_HOSTNAME,
    user     : process.env.RDS_USERNAME,
    password : process.env.RDS_PASSWORD,
    port     : process.env.RDS_PORT,
    database: process.env.RDS_DATABASE
});

exports.handler =  (event, context, callback) => {
  //prevent timeout from waiting event loop
  context.callbackWaitsForEmptyEventLoop = false;
  pool.getConnection(function(error, connection) {
      if (error) callback(error);
    // Use the connection
    //const sql = "CREATE TABLE MESSAGE (message VARCHAR(255))";
    //const sql = "INSERT INTO MESSAGE (message) VALUES ('I am MySQL')";
    const sql = "select * from MESSAGE";
    connection.query(sql, function (error, results, fields) {
      // And done with the connection.
      connection.release();
      // Handle error after the release.
      var res ={
        "statusCode": 200,
        "headers": {
            "Content-Type": "*/*"
          }
        };
        res.body = JSON.stringify(results[0]);
      if (error) callback(error);
      else callback(null,res);
    });
  });
};




