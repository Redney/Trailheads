@isTest
public class AnimalLocatorTest {
    @isTest
    static void testGetCallout() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String result = AnimalLocator.getAnimalNameById(1);
        String expectedResult = 'chicken';
        System.assertEquals(result, expectedResult);
    }   
}
