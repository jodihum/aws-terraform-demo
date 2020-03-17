'use strict';
console.log('Loading schema function');

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
    
    let sql = "CREATE TABLE IF NOT EXISTS MESSAGE (message VARCHAR(255))";
   
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
