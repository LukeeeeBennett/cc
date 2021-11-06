# SLAM

## Description

Hot is a SLAM graph module. Have a turtle generate a graph data structure of any unknown environment. There is an additional server provided to share slam across a network of bots.

On your host machine (normal development environement), you should run the server.

```
yarn global add @lbennett/slam-server --latest
slam
```

_NOTE: Set `HOT_PORT=8081` to change the server port._
It will also offer a URL from the internal [ngrok](https://ngrok.com/) proxy. Set `DISABLE_PROXY=true` to disable the internal proxy.

In-game, you can easily install the slam module using [rpm](https://github.com/Reactified/rpm).

```
rpm install slam
```

Configure the slam server with

```
slam server ws://<your_slam_server_ip>
```

Start a scan with

```
slam scan
```

# TODO

- Add `slam server`
- Add `slam scan`
