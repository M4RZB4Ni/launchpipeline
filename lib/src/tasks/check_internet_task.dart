import 'package:launchpipeline/src/base/base_index.dart';

class CheckInternetTask extends LaunchTask {
  CheckInternetTask(this.connectivityChecker);

  final ConnectivityChecker connectivityChecker;

  @override
  Future<TaskOutput> execute(LaunchContext context) async {
    return await connectivityChecker.isNetworkAvailable() ? const TaskContinue() : const TaskStop(NoInternet());
  }
}

abstract interface class ConnectivityChecker {
  Future<bool> isNetworkAvailable();
}
