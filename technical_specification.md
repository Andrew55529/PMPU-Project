# Описание
Существует множество СКУД в офисах предлагающих ограниченный набор функций.
Это веб приложение должно расширить их функционал добавив:
* Открытие с телефона(в том числе дистанционное) 
* Просмотр логов открытий

Для подключения существующая система должна обладать возможностью передачи данных:
* TCP/IP
* COM (требуется дополнительное устройство)

Позволяет администраторам настраивать:
* Права на доступ к дверям каждому пользователю в отдельности.
* Назначать различные права по отдельности
* Создавать двери
## Наименование
LockSystem
## Предметная область
СКУД   Система контроля и управления доступом
# Данные

### systems

Таблица systems нужна для масштабирования системы на одном сервере.


| name      | type       | constraints | description      | default        |
|-----------|------------|-------------|------------------|----------------|
| sys_id    | int        | PRIMARY     |                  | AUTO_INCREMENT |
| name      | text       |             | Name of system   |                |
| address   | text       | UNIQUE      | Login for system |                |
| onoff     | tinyint(1) |             | On or off system | 1              |
| parent_id | int        |             | Parent id        | NULL           |
| lock_url  | text       |             | URL to open lock |                |


Поле `onoff` нужно для возможности временного отключения офиса

Поле `parent_id` нужно для создания дочернего офиса, имеющих тех же пользователей, что и основной, но другие двери.

Поле `lock_url` нужно для указания адрес сервера отвечающего за открытия дверей. Должен содержать макрос ${local_door_id}, на место которого будет подставлен номер двери



### users

| name       | type     | constraints | description             | default           |
|------------|----------|-------------|-------------------------|-------------------|
| user_id    | int      | PRIMARY     | User id                 | AUTO_INCREMENT    |
| sys_id     | text     |             | System id               |                   |
| name       | text     |             | Username                |                   |
| email      | text     |             | Email address           |                   |
| create_at  | datetime |             | Creation time           | CURRENT_TIMESTAMP |
| password   | text     |             | User password           |                   |
| github_id  | int      |             | Need to login by github |                   |
| onoff      | int      |             | Status                  | 1                 |
| created_by | int      |             | Id of user who create   |                   |

Поле `email` нужно для отправки почты пользователю

Поле `github_id` нужно для привязки github к аккаунтам в системе. Для последующего входа посредством OAuth.

Поле `created_by, create_at` нужно для понимая кто и когда создал пользователя




### sessions

| name          | type     | constraints | description            | default              |
|---------------|----------|-------------|------------------------|----------------------|
| auth_id       | int      | PRIMARY     | Logs id                | AUTO_INCREMENT       |
| user_id       | int      |             | User id                |                      |
| ip            | text     |             | Ip of device           |                      |
| last_action   | datetime |             | Creation time          | CURRENT_TIMESTAMP    |
| first_enter   | datetime |             | First enter in sysyem  | CURRENT_TIMESTAMP    |
| expired_in    | datetime |             | Expired time           | CURRENT_TIMESTAMP+?D |
| useragent     | text     |             | Useragent from browser |                      |
| refresh_token | text     |             | Auth string            |                      |
Поле `useragent` нужно для повышения безопасности, за счет него можно отсеять злоумышленника, который смогу украсть только access token

Поле `refresh_token` нужно для повышения безопасности, за счет него можно закрывать конкретные сессии.

Поле `expired_in` нужно для повышения безопасности, за счет него можно ограничивается время действия сессии.

Поля `ip`, `last_action`,`first_enter`,`useragent`  нужны для понимания пользователем, что за устройство и когда оно было активно.

### doors

| name          | type | constraints | description   | default        |
|---------------|------|-------------|---------------|----------------|
| door_id       | int  | PRIMARY     | Door id       | AUTO_INCREMENT |
| sys_id        | int  |             | System id     | 1              |
| local_door_id | int  |             | Local door id |                |
| name          | text |             | Name of door  |                |

Дополнительная информация:

local_door_id - номер двери использующийся в запросе для открытия


### list

| name     | type | constraints | description | default        |
|----------|------|-------------|-------------|----------------|
| list_id  | int  | PRIMARY     | Id of list  | AUTO_INCREMENT |
| user_id  | int  |             | User id     |                |
| door_id  | int  |             | Door id     |                |
| gived_by | int  |             | User gived  |                |

Поле `gived_by` нужны для понимания кто выдал право пользователю.

Поле `door_id` Показывает какую дверь, может открывать пользователь.

### permissions

| name         | type | constraints | description         | default        |
|--------------|------|-------------|---------------------|----------------|
| perm_id      | int  | PRIMARY     | Permission id       | AUTO_INCREMENT |
| user_id      | int  |             | User id             |                |
| perm_name_id | int  |             | Id of permission    |                |
| gived_by     | int  |             | Id of user who give |                |

Поле `gived_by` нужны для понимания кто выдал право пользователю.

Поле `perm_name_id` Показывает какое право добавлено пользователю.


### permissions_name

| name         | type | constraints | description        | default        |
|--------------|------|-------------|--------------------|----------------|
| perm_name_id | int  | PRIMARY     | Permission id      | AUTO_INCREMENT |
| name         | text |             | Name of permission |                |

Поле `perm_name_id` - нужно для связи таблиц.

Поле `name` нужно для отображения, что дает это права.

# Пользовательские роли
Возможность выдачи прав
* Редактирование прав пользователей
* Редактирование дверей

# UI / API 
Страницы
* Вход
* Страница с дверьми
* Страница с пользователями
* Страница управления пользователями
* Страница добавления пользователя
* Страница добавление дверей



## Язык программирования
    Frontend: HTML,TypeScript(React)
    Backend: NodeJS(express)
## СУБД
    MariaDB
