
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
        console.log(results);
        console.log("CHARACTER CREATED!");
        backToMainMenu();
    });

}

function processMainMenu(input) {
    refreshView();
    switch (input.Command) {
        case 'CREATE':
            getUserInput(['characterName', 'characterClass'], processCreateCharacter);
            break;
        case 'DELETE':
            diaplayDeleteMenu();
            break;
        case 'UPDATE':
            displayUpdateMenu();
            break;
        case 'VIEW':
            displayViewMenu();
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
            getUserInput(mainMenuParams, processMainMenu);
    }


}

function displayUpdateMenu() {
        displayCharacters(function (foundChar) {
        if (!foundChar) {
            getUserInput(mainMenuParams, processMainMenu);
        } else {
            console.log("TYPE A CHARACTER NAME TO UPDATE");
            getUserInput(['characterName', 'update'], processUpdate);
        }
    });
}

function processUpdate(input){
    switch(input.update){
        case 'LEVELUP':
        console.log("LEVELED UP " + input.characterName);
        break;
        case 'RENAME':
        console.log("RENAMED " + input.characterName);
        break;
        case 'CLASS':
        console.log("CLASS CHANGE " + input.characterName);
        break;
        case 'BACK' :
            backToMainMenu();
        break;
        default :
        console.log("INVALID FUNCTION TRY AGAIN, BACK TO GO BACK.");
    }

    getUserInput(mainMenuParams, processMainMenu);
}

function diaplayDeleteMenu() {
    displayCharacters(function (foundChar) {
        if (!foundChar) {
            getUserInput(mainMenuParams, processMainMenu);
        } else {
            console.log("TYPE A CHARACTER NAME TO DELETE");
            getUserInput(['characterName'], processDeletion);
        }
    });

}
var characterToDelete = '';

function processDeletion(input) {
    //console.log(input);
    characterToDelete = input.characterName;
    getCharID(characterToDelete, function (charID) {

        //console.log(charID[0].character_id);
        getBasicCharInfo(charID[0].character_id, function (results) {
            displayBasicCharInfo(results[0]);
            console.log("ARE YOU SURE?");
            getUserInput(['Confirm'], finalizeDeletion);
        });
    });


}
function finalizeDeletion(input) {
    if (input.Confirm != "Y") {
        getUserInput(mainMenuParams, processMainMenu);
    } else {
        getCharID(characterToDelete, function (result) {
            connection.query('CALL delete_character(\'' + characterToDelete + '\');', function (error, results, fields) {
                if (error) throw error;
                console.log(results);
                getUserInput(mainMenuParams, processMainMenu);
            });

        });
    }
}

function processView(input) {

    getCharID(input.characterName, function (results) {
        if (results[0] == undefined) {
            displayViewMenu();
        } else {

            var CharacterID = results[0].character_id;
            //console.log("CHAR NAME:");
            //console.log(results[0].character_id);
            //
            getBasicCharInfo(CharacterID, function (results) {
                refreshView();
                displayBasicCharInfo(results[0]);
                getDetailedCharInfo(input.characterName, function (results) {
                    displayDetailCharInfo(results[0]);
                    getCharEquipInfo(CharacterID, function (results) {
                        displayCharEquipInfo(results[0]);
                        getCharSkillsInfo(CharacterID, function (results) {
                            displayCharSkillsInfo(results[0]);
                            getCharSpellsInfo(CharacterID, function (results) {
                                displayCharSpellsInfo(results[0]);
                                console.log("ENTER A COMMAND:");
                                getUserInput(mainMenuParams, processMainMenu);

                            });
                        });

                    });

                });
            });
        }
    });


}
function getCharID(characterName, callback) {
    connection.query('SELECT character_id FROM characters WHERE character_name = \'' + characterName + '\';', function (error, results, fields) {
        if (error) throw error;
        callback(results);
    });
}
function backToMainMenu() {
    refreshView();
    console.log("ENTER A COMMAND:");
    getUserInput(mainMenuParams, processMainMenu);
}

function getBasicCharInfo(CharacterID, callback) {
    connection.query('CALL read_basic_char_info(\'' + CharacterID + '\')', function (error, results, fields) {
        if (error) throw error;
        callback(results);
    });
}
function getDetailedCharInfo(characterName, callback) {
    connection.query('CALL read_character_detail(\'' + characterName + '\')', function (error, results, fields) {
        if (error) throw error;
        callback(results);
    });
}
function getCharEquipInfo(CharacterID, callback) {
    connection.query('CALL read_equipment_detail(\'' + CharacterID + '\')', function (error, results, fields) {
        if (error) throw error;
        callback(results);
    });
}
function getCharSkillsInfo(CharacterID, callback) {
    connection.query('CALL read_skills_detail(\'' + CharacterID + '\')', function (error, results, fields) {
        if (error) throw error;
        callback(results);
    });
}
function getCharSpellsInfo(CharacterID, callback) {
    connection.query('CALL read_spells_detail(\'' + CharacterID + '\')', function (error, results, fields) {
        if (error) throw error;
        callback(results);
    });
}
function displayBasicCharInfo(info) {
    console.log("###################################################################################################");
    console.log("CHARACTER NAME: " + info[0].character_name + "\t\tLEVEL: " + info[0].character_level + "\t\tCLASS: " + info[0].class_name + "\t\tHP: " + 0 + "/" + 0);

}

function displayDetailCharInfo(info) {
    console.log("###################################################################################################");
    console.log("STR: " + info[0].strength + "\t\tDEX: " + info[0].dexterity + "\t\tCON: " + info[0].constitution + "\t\tINT: " + info[0].intelligence + "\t\tWIS: " + info[0].wisdom + "\t\tCHA: " + info[0].charisma);
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
    displayCharacters(function (foundChar) {
        if (!foundChar) {
            getUserInput(mainMenuParams, processMainMenu);
        } else {
            console.log("TYPE A CHARACTER NAME TO VIEW");
            getUserInput(['characterName'], processView);
        }
    });

}
function displayCharacters(callback) {
    connection.query('CALL read_all_characters(\'' + playerEmail + '\')', function (error, results, fields) {
        if (error) throw error;
        //console.log(results);
        if (results[0][0] == undefined) {
            console.log("NO CHARACTERS TO DISPLAY, TRY CREATING A CHARACTER.");
            callback(false);
        } else {
            console.log("YOUR CHARACTERS: ");
            for (var i = 0; i < results[0].length; i++) {
                console.log(results[0][i].character_name);
            }
            callback(true);
        }
    });
}

function displayHelpMenu() {

    console.log("HELP LIST:");
    console.log("\t-\t-\t-\tMAIN MENU COMMANDS\t-\t-\t-");
    console.log("CREATE\t-\tcreates a new character.");
    console.log("VIEW\t-\tshows the stats of the character. (MOSTLY FINISHED)");
    console.log("UPDATE\t-\tallows players to update their characters. (NOT FINISHED)");
    console.log("DELETE\t-\tdeletes character from the system.");
    console.log("HELP\t-\tshows the help menu.");
    console.log("QUIT\t-\texits the program.");
    console.log("\r\t-\t-\t-\tUPDATE COMMANDS\t-\t-\t-");
    console.log("LEVELUP\t-\tlevels up a character.");
    console.log("RENAME\t-\trenames a character. (MOSTLY FINISHED)");
    console.log("CLASS\t-\tchanges the character's class. (NOT FINISHED)");
    console.log("BACK\t-\tgoes back to main menu");
}
