# Introduction to Salesforce Development

Welcome to the beginner Salesforce developer webinar: **Introduction to Salesforce Development**. This project contains examples and resources to help you get started with Salesforce development.

## Key Concepts and Examples

This project includes several Apex classes and triggers that demonstrate fundamental Salesforce development concepts:

### Apex Classes

1. **BasicConcepts.cls**
   - Demonstrates fundamental programming concepts such as variables, data types, flow control, loops, and methods.
   - Includes examples of simple calculations, string operations, and collection handling.

2. **DataHelper.cls**
   - Shows how to work with Salesforce data using SOQL queries and DML operations.
   - Examples include finding contacts by name, creating new accounts, updating contact titles, and deleting old leads.

3. **CustomUIController.cls**
   - Demonstrates the controller side of custom UI development.
   - Includes methods for retrieving recent accounts, getting account details, saving accounts, searching accounts, and logging errors.

4. **AccountTriggerHelper.cls**
   - Contains business logic for handling Account triggers.
   - Includes methods for processing accounts before and after insert/update, creating follow-up tasks, and generating opportunities for hot accounts.

### Apex Triggers

1. **AccountTrigger.trigger**
   - A basic trigger that fires when Account records are modified.
   - Delegates logic to the `AccountTriggerHelper` class for handling different trigger contexts (before/after insert/update).

### SOQL Queries

- **account.soql**
  - Example query to retrieve Account records with their IDs and Names.

### Anonymous Apex

- **hello.apex**
  - Demonstrates how to execute anonymous Apex code for debugging and testing purposes.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
