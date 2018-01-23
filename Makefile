clear-cache:
	docker exec dime rm -rf /dev/shm/dime

db-mirror:
	gunzip -c ~/Downloads/stiftun8_dime.sql.gz| docker exec -i mariadb mysql dime && docker exec dime app/console doctrine:migrations:migrate

db-fixtures:
	docker exec dime env/fixtures/flush_db.sh && docker exec dime env/fixtures/load.sh
