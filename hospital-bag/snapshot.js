#import "SnapshotHelper.js"

var target = UIATarget.localTarget();
var app = target.frontMostApp();
var window = app.mainWindow();

target.delay(3)
captureLocalizedScreenshot("0-LandingScreen")

target.frontMostApp().mainWindow().tableViews()[0].cells()["For Mom"].tap();
target.frontMostApp().mainWindow().tableViews()[0].cells()["Underwear"].tap();
target.frontMostApp().mainWindow().tableViews()[0].cells()["Nursing Bras"].tap();

target.delay(3)
captureLocalizedScreenshot("1-Mom")