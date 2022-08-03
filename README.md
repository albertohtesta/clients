# Norden Clients - Backend

## System dependencies
* Docker (If you are on macOS use the desktop version 😁)
* Ruby 3.1.1
* Rails 7.0.2.1

## Configuration
Please follow the steps below in the order they are presented.

### Clone the project
To clone this project please run
```console
git clone git@git.michelada.io:norden/clients-backend.git
```

### Install overcommit
We use [overcommit](https://github.com/sds/overcommit) in this project to enforce best practices. To install it, please run
```console
gem install overcommit
```

and then run
```console
overcommit --install
```

### Load the containers
Since Docker loads all the dependencies as containers, all you have to do is clone the repo and run:

```console
docker-compose up core
```
That will fetch you rails, redis, postgres, rabbitMQ, sidekiq, download and install the needed gems, setup the DB and prepare the ground for the project.

### Set the data up
**While the container is running**, in another console prompt, run 
```console
docker-compose exec core sh
```
to bring up the **core** container shell. Inside the shell, create the development and testing databases and run the migrations with 
```console
bin/rails db:setup
```
Leave the shell with `exit`.

### Finishing steps
You should be ready to go! In our wiki you can find some [docker commands](https://git.michelada.io/norden/core-backend/-/wikis/Docker) that might prove useful in your development process.
If you need the **master.key** or need help with anything else please reach out to the team.

### Best practices
Check out our [gitflow styleguide](https://git.michelada.io/norden/core-backend/-/wikis/Gitflow) on creating well-named branches and writing good commits before adding your code.

## Testing
To run the test suite open another console prompt and, **while the container is running**, you can either run 
```console
docker-compose exec core bin/rails test
```
or enter the container''s shell with
```console
docker-compose exec core sh
```

and run
```console
bin/rails test
```

## Services (job queues, cache servers, search engines, etc.)
**Soon**

## Deployment
**Soon**
