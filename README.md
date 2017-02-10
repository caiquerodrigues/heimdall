# Heimdall

## Description
Heimdall aims to implements JSON Web Token (JWT) and provides AAAS (Authentication As A Service) for multiple applications management and also other cool features such as single sign-on.

## DONE
- JWT token authorization
- Status
- Auth
- Create account
- Update account (without password)
- Update password

## TODO
- Delete Account
- Register Applications
- One Application has many Accounts
- Accounts has and belongs to many Applications (for Single Sign On)

## HOW TO
### Shipping with Docker
- Install [Docker](https://www.docker.com) and [Docker Compose](https://docs.docker.com/compose/)
- Configure the containers running `docker-compose build`
- Ship the infrastructure with `docker-compose up -d`
- Check if everything is right with `docker-compose ps`
- Shut down everything with `docker-compose down`

### Shipping static services locally
- Install MongoDB and initialize an instance at port **27017**
- Run `bundle exec padrino s` from this project's root folder

## Authors
- [Caique Rodrigues](http://caiquerodrigues.github.io)
