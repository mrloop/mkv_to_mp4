# mkv_to_mp4

[![endorse](http://api.coderwall.com/mrloop/endorsecount.png)](http://coderwall.com/mrloop)

Simple script to remux mkv to mp4. Useful for changing file container from mkv where video is encoded using h264 and audio AC3 to mp4 without any additional encoding, video and audio streams passthrough.
The script will search the current directory and sub directories for mkv files. Foreach mkv it'll look to see if a corresponding mp4 exists, if it doesn't it'll attempt to remux it.

## Usage

```shell
./mkv_to_mp4.sh
```

```shell
./mkv_to_mp4.sh file_dir
```
