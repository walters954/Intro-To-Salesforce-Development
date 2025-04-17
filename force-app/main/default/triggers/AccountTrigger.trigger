/**
 * AccountTrigger
 * Basic trigger that fires when Account records are modified
 */
trigger AccountTrigger on Account (before insert, before update, after insert, after update) {
    // Call the helper class to handle different trigger contexts
    if (Trigger.isBefore) {
        // Before triggers run before the record is saved to the database
        if (Trigger.isInsert) {
            // Handle before insert logic
            AccountTriggerHelper.handleBeforeInsert(Trigger.new);
        } else if (Trigger.isUpdate) {
            // Handle before update logic
            AccountTriggerHelper.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
        }
    } else if (Trigger.isAfter) {
        // After triggers run after the record is saved to the database
        if (Trigger.isInsert) {
            // Handle after insert logic
            AccountTriggerHelper.handleAfterInsert(Trigger.new);
        } else if (Trigger.isUpdate) {
            // Handle after update logic
            AccountTriggerHelper.handleAfterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}