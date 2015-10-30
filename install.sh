#!/bin/bash

cp FollowPleaSettings.stub ../FollowPleaSettings.tmp

echo -n "Tweak Bundle ID (e.g. com.organization.tweakname):"
read tweakName

echo -n "Twitter Screenname (without @ symbol):"
read twitterID

echo "===================="
echo "Installing..."

sed -e "s/\${BUNDLE_ID}/$tweakName/" -e "s/\${TWITTER_ID}/$twitterID/" ../FollowPleaSettings.tmp > ../FollowPleaSettings.h

echo "Cleaning Up..."

rm "../FollowPleaSettings.tmp"

echo "Installation complete! Don't forget to customize the FollowSettings.h file some more. Enjoy!"
