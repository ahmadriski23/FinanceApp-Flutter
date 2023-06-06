import 'companyData.dart';

List<Money> geter() {
  Money food = Money();
  food.name = 'Food';
  food.fee = '650';
  food.time = 'Today';
  food.image = 'assets/images/Food.png';
  food.buy = false;

  // education
  Money education = Money();
  education.buy = true;
  education.fee = '15';
  education.image = 'assets/images/Education.png';
  education.name = 'Education';
  education.time = 'Today';
  Money transfer = Money();

  // Transfer Buy
  Money transportation = Money();
  transportation.buy = true;
  transportation.fee = '100';
  transportation.image = 'assets/images/Transportation.png';
  transportation.name = 'Transportation';
  transportation.time = 'Jan 30,2022';

  return [food, education, transportation, food, education, transportation];
}
