public with sharing class StringArrayTest {
    public static List<String> generateStringArray(Integer arraySize) {
        List<String> tests = new List<String>();
        for (Integer i = 0; i < arraySize; i++) {
            tests.add('Test ' + i);
            System.debug(tests[i]);
        }
        //System.debug(tests[arraySize-1]);
        return tests;
    }
}
