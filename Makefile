.PHONY: start stop open-mysql open-mysql-bash open-bash

start:
	@docker compose up -d

stop:
	@docker compose down

open-mysql:
	@docker exec -it php8_ubuntu-mysql-1 bash -c "mysql -u root -p"

open-mysql-bash:
	@docker exec -it php8_ubuntu-mysql-1 bash

open-bash:
	@docker exec -it php8_ubuntu-apache-1 bash -c "cd /var/www/html && bash"
