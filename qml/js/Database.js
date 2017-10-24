.pragma library

.import QtQuick.LocalStorage 2.0 as Storage

function instance() { return openDatabase("1.0"); }
function openDatabase(version) { return Storage.LocalStorage.openDatabaseSync("MainDB", version, "MainDB", 1000000); }

function load() {
    instance().transaction(function(tx) {
        tx.executeSql("CREATE TABLE IF NOT EXISTS active_iconpack (active TEXT, type TEXT)"); // Creates table which holds current active iconpack

        var res = tx.executeSql("SELECT * FROM active_iconpack");

        if(res.rows.length > 0)
            return;

        tx.executeSql("INSERT INTO active_iconpack (active,type) VALUES ('none','fonts')"); // Insert an empty value to the table
        tx.executeSql("INSERT INTO active_iconpack (active,type) VALUES ('none','icons')"); // Insert an empty value to the table
    });
}

function activateIconPack(name, type) {
    instance().transaction(function(tx) {
        tx.executeSql("UPDATE active_iconpack SET active=? WHERE type=?;", [name, type]);
    });
}

function activateFont(name) { activateIconPack(name, "fonts"); }
function activateIcon(name) { activateIconPack(name, "icons"); }

function getActiveIconPack(type) {
    var res = "none";

    instance().transaction( function(tx) {
        var r = tx.executeSql("SELECT active FROM active_iconpack WHERE type = ?;", [type]);

        if(r.rows.length <= 0)
            return;

        res = r.rows.item(0).active;
    });

    return res;
}

function getActiveFont() { return getActiveIconPack("fonts"); }
function getActiveIcon() { return getActiveIconPack("icons"); }
