.SILENT:

# Запуск докер контейнера в разработке

.PHONY: up
up: ## Создает и запускает контейнер
	docker-compose -f docker/docker-compose.yml --env-file .env up -d --build

.PHONY: down
down: ## Останавливает и удаляет контейнеры
	docker-compose -f docker/docker-compose.yml --env-file .env down

.PHONY: stop
stop: ## Останавливает контейнеры
	docker-compose -f docker/docker-compose.yml --env-file .env stop

.PHONY: start
start: ## Запускает контейнеры
	docker-compose -f docker/docker-compose.yml --env-file .env start

.PHONY: down-v
down-v: ## Останавливает и удаляет контейнеры вместе с зависимостями
	docker-compose -f docker/docker-compose.yml --env-file .env down -v

.PHONY: logs
logs: ## Просмотр логов
	docker-compose -f docker/docker-compose.yml --env-file .env logs -f

.PHONY: ps
ps: ## Список всех контейнеров
	docker-compose -f docker/docker-compose.yml --env-file .env ps -a

.PHONY: createsuperuser
createsuperuser: ## Создание суперпользователя
	docker-compose -f docker/docker-compose.yml exec web python3 app/manage.py createsuperuser




# Запуск контейнера в проадкшене

.PHONY: compose-up
compose-up: ## Создает и запускает контейнер
	docker-compose -f docker/docker-compose.prod.yml --env-file docker/.env up -d --build

.PHONY: compose-down
compose-down: ## Останавливает и удаляет контейнеры
	docker-compose -f docker/docker-compose.prod.yml --env-file docker/.env down

.PHONY: compose-down-v
compose-down-v: ## Останавливает и удаляет контейнеры вместе с зависимостями
	docker-compose -f docker/docker-compose.prod.yml --env-file docker/.env down -v

.PHONY: compose-stop
compose-stop: ## Останавливает контейнеры
	docker-compose -f docker/docker-compose.prod.yml --env-file docker/.env stop

.PHONY: compose-start
compose-start: ## Запускает контейнеры
	docker-compose -f docker/docker-compose.prod.yml --env-file docker/.env start

.PHONY: compose-logs
compose-logs: ## Просмотр логов
	docker-compose -f docker/docker-compose.prod.yml --env-file docker/.env logs -f

.PHONY: compose-ps
compose-ps: ## Список всех контейнеров
	docker-compose -f docker/docker-compose.prod.yml --env-file docker/.env ps -a

.PHONY: compose-collect-up
compose-collect-up: compose-up ## Полный запуск контейнеров
	 docker-compose -f docker/docker-compose.prod.yml exec web python3 app/manage.py collectstatic

.PHONY: compose-createsuperuser
compose-createsuperuser: ## Создание суперпользователя
	## poetry run python3 app/manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(username='admin', password='1')"
	docker-compose -f docker/docker-compose.prod.yml exec web python3 app/manage.py createsuperuser



.PHONY: gunicorn
gunicorn: ## Запуск проекта через gunicorn
	poetry run gunicorn --reload --bind $(HOST):$(PORT) --workers $(WORKERS) --log-level $(LEVEL) --chdir app/ config.wsgi:application

.PHONY: migrate
migrate: ## Проведение миграций
	poetry run python3 app/manage.py migrate

.PHONY: makemigrations
makemigrations: ## Создание миграций
	poetry run python3 app/manage.py makemigrations

