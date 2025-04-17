/**
 * DataHelper Class
 * This class demonstrates working with Salesforce data 
 * through SOQL queries and DML operations
 */
public class DataHelper {
    
    /**
     * Find contacts by name using SOQL
     * @param searchName The name to search for
     * @return A list of contacts matching the search term
     */
    public static List<Contact> findContactsByName(String searchName) {
        // Basic SOQL query with a WHERE filter
        List<Contact> contacts = [
            SELECT Id, FirstName, LastName, Email, Phone 
            FROM Contact 
            WHERE FirstName LIKE :('%' + searchName + '%') 
            OR LastName LIKE :('%' + searchName + '%')
            LIMIT 10
        ];
        
        // Debug the results
        System.debug('Found ' + contacts.size() + ' contacts');
        return contacts;
    }
    
    /**
     * Create a new account record
     * @param accountName Name for the new account
     * @return The newly created account
     */
    public static Account createNewAccount(String accountName) {
        // Create a new sObject record
        Account newAccount = new Account();
        
        // Set field values
        newAccount.Name = accountName;
        newAccount.Type = 'Customer';
        newAccount.Industry = 'Technology';
        
        try {
            // Insert the record into the database
            insert newAccount;
            System.debug('Created new account with ID: ' + newAccount.Id);
            return newAccount;
        } catch(Exception e) {
            // Handle any errors
            System.debug('Error creating account: ' + e.getMessage());
            return null;
        }
    }
    
    /**
     * Get accounts and their related contacts
     * @return List of accounts with contacts
     */
    public static List<Account> getAccountsWithContacts() {
        // SOQL query with relationship
        List<Account> accounts = [
            SELECT Id, Name, 
                   (SELECT Id, FirstName, LastName, Email FROM Contacts)
            FROM Account
            WHERE Type = 'Customer'
            LIMIT 5
        ];
        
        // Loop through results to access related records
        for(Account acc : accounts) {
            System.debug('Account: ' + acc.Name);
            System.debug('Number of contacts: ' + acc.Contacts.size());
            
            // Loop through child records
            for(Contact con : acc.Contacts) {
                System.debug('-- Contact: ' + con.FirstName + ' ' + con.LastName);
            }
        }
        
        return accounts;
    }
    
    /**
     * Update multiple contact records
     * @param contactIds List of contact IDs to update
     * @param title The title to set for these contacts
     */
    public static void updateContactTitle(List<Id> contactIds, String title) {
        // Query the records first
        List<Contact> contactsToUpdate = [
            SELECT Id, Title
            FROM Contact
            WHERE Id IN :contactIds
        ];
        
        // Loop through and update each record
        for(Contact con : contactsToUpdate) {
            con.Title = title;
        }
        
        try {
            // Update all records in a single DML statement
            update contactsToUpdate;
            System.debug('Successfully updated ' + contactsToUpdate.size() + ' contacts');
        } catch(Exception e) {
            System.debug('Error updating contacts: ' + e.getMessage());
        }
    }
    
    /**
     * Delete records that match certain criteria
     * @param daysOld Records older than this many days will be deleted
     */
    public static void deleteOldLeads(Integer daysOld) {
        // Calculate the cutoff date
        Date cutoffDate = Date.today().addDays(-daysOld);
        
        // Find records to delete
        List<Lead> leadsToDelete = [
            SELECT Id, Name, CreatedDate
            FROM Lead
            WHERE Status = 'Closed - Not Converted'
            AND CreatedDate < :cutoffDate
        ];
        
        System.debug('Found ' + leadsToDelete.size() + ' leads to delete');
        
        if(!leadsToDelete.isEmpty()) {
            try {
                // Delete records
                delete leadsToDelete;
                System.debug('Successfully deleted old leads');
            } catch(Exception e) {
                System.debug('Error deleting leads: ' + e.getMessage());
            }
        }
    }
}