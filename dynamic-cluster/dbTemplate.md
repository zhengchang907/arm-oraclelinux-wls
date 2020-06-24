# Apply Database ARM Template to {{ site.data.var.wlsFullBrandName }}

This page documents how to configure an existing deployment of {{ site.data.var.wlsFullBrandName }} with an existing Azure database using Azure CLI.

## Prerequisites

### Environment for Setup

* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure), use `az --version` to test if `az` works.

### WebLogic Server Instance

The database ARM tempate will be applied to an existing {{ site.data.var.wlsFullBrandName }} instance.  If you don't have one, please create a new instance from the Azure portal, by following the link to the offer [in the index](index.md).

### Database Instance

To apply configure a database with {{ site.data.var.wlsFullBrandName }},
you must have an existing database instance to use.  This template
supports three popular Azure databases: [Oracle](https://ms.portal.azure.com/#blade/Microsoft_Azure_Marketplace/MarketplaceOffersBlade/selectedMenuItemId/home/searchQuery/oracle%20database), [Azure SQL Server](https://docs.microsoft.com/en-us/azure/azure-sql/) and [Azure Database for PostgreSQL](https://docs.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart?WT.mc_id=gallery&tabs=azure-portal).  If you do not have an instance, please
create one from the Azure portal.

## Prepare the Parameters JSON file

You must construct a parameters JSON file containing the parameters to the database ARM template.   We must specify the information of the exsiting {{ site.data.var.wlsFullBrandName }} and database instance, as shown next.

### Obtain the JDBC Connection String, Database User, and Database Password

The parameter `dsConnectionURL` stands for JDBC connection string. To obtain the JDBC connection string for your database:

#### Oracle Database:

The following is the format of the JDBC connection string for Oracle Database:

```bash
jdbc:oracle:thin:@HOSTNAME:1521/DATABASENAME
```

For example:

```bash
jdbc:oracle:thin:@benqoiz.southeastasia.cloudapp.azure.com:1521/pdb1
```

#### Azure Database for PostgreSQL:

Deploy an Azure Database PostgreSQL as described in [Create an Azure Database for PostgreSQL server in the Azure portal](https://docs.microsoft.com/en-us/azure/postgresql/quickstart-create-server-database-portal).

1. Access the [Azure portal](https://portal.azure.com), and go to the service instance.

2. Click **Connection Strings** under **Settings**.

3. Locate the **JDBC** section and click the copy icon on the right to copy the JDBC connection string to the clipboard. The JDBC connection string will be similar to the following:

```
jdbc:postgresql://20191015cbfgterfdy.postgres.database.azure.com:5432/{your_database}?user=jroybtvp@20191015cbfgterfdy&password={your_password}&sslmode=require
```

When passing this value to the ARM template, remove the database user and password values from the connection string, and let them be the parameters `dbUser` and `dbPassword`. In the above JDBC connection string sample, the value for `dsConnectionURL` argument after removing the database user and password, will be:

```
jdbc:postgresql://20191015cbfgterfdy.postgres.database.azure.com:5432/{your_database}?sslmode=require
```

Finally, replace `{your_database}` with the name of your database, typically `postgres`.

#### Azure SQL Server

Deploy Azure SQL Server as described in [Create a single database in Azure SQL Database using the Azure portal, PowerShell, and Azure CLI](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-single-database-get-started?tabs=azure-portal).

1. Access the [Azure portal](https://portal.azure.com) and go to the service instance.

2. Click **Connection Strings** under **Settings**.

3. Locate the **JDBC** section and click the copy icon on the right to copy the JDBC connection string to the clipboard. The JDBC connection string will be similar to the following:

```bash
jdbc:sqlserver://rwo102804.database.windows.net:1433;database=rwo102804;user=jroybtvp@rwo102804;password={your_password_here};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;
```

When passing this value to the ARM template, remove the database user and password values, let them be the parameters `dbUser` and `dbPassword`. In the above JDBC connection string sample, the value for `dsConnectionURL` argument after removing the database user and password, will be:

```
jdbc:sqlserver://rwo102804.database.windows.net:1433;database={your_database};encrypt=true;tr
```

Finally, replace `{your_database}` with the name of your database, typically `postgres`.

2. For `_artifactsLocation`, please use the default value, `https://raw.githubusercontent.com/wls-eng/arm-oraclelinux-wls-admin/master/src/main/arm/`.

```
{
    "_artifactsLocation":{
        "value": "https://raw.githubusercontent.com/wls-eng/arm-oraclelinux-wls-admin/master/src/main/arm/"
      },
      "location": {
        "value": "<location>"
      },
      "databaseType": {
        "value": "<db-type>"
      },
      "dsConnectionURL": {
        "value": "<ds-string>"
      },
      "dbPassword": {
        "value": "<db-psw>"
      },
      "dbUser": {
        "value": "<db-user>"
      },
      "jdbcDataSourceName": {
        "value": "<jdbc-name>"
      },
      "wlsPassword": {
        "value": "<wls-psw>"
      },
      "wlsUserName": {
        "value": "<wls-user>"
      },
      "adminVMName":{
        "value": "<admin-vm-name>"
      }
    }
``` 

Run the following command to apply database service to your WebLogic Server.  

```
RESOURCE_GROUP=<resource-group-of-your-weblogic-server-instance>

# cd nestedtemplates
# Create parameters.json with above variables, and place it in the same folder with dbTemplate.json.
az group deployment create --verbose --resource-group $RESOURCE_GROUP --name db --parameters @parameters.json --template-file dbTemplate.json
```

You will not get any error if the database service is deployed successfully.

This is an example output of successful deployment.  

```
{
  "id": "/subscriptions/05887623-95c5-4e50-a71c-6e1c738794e2/resourceGroups/oraclevm-admin-0602/providers/Microsoft.Resources/deployments/db",
  "location": null,
  "name": "db",
  "properties": {
    "correlationId": "6fc805b9-1c47-4b32-b9b0-59745a21e559",
    "debugSetting": null,
    "dependencies": [
      {
        "dependsOn": [
          {
            "id": "/subscriptions/05887623-95c5-4e50-a71c-6e1c738794e2/resourceGroups/oraclevm-admin-0602/providers/Microsoft.Compute/virtualMachines/adminVM/extensions/newuserscript",
            "resourceGroup": "oraclevm-admin-0602",
            "resourceName": "adminVM/newuserscript",
            "resourceType": "Microsoft.Compute/virtualMachines/extensions"
          }
        ],
        "id": "/subscriptions/05887623-95c5-4e50-a71c-6e1c738794e2/resourceGroups/oraclevm-admin-0602/providers/Microsoft.Resources/deployments/3b35b279-0e94-5264-85f5-0d9d662f8a38",
        "resourceGroup": "oraclevm-admin-0602",
        "resourceName": "3b35b279-0e94-5264-85f5-0d9d662f8a38",
        "resourceType": "Microsoft.Resources/deployments"
      }
    ],
    "duration": "PT17.4377546S",
    "mode": "Incremental",
    "onErrorDeployment": null,
    "outputResources": [
      {
        "id": "/subscriptions/05887623-95c5-4e50-a71c-6e1c738794e2/resourceGroups/oraclevm-admin-0602/providers/Microsoft.Compute/virtualMachines/adminVM/extensions/newuserscript",
        "resourceGroup": "oraclevm-admin-0602"
      }
    ],
    "outputs": {
      "artifactsLocationPassedIn": {
        "type": "String",
        "value": "https://raw.githubusercontent.com/wls-eng/arm-oraclelinux-wls-admin/master/src/main/arm/"
      }
    },
    "parameters": {
      "_artifactsLocation": {
        "type": "String",
        "value": "https://raw.githubusercontent.com/wls-eng/arm-oraclelinux-wls-admin/master/src/main/arm/"
      },
      "_artifactsLocationDbTemplate": {
        "type": "String",
        "value": "https://raw.githubusercontent.com/wls-eng/arm-oraclelinux-wls-admin/master/src/main/arm/"
      }
      "adminVMName": {
        "type": "String",
        "value": "adminVM"
      },
      "databaseType": {
        "type": "String",
        "value": "postgresql"
      },
      "dbPassword": {
        "type": "SecureString"
      },
      "dbUser": {
        "type": "String",
        "value": "weblogic@oraclevm"
      },
      "dsConnectionURL": {
        "type": "String",
        "value": "jdbc:postgresql://oraclevm.postgres.database.azure.com:5432/postgres"
      },
      "jdbcDataSourceName": {
        "type": "String",
        "value": "jdbc/WebLogicCafeDB"
      },
      "location": {
        "type": "String",
        "value": "eastus"
      },
      "wlsPassword": {
        "type": "SecureString"
      },
      "wlsUserName": {
        "type": "String",
        "value": "weblogic"
      }
    },
    "parametersLink": null,
    "providers": [
      {
        "id": null,
        "namespace": "Microsoft.Resources",
        "registrationPolicy": null,
        "registrationState": null,
        "resourceTypes": [
          {
            "aliases": null,
            "apiVersions": null,
            "capabilities": null,
            "locations": [
              null
            ],
            "properties": null,
            "resourceType": "deployments"
          }
        ]
      },
      {
        "id": null,
        "namespace": "Microsoft.Compute",
        "registrationPolicy": null,
        "registrationState": null,
        "resourceTypes": [
          {
            "aliases": null,
            "apiVersions": null,
            "capabilities": null,
            "locations": [
              "eastus"
            ],
            "properties": null,
            "resourceType": "virtualMachines/extensions"
          }
        ]
      }
    ],
    "provisioningState": "Succeeded",
    "template": null,
    "templateHash": "6381424766408193665",
    "templateLink": null,
    "timestamp": "2020-06-02T06:05:03.141828+00:00"
  },
  "resourceGroup": "oraclevm-admin-0602",
  "type": "Microsoft.Resources/deployments"
}

```

## Verify Database Connection

Follow the steps to check if AAD is enabled.

* Go to WebLogic Admin Server Console,  you can find it from output of WebLogic Instance deployment.
* Go to Services -> DataSources
* Click JDBC database name, e.g. `jdbc/WebLogicDB`
* Click Monitoring -> Testing
* Select `admin` and click "Test Data Source"
* If the database is enbaled, you will get message like "Test of jdbc/WebLogicDB on server admin was successful."


