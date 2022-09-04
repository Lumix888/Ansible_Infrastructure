# SLA - Backup Service Level Agreement

## Coverage

Our objective is to be able to backup most of the infrastracure:
 
 - all services configurations and wanted state
 - MYSQL data
 - influxdb data
 - grafana dashboards 
 - relevant documentation

## RPO - Recovery Point Objective

The recovery point objective of users data is one day.

MYSQL backups happen with the following skedule:

- full local backup / every day at 21:05 UTC  (23:05 Estonian time)

- full remote servere backup / friday at 21:15 UTC (23:15 Estonian time)

- incremental remote server backup /every day at 21:25 UTC (23:25 Estonian time)

Influxdb backups happen with the following skedule:

- full local backup / every day at 21:10 UTC  (23:10 Estonian time)

- full remote servere backup / friday at 21:20 UTC (23:20 Estonian time)

- incremental remote server backup /every day at 21:30 UTC (23:30 Estonian time)

After consultation whit the marketing team is emerged that most of user need using AGAMA during the working week (monady to friday), while the traffic is close to null during the weekend. Therefore friday night has been chosen for the full remote service backups.

Untill the end of Jannuary incremental backups will happen also on friday after the full backup for testing pourpouse, from February only full backups will be performed on friday.

## Retention

Daily full local backup are going to be stored for 24 hrs (exept when getting lost due to virtual machine reset).

Full and incremental backups stored on remote backup server are going to be retained for 3 months.

## Usablility checks

The usability checks of the different backups are going to be performed every 3 weeks and after any new release of the application or any substantial modification of the infrastructure. 

## Restoration criteria

In case of crash of one or few services or the wole infrastructure the course of action will be to restore them using the ansible code available on this repository:

- https://github.com/Lumix888/ica0002

In case of loss of user data or other influxdb data, the data from the most recent available backup will be restored. Detailed instructions to be found in:

- backup_restore.md

## RTO - Recovery Time Objective

The service will be fully restored within 24 hrs from the incident plus 1 hr to restore database data from the remote backup server if needed.
