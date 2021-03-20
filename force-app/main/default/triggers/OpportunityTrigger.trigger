trigger OpportunityTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    OpportunityTriggerHandler oppTriggerHandler = new OpportunityTriggerHandler();
    
    if ((Trigger.isInsert)||(Trigger.isUndelete)) {
        oppTriggerHandler.oppInsertUndelete(Trigger.New);
    } 

    if (Trigger.isDelete) {
        oppTriggerHandler.oppDelete(Trigger.Old);
    }

    if (Trigger.isUpdate) {
        oppTriggerHandler.oppUpdate(Trigger.New, Trigger.OldMap);
    }
}
