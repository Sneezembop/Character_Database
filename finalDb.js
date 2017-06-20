
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
var playerEmail = "";
var playerAdmin = false;

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

var mainMenuParams = ["Command"];
var inputParams = ["value"];

function processLogin(input) {
    connection.query('SELECT * FROM players WHERE player_email LIKE \'' + input.userEmail + '\';', function (error, results, fields) {
        if (error) throw error;

        //console.log("results:", results);
        if (results[0] == undefined) {
            console.log("ACCOUNT NOT FOUND, WOULD YOU LIKE TO CREATE A NEW ACCOUNT?[Y/N]");
            getUserInput(['YorN'], processCreatePlayerQuestion);
        } else {
            playerID = results[0].player_id;
            playerEmail = results[0].player_email;
            console.log("WELCOME " + results[0].player_fname + "! PLEASE ENTER A COMMAND.");
            getUserInput(mainMenuParams, processMainMenu);
        }
    });
}

function processCreatePlayerQuestion(input) {
    if (input.YorN == 'Y') {
        console.log("PLEASE ENTER THE FOLLOWING INFO:");
        getUserInput(['email', 'firstName', 'lastName', 'password'], processCreatePlayer);
    } else {
        console.log("PLEASE LOG IN:");
        getUserInput(['userEmail', 'password'], processLogin);
    }
}

function processCreatePlayer(input) {


    connection.query('CALL create_player(\'' + input.email + '\', \'' + input.firstName + '\', \'' + input.lastName + '\')', function (error, results, fields) {
        if (error) throw error;
        console.log("PLAYER CREATED, PLEASE LOG IN");
        getUserInput(['userEmail', 'password'], processLogin);
    });
}

function processCreateCharacter(input){
    connection.query('CALL create_character(\'' + input.characterName + '\', \'' + input.characterClass + '\', \'' + playerEmail + '\')', function (error, results, fields) {
        if (error) throw error;
        console.log("CHARACTER CREATED!");
        getUserInput(mainMenuParams, processMainMenu);
    });

}


var ValidMainCommands = ['CREATE', 'DELETE', 'UPDATE', 'VIEW', 'QUIT', 'HELP'];

function processMainMenu(input) {
    switch (input.Command) {
        case 'CREATE':
            getUserInput(['characterName','characterClass'],processCreateCharacter);
            break;
        case 'DELETE':
            quit();
            break;
        case 'UPDATE':
            quit();
            break;
        case 'VIEW':
            quit();
            break;
        case 'QUIT':
            quit();
            break;
        case 'HELP':
            displayHelpMenu();
            getUserInput(mainMenuParams, processMainMenu);
            break;
        default:
            console.log("INVALID COMMAND, TRY AGAIN.  TYPE HELP IF YOU NEED ASSISTANCE.");
            console.log("PLEASE ENTER A COMMAND:");
            getUserInput(mainMenuParams, processMainMenu);
    }


}

function displayHelpMenu(){

            console.log("HELP LIST:");
            console.log("\t-\t-\t-\tMAIN MENU COMMANDS\t-\t-\t-");
            console.log("COMMAND\t-\t-VALUE");
            console.log("CREATE\t-\t[character name]\t-\tcreates a new character with the inputed name. (NOT FINISHED)");
            console.log("VIEW\t-\t[character name]\t-\tshows the stats of the character. (NOT FINISHED)");
            console.log("UPDATE\t-\t[character name]\t-\tallows players to update their characters. (NOT FINISHED)");
            console.log("DELETE\t-\t[character name]\t-\tdeletes character from the system. (NOT FINISHED)");
            console.log("HELP\t-\t[none]\t-\tshows the help menu.");
            console.log("QUIT\t-\t[none]\t-\texits the program.");
};
