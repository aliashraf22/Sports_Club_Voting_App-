part of 'security_check_cubit.dart';

abstract class SecurityCheckState extends Equatable {
  const SecurityCheckState();
}

class SecurityCheckInitial extends SecurityCheckState {
  @override
  List<Object> get props => [];
}

class SecurityCheckLoading extends SecurityCheckState {
  @override
  List<Object> get props => [];
}

class SecurityCheckLoaded extends SecurityCheckState {
  final bool isSecure;

  const SecurityCheckLoaded(this.isSecure);

  @override
  List<Object> get props => [isSecure];
}

class SecurityCheckError extends SecurityCheckState {
  final String errorMessage;

  const SecurityCheckError({required this.errorMessage});

  @override
  List<String> get props => [errorMessage];
}
