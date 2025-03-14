#!/bin/bash

# Source: https://geek.co.il/2023/03/13/script-day-check-the-currently-set-plasma-desktop-wallpaper

##
# Helper to find the user configured name of an activity, by its ID
function getActivityName() {
  qdbus org.kde.ActivityManager /ActivityManager/Activities \
    org.kde.ActivityManager.Activities.ActivityName "$1"
}

##
# Helper to list all the currently configured activities by their ID
function listActivityIds() {
  qdbus org.kde.ActivityManager /ActivityManager/Activities \
    org.kde.ActivityManager.Activities.ListActivities
}

##
# Helper to get the ID of the current activity
function currentActivity() {
  qdbus org.kde.ActivityManager /ActivityManager/Activities \
    org.kde.ActivityManager.Activities.CurrentActivity
}

activity="$1" ## allow the user to choose the activity to look at
screen="${2:-0}" ## allow the user to choose the screen to look at
# but default to the first screen, if they didn't specify

grep -qi plasma <<<"$DESKTOP_SESSION" || { echo "Not running under a Plasma desktop!">&2; exit 1; }

# if the user did not specify an activity, use the current one
[ -z "$activity" ] && activity=$(currentActivity)

# if the user specified the activity by name, locate the ID
if [ -z "$(getActivityName "$activity")" ]; then
	activities=( $(listActivityIds) )
	aname="$activity"
	activity=
	for aid in "${activities[@]}"; do
		if [ "$aname" == "$(getActivityName $aid)" ]; then
			activity=$aid
		fi
	done
fi

[ -z "$activity" ] && { echo "Activity '$activity' was not found!">&2; exit 1; }

# The meat of the thing - ask Plasma to run our script
qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
  var actId = '$activity';
  var scr = $screen;
  var ds = desktops(); // load the containments
  for (let d of ds) { // and walk through them
    // skip any containment that does not match activity and screen
    if (d.readConfig('activityId') != actId ||
        d.readConfig('lastScreen') != scr)
      continue;
    // prepare to read the General configuration (where plugins normally
    // put the current image)
    d.currentConfigGroup = Array('Wallpaper',d.wallpaperPlugin,'General');
    // identify the wallpaper plugin so we can read it properly
    if (d.wallpaperPlugin == 'org.kde.slideshow') {
      print(d.readConfig('Image').replace('file://',''));
    } else if (d.wallpaperPlugin == 'org.kde.image') {
      print(d.readConfig('Image').replace('file://',''));
    } else if (d.wallpaperPlugin == 'org.kde.potd') {
      print('Picture of the Day (Provider: ' + d.readConfig('Provider') +
          ') does not support reading the current image');
    } else {
      print('Unsupported wallpaper plugin: '+d.wallpaperPlugin+'\n');
    }
    break;
  }"