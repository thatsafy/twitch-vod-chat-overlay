# twitch-vod-chat-overlay
Create Twitch VODs with simple chat overlay using [TwitchDownloader](https://github.com/lay295/TwitchDownloader) and [FFmpeg](https://ffmpeg.org/).

![Example image of a Twitch VOD overlayed with the chat](example.webp)

## Prerequisites

Download and extract [TwitchDownloader(https://github.com/lay295/TwitchDownloader), have [FFmpeg](https://ffmpeg.org/) installed.
Download the latest release of this script from [releases](https://github.com/thatsafy/twitch-vod-chat-overlay/releases) to the TwitchDownloader directory.

## How to run

Make the script executable with 'chmod +x twitchvods.sh'.
Run script ./twitchvods.sh  vod-url/vod-id output-file-name

The script will first download the vod from twitch, the chat in json format and render the chat into an mp4 file.
It will then use FFmpeg to overlay the chat mp4 file over the video.

Script will create a subdirectory for the output files, $FILENAME/$FILENAME.mp4 + downloaded files.

## Planned features

- Batch rendering
- parallel jobs (downloads+render chat file)
- timestamps?
