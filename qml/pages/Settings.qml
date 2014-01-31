import QtQuick 2.0

QtObject {
    id: settings;

    property string appName : "Sailimgur";

    property string client_id : "956cdde55ca20c8";
    property string client_secret : "249aaad000f45839c2cf517a200a5be8072cd0ca";

    property string user_agent : appName + " " + APP_VERSION + "-" + APP_RELEASE + "(Jolla; Qt; SailfishOS)";

    // default options for gallery
    property string mode : "main";
    property string section : "hot"; // hot | top | user
    property string sort : "viral"; // viral | time
    property string window : "top"; // day | week | month | year | all
    property bool showViral : true; // true | false

    property string galleryModeText : "The most viral images, sorted by popularity";
    property string galleryModeTextDefault : "The most viral images, sorted by popularity";
    property string galleryModeTextRandom: "Randomly selected images";

    property bool autoplayAnim: true; // play anim gifs automatically?
    property bool showComments: true;

    property int commentPointsLimit: 1;

}
