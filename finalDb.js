
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


function quit() {
    prompt.stop();
    connection.end();
    process.stdout.write('\033c');
    console.log("PROGRAM ENDED");
}

function main() {
    connection.connect();
    prompt.start();



    refreshView();
    console.log("PLEASE LOG IN");

    getUserInput(['userEmail', 'password'], processLogin);

}
function refreshView() {
    process.stdout.write('\033c');
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
            refreshView();
            console.log("WELCOME " + results[0].player_fname + "! PLEASE ENTER A COMMAND.");
            getUserInput(mainMenuParams, processMainMenu);
        }
    });
}

function processCreatePlayerQuestion(input) {
    refreshView();
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
        refreshView();
        console.log("PLAYER CREATED, PLEASE LOG IN");
        getUserInput(['userEmail', 'password'], processLogin);
    });
}

function processCreateCharacter(input) {
    connection.query('CALL create_character(\'' + input.characterName + '\', \'' + input.characterClass + '\', \'' + playerEmail + '\')', function (error, results, fields) {
        if (error) throw error;
        refreshView();
        console.log("CHARACTER CREATED!");
        getUserInput(mainMenuParams, processMainMenu);
    });

}

function processMainMenu(input) {
    refreshView();
    switch (input.Command) {
        case 'CREATE':
            getUserInput(['characterName', 'characterClass'], processCreateCharacter);
            break;
        case 'DELETE':
            quit();
            break;
        case 'UPDATE':
            quit();
            break;
        case 'VIEW':
            displayViewMenu();
            //getUserInput(['characterName'], processView);
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

function processView(input) {

    connection.query('SELECT character_id FROM characters WHERE character_name = \'' + input.characterName + '\';', function (error, results, fields) {
        if (error) throw error;
        var CharacterID = results[0].character_id;
        //console.log("CHAR NAME:");
        //console.log(results[0].character_id);
        connection.query('CALL read_basic_char_info(\'' + CharacterID + '\')', function (error, results, fields) {
            if (error) throw error;
            refreshView();
            displayBasicCharInfo(results[0]);
            connection.query('CALL read_equipment_detail(\'' + CharacterID + '\')', function (error, results, fields) {
                if (error) throw error;
                displayCharEquipInfo(results[0]);
                connection.query('CALL read_skills_detail(\'' + CharacterID + '\')', function (error, results, fields) {
                    if (error) throw error;
                    displayCharSkillsInfo(results[0]);
                    connection.query('CALL read_spells_detail(\'' + CharacterID + '\')', function (error, results, fields) {
                        if (error) throw error;
                        displayCharSpellssInfo(results[0]);
                        getUserInput(mainMenuParams, processMainMenu);

                    });

                });

            });
        });
    });


}

function displayBasicCharInfo(info) {
    console.log("##########################################################");
    console.log("CHARACTER NAME: " + info[0].character_name + "\t\tLEVEL: " + info[0].character_level + "\t\tCLASS: " + info[0].class_name + "\t\tHP: " + 0 + "/" + 0);
    console.log("##########################################################");
}

function displayDetailCharInfo(info) {
    console.log(info);
}

function displayCharEquipInfo(info) {
    console.log(info);
}
function displayCharSkillsInfo(info) {
    console.log(info);
}
function displayCharSpellsInfo(info) {
    console.log(info);
}

function displayViewMenu() {
    connection.query('CALL read_all_characters(\'' + playerEmail + '\')', function (error, results, fields) {
        if (error) throw error;

        console.log(results[0]);
        console.log("VIEW WHICH CHARACTER?");
        getUserInput(['characterName'], processView);
    });

}

function displayHelpMenu() {

    console.log("HELP LIST:");
    console.log("\t-\t-\t-\tMAIN MENU COMMANDS\t-\t-\t-");
    console.log("CREATE\t-\tcreates a new character.");
    console.log("VIEW\t-\tshows the stats of the character.");
    console.log("UPDATE\t-\tallows players to update their characters. (NOT FINISHED)");
    console.log("DELETE\t-\tdeletes character from the system. (NOT FINISHED)");
    console.log("HELP\t-\tshows the help menu.");
    console.log("QUIT\t-\texits the program.");
}
