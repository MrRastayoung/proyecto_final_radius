# RADIUS 
``Aqui y Ahora``

    Proyecto:
      ## Documentación tecnica:
      De que trata el proyecto?
          - Una explicación de lo que se trata el proyecto y las tecnicas
            que se emplean
            
      Que puntos se van a tratar?:
        - Docker-Compose
        - Docker-File
        - Radius
        - Ldap 
        - Kerberos
        - TLS/SSL
        
        Radius PRINCIPALMENTE:
          - PROTOCOLO
          - USO
          - FINALIDAD
          - EJEMPLOS
      
      Objetivos?:
        - Montar un servidor Radius
        - Montar un servidor Ldap
        - Montar un servidor Web
        - Montar un servidor Kerberos
        - Montar una Autoridad Certificadora ( TLS/SSL )
        - Montar un servidor mysql ( alternativa a LDAP )
       
      Que se ha aprendido del proyecto?:
        - Puntos positivos del proyecto
        - Puntos negativos del proyecto
      
      Posibles mejoras i/o modificaciones del proyecto?
      
      Valoración personal del proyecto?
    
    ## Documentación Practica:  
    
      radius_server:
        - Montar servidor
        - Configurar servidor
        - Añadir usuarios locales
        - Añadir usuarios remotos
        - Añadir AP ( switch, routers si hay tiempo y material )
        - Añadir usuarios a otras plataformas
        - Enlazar con servicios como LDAP o MySQL
        - Proteger con TLS
        - Test de pruebas ( funcionamiento, y puesta en marcha )
        
      mysql_server:
        *el objetivo de este servidor es alojar las base de datos que
         requieran los servicios que componen el proyecto, sin mucha más
         dilaciones*
        - Montar servidor
        - Configurar servidor
        - Añadir base de datos
        - Test de pruebas ( funcionamiento, y puesta en marcha )
      
      ldap_server:
        - Montar servidor
        - Configurar servidor
        - Añadir Arbol Ldap y configurar administrador
        - Trabajar con Arbol Ldap
        - Importar usuarios desde un archivo
        - Exportar usuarios desde ldap a un archivos
        - Test de pruebas ( funcionamiento, y puesta en marcha )
                
      kerberos_server:
        - Montar servidor
        - Configurar servidor
        - Configurar Reinos 
        - Creación de usuarios administradores
        - Creacion de Tikets de Aplicaciones ( HOST / SERVICIOS )
        - Test de pruebas ( funcionamiento, y puesta en marcha )
               
      tls/ssl:
        - Montart Autoridad Certificadora
        - Creación de certificados de servidor 
        - Creación de revocación de certificados
        - Creación de peticiones 
        - Creacion de certificados de cliente
        - Segurizando servicios
          - Ldap
          - Kerberos
          - Radius
          - Http
          - Mysql ( si da tiempo )

      http_server:
        - Montar servidor
        - Configurar servidor
        - Configurar Virtualhost
            - Daloradius
            - PhpMyAdmin
            - PhpLdapAdmin

