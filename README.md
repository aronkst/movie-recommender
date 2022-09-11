# Movie Recommender

This is a project developed in Ruby and Rails to be a movie recommender.

A Crawler was developed to search for information about the movies on IMDb.

This application does not need to install Ruby, PostgreSQL or Redis, as this application runs inside Docker.

# System dependencies

Docker and Docker Compose.

# How to run

```
make run
```

Or:

```
docker compose -f docker-compose.yml up
```

# Makefile

There are some commands inside the Makefile to facilitate the development and execution of this project.

Run the DEV MODE (run only PostgreSQL and Redis):

```
make dev
```

Run the application:

```
make run
```

Start the Docker Compose:

```
make start
```

Stop the Docker Compose:

```
make stop
```

View logs for Docker containers:

```
make logs
```
