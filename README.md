# Handly Virtul Machine

## Build Virtual Machine Image

1. Create a directory of the machine name under `/mnt/d/dev`
2. Create a directory of the machine name under `containers`
3. Prepare `Dockerfile` for the machine under the directory created in 2.
4. Run:
```sh
containers]$ ./build.sh "MachineName"
```

## Create a New Container from Machine Image

```sh
containers]$ ./control.sh up "MachineName" [Host Name]
```

## Remove a Container

```sh
containers]$ ./control.sh down "MachineName"
```

## Stop a Container

```sh
containers]$ ./control.sh stop "MachineName"
```

## Start a Container

```sh
containers]$ ./control.sh start "MachineName"
```
