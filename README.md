# question2answer-docker
Question2Answer docker image

## Using plain docker
TBA

## Using docker-compose
TBA


Here's an example of a `docker-compose.yml` file
```yaml
question2answer:
    image: wiesom/question2answer
    links:
        - db:mysql
    environment:
        QUESTION2ANSWER_DB_USER: question2answer_user
        QUESTION2ANSWER_DB_PASSWORD: 123456
        QUESTION2ANSWER_DB_NAME: question2answer


db:
    image: mariadb
    environment:
        MYSQL_USER: question2answer_user
        MYSQL_PASSWORD: 123456
        MYSQL_DATABASE: question2answer
        MYSQL_ROOT_PASSWORD: <something secret>

```
