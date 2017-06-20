
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

// GLOBALS
var playerID = 0;

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
    
   // load('Axiom Verge Soundtrack - Trace Awakens.mp3').then(play);

    console.log("WELCOME TO THE RPG CHARACTER DATABASE SYSTEM");
    console.log("                                 .       .                              ");
    console.log("                                / `.   .' \\                             ");
    console.log("                        .---.  <    > <    >  .---.                     ");
    console.log("                        |    \\  \\ - ~ ~ - /  /    |                     ");
    console.log("                         ~-..-~             ~-..-~                      ");
    console.log("                     \\~~~\\.'                    `./~~~/                 ");
    console.log("           .-~~^-.    \\__/                        \\__/                  ");
    console.log("         .'  O    \\     /               /       \\  \\                    ");
    console.log("        (_____,    `._.'               |         }  \\/~~~/              ");
    console.log("         `----.          /       }     |        /    \\__/               ");
    console.log("               `-.      |       /      |       /      `. ,~~|           ");
    console.log("                   ~-.__|      /_ - ~ ^|      /- _      `..-'   f: f:   ");
    console.log("                        |     /        |     /     ~-.     `-. _||_||_  ");
    console.log("                        |_____|        |_____|         ~ - . _ _ _ _ _> ");
    console.log("PLEASE LOG IN");

    getUserInput(['userEmail', 'password'], processLogin);

}

function getUserInput(params, callback) {

    prompt.get(params, function (err, result) {
        if (err) throw err;
        callback(result);
    });

}
var ValidCommands = ['CREATE', 'DELETE', 'UPDATE', 'VIEW', 'QUIT'];

function processLogin(input) {
    connection.query('SELECT * FROM players WHERE player_email LIKE \'' + input.userEmail + '\';', function (error, results, fields) {
        if (error) throw error;

        console.log("results:", results);
        if (results[0] == undefined){
            console.log("PLAYER NOT FOUND, PLEASE ENTER THE FOLLOWING INFO TO CREATE ACCOUNT");
            getUserInput(['email', 'firstName', 'lastName'], processCreatePlayer);
        } else {
            playerID = results[0].player_id;
            console.log("WELCOME "+ results[0].player_fname + "!");
            quit();
        }
    });
}

function processCreatePlayer(input){
    connection.query('CALL create_player(\'' + input.email + '\', \'' + input.firstName + '\', \'' + input.lastName + '\')', function (error, results, fields) {
        if (error) throw error;
        console.log ("PLAYER CREATED, PLEASE LOG IN");
        getUserInput(['userEmail', 'password'], processLogin);
    });
}

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
