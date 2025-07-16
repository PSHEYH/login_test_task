part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, authenticated, error }

@JsonSerializable()
final class AuthState extends Equatable {
  const AuthState({this.status = AuthStatus.initial});

  final AuthStatus status;

  @override
  List<Object?> get props => [status];

  AuthState copyWith({AuthStatus? status}) {
    return AuthState(status: status ?? this.status);
  }
}
