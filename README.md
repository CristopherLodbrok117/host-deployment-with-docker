# Sinaloa App: Gestor de proyectos

El objetivo de este repositorio es dar seguimiento al proceso de host de una aplicación distribuida, realizando el despliegue con Docker. Cuenta con una increíble cantidad de servicios disponibles, desde manejo control de , proyectos, actividades, grupos con repositorio privado de archivos, membresías y servicio automatizado de envio de correos con notificaciones de eventos o invitaciones a grupos.

Se configurara un contenedor por cada uno de los siguientes servicios
- MySQL para la persistencia
- Frontend: Cliente gestor de proyectos desarrollado en React
- Backend: API Rest desarrollada en Spring boot, con JPA, MailService, Flyway, Lombok, sistema de archivos, etc.


## DigitalOcean

Accedemos a nuestra cuenta de digital ocean y nos dirigimos a droplets, ahi damos clic en crear uno nuevo.

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/6bf95d5b7b1623ae1e1a9ee93ffbe9ee3ecaac0e/screenshots/server/0%20-%20abrir%20digital%20ocean%20droplets.png" alt="dogitalocean" width="600">

<br>

Elegimos el sistema operativo

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/6bf95d5b7b1623ae1e1a9ee93ffbe9ee3ecaac0e/screenshots/server/01%20-%20so.png" alt="so" width="600">

<br>


Elegimos un CPU adecuado y recursos con buena relación precio-calidad para evitar sobrecargas.

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/6bf95d5b7b1623ae1e1a9ee93ffbe9ee3ecaac0e/screenshots/server/04%20-%20select%20characteristics.png" alt="cpu" width="600">

<br>

Definimos y guardamos nuestra contraseña (DigitalOcean no la enviara a nuestro correo)

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/6bf95d5b7b1623ae1e1a9ee93ffbe9ee3ecaac0e/screenshots/server/05%20-%20pass.png" alt="pass" width="600">

<br>

Activamos opción para contar con métricas de monitoreo y alertas

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/fb837c36aada81ca2edd430108dd5396e4ce7539/screenshots/server/06%20-%20free%20monitoring%20.png" alt="monitoring" width="600">

<br>


Elegimos la cantidad de droplets a desplegar y lo creamos

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/fb837c36aada81ca2edd430108dd5396e4ce7539/screenshots/server/07%20-%20resume.png" alt="complete" width="600">

<br>

Nos dirigimos desde el panel izquierdo a Droplets, donde se listaran los que hayamos configurado

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/fb837c36aada81ca2edd430108dd5396e4ce7539/screenshots/server/08%20-%20list%20of%20droplets.png" alt="droplets" width="600">

<br>


Damos clic sobre este y se nos mostrara información desde las métricas para monitorearlo, IPv4 y 6, asi como acceso a una consola para conectarnos. Desde este momento el 
servidor ya esta corriendo, aunque puede demorar unos minutos al inicio.

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/fb837c36aada81ca2edd430108dd5396e4ce7539/screenshots/server/09%20-%20our%20droplet.png" alt="my droplet" width="600">

<br>

Nosotros no utilizaremos la consola web, se desconecta mucho, entre otras desventajas. Utilizaremos Putty para conectarnos de manera remota

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/fb837c36aada81ca2edd430108dd5396e4ce7539/screenshots/server/10%20-%20putty.png" alt="putty" width="600">

<br>

Una vez descargado e instalado (también hjay una versión portable). Al abrirlo mostrara esta interfaz donde podremos ingresar la IP del servidor. Pero antes debemos 
configurar el acceso remoto

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/fb837c36aada81ca2edd430108dd5396e4ce7539/screenshots/server/11%20-%20open%20putty.png" alt="open putty" width="600">

<br>


En la consola web nos conectaremos con el usuario root y crearemos nuevos usuarios con el siguiente comando

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/fb837c36aada81ca2edd430108dd5396e4ce7539/screenshots/server/12%20-%20add%20user.png" alt="adduser" width="600">

<br>


Podemos agregarlo al grupo sudo para que cuente con privilegios de administrador, pero además crearemos este directorio donde copiaremos el .ssh del root. Para poder obtener 
privilegios de root con su -

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/fb837c36aada81ca2edd430108dd5396e4ce7539/screenshots/server/13%20-%20create%20demo%20folder.png" alt="create dir" width="600">

<br>

Cpopiamos la llave pública con los siguientes comandos y cambiamos propietario asi como el sistema de permisos

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/fb837c36aada81ca2edd430108dd5396e4ce7539/screenshots/server/14%20-%20copy%20public%20key.png" alt="public key" width="600">

<br>

Ahora podemos conectarnos a través de putty, ingresando la IP del servidor

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/fb837c36aada81ca2edd430108dd5396e4ce7539/screenshots/server/15%20-%20putty%20again.png" alt="ip" width="600">

<br>

Ingresamos los datos del nuevo usuario y con su - obtenemos privilegios de root

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/fb837c36aada81ca2edd430108dd5396e4ce7539/screenshots/server/16%20-%20login.png" alt="login" width="600">

<br>


## Docker

Desde la pagina oficial, en su [documentación](https://docs.docker.com/engine/install/ubuntu/) seguiremos la guía para instalar Docker. En esta distribución no 
tenemos interfaz gráfica, por lo que no necesitamos Docker desktop.

Ejecutamos los siguientes comandos uno a uno, para configurar el repositorio.

```java
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Instalamos Docker

`
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
`

Podemos comprobar el éxito de la instalación ejecutando

`sudo docker run hello-world`

<br>

### Instalación de  GIT

Git nos facilitara la tarea de descargar proyectos que busquemos desplegar. Ejecutamos en orden los siguientes comandos para instalar GIT

```java
sudo apt update

sudo apt install git

git --version
```


<br>

### Instalación y configuración del proyecto

Hacemos pull o clonando el proyecto con el siguiente comando, para traer la rama especifica

`git clone -b <branchname> <remote-repo-url>`

Descargaremos frontend y backend

### Archivos de despliegue

<br>

Los siguientes archivos son esenciales para el despliegue del contenedor de la API

#### Dockerfile

```java
# Usa Java 21 (Temurin LTS)
FROM eclipse-temurin:21-jdk-jammy

# Directorio de trabajo
WORKDIR /app

# Copia el wrapper de Maven
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
COPY .env /app/.env

# Otorga permisos
RUN chmod +x mvnw

# Descarga dependencias en caché
RUN ./mvnw dependency:go-offline -B

# Copia el código fuente y el entrypoint
COPY src/ src/
COPY entrypoint.sh /entrypoint.sh

# Permisos para el entrypoint y compilación
RUN chmod +x /entrypoint.sh && \
    ./mvnw clean package -DskipTests && \
    mv target/*.jar /app/sinaloa-api.jar && \
    rm -rf target/ .mvn/ mvnw* pom.xml

# Puerto expuesto
EXPOSE 8080

# Volumen para uploads
VOLUME /app/uploads

# Reemplaza el ENTRYPOINT original por nuestro script
ENTRYPOINT ["/entrypoint.sh"]
```

<br>

Creamos entrypoint.sh a la altura del dockerfile

```java
#!/bin/sh

# Configuración de seguridad base
JAVA_OPTS="-Djdk.tls.client.protocols=TLSv1.2"

# Verifica si debemos ejecutar seeders (ahora con SEED_DB)
if [ "$SEED_DB" = "true" ]; then
  echo "🔵 Ejecutando seeders..."
  ARGS="--seedAll"
else
  echo "⚪ Saltando seeders (SEED_DB no es 'true')"
  ARGS=""
fi

# Debug: Muestra variables relevantes
echo "🔍 Variables: SEED_DB=$SEED_DB, ARGS=$ARGS"

# Inicia la aplicación
exec java $JAVA_OPTS -jar sinaloa-api.jar $ARGS
```

<br>

.env de API (a lado del dockerfile)

```java
# ===== DATABASE =====
DB_USER=<tu-user>
DB_PASSWORD=<tu-user>
DB_ROOT_PASSWORD=<tu-password-de-root>

# ===== SPRING =====
SPRING_DATASOURCE_USERNAME=<tu-user>
SPRING_DATASOURCE_PASSWORD=<tu-user>
SPRING_PROFILES_ACTIVE=prod

# HIBERNATE
SPRING_JPA_SHOW_SQL=true
SPRING_JPA_DDL_AUTO=validate

# FRONTEND
#FRONTEND_URL=http://localhost:8081

# EMAIL
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=<tu-correo@gmail.com>
SMTP_PASSWORD=<tu-password>

# ===== APP =====
UPLOAD_DIR=/app/uploads
```






### FRONTEND

#### Dockerfile de frontend

```java
# Etapa de construcción
FROM node:20-alpine AS builder
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY .env ./.env

COPY . .
RUN yarn build

# Etapa de producción
FROM nginx:alpine

# Instalar netcat (nc) para el script de espera
RUN apk add --no-cache bash netcat-openbsd

# Copiar el script de espera
COPY wait-for-api.sh /wait-for-api.sh
RUN chmod +x /wait-for-api.sh

# Copiar los archivos de construcción y configuración de Nginx
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# Usar el script de espera como entrypoint
ENTRYPOINT ["/wait-for-api.sh"]
CMD ["nginx", "-g", "daemon off;"]
```

#### nginx.conf para configurar proxy

```java
server {
    listen 80;
    server_name localhost;

    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api {
        # Asegúrate de usar la barra al final
        proxy_pass http://sinaloa-api:8080/;

        # Cabeceras esenciales para CORS
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Cabeceras CORS explícitas
        add_header 'Access-Control-Allow-Origin' '$http_origin' always;
        add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS' always;
        add_header 'Access-Control-Allow-Headers' 'Content-Type, Authorization, X-Requested-With' always;
        add_header 'Access-Control-Allow-Credentials' 'true' always;

        # Manejo de OPTIONS (preflight)
        if ($request_method = OPTIONS) {
            return 204;
        }
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
        expires 1y;
        add_header Cache-Control "public, no-transform";
    }
}
```



#### wait-for-api.sh 

Se ejecutara desde el dockerfile en sincronia con el despliegue de la API

```java
#!/bin/sh

host="sinaloa-api"
port="8080"

echo "Esperando a que la API esté disponible en $host:$port..."

while ! nc -z $host $port; do
  sleep 1
done

echo "API está disponible - iniciando Nginx"
exec "$@"
```


#### .env

Variables de entorno del frontend

```java
VITE_MODE=dev
VITE_API_URL=http://146.190.171.239:8080/api
```




### Docker compose

/home/demo/docker-compose.yml

Un nivel superior de los proyectos de frontend y backend

<br>

```java
services:

  sinaloa-api:
    build:
      context: ./api
      dockerfile: Dockerfile
    container_name: sinaloa-api
    depends_on:
      mysql_db:
        condition: service_healthy
    ports:
      - "8080:8080"  # Cambiado a puerto estándar
    networks:
      - sinaloa-net
    environment:
      SPRING_DATASOURCE_URL: jdbc:mysql://mysql_db:3306/sinaloa_db?createDatabaseIfNotExist=true&serverTimezone=UTC
      SPRING_DATASOURCE_USERNAME: ${DB_USER}
      SPRING_DATASOURCE_PASSWORD: ${DB_PASSWORD}
      SPRING_JPA_HIBERNATE_DDL_AUTO: validate  # Mejor que create-drop en producción
      SERVER_PORT: 8080
      SERVER_ADDRESS: 0.0.0.0
      SEED_DB: true
      FRONTEND_URL: http://sinaloa-frontend:80
    volumes:
      - ./api/uploads:/app/uploads  # Persistencia de archivos
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost:8080/actuator/health || exit 1"]
      interval: 30s
      timeout: 10s
      retries: 3

  mysql_db:
    image: mysql:8.0  # Versión fija (evita surprises con 'latest')
    container_name: sinaloa-mysql
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD:-1234}
      MYSQL_DATABASE: sinaloa_db
      MYSQL_USER: admin
      MYSQL_PASSWORD: ${DB_PASSWORD:-1234}
    ports:
      - "3306:3306"  # Puerto estándar (sin mapeo alternativo)
    networks:
      - sinaloa-net
    volumes:
      - ./db_data:/var/lib/mysql  # Persistencia de datos
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-u${DB_USER:-root}", "-p${DB_PASSWORD:-1234}"]
      interval: 10s
      timeout: 5s
      retries: 10


  sinaloa-frontend:
    build: ./frontend/Calendar-React
    ports:
      - "3000:80"  # Nginx en producción
      # - "5173:5173"  # Descomentar para desarrollo con Vite
    networks:
      - sinaloa-net

networks:
  sinaloa-net:
    driver: bridge
```

<br>

## Creación de imágenes

Con nuestros dockerfile crearemos las imágenes, que nos servirán como template para crear contenedores (instancias activas de dichas imágenes que nos permiten cambiar su estato)

Necesitaremos la imagen de MySQL. Podemos ir a Dockerhub a buscarla

Ejecutamos: `docker pull mysql:8.0`

Después ejecutamos en la misma carpeta donde se encuentran los dockerfile de frontend y backend los siguientes comandos

```java
docker build -t sinaloa-frontend . --no-cache

docker build -t sinaloa-api . --no-cache
```

<br>

## Creación y monitoreo de contenedores

En la misma carpeta donde tenemos el docker-compose.yml ejecutamos
Docker compose up -d

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/35f61978793565c552f7afb7eb404bcb5a96b9b9/screenshots/docker-host/70%20-%20compose%20everything.png" alt="compose up" width="600">

<br>

Para observar los logs del frontend
`docker compose logs -f sinaloa-frontend`

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/35f61978793565c552f7afb7eb404bcb5a96b9b9/screenshots/docker-host/92%20-%20logs%20frontend.png" alt="logs frontend" width="600">

<br>

Para acceder a los logs del backend
`docker compose logs -f sinaloa-api`

Lo que nos permitirá dar seguimiento a toda la actividad de nuestros contenedores activos

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/35f61978793565c552f7afb7eb404bcb5a96b9b9/screenshots/docker-host/71%20-%20apo%20logs%20with%20seeders.png" alt="logs api" width="600">

<br>


### Resultados

Desde Insomnia podemos probar los endpoints individuales

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/35f61978793565c552f7afb7eb404bcb5a96b9b9/screenshots/docker-host/90-%20test%20login%20insomnia.png" alt="auth" width="500">

<br>

Desde el navegador accedemos al cliente y probar toda la aplicación 

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/35f61978793565c552f7afb7eb404bcb5a96b9b9/screenshots/docker-host/93%20-%20Client%20access.png" alt="client" width="500">

<br>

La herramienta DevTools de nuestro navegador nos ayudara mucho en el proceso de pruebas

<br>

<img src="https://github.com/CristopherLodbrok117/host-deployment-with-docker/blob/35f61978793565c552f7afb7eb404bcb5a96b9b9/screenshots/docker-host/93%20-%20devtools.png" alt="devtools" width="500">

<br>

Uso de la aplicación
[Video de aplicación web hosteada](https://drive.google.com/file/d/1JTBbc5S4gy5f4oBAULyYhLpmXiG3acIq/view?usp=sharing)










