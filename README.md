# nerv-demo-java

Nerv can deploy and monitoring any java application, don't care it's development environment and framework.

## Spring Boot Application

The project in the directory nerv-app-springboot.

### Develop

#### Create a service template

Create a nerv template for application in the file /nerv/nerv-app-springboot.json, set parameters:

##### node nerv-app-springboot

* pkg_root: The package root url of file service in the nerv server.
* pkg_url: The package of the application for deploy.
* config_root: The configuration root url of file service in the nerv server.
* config_url: The configuration file of the application.

##### node host

* address: The address of the host where to be deployed
* credential: The ssh credential key pair of the host. The data is stored in DB

#### Create a start shell script

Create a shell script app called by nerv for control application lifecycle.The script must support commands:

* start: Start application
* stop: Stop application

#### Record PID in app.pid

The start script must save the pid of application in the log file app.pid. Nerv will check it when install, start.

### Relase

Use maven to release the application

```shell
nerv-demo-java$ cd nerv-app-springboot
nerv-app-springboot$ mvn clean install
nerv-app-springboot$ cd target
target$ ls
nerv-app-springboot-1.0.tgz #The package of application
```

### Deploy & Start

Please read the nerv [README](https://github.com/ChaosXu/nerv) firstly. Then:

1. Copy nerv-app-springboot.json to NERV_PATH/resources/templates/nerv/demo.
1. Copy nerv-app-springboot-1.0.tgz to NERV_PATH/pkg.
1. Create install setup the application:

```shell
bin$ ./nerv-cli topo create -t ../../resources/tempaltes/nerv/nerv-app-srpingboot-1.0.tgz -o nerv-app-springboot
Create topology success. id=2
bin$ ./nerv-cli topo install -i 2
Install topology success. id=2
bin$ ./nerv-cli topo setup -i 2
Setup topology success. id=2
bin$ ./nerv-cli topo start -i 2
Start topology success. id=2
```

Use curl or browser access the url http://server:8080, the application echo:

```shell
I'm a java app!
```

### Monitoring

TBD

