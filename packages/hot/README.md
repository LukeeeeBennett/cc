# Hot

:warning: UNDER DEVELOPMENT :warning:

## Description

Hot is a hot reloader module for use in-game.
Make changes to code locally in your own development environment and have files instantly updated in game on your ComputerCraft device.

On your host machine (normal development environement), you should run the server.

```
cd packages/hot/server
yarn install

./hot <path_to_file_or_dir_to_sync>
```

This will wait for changes in your target file/dir using [chokidar](https://github.com/paulmillr/chokidar) and emits these changes to all connected and subscribing clients.

The message emitted to socket clients follows the format `change:<file_path>:<file_contents_utf8>`.

In-game, you can easily install the hot module using [rpm](https://github.com/Reactified/rpm).

```
rpm install hot
```

From your ComputerCraft device's working directory, start the hot module pointed at your local-but-public websocket server.

```
hot ws://my.public.ip:8080
```

To simply obtain a public IP, use [ngrok](https://ngrok.com/).

```
# Host system
ngrok http 8080

# In-game device
hot ws://<my-ngrok-domain>
```

If successful, changing files that are within the target of your hot server will have them updated on your connected devices.

# TODO

- Automatically run and re-run scripts that are being served by hot
- Automatically create public IP when running server
- Package server to be installed as a CLI tool without cloning source
- Guard against source with message delimeters
