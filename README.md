# Handly Virtul Machine

## Build Virtual Machine Image

1. Create a source voulme of the machine name under a persistent location (For example, you can create a directory `MyMachine` under `/your/dev/files`). 
2. Create a directory of the machine name under this repository root (namely, `handy_development_containers`).
3. Prepare `Dockerfile` for the machine under the directory created in 2.
4. Run (replace `MyMachine` with your machine name):
```sh
handy_development_containers]$ ./build.sh MyMachine
```

## Create a New Container from Machine Image

```sh
handy_development_containers]$ ./control.sh up MyMachine [Host Name] [Root of the source volumes (`/your/dev/files` etc.)]
```

## Remove a Container

```sh
handy_development_containers]$ ./control.sh down MyMachine
```

## Stop a Container

```sh
handy_development_containers]$ ./control.sh stop MyMachine
```

## Start a Container

```sh
handy_development_containers]$ ./control.sh start MyMachine
```
