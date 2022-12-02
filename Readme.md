# ffmpeg-watch

A Docker container designed to watch a directory and encode any file to 8 bit mono uLaw WAV files

You need to set your watch and output folders either as ENVIRONMENT variables or map volumes in docker-compose:
```docker-compose 
services:
  ffmpeg-watch:
    container_name: ffmpeg-watch
    image: labithiotis/ffmpeg-watch
    restart: always
    volumes:
      - 'PATH_TO_STORAGE:/storage'
      - 'PATH_TO_WATCH:/watch'
      - 'PATH_TO_OUTPUT:/output'
```

## Options

|Variables|Default||
|:---|:---|:---|
| WATCH       | /watch | Location of files to encode.         |
| OUTPUT       | /output | Where encoded files are saved.              |
| STORAGE       | /storage |Temp directory while processing files.|
