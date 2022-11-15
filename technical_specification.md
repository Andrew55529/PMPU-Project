# Описание
Существует множество СКУД в офисах предлагающих ограниченный набор функций.
Это веб приложение должно расширить их функционал добавив:
* Открытие с телефона(в том числе дистанционное) 
* Просмотр логов открытий
Для подключения существующая ситема должна обладать возможностью передачи данных:
* TCP/IP
* COM (требуется дополнительное кстройство)
Позволяет администраторам настраивать:
* права на доступ к дверям каждому пользователю в отдельности.
* назначать различные права по отдельности
## Наименование
LockSystem
## Предметная область
СКУД   Система контроля и управления доступом
# Данные

systems

| name      | type       | constraints | description      | default        |
|-----------|------------|-------------|------------------|----------------|
| sys_id    | int        | PRIMARY     |                  | AUTO_INCREMENT |
| name      | text       |             | Name of system   |                |
| address   | text       | UNIQUE      | Login for system |                |
| onoff     | tinyint(1) |             | On or off system | False          |
| parent_id | int        |             | Parant id        | NULL           |

users

| name      | type     | constraints | description   | default           |
|-----------|----------|-------------|---------------|-------------------|
| user_id   | int      | PRIMARY     | User id       | AUTO_INCREMENT    |
| sys_id    | text     |             | System id     |                   |
| name      | text     |             | Username      |                   |
| create_at | datetime |             | Creation time | CURRENT_TIMESTAMP |
| password  | text     |             | User password |                   |

auth

| name         | type     | constraints | description            | default              |
|--------------|----------|-------------|------------------------|----------------------|
| auth_id      | int      | PRIMARY     | Logs id                | AUTO_INCREMENT       |
| user_id      | int      |             | User id                |                      |
| ip           | text     |             | Ip of device           |                      |
| last_action  | datetime |             | Creation time          | CURRENT_TIMESTAMP    |
| first_enter  | datetime |             | First enter in sysyem  | CURRENT_TIMESTAMP    |
| expired_in   | datetime |             | Expired time           | CURRENT_TIMESTAMP+?D |
| useragent    | text     |             | Useragent from browser |                      |
| session_hash | text     |             | Auth string            |                      |
| work_for     | datetime |             | End of work            |                      |

doors

| name          | type | constraints | description   | default        |
|---------------|------|-------------|---------------|----------------|
| door_id       | int  | PRIMARY     | Door id       | AUTO_INCREMENT |
| sys_id        | int  |             | System id     |                |
| local_door_id | int  |             | Local door id |                |
| name          | text |             | Name of door  |                |

list

| name     | type | constraints | description | default        |
|----------|------|-------------|-------------|----------------|
| list_id  | int  | PRIMARY     | Id of list  | AUTO_INCREMENT |
| user_id  | int  |             | User id     |                |
| door_id  | int  |             | Door id     |                |
| gived_by | int  |             | User gived  |                |

permissions

| name         | type | constraints | description         | default        |
|--------------|------|-------------|---------------------|----------------|
| perm_id      | int  | PRIMARY     | Permission id       | AUTO_INCREMENT |
| user_id      | int  |             | User id             |                |
| perm_name_id | int  |             | Id of permission    |                |
| gived_by     | int  |             | Id of user who give |                |

permissions_name

| name         | type | constraints | description   | default        |
|--------------|------|-------------|---------------|----------------|
| perm_name_id | int  | PRIMARY     | Permission id | AUTO_INCREMENT |
| name         | int  |             | User id       |                |
| type         | bool |             | Diff system   |                |

# Пользовательские роли
Возможность выдачи прав
* Просмотр пользователей
* Редактирование пользователей
* Редактирование прав пользователей

# UI / API 
Страницы
* Вход
* Страница с дверьми
* Страница с пользователями
* Стрница управления пользователями


## Язык программирования
    Frontend: HTML,JavaScript(React)
    Backend: NodeJS
## СУБД
    MariaDB
