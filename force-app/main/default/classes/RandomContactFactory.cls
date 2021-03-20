public with sharing class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer num, String lastname) {
        List<Contact> conts = new List<Contact>();

        for (Integer i = 1; i < num + 1; i++) {
            Contact currentCon = new Contact (FirstName = 'Test ' + i, LastName = lastname);
            conts.add(currentCon);
        }

        return conts;
    }
}
