'use strict';
console.log('Loading hello world function');

const mysql = require('mysql');

function connection() {
  return mysql.createConnection({
    host     : process.env.RDS_HOSTNAME,
    user     : process.env.RDS_USERNAME,
    password : process.env.RDS_PASSWORD,
    port     : process.env.RDS_PORT,
    database : 'newdb'
  });
}

//let responseCode = 200;

exports.handler = function(event, context, callback) {
    console.log('Received event:', JSON.stringify(event, null, 2));
    const sql = "select * from MESSAGE";
    let con = connection();
    let result = con.query(sql, (err, res) => {
    
      if (err) {
        console.log("query error");
        throw err;
      }
    
     console.log("response from query: " + JSON.stringify(res));

     return res;
    });
    console.log(result);
    con.destroy();
    
    var res ={
        "statusCode": 200,
        "headers": {
            "Content-Type": "*/*"
        }
    };
    var greeter = 'World';
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
    
    res.body = "Hello, " + greeter + "!";
    //res.body = result;
    callback(null, res);
};


