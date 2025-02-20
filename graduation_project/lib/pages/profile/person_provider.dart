import 'package:flutter/material.dart';
import 'package:graduation_project/pages/profile/person_module.dart';

class PersonProvider extends ChangeNotifier {
  Map<String, PersonModule> persons = {};
  int numberOfPersons = 0;

  addPerson(PersonModule person) {
    persons['$numberOfPersons'] = person;
    numberOfPersons++;
    notifyListeners();
  }

  PersonModule getPersonDataUsingUserName(String userName)
  {
    PersonModule? foundPerson = persons.values.firstWhere(
    (person) => person.userName == userName);
    return foundPerson;
  }
}
