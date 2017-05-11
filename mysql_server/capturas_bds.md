# Capturas de las tablas radcheck, radpostauth, nas, ...

## Captura de la tabla nas, que contiene los Network Access (System /Service).
### Nas, APs...

mysql> select * from nas;
+----+---------------+-----------+-------+-------+---------+--------+-----------+---------------+
| id | nasname       | shortname | type  | ports | secret  | server | community | description   |
+----+---------------+-----------+-------+-------+---------+--------+-----------+---------------+
|  1 | 192.168.0.3   | servidor  | other |  NULL | radius  | NULL   | NULL      | RADIUS Client |
|  2 | 192.168.2.254 | dlink     | other |  NULL | ap_wifi | NULL   | NULL      | RADIUS Client |
+----+---------------+-----------+-------+-------+---------+--------+-----------+---------------+
2 rows in set (0.00 sec)

## Captura de la tabla radcheck, que contiene los usuarios que podran ser autenticados en el servidor radius

mysql> select * from radcheck;
+----+----------+-----------+----+----------+
| id | username | attribute | op | value    |
+----+----------+-----------+----+----------+
|  1 | usuario1 | password  | == | usuario1 |
|  2 | usuario2 | password  | == | usuario1 |
|  3 | altair   | password  | == | zion     |
+----+----------+-----------+----+----------+
3 rows in set (0.00 sec)


## Captura de la tabla radpostauth que contiene los usuarios post procesados
despues de la autorización en alguno de los modulos de autenticación.
ya sean Access-Accept o Access-Reject.

mysql> select * from radpostauth;
+----+----------+----------+---------------+---------------------+
| id | username | pass     | reply         | authdate            |
+----+----------+----------+---------------+---------------------+
|  1 | usuario2 | usuario2 | Access-Reject | 2017-05-09 03:59:18 |
|  2 | usuario2 | usuario1 | Access-Accept | 2017-05-09 03:59:45 |
|  3 | altair   | saman    | Access-Reject | 2017-05-09 04:02:51 |
|  4 | altair   | saman    | Access-Reject | 2017-05-09 04:02:57 |
|  5 | altair   | jupiter  | Access-Reject | 2017-05-09 04:04:50 |
|  6 | altair   | jupiter  | Access-Reject | 2017-05-09 04:05:09 |
|  7 | usuario2 | usuario1 | Access-Accept | 2017-05-09 04:05:50 |
|  8 | usuario2 | usuario1 | Access-Accept | 2017-05-09 04:06:00 |
|  9 | altair   | zionLDAP | Access-Accept | 2017-05-09 04:09:27 |
+----+----------+----------+---------------+---------------------+
9 rows in set (0.00 sec)

