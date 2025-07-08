setup:
	docker build --platform linux/amd64 -t keycloak-java-runtime .

build:
	docker run -it --rm -v $(PWD):/app keycloak-java-runtime /bin/bash -c "cd /app && ./mvnw -pl quarkus/deployment,quarkus/dist -am -DskipTests clean install"

dist:
	cp ./quarkus/dist/target/keycloak-999.0.0-SNAPSHOT.tar.gz ./quarkus/container/keycloak-999.0.0-SNAPSHOT.tar.gz
	cd ./quarkus/container && docker build --platform linux/amd64 -t keycloak-dist --build-arg KEYCLOAK_DIST=keycloak-999.0.0-SNAPSHOT.tar.gz .

disable-ssl:
	docker compose exec keycloak /opt/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080 --realm master --user admin
	docker compose exec keycloak /opt/keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE