/**
 * CustomUIController
 * A simple Apex controller for a custom UI component
 * This demonstrates the controller side of custom UI development
 */
public with sharing class CustomUIController {
    
    // Property to store the current account
    private Account currentAccount;
    
    // Constructor
    public CustomUIController() {
        // Initialize any necessary variables
        System.debug('Controller initialized');
    }
    
    /**
     * Get a list of recent accounts
     * @return List of recent accounts
     */
    @AuraEnabled(cacheable=true)
    public static List<Account> getRecentAccounts() {
        return [
            SELECT Id, Name, Industry, Type, Phone, Website
            FROM Account
            ORDER BY CreatedDate DESC
            LIMIT 5
        ];
    }
    
    /**
     * Get account details by ID
     * @param accountId The ID of the account to retrieve
     * @return The Account record with contacts
     */
    @AuraEnabled(cacheable=true)
    public static Account getAccountDetails(Id accountId) {
        try {
            // Query the account and related contacts
            Account acc = [
                SELECT Id, Name, Industry, Type, Phone, Website,
                       BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry,
                       (SELECT Id, FirstName, LastName, Email, Phone FROM Contacts LIMIT 10)
                FROM Account
                WHERE Id = :accountId
            ];
            
            return acc;
        } catch(Exception e) {
            // Handle any errors and return null
            System.debug('Error retrieving account: ' + e.getMessage());
            throw new AuraHandledException('Unable to retrieve account details: ' + e.getMessage());
        }
    }
    
    /**
     * Save changes to an account
     * @param account The account to save
     * @return The updated account
     */
    @AuraEnabled
    public static Account saveAccount(Account account) {
        try {
            // Perform data validation
            if(account.Name == null || account.Name.trim() == '') {
                throw new AuraHandledException('Account name cannot be empty');
            }
            
            // Update the record in the database
            update account;
            System.debug('Account updated successfully: ' + account.Id);
            
            // Return the updated account
            return getAccountDetails(account.Id);
        } catch(Exception e) {
            System.debug('Error saving account: ' + e.getMessage());
            throw new AuraHandledException('Unable to save account: ' + e.getMessage());
        }
    }
    
    /**
     * Search for accounts by keyword
     * @param searchTerm The search term
     * @return List of matching accounts
     */
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(String searchTerm) {
        // Format the search term for SOQL query
        String searchKey = '%' + searchTerm + '%';
        
        try {
            // Perform the search query
            List<Account> results = [
                SELECT Id, Name, Industry, Type, Phone
                FROM Account
                WHERE Name LIKE :searchKey
                OR Industry LIKE :searchKey
                OR Type LIKE :searchKey
                ORDER BY Name
                LIMIT 10
            ];
            
            return results;
        } catch(Exception e) {
            System.debug('Error searching accounts: ' + e.getMessage());
            throw new AuraHandledException('Error performing search: ' + e.getMessage());
        }
    }
    
    /**
     * Log an error to a custom object
     * @param componentName The name of the component where the error occurred
     * @param errorMessage The error message
     * @param stackTrace The error stack trace
     */
    @AuraEnabled
    public static void logError(String componentName, String errorMessage, String stackTrace) {
        System.debug('Error in ' + componentName + ': ' + errorMessage);
        
        // In a real system, you might create a record in a custom Error_Log__c object
        // For this demo, we'll just debug the error
        System.debug('Component: ' + componentName);
        System.debug('Error Message: ' + errorMessage);
        System.debug('Stack Trace: ' + stackTrace);
    }
}