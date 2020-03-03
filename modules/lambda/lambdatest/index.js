'use strict';
console.log('Loading hello world function');

const mysql = require('mysql');

function connection() {
  return mysql.createConnection({
    host     : process.env.RDS_HOSTNAME,
    user     : process.env.RDS_USERNAME,
    password : process.env.RDS_PASSWORD,
    port     : process.env.RDS_PORT,
    database: process.env.RDS_DATABASE
  });
}

exports.handler = function(event, context, callback) {
    console.log('Received event:', JSON.stringify(event, null, 2));

    var res ={
        "statusCode": 200,
        "headers": {
            "Content-Type": "*/*"
        }
    };

    let con = connection();
    var sql;
    console.log("Event path: " + event.path);
    
    if (event.path == "/table") {
        sql = "CREATE TABLE MESSAGE (message VARCHAR(255))";
    } else if (event.path == "/message") {
        if (event.httpMethod == "POST") {
	     	sql = "INSERT INTO MESSAGE (message) VALUES ('I am MySQL')";
	    }  else {
		  sql = "select * from MESSAGE";
        }
    } 

    let result = con.query(sql, (err, res) => {
    
      if (err) {
        console.log("query error");
        throw err;
      }
    
     // why doesn't this show up in the logs??
     console.log("response from query: " + JSON.stringify(res));
     // how do I get res out of here and into the callback?
     return res;
    });
    
    console.log(result);
    con.destroy();
    
    
   var greeter = 'World';
   if (event.path == "/helloworld") {
      greeter = '?'
      
      if (event.greeter && event.greeter!=="") {
          greeter =  event.greeter;
      } else if (event.body && event.body !== "") {
          var body = JSON.parse(event.body);
          if (body.greeter && body.greeter !== "") {
              greeter = body.greeter;
          }
      } else if (event.queryStringParameters && event.queryStringParameters.greeter && event.queryStringParameters.greeter !== "") {
          greeter = event.queryStringParameters.greeter;
      } else if (event.multiValueHeaders && event.multiValueHeaders.greeter && event.multiValueHeaders.greeter != "") {
          greeter = event.multiValueHeaders.greeter.join(" and ");
      } else if (event.headers && event.headers.greeter && event.headers.greeter != "") {
          greeter = event.headers.greeter;
      } 
    
      
    }
    res.body = "Hello, " + greeter + "!";
    callback(null, res);
};
