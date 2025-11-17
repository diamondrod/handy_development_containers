# Handy Development Containers

Scripts to build a simple development environments with Docker containers.

**Note:** for Mac, you should set [Lima](https://github.com/lima-vm/lima/) with the docker template.

## 1. Build Virtual Machine Image

1. Create a source voulme of the machine name under a persistent location (For example, you can create a directory `MyMachine` under `/your/dev/files`). 
2. Create a source voulme for a shared directory across containers under a persistent location (`Shared` under `/your/dev/files`). 
3. Create a directory of the machine name under this repository root (namely, `handy_development_containers`).
4. Prepare `Dockerfile` for the machine under the directory created in 2.
5. Run (replace `MyMachine` with your machine name):
```sh
handy_development_containers]$ ./build.sh MyMachine
```
If you need to build without cache, run:
```sh
handy_development_containers]$ ./build.sh MyMachine --no-cache
```

## 2. Control Script

This section shows how to use control scripts.

### 2.1. Create a New Container from Machine Image

```sh
handy_development_containers]$ ./control.sh up MyMachine [--port source:destination]+ [Host Name used in the container] [Root of the source volumes (`/your/dev/files` etc.)]
```

### 2.2. Remove a Container

```sh
handy_development_containers]$ ./control.sh down MyMachine
```

### 2.3. Stop a Container

```sh
handy_development_containers]$ ./control.sh stop MyMachine
```

### 2.4. Start a Container

```sh
handy_development_containers]$ ./control.sh start MyMachine
```

## 3. Samples

Two samples are provided in this repository:
- [Ubuntu 22.04](./Revival)
- [AlmaLinux 9](./Sanctuary/)
