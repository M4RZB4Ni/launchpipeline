import 'package:launchpipeline/src/base/base_index.dart';

class CheckCredentialsTask extends LaunchTask {
  CheckCredentialsTask({required this.authTokenValidator});

  final AuthTokenValidator authTokenValidator;

  @override
  Future<TaskOutput> execute(LaunchContext context) async {
    try {
      final isValid = await authTokenValidator.isValid();
      context.isLoggedIn = isValid;
      return isValid ? const TaskContinue() : const TaskStop(NoCredentials());
    } catch (_) {
      context.isLoggedIn = false;
      return const TaskStop(NoCredentials());
    }
  }
}

abstract class AuthTokenValidator {
  Future<bool> isValid();
}
