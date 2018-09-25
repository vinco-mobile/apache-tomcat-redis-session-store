# apache-tomcat-redis-session-store
Ejemplo de cluster l Apache + Tomcat Cluster store seesion in Redis

Este proyecto es un ejemplo de montar un cluster de Tomcat en alta disponibilidad donde las sessiones se almacenan en una BD en memoria Redis. El proyecto se encuentra en 2 ramas

 - **with-stickysession:** El enrutamiento en los tomcats se basa en stickysession JSESSIONID. Si falla un servidor entonces se reenvia la peticion a otro tomcat.
    - **pro**: Solo recupera la sessio desde Redis cuando el tomcat que tiene asignada la peticion no responde.
    - **contra**: La carga de los servidores no es equitativa por lo que no se hace un uso optimo del hardware.
 - **without-stickysession:** No hay stikysession y cada peticion va a un tomcat diferente.
    - **pro**: La carga de los servidores se reparte mas equitativa.
    - **contra**: Aumenta mucho el trafico de red escribiendo a Redis desde todos los servidores tomcat
     

## Primeros pasos.
1. Compilar el proyecto y copiar war a docker

`    ./package.sh
`    
2. Contruir imagenes docker

`    ./deploy.sh
`
3. Arrancar cluster

`    ./cluster.sh
`
4. Acceder a la aplicación

    En un navegador acceder a [pagina inicial](http://localhost/sample)

5. Acceder al balanceador

    En una nueva pestaña  acceder a [balanceador](http://localhost/load-balance)

6. Recargar la [pagina inicial](http://localhost/sample) y ver que se muestran los datos de la sessión y la IP de la maqina donde se accede. 
``
7. Apagar el tomcat donde se entro en el punto 6

`    
   docker ps 
   docker kill ID_CONTAINER
`

8. Recargar la [pagina inicial](http://localhost/sample) y ver que se muestran los datos de la sessión y la IP es diferene a la maqina donde se accede. 

## Configuracion apache

`docker/apache/httpd.conf
`
### Modulos cargados

`LoadModule proxy_module modules/mod_proxy.so
LoadModule proxy_http_module modules/mod_proxy_http.so
LoadModule proxy_ajp_module modules/mod_proxy_ajp.so
LoadModule proxy_balancer_module modules/mod_proxy_balancer.so
LoadModule lbmethod_byrequests_module modules/mod_lbmethod_byrequests.so
LoadModule lbmethod_bytraffic_module modules/mod_lbmethod_bytraffic.so
LoadModule lbmethod_bybusyness_module modules/mod_lbmethod_bybusyness.so
`
### Balanceador

`    ProxyRequests Off
    ProxyPass /balancer-manager !

    <Proxy "balancer://cluster">
        BalancerMember "ajp://tomcat1:8009" loadfactor=1 route=tomcat1
        BalancerMember "ajp://tomcat2:8009" loadfactor=1 route=tomcat2
        BalancerMember "ajp://tomcat3:8009" loadfactor=1 route=tomcat3
        ProxySet lbmethod=bytraffic
    </Proxy>
    ProxyPass "/sample" "balancer://cluster/sample" stickysession=JSESSIONID
    ProxyPassReverse "/sample" "balancer://cluster/sample" stickysession=JSESSIONID
`

### Gestion del balanceador

`        <Location /balancer-manager>
            SetHandler balancer-manager
            # Require ip 192.168.4.0/24
        </Location>
`

## Configuracion tomcat

### web.xml
`<?xml version="1.0" encoding="UTF-8"?>

<web-app version="3.1"
         xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         metadata-complete="false">

    <distributable/>
    <session-config>
        <session-timeout>
            30
        </session-timeout>
    </session-config>

</web-app>
`
### context.xml

`    <Manager className="org.redisson.tomcat.RedissonSessionManager"
             configPath="${catalina.base}/conf/redisson.json" readMode="REDIS" updateMode="AFTER_REQUEST"/>
`

### Server xml.

Se modificar el **jvmRoute**

`RUN  sed -i 's|<Engine name="Catalina" defaultHost="localhost">|<Engine name="Catalina" defaultHost="localhost" jvmRoute="tomcat1">|g' /usr/local/tomcat/conf/server.xml
`

## Configuracion redis

No hay

## Docker compose

`
version: "3"
services:
  # Redis
  db:
    image: redis:5.0-rc5-alpine
    hostname: redis
    ports:
      - "6379:6379"
  # Tomcat1
  tomcat1:
      build: tomcat1
      links:
       # Conexion con redis
        - "db:redis"
  tomcat2:
      build: tomcat2
      links:
        # Conexion con redis
        - "db:redis"
  tomcat3:
      build: tomcat3
      links:
        # Conexion con redis
        - "db:redis"
  httpd:
      build: apache
      ports:
        - "80:80"
        - "1936:1936"
      links:
          # Conexion con instancias del cluster
          - tomcat1
          - tomcat2
          - tomcat3
`



