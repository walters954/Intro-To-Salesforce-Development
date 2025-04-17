/**
 * BasicConcepts Class
 * This is a basic Apex class demonstrating fundamental programming concepts
 * Perfect for beginners learning Salesforce development
 */
public class BasicConcepts {
    // Class variable with a default value (accessible to all methods)
    private static final String COMPANY_NAME = 'Salesforce Mentor';
    
    // Public method that demonstrates variables and data types
    public static void demonstrateVariables() {
        // Variable declarations with different data types
        String name = 'Warren';              // Text data
        Integer age = 35;                    // Whole number
        Decimal salary = 75000.50;           // Number with decimal places
        Boolean isActive = true;             // True/false value
        Date joinDate = Date.today();        // Today's date
        DateTime currentTime = DateTime.now(); // Current date and time
        
        // Using System.debug to print values to the debug log
        System.debug('Name: ' + name);
        System.debug('Age: ' + age);
        
        // Simple math operations using operators
        Integer nextYearAge = age + 1;       // Addition
        Decimal monthlySalary = salary / 12; // Division
        
        // Using operators for comparison
        if (age > 30) {
            System.debug(name + ' is over 30 years old');
        }
        
        // String operations
        String fullName = name + ' Walters'; // Concatenation
        Boolean containsA = name.contains('a'); // Using dot notation
    }
    
    // Method demonstrating flow control with if/else statements
    public static void demonstrateFlowControl(Integer score) {
        // Simple if-else statement
        if (score >= 90) {
            System.debug('Grade: A');
        } else if (score >= 80) {
            System.debug('Grade: B');
        } else if (score >= 70) {
            System.debug('Grade: C');
        } else {
            System.debug('Grade: Needs Improvement');
        }
    }
    
    // Method demonstrating loops and collections
    public static void demonstrateLoops() {
        // Create a list (collection) of strings
        List<String> certifications = new List<String>{
            'Admin', 'Platform Developer I', 'Platform App Builder', 'Sales Cloud'
        };
        
        // For loop to iterate through each item
        System.debug('All certifications:');
        for(String cert : certifications) {
            System.debug('- ' + cert);
        }
        
        // Traditional for loop with counter
        System.debug('Counting from 1 to 5:');
        for(Integer i = 1; i <= 5; i++) {
            System.debug('Count: ' + i);
        }
        
        // While loop example
        Integer count = 1;
        while(count <= 3) {
            System.debug('While count: ' + count);
            count++;
        }
    }
    
    // Method demonstrating multiple parameters and return values
    public static Decimal calculateTotal(Decimal price, Integer quantity) {
        // Simple calculation
        Decimal subtotal = price * quantity;
        Decimal tax = subtotal * 0.08; // 8% tax
        Decimal total = subtotal + tax;
        
        // Return the calculated value
        return total;
    }
}