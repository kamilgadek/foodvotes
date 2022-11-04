part of 'add_opinion_cubit.dart';

@immutable
class AddOpinionState {
  final double rating;
  final String restaurantName;
  final String pizzaName;
  final bool isLoading;

  const AddOpinionState({
    required this.pizzaName,
    required this.restaurantName,
    required this.rating,
    required this.isLoading,
  });
}
