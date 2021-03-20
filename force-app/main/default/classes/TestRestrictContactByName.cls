@isTest
private class TestRestrictContactByName {

    @isTest
    static void testTriggerRestrictContactByName() {
        Contact conBad = new Contact(LastName = 'INVALIDNAME');
           
        Test.startTest();
        try {
            insert conBad;
        } catch(DmlException e) {   }

        Test.stopTest();
    }
}
