import 'package:fark_et/repository/student_repository.dart';
import 'package:fark_et/services/fake_auth_service.dart';
import 'package:fark_et/services/firebase_auth_service.dart';
import 'package:get_it/get_it.dart';

/// GEtIt library with locator
///
/// While using with this library,
/// Whole services and repositories can accessible everywhere
GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthenticationService());
  locator.registerLazySingleton(() => StudentRepository());
}
