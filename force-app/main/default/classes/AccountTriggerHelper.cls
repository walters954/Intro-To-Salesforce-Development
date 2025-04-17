/**
 * AccountTriggerHelper
 * Helper class that contains the business logic for the AccountTrigger
 */
public class AccountTriggerHelper {
    
    /**
     * Handles logic before new Account records are inserted
     * @param newAccounts List of new Account records
     */
    public static void handleBeforeInsert(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            // Set default values for new accounts
            if (acc.Industry == null) {
                acc.Industry = 'Other';
            }
            
            // Format the account name to proper case
            if (acc.Name != null) {
                acc.Name = formatName(acc.Name);
            }
            
            // Set a description if empty
            if (acc.Description == null || acc.Description.trim() == '') {
                acc.Description = 'This account was created on ' + Date.today().format();
            }
        }
        
        System.debug('Processed ' + newAccounts.size() + ' new accounts before insert');
    }
    
    /**
     * Handles logic before existing Account records are updated
     * @param newAccounts List of updated Account records
     * @param oldMap Map of Account records before the update
     */
    public static void handleBeforeUpdate(List<Account> newAccounts, Map<Id, Account> oldMap) {
        for (Account acc : newAccounts) {
            Account oldAcc = oldMap.get(acc.Id);
            
            // Check if specific fields changed
            if (acc.Name != oldAcc.Name && acc.Name != null) {
                acc.Name = formatName(acc.Name);
            }
            
            // Add a note about when the account was last modified
            acc.Description = acc.Description + '\nLast modified on: ' + DateTime.now().format();
        }
        
        System.debug('Processed ' + newAccounts.size() + ' accounts before update');
    }
    
    /**
     * Handles logic after new Account records are inserted
     * @param newAccounts List of new Account records
     */
    public static void handleAfterInsert(List<Account> newAccounts) {
        // Create Tasks for new accounts
        List<Task> tasksToInsert = new List<Task>();
        
        for (Account acc : newAccounts) {
            // Create a follow-up task for each new account
            Task followUpTask = new Task();
            followUpTask.Subject = 'Follow up with new account: ' + acc.Name;
            followUpTask.ActivityDate = Date.today().addDays(7); // Due in one week
            followUpTask.Status = 'Not Started';
            followUpTask.Priority = 'Normal';
            followUpTask.WhatId = acc.Id; // Link to the account
            
            tasksToInsert.add(followUpTask);
        }
        
        if (!tasksToInsert.isEmpty()) {
            try {
                insert tasksToInsert;
                System.debug('Created ' + tasksToInsert.size() + ' follow-up tasks');
            } catch (Exception e) {
                System.debug('Error creating tasks: ' + e.getMessage());
            }
        }
    }
    
    /**
     * Handles logic after existing Account records are updated
     * @param newAccounts List of updated Account records
     * @param oldMap Map of Account records before the update
     */
    public static void handleAfterUpdate(List<Account> newAccounts, Map<Id, Account> oldMap) {
        // Get accounts where the rating changed to "Hot"
        List<Account> hotAccounts = new List<Account>();
        
        for (Account acc : newAccounts) {
            Account oldAcc = oldMap.get(acc.Id);
            
            // Check if Rating changed to "Hot"
            if (acc.Rating == 'Hot' && oldAcc.Rating != 'Hot') {
                hotAccounts.add(acc);
            }
        }
        
        // Process hot accounts
        if (!hotAccounts.isEmpty()) {
            createOpportunitiesForHotAccounts(hotAccounts);
        }
    }
    
    /**
     * Creates new opportunity records for accounts marked as "Hot"
     * @param accounts List of hot-rated accounts
     */
    private static void createOpportunitiesForHotAccounts(List<Account> accounts) {
        List<Opportunity> oppsToInsert = new List<Opportunity>();
        
        for (Account acc : accounts) {
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name + ' - New Opportunity';
            opp.AccountId = acc.Id;
            opp.CloseDate = Date.today().addMonths(1);
            opp.StageName = 'Prospecting';
            
            oppsToInsert.add(opp);
        }
        
        if (!oppsToInsert.isEmpty()) {
            try {
                insert oppsToInsert;
                System.debug('Created ' + oppsToInsert.size() + ' opportunities for hot accounts');
            } catch (Exception e) {
                System.debug('Error creating opportunities: ' + e.getMessage());
            }
        }
    }
    
    /**
     * Formats a name string to proper case
     * @param name The name to format
     * @return The formatted name
     */
    private static String formatName(String name) {
        if (name == null || name.trim() == '') return name;
        
        // Split the name into words
        List<String> words = name.toLowerCase().split(' ');
        List<String> formattedWords = new List<String>();
        
        // Capitalize the first letter of each word
        for (String word : words) {
            if (word.length() > 0) {
                formattedWords.add(word.substring(0, 1).toUpperCase() + 
                                  (word.length() > 1 ? word.substring(1) : ''));
            } else {
                formattedWords.add(word);
            }
        }
        
        // Join the words back together
        return String.join(formattedWords, ' ');
    }
}