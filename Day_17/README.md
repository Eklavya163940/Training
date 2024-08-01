# Project 01

### Deploy a Database Server with Backup Automation

### Objective: 
+ Automate the deployment and configuration of a PostgreSQL database server on an Ubuntu instance hosted on AWS, and set up regular backups.

### Problem Statement

### Objective: 

+ Automate the deployment, configuration, and backup of a PostgreSQL database server on an Ubuntu instance using Ansible.

#### Requirements:

1. ***AWS Ubuntu Instance:*** You have an Ubuntu server instance running on AWS.

2. ***Database Server Deployment:*** Deploy and configure PostgreSQL on the Ubuntu instance.

3. ***Database Initialization:*** Create a database and a user with specific permissions.

4. ***Backup Automation:*** Set up a cron job for regular database backups and ensure that backups are stored in a specified directory.

5. ***Configuration Management:*** Use Ansible to handle the deployment and configuration, including managing sensitive data like database passwords.

### Deliverables

1. ***Ansible Inventory File***
    
    + Filename: inventory.ini
    
    + Content: Defines the AWS Ubuntu instance and connection details for Ansible.


```ini
[servers]
3.145.46.102 ansible_user=ubuntu ansible_ssh_private_key_file=ansible-worker.pem
```


2. ***Ansible Playbook***
    
    + Filename: deploy_database.yml
    
    + Content: Automates the installation of MySQL, sets up the database, creates a user, and configures a cron job for backups. It also includes variables for database configuration and backup settings.

```yml

- name: setup Mysql
  hosts: servers
  become: yes
  vars:
    db_name: "my_database"
    db_user: "my_user"
    db_password: "user123"
    backup_dir: "/backup/mysql"
    backup_schedule: "daily"

  tasks:
  - name: Install MySQL server
    apt:
      update_cache: yes
      name: "{{ item }}"
      state: present
    with_items:
    - mysql-server
    - mysql-client
    - python3-mysqldb
    - libmysqlclient-dev

  - name: Copy MySQL configuration file
    template:
      src: /home/einfochips/Downloads/Training/Day_17/templets/mysql.conf.j2
      dest: /etc/mysql/mysql.conf.d/mysqld.cnf
    notify: Restart MySQL

  - name: Ensure MySQL service is running and enabled
    service:
      name: mysql
      state: started
      enabled: yes

  - name: Create MySQL user
    mysql_user:
      name: "{{ db_user }}"
      password: "{{ db_password }}"
      priv: '*.*:ALL'
      host: '%'
      state: present

  - name: Create MySQL database
    mysql_db:
      name: "{{ db_name }}"
      state: present

  - name: Configure backup directory
    file:
      path: "{{ backup_dir }}"
      state: directory
      mode: '0755'

  - name: Copy MySQL backup script
    copy:
      src: /home/einfochips/Downloads/Training/Day_17/scripts/backup.sh
      dest: /usr/local/bin/mysql_backup.sh
      mode: '0755'

  - name: Configure backup cron job
    cron:
      name: "mysql backup"
      minute: "0"
      hour: "2"
      day: "*"
      month: "*"
      weekday: "*"
      job: "/usr/local/bin/mysql_backup.sh"
      state: present

  handlers:
  - name: Restart MySQL
    service:
      name: mysql
      state: restarted

```

![alt text](image.png)

3. ***Jinja2 Template***
    
    + Filename: templates/mysql.cnf.j2
    
    + Content: Defines the MySQL configuration file (pg_hba.conf) using Jinja2 templates to manage access controls dynamically.

```jinja
# Here is entries for some specific programs
# The following values assume you have at least 32M ram

!includedir /etc/mysql/conf.d/
!includedir /etc/mysql/mysql.conf.d/
```
![alt text](image.png)

4. ***Backup Script***
    
    + Filename: scripts/backup.sh
    
    + Content: A script to perform the backup of the PostgreSQL database. This script should be referenced in the cron job defined in the playbook.

```bash
#!/bin/bash

# Set variables

DATABASE_NAME=mydatabase
BACKUP_DIR=/var/backups/mysql
DATE=$(date +"%Y-%m-%d")

# Create backup file name

BACKUP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_${DATE}.sql"

# Dump database to backup file

mysqldump -u myuser -p${database_password} ${DATABASE_NAME} > ${BACKUP_FILE}

# Compress backup file

gzip ${BACKUP_FILE}

# Remove old backups (keep only 7 days)

find ${BACKUP_DIR} -type f -mtime +7 -delete
```


