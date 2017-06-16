// CS 5200 FINAL PROJECT
// Nick Morgan, Miles Benjamin, AJ Esguerra

var mysql = require('mysql');

var config = require('./config');

var connection = mysql.createConnection({
    host: config.host,
    user: config.user,
    password: config.password,
    database: config.database
});

var prompt = require('prompt');


main();


/*
connection.query('SELECT * FROM planets WHERE planets.affiliation = \'rebels\'', function (error, results, fields) {
  if (error) throw error;
  console.log('The solution is:\n', results);
});
 */

function quit() {
    prompt.stop();
    connection.end();
}

function main() {
    connection.connect();
     prompt.start();

    getUserInput(processUserInput);

}

function getUserInput(callback) {
   
    prompt.get(['command', 'value'], function (err, result) {
        if (err) throw err;
        callback(result);
    });

}
var ValidCommands = ['CREATE', 'DELETE', 'UPDATE', 'VIEW', 'QUIT'];

function processUserInput(input) {
    

    if (ValidCommands.includes(input.command)) {
        console.log('VALID COMMAND! ' + input.value + '\n');
    } else {
        console.log('INVALID COMMAND\n');
    }

    if (input.command == 'QUIT') {
        quit();
    } else {
        getUserInput(processUserInput);
    }

}
