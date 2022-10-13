# Описание
Сайт для откытия замков в офисах, с возможносью настройки прав пользователей
## Наименование
LockSystem
## Предметная область
Замковая система
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

| name         | type     | constraints | description            | default           |
|--------------|----------|-------------|------------------------|-------------------|
| auth_logs_id | bigint   | PRIMARY     | Logs id                | AUTO_INCREMENT    |
| user_id      | int      |             | User id                |                   |
| ip           | text     |             | Ip of device           |                   |
| last_action  | datetime |             | Creation time          | CURRENT_TIMESTAMP |
| first_enter  | text     |             | First enter in sysyem  | CURRENT_TIMESTAMP |
| useragent    | text     |             | Useragent from browser |                   |
| session_hash | text     |             | Auth string            |                   |
| work_for     | datetime |             | End of work            |                   |

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
    Backend: Python
## СУБД
    MariaDB
