@isTest
private class TestVerifyDate {
    
    @isTest
    static void testBeforeOfRange(){
        Date date1 = Date.NewInstance(2000, 2, 27);
        Date date2 = Date.NewInstance(1999, 6, 16);
        Date dateExpected1 = Date.NewInstance(2000, 2, 29);
        
        Date d = VerifyDate.CheckDates(date1, date2);    
        System.assertEquals(dateExpected1, d);
    }

    @isTest
    static void testFarAfterOfRange() {
        Date date1 = Date.NewInstance(2018, 4, 27);
        Date date2 = Date.NewInstance(2018, 6, 19);
        Date dateExpected1 = Date.NewInstance(2018, 4, 30);

        Date d = VerifyDate.CheckDates(date1, date2);    
        System.assertEquals(dateExpected1, d);
    }

    @isTest
    static void testInsideOfRange() {
        Date date1 = Date.NewInstance(2018, 4, 27);
        Date date2 = Date.NewInstance(2018, 5, 19);

        Date d = VerifyDate.CheckDates(date1, date2);    
        System.assertEquals(date2, d);
    }
}
