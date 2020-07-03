# WebLogic Server on Microsoft Azure - Marketplace Offerings

This readme provides an overview of the usage and features available in the WebLogic Server Azure Marketplace Offerings. 

For more comprehensive documentation, please refer [Oracle WebLogic Server Azure Applications](https://docs.microsoft.com/en-us/azure/virtual-machines/workloads/oracle/oracle-weblogic)

This is the main/root git repository for the Azure Resource Management (ARM) templates and other scripts used for the implementation of WebLogic Server on Microsoft Azure.

<a href="https://github.com/wls-eng/arm-oraclelinux-wls">https://github.com/wls-eng/arm-oraclelinux-wls</a>

## Azure Marketplace

The [Azure Marketplace WebLogic Server Offering](https://portal.azure.com/#create/oracle.20191001-arm-oraclelinux-wls20191001-arm-oraclelinux-wls) offers a simplified UI and installation experience over the full power of the ARM template.
The basic offering will bootstrap an Oracle Linux VM with pre-installed WebLogic Server (without Administration Server).

Apart from the basic offering, the following are few of the other single/multinode deployment offers that are available in the Azure Marketplace:

-	Oracle WebLogic Server with Administration Server
-	Oracle WebLogic Server N-Node cluster
-	Oracle WebLogic Server N-Node dynamic cluster

---

![WebLogic Server Azure Marketplace UI Flow](images/wls-on-azure.gif)

---

Each of these Azure Marketplace WebLogic Server Offerings also have their corresponding github repositories, where in the arm templates can be used to deploy the offering directly from the Azure CLI or Azure Powershell.

The following are the corresponding github repositories:

-	[https://github.com/wls-eng/arm-oraclelinux-wls-admin](https://github.com/wls-eng/arm-oraclelinux-wls-admin)

-	[https://github.com/wls-eng/arm-oraclelinux-wls-cluster](https://github.com/wls-eng/arm-oraclelinux-wls-cluster)

-	[https://github.com/wls-eng/arm-oraclelinux-wls-dynamic-cluster](https://github.com/wls-eng/arm-oraclelinux-wls-dynamic-cluster)


## Issue Tracker

Any Issue related to Oracle WebLogic on Microsoft Azure implementation is tracked at <br> [https://github.com/wls-eng/arm-oraclelinux-wls/issues](https://github.com/wls-eng/arm-oraclelinux-wls/issues). <br>
This is a common issue tracker and tracks all issues across all the WebLogic Server offerings 

