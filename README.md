### Disclaimer

Experimental docker for test pruposes.
Partially based over 
[MaximeD/docker-react-native](https://github.com/MaximeD/docker-react-native) and
[mayhewluke/react-native-docker](https://github.com/mayhewluke)
Use at your own risk!

# Usage
## Get and install the image

Clone the repository and build the image:
```
git clone https://github.com/pablogottifredi/react-native-test-ci
cd react-native-test-ci
```


### Use Makefile 
To build the image use Makefile
The image use an Ubuntu 18.04 and download Android SDK 4333796
The process download > 3GB of data. Be patient to build
```
make build
```

For test pruposes I suggest you use
```
make watch
```

The difference is de docker-compose.yml use to mount and enviroment setted


If you want access to shell you can use `docker exec -ti react-native-test-ci sh` 
or use the follow make command
```
make run ACTION=shell
```

## Docker Entry point
The image are designed to run command through the bash/docker-entrypoint.sh
In watch mode, the shell is mapped from the host, to help you to add commands
Is possible directly use the enviroment through the shell.

If you want launch command from host you can use
```
make run ACTION=<command>
```

### Commands enabled
```
shell: launch an interactive shell
emulator: build and emulator Nexus 5 (setted in docker-entrypoint.sh)
devices: list devices installed in the image
launch: build and install the app into the emulator o device connected
```


## Put your code and go
The docker-compose are designed to use de /src folder to build, or use for developer pruposes
Only put your src with the respective package.json to install dependencies.
The command `launch` run the compiler

```
make run ACTION=launch
```

## Debugger
You can use de debugger accross
```
localhost:8081/debugger-ui
```
You can use your own physical device if you active the developer options


## Pending
- [ ] Use volumes to make the images
- [ ] Replace dist folder outside the src 
- [ ] Configure script to read tty of each command
- [ ] Config correcty host+ command to restrict clients
- [ ] CI pipeline to production build
