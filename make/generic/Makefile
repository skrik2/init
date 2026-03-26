.PHONY: up restart down ps log clean

up:	
	docker compose up -d

restart:
	docker compose restart

down:
	docker compose down

ps:
	docker compose ps

log:
	docker compose logs

clean:
	docker system prune -a --volumes -f
