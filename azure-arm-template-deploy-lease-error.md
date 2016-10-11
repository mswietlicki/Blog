Title:  
Autor: Mateusz Świetlicki
CreateDate: 2016-10-11 13:15
Tags:	Blog
		EN
		Azure
		ARM Template
		PowerShell

![Azure](/files/Azure_small.png) Lately I tried to deploy Azure Resource Manager (ARM) Template with several WebTests (*microsoft.insights/webtests*) and I kept getting random error with message **"Lease already present"**. Error was very cryptic at first because it's internal implementation error licking out to end user but 
LZandmans [topic on msdn](https://social.msdn.microsoft.com/Forums/en-US/fe10c309-8d8f-4cd4-8cdc-80a93bee81b7/lease-already-present-while-deploying-web-test-using-arm-template?forum=azurescripting) supported my suspicions than error is caused by webtests concurrent deployment. 

So the solution is to fix dependencies in your template file. WebTests should be *dependsOn* Insights Component, Alerts should be *dependsOn* WebTests and WebTests should *dependsOn* previous WebTest.

```js
{
	"apiVersion": "2014-04-01",
	"name": "[parameters('webApi')]",
	"type": "Microsoft.Insights/components",
	...
},
{
	"type": "microsoft.insights/webtests",
	"name": "[concat(parameters('webApi'),'-CalculatorStatus')]",
	"apiVersion": "2014-04-01",
	"dependsOn": [
		"[resourceId('Microsoft.Insights/components', parameters('webApi'))]"
	]
	...
},
{
	"type": "microsoft.insights/alertrules",
	"name": "[concat(parameters('webApi'),'-CalculatorStatus-Alert')]",
	"apiVersion": "2014-04-01",
	"dependsOn": [
		"[resourceId('microsoft.insights/webtests', concat(parameters('webApi'),'-CalculatorStatus'))]"
	]
	...
},
{
	"comments": "",
	"type": "microsoft.insights/webtests",
	"name": "[concat(parameters('webApi'),'-DataProviderStatus')]",
	"apiVersion": "2014-04-01",
	"dependsOn": [
		"[resourceId('Microsoft.Insights/components', parameters('webApi'))]",
		"[resourceId('microsoft.insights/webtests', concat(parameters('webApi'),'-CalculatorStatus'))]"
	]
	...
},
{
	"type": "microsoft.insights/alertrules",
	"name": "[concat(parameters('webApi'),'-DataProviderStatus-Alert')]",
	"apiVersion": "2014-04-01",
	"dependsOn": [
		"[resourceId('microsoft.insights/webtests', concat(parameters('webApi'),'-DataProviderStatus'))]",
		"[resourceId('microsoft.insights/alertrules', concat(parameters('webApi'),'-CalculatorStatus-Alert'))]"
	]
	...
}

```