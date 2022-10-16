part of 'root_cubit.dart';

@immutable
class RootState {
  final User? user;
  final bool isLoading;
  final bool isCreatingAccount;
  final String errorMessage;

  const RootState(
      {required this.user,
      required this.isLoading,
      required this.isCreatingAccount,
      required this.errorMessage});
}
