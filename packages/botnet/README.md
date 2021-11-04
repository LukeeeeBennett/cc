# BotNet

:warning: UNDER DEVELOPMENT :warning:

## Description

BotNet is a websocket network for bots to communicate across.

On your host machine (normal development environement), you should run the server.

```
cd packages/botnet/server
yarn install

./botnet <path_to_file_or_dir_to_sync>
```

This will start the websocket server that manages communications.

In-game, you can easily install the botnet module using [rpm](https://github.com/Reactified/rpm).

```
rpm install botnet
```

From your ComputerCraft device's working directory, start the botnet module pointed at your local-but-public websocket server.

```
botnet ws://my.public.ip:8080
```

To simply obtain a public IP, use [ngrok](https://ngrok.com/).

```
# Host system
ngrok http 8080

# In-game device
botnet ws://<my-ngrok-domain>
```

# TODO

- Share SLAM models
- Pull bot "role" instructions
