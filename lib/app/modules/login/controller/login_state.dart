
part of 'login_controller.dart';

enum LoginStatus {
  initial,
  loading,
  failure,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMassage;

  const LoginState._({required this.status, this.errorMassage});

  const LoginState.initial() : this._(status: LoginStatus.initial);

  @override
  List<Object?> get props => [status, errorMassage];



  LoginState copyWith({
    LoginStatus? status,
    String? errorMassage,
  }) {
    return LoginState._(
      status: status ?? this.status,
      errorMassage: errorMassage ?? this.errorMassage,
    );
  }
}
