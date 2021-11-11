# SLAM

## Description

Have a turtle generate a graph data structure of any unknown environment. There is an additional server provided to share slam across a network of bots.

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
slam scan <start_x> <start_y> <start_z> <heading>
```

_NOTE: `x`, `y` and `z` are the starting coords of the device._ `heading` is either `n`, `e`, `s` or `w` depending on how the device is oriented.

## Development

```
 ---BACK--
|   NODE  |
|    A    |
|         |
 --FRONT--
     |
     | HEAD
     |
    ---
   | E | (
   | D |   if direction needed:
   | G |     'head->tail', 'head<-tail', 'head<->tail'
   | E | )
    ---
     |
     | TAIL
     |
 ---BACK--
|   NODE  |
|    B    |
|         |
 --FRONT--
```
