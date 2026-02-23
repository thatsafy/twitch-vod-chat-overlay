#!/usr/bin/bash
if [ -z "$1" ]
then
	echo "Usage: ./twitchvods.sh <vod-url or vod-id> <vod-name>"
	exit 1
fi

VOD=$1
FILENAME=$2

echo "Let's make some Twitch vods with chat overlay!"
echo "VOD URL: $VOD"
echo "VOD filename: $FILENAME"

# Chat overlay size
# Defaults:
# CHAT_HEIGHT = 468
# CHAT_WIDTH = 366
CHAT_HEIGHT=468
CHAT_WIDTH=366

# Chat position on screen, x=0 y=0 being top left corner.
# Defaults:
# CHAT_POS_X=50
# CHAT_POS_Y=234
CHAT_POS_X=50
CHAT_POS_Y=234 

echo "Creating video directory $FILENAME"
mkdir $FILENAME
echo "Starting vod download..."
./TwitchDownloaderCLI videodownload --id $VOD -o $FILENAME/$FILENAME-vod.mp4
echo "Vod download finished."

echo "Starting chat download"
./TwitchDownloaderCLI chatdownload --id $VOD -o $FILENAME/$FILENAME-chat.json
echo "VOD chat downloaded"

echo "Starting VOD chat render..."
./TwitchDownloaderCLI chatrender -i $FILENAME/$FILENAME-chat.json -h $CHAT_HEIGHT -w $CHAT_WIDTH --framerate 30 --update-rate 0 --font-size 18 -o $FILENAME/$FILENAME-chat.mp4
echo "Chat rendered."

echo "Inserting the chat overlay using ffmpeg..."
ffmpeg -i $FILENAME/$FILENAME-vod.mp4 -i $FILENAME/$FILENAME-chat.mp4 -filter_complex "[1:v]colorkey=0x111111:0.05:0.1[ckout];[0:v][ckout]overlay=x=$CHAT_POS_X:y=$CHAT_POS_Y[out]" -map "[out]" -map 0:a -c:a copy $FILENAME/$FILENAME.mp4

echo "Video render done! Finished file: $FILENAME/$FILENAME.mp4"
