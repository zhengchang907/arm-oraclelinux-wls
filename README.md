This template allows us to deploy a simple Oracle Linux VM with Weblogic Server (12.2.1.3.0) pre-installed. 
This template deploy by default, an A3 size VM in the resource group location and return the fully qualified domain name of the VM.

To install Weblogic Server, requires Oracle Weblogic Install kit and Oracle JDK to be downloaded, from OTN Site (https://www.oracle.com/technical-resources/). The OTN site requires the user to accept OTN User License Agreement before downloading any resources. 
So, when this template is run, user will be required to accept the License Agreement and also provide OTN credentials (username and password), to download the Oracle Weblogic Install Kit and Oracle JDK.


<h3>Using the template</h3>

**PowerShell**

*#use this command when you need to create a new resource group for your deployment*
*New-AzResourceGroup -Name <resource-group-name> -Location <resource-group-location> 

*New-AzResourceGroupDeployment -ResourceGroupName <resource-group-name> -TemplateUri https://raw.githubusercontent.com/wls-eng/arm-oraclelinux-wls/master/olvmdeploy.json*

**Command line**

*#use this command when you need to create a new resource group for your deployment*
*az group create --name <resource-group-name> --location <resource-group-location> 

*az group deployment create --resource-group <my-resource-group> --template-uri https://raw.githubusercontent.com/wls-eng/arm-oraclelinux-wls/master/olvmdeploy.json*

If you are new to Azure virtual machines, see:

    Azure Virtual Machines.
    Azure Linux Virtual Machines documentation
    Azure Windows Virtual Machines documentation
    Template reference
    Quickstart templates

If you are new to template deployment, see:

Azure Resource Manager documentation
