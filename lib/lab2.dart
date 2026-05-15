void runLab2() {
  print('Lab2\n');

  exercise1();
  exercise2();
  exercise3();
  exercise4();
}

void main() {
  runLab2();
}

void exercise1() {
  print('Exercise 1: Basic Syntax & Data Types');

  // Declare variables using core Dart types.
  int studentCount = 28;
  double averageScore = 87.4;
  String courseName = 'Dart Fundamentals';
  bool isLabActive = true;

  // Print values with string interpolation.
  print('Course: $courseName');
  print('Students enrolled: $studentCount');
  print('Average score: $averageScore');
  print('Lab active: ${isLabActive ? 'Yes' : 'No'}');
  print('Next student index: ${studentCount + 1}');
  print('');
}

void exercise2() {
  print('Exercise 2: Collections & Operators');

  // Create a List of integers.
  List<int> numbers = [10, 20, 30, 40, 40];
  print('Original list: $numbers');

  // Arithmetic and comparison operators.
  int sum = numbers[0] + numbers[1];
  bool isEqual = numbers[2] == 30;
  print('Sum of first two values: $sum');
  print('Third value equals 30: $isEqual');

  // Create a Set to ensure unique values.
  Set<int> uniqueNumbers = numbers.toSet();
  uniqueNumbers.add(50);
  uniqueNumbers.remove(10);
  print('Unique numbers: $uniqueNumbers');

  // Create a Map of student data.
  Map<String, dynamic> student = {
    'name': 'Alice',
    'age': 21,
    'passed': true,
  };
  print('Student map: $student');
  print('Student name: ${student['name']}');
  print('Student age: ${student['age']}');

  // Use the ternary operator.
  String result = (student['passed'] == true) ? 'Passed' : 'Failed';
  print('Result: $result');
  print('');
}

void exercise3() {
  print('Exercise 3: Control Flow & Functions');

  int score = 74;

  // if / else logic to determine grade.
  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 75) {
    print('Grade: B');
  } else if (score >= 60) {
    print('Grade: C');
  } else {
    print('Grade: D');
  }

  // switch statement for day of week.
  int weekday = 3;
  switch (weekday) {
    case 1:
      print('Day 1: Monday');
      break;
    case 2:
      print('Day 2: Tuesday');
      break;
    case 3:
      print('Day 3: Wednesday');
      break;
    case 4:
      print('Day 4: Thursday');
      break;
    case 5:
      print('Day 5: Friday');
      break;
    default:
      print('Weekend');
  }

  List<String> fruits = ['apple', 'banana', 'cherry'];

  // for loop with index.
  for (int i = 0; i < fruits.length; i++) {
    print('for index $i: ${fruits[i]}');
  }

  // for-in loop.
  for (String fruit in fruits) {
    print('for-in item: $fruit');
  }

  // forEach loop.
  fruits.forEach((fruit) => print('forEach item: $fruit'));

  // Normal function call.
  print(descriptionMessage(score));

  // Arrow function call.
  print(shortDescription(score));
  print('');
}

String descriptionMessage(int score) {
  // Normal function with a block body.
  if (score >= 80) {
    return 'Excellent performance with score $score.';
  }
  return 'Keep improving; your score is $score.';
}

String shortDescription(int score) => 'Score passed to arrow function: $score';

void exercise4() {
  print('Exercise 4: Intro to OOP');

  // Create a Car object using the default constructor.
  Car car1 = Car('Sedan', 2018);
  print(car1.describe());
  car1.start();

  // Create a Car object using a named constructor.
  Car classicCar = Car.classic();
  print(classicCar.describe());
  classicCar.start();

  // Create an ElectricCar object and demonstrate method overriding.
  ElectricCar tesla = ElectricCar('Tesla Model 3', 2022, 95);
  print(tesla.describe());
  tesla.start();
  print(tesla.charge());
  print('');
}

class Car {
  String model;
  int year;

  Car(this.model, this.year);

  Car.classic()
      : model = 'Classic Coupe',
        year = 1968;

  String describe() {
    return 'Car model: $model, year: $year';
  }

  void start() {
    print('$model is starting with a roar.');
  }
}

class ElectricCar extends Car {
  int batteryLevel;

  ElectricCar(String model, int year, this.batteryLevel) : super(model, year);

  @override
  void start() {
    print('$model powers up silently with $batteryLevel% battery.');
  }

  String charge() {
    return '$model is charging to full capacity.';
  }
}

