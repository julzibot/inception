COMPOSE_FILE = ./srcs/docker-compose.yml

all:
	@sudo mkdir -p /home/${USER}/data/wordpress/ /home/${USER}/data/mariadb/
	@docker-compose -f $(COMPOSE_FILE) up

build:
	@sudo mkdir -p /home/${USER}/data/wordpress/ /home/${USER}/data/mariadb/
	@docker-compose -f $(COMPOSE_FILE) up --build

down:
	@docker-compose -f $(COMPOSE_FILE) down

stop:
	-docker stop $$(docker ps -qa)

re: down fclean build

fclean: stop down
	-docker system prune -f -a --volumes
	-docker volume rm srcs_db-volume srcs_wp-volume
	@sudo rm -rf /home/${USER}/data/wordpress
	@sudo rm -rf /home/${USER}/data/mariadb

.PHONY: all build down stop fclean re
