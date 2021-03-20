public class AnimalLocator {
        
    public static String getAnimalNameById(Integer animalId) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+animalId);
        request.setMethod('GET');
        String animalName = '';
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            System.debug(response.getBody());
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> animals = (Map<String, Object>) results.get('animal');
            animalName = String.valueof(animals.get('name'));
        }
        return animalName;
    }
}
