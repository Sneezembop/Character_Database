
// CS 5200 FINAL PROJECT
// Nick Morgan, Miles Benjamin, Arnold Esguerra                      

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
    var query = 'CALL create_character(\'' + input.characterName + '\',\'' + input.characterClass + '\',\'' + playerEmail + '\');';
    connection.query(query, function (error, results, fields) {
        if (error) throw error;
        refreshView();
       // console.log(query);
        console.log(results);
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
            console.log("TYPE A UPDATE PROCEDURE AND CHARACTER");
            console.log("COMMANDS INCLUDE: LEVELUP, EQUIP, CLASS, HEALTH OR BACK");
            getUserInput(['update', 'characterName'], processUpdate);
        }
    });
}

function processUpdate(input) {
    switch (input.update) {
        case 'LEVELUP':
            levelup(input.characterName);
            break;
        case 'RENAME':
            console.log("RENAME AVAILABLE IN FULL PRODUCT");
            getUserInput(mainMenuParams, processMainMenu);
            break;
        case 'EQUIP':
            equipChange(input.characterName);
            break;
        case 'CLASS':
            classChange(input.characterName);
            break;
        case 'HEALTH':
            healthChange(input.characterName);
            break;
        case 'BACK':
            backToMainMenu();
            break;
        default:
            console.log("INVALID FUNCTION, SENDING BACK TO MENU.");
            getUserInput(mainMenuParams, processMainMenu);
    }


}

function equipChange(characterName) {
    getCharID(characterName, function (charID) {
        getCharEquipInfo(charID[0].character_id, function (info) {
            displayCharEquipInfo(info[0]);
            console.log('EQUIP OR UNEQUIP?');
            getUserInput(['equip', 'itemName'], function (input) {
                var myquery = '';
                if (input.equip == 'EQUIP') {
                    myquery = 'CALL add_equip_to_char(\'' + characterName + '\',\'' + input.itemName + '\');';
                } else if (input.equip == 'UNEQUIP') {
                    myquery = 'CALL remove_char_equipment(\'' + characterName + '\',\'' + input.itemName + '\');';
                }

                console.log(myquery);
                if (myquery != '') {
                    connection.query(myquery, function (error, results, fields) {
                        console.log(results);
                        getUserInput(mainMenuParams, processMainMenu);
                    });
                } else {
                    getUserInput(mainMenuParams, processMainMenu);
                }

            });
        })
    });

}


function healthChange(characterName) {
    getUserInput(['healthVal'], function (input) {
        var myquery = 'CALL update_health(\'' + characterName + '\', \'down\', \'' + input.healthVal + '\');'
        console.log(myquery);
        connection.query(myquery, function (error, results, fields) {
            console.log(results);
            getUserInput(mainMenuParams, processMainMenu);
        });

    });
}

function levelup(characterName) {
    connection.query('CALL character_level_up(\'' + characterName + '\');', function (error, results, fields) {
        if (error) throw error;
        console.log(results);
        getUserInput(mainMenuParams, processMainMenu);
    });

}
function classChange(characterName) {
    getUserInput(['newClass'], function (input) {
        var myquery = 'CALL change_class(\'' + characterName + '\', \'' + input.newClass + '\');'
        console.log(myquery);
        connection.query(myquery, function (error, results, fields) {
            console.log(results);
            getUserInput(mainMenuParams, processMainMenu);
        });

    });
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
    console.log("COMMANDS INCLUDE: VIEW, UPDATE, CREATE, DELETE, HELP, QUIT.");
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
    //console.log(info);
    console.log("###################################################################################################");
    console.log("CHARACTER NAME: " + info[0].character_name + "\t\tLEVEL: " + info[0].character_level + "\t\tCLASS: " + info[0].class_name + "\t\tHP: " + info[0].current_health_points + "/" + info[0].total_health_points);

}

function displayDetailCharInfo(info) {
    console.log("###################################################################################################");
    console.log("STR: " + info[0].strength + "\t\tDEX: " + info[0].dexterity + "\t\tCON: " + info[0].constitution + "\t\tINT: " + info[0].intelligence + "\t\tWIS: " + info[0].wisdom + "\t\tCHA: " + info[0].charisma);
}

function displayCharEquipInfo(info) {
    console.log("###################################################################################################");
    console.log("EQUIPMENT");
    for (var i = 0; i < info.length; i++) {
        console.log("ITEM: " + info[i].equipment_name + "\t\tWT: " + info[i].equipment_weight + "\t\tQT: " + info[i].ce_quantity + "\t\tDESC: " + info[i].equipment_description);
    }

}
function displayCharSkillsInfo(info) {
    console.log("###################################################################################################");
    console.log("SKILLS");
    for (var i = 0; i < info.length; i++) {
        console.log("NAME: " + info[i].skill_name + "\t\tLVL: " + info[i].level + "\t\tATT: " + info[i].attribute + "\t\tDESC: " + info[i].skill_description);
    }
}
function displayCharSpellsInfo(info) {
    console.log("###################################################################################################");
    console.log("SPELLS");
    for (var i = 0; i < info.length; i++) {
        console.log("NAME: " + info[i].spell_name + "\t\tLVL: " + info[i].level + "\t\tATT: " + info[i].attribute + "\t\tDESC: " + info[i].spell_description);
    }
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
    console.log("VIEW\t-\tshows the stats of the character.");
    console.log("UPDATE\t-\tallows players to update their characters.");
    console.log("DELETE\t-\tdeletes character from the system.");
    console.log("HELP\t-\tshows the help menu.");
    console.log("QUIT\t-\texits the program.");
    console.log("\r\t-\t-\t-\tUPDATE COMMANDS\t-\t-\t-");
    console.log("LEVELUP\t-\tlevels up a character.");
    console.log("RENAME\t-\trenames a character. (FUTURE UPDATE)");
    console.log("CLASS\t-\tchanges the character's class. ");
    console.log("EQUIP\t-\tchanges a character's gear. ");
    console.log("HEALTH\t-\tsubtracts a number from character's current health.");
    console.log("BACK\t-\tgoes back to main menu");
}
