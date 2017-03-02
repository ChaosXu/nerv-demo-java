# nerv-demo-java

Nerv can deploy and monitoring any java application, don't care it's development environment and framework.

## Spring Boot Application

The project in the directory nerv-app-springboot.

### Develop

#### Create a service template

Create a nerv template for application in the file /nerv/nerv-app-springboot.json, set parameters:

##### node nerv-app-springboot

* file_repository: The root url of file service in the nerv server.
* pkg_url: The package of the application for deploy.
* config_url: The configuration file of the application.

##### node host

* address: The address of the host where to be deployed

```json
{
    "name": "address",
    "value": "${host_ip_list}"
}
```

The varaiable host_ip_list is a input parameter:

```json
{
  "name": "/nerv/demo/nerv-app-springboot",
  "version": 1,
  "inputs": [
    {
      "name": "host_ip_list",
      "type": "string[]"
    }
  ],
  ...
}
```

#### Create a start shell script

Create a shell script app called by nerv for control application lifecycle.The script must support commands:

* start: Start application
* stop: Stop application

#### Record PID in app.pid

The start script must save the pid of application in the log file app.pid. Nerv will check it when install, start.

### Relase

Start nerv firstly, then use maven to release the application

```shell
nerv-demo-java$ cd nerv-app-springboot
nerv-app-springboot$ mvn clean install
nerv-app-springboot$ cd target
target$ ls
nerv-app-springboot-1.0.tgz #The package of application
```

1. The release pkg nerv-app-springboot-1.0.tgz will be uplod to path pkg in the nerv server.
1. The config will be upload to path /resources/config in the nerv server.
1. The template nerv-app-springboot.json will be upload to path /resources/tempaltes in the nerv server

### Deploy & Start

Please read the nerv [README](https://github.com/ChaosXu/nerv) firstly. Then:

Run commands:

```shell
bin$ ./nerv-cli topo create -t ../../resources/tempaltes/nerv/nerv-app-srpingboot-1.0.tgz -o nerv-app-springboot -n app_inputs.json
Create topology success. id=2
bin$ ./nerv-cli topo install -i 2
Install topology success. id=2
bin$ ./nerv-cli topo setup -i 2
Setup topology success. id=2
bin$ ./nerv-cli topo start -i 2
Start topology success. id=2
```

app_inputs.json provid the host ip to be installed

```json
{
  "host_ip_list": [
    "xxxx"
  ]
}
```

Use curl or browser access the url http://server:8080, the application echo:

```shell
I'm a java app!
```

### Monitoring

TBD