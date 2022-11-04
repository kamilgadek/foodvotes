part of 'add_opinion_cubit.dart';

@immutable
class AddOpinionState {
  final double rating;
  final String restaurantName;
  final String pizzaName;

  const AddOpinionState({
    required this.pizzaName,
    required this.restaurantName,
    required this.rating,
  });
}
