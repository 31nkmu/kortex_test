.SILENT:

# Запуск докер контейнера в разработке

.PHONY: up
up:
	docker-compose -f docker/docker-compose.yml --env-file .env up -d --build

.PHONY: down
down:
	docker-compose -f docker/docker-compose.yml --env-file .env down -v

.PHONY: logs
logs:
	docker-compose -f docker/docker-compose.yml --env-file .env logs -f

.PHONY: ps
ps:
	docker-compose -f docker/docker-compose.yml --env-file .env ps -a



# Запуск контейнера в проадкшене

.PHONY: prod-up
prod-up:
	docker-compose -f docker/docker-compose.prod.yml --env-file docker/.env up -d --build

.PHONY: prod-down
prod-down:
	docker-compose -f docker/docker-compose.prod.yml --env-file docker/.env down -v

.PHONY: prod-logs
prod-logs:
	docker-compose -f docker/docker-compose.prod.yml --env-file docker/.env logs -f

.PHONY: prod-ps
prod-ps:
	docker-compose -f docker/docker-compose.prod.yml --env-file docker/.env ps -a

.PHONY: compose-start
compose-start: prod-up
	 docker-compose -f docker/docker-compose.prod.yml exec web python3 app/manage.py collectstatic



.PHONY: gunicorn
gunicorn:
	poetry run gunicorn --reload --bind $(HOST):$(PORT) --workers $(WORKERS) --log-level $(LEVEL) --chdir app/ config.wsgi:application

.PHONY: migrate
migrate:
	poetry run python3 app/manage.py migrate

.PHONY: makemigrations
makemigrations:
	poetry run python3 app/manage.py makemigrations

.PHONY: createsuperuser
createsuperuser: migrate
	poetry run python3 app/manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser(username='admin', password='1')"
