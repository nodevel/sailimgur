import QtQuick 2.0
import "../components/storage.js" as Storage

QtObject {
    id: settings;

    signal settingsLoaded;

    property string accessToken : "";
    property string refreshToken : "";

    // Settings page
    property int albumImagesLimit: 3;
    property bool showComments: false;

    // user
    property string user: "anonymous";

    // slicing arrays
    property int commentsSlice : 25;
    property int albumImagesSlice : 5;

    // default options for gallery
    property string mode : "main"; // main | user | random | memes | favorities
    property string section : "hot"; // hot | top | user
    property string sort : "viral"; // viral | time
    property string window : "day"; // day | week | month | year | all
    property bool showViral : false; // true | false
    property bool autoplayAnim: true; // play anim gifs automatically?

    property string installedVersion: ""; // which version user currently has?

    function loadSettings() {
        //Storage.reset();

        var results = Storage.readAllSettings();
        for (var s in results) {
            if (settings.hasOwnProperty(s)) {
                if (results[s] && results[s] !== "") {
                    settings[s] = results[s];
                }
            }
        }

        readTokens();

        settingsLoaded();
    }

    function saveSettings() {
        Storage.writeSetting("albumImagesLimit", settings.albumImagesLimit);
        Storage.writeSetting("showComments", settings.showComments);
    }

    function saveSetting(key, value) {
        Storage.writeSetting(key, value);
    }

    function readSetting(key) {
        return Storage.readSetting(key);
    }

    function resetTokens() {
        accessToken = "";
        refreshToken = "";
        Storage.writeSetting("accessToken", accessToken);
        Storage.writeSetting("refreshToken", refreshToken);
    }

    function saveTokens() {
        Storage.writeToken("accessToken", accessToken, constant.clientSecret);
        Storage.writeToken("refreshToken", refreshToken, constant.clientSecret);
    }

    function readTokens() {
        accessToken = Storage.readToken("accessToken", constant.clientSecret);
        refreshToken = Storage.readToken("refreshToken", constant.clientSecret);
    }

}
