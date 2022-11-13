//menu option widget to select day and meal and display the nutrition data using NutritionX widget

import 'package:flutter/material.dart';
import 'package:client/pages/Data/NutritionX.dart';

//convert the day to int
int dayToInt(String day) {
  switch (day) {
    case 'Monday':
      return 0;
    case 'Tuesday':
      return 1;
    case 'Wednesday':
      return 2;
    case 'Thursday':
      return 3;
    case 'Friday':
      return 4;
    case 'Saturday':
      return 5;
    case 'Sunday':
      return 6;
    default:
      return 0;
  }
}

//convert the meal to int
int mealToInt(String meal) {
  switch (meal) {
    case 'Breakfast':
      return 0;
    case 'Lunch':
      return 1;
    case 'Dinner':
      return 2;
    default:
      return 0;
  }
}

class MenuOption extends StatefulWidget {
  const MenuOption({Key? key}) : super(key: key);

  @override
  _MenuOptionState createState() => _MenuOptionState();
}

class _MenuOptionState extends State<MenuOption> {
  String _selectedDay = 'Monday';
  String _selectedMeal = 'Breakfast';

  @override
  Widget build(BuildContext context) {
    return Column(
      //add margin top
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        const Text(
          'Select Day and Meal',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 20),
        DropdownButton<String>(
          value: _selectedDay,
          items: <String>[
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedDay = value!;
            });
          },
        ),
        const SizedBox(height: 20),
        DropdownButton<String>(
          value: _selectedMeal,
          items: <String>['Breakfast', 'Lunch', 'Dinner']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedMeal = value!;
            });
          },
        ),
        const SizedBox(height: 20),
        NutritionX(
          day: dayToInt(_selectedDay),
          meal: mealToInt(_selectedMeal),
          index: 0,
        ),
      ],
    );
  }
}
