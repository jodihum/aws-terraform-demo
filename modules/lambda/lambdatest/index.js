'use strict';
console.log('Loading hello world function');

const mysql = require('mysql');

var pool  = mysql.createPool({
    host     : process.env.RDS_HOSTNAME,
    user     : process.env.RDS_USERNAME,
    password : process.env.RDS_PASSWORD,
    port     : process.env.RDS_PORT,
    database : process.env.RDS_DATABASE
});

exports.handler =  (event, context, callback) => {
  context.callbackWaitsForEmptyEventLoop = false;
  
  pool.getConnection(function(error, connection) {
    if (error) callback(error);
      
    console.log("Event path: " + event.path);
    
    // Handle hello world path
    if (event.path == "/helloworld") {
      var res ={
        "statusCode": 200,
        "headers": {
            "Content-Type": "*/*"
          }
        };
        res.body = "Hello World"
        callback(null,res);
    }
   
   // Handle others
    var sql;
    if (event.path == "/table") {
        sql = "CREATE TABLE MESSAGE (message VARCHAR(255))";
    } else if (event.path == "/message") {
        if (event.httpMethod == "POST") {
                sql = "INSERT INTO MESSAGE (message) VALUES ('I am MySQL')";
            }  else {
                  sql = "select * from MESSAGE";
        }
    }
   
    connection.query(sql, function (error, results, fields) {
      connection.release();
     
      var res ={
        "statusCode": 200,
        "headers": {
            "Content-Type": "*/*"
          }
        };
      res.body = JSON.stringify(results);
      
      if (error) callback(error);
      else callback(null,res);
    });
  });
};



