import 'package:launchpipeline/src/base/base_index.dart';

class CheckUpdateTask extends LaunchTask {
  CheckUpdateTask({required this.updateInfoProvider});

  final UpdateInfoProvider updateInfoProvider;

  @override
  Future<TaskOutput> execute(LaunchContext context) async {
    final serverInfo = await updateInfoProvider.getServerUpdateInfo();
    context.isUpdateAvailable = serverInfo.isUpdateAvailable;
    context.isForcedUpdate = serverInfo.isForced;
    context.updateUrl = serverInfo.updateUrl;

    return TaskContinue();
  }
}

abstract class UpdateInfoProvider {
  Future<ServerUpdateInfo> getServerUpdateInfo();
}

class ServerUpdateInfo {
  ServerUpdateInfo({required this.isUpdateAvailable, required this.isForced, required this.updateUrl});

  final bool isUpdateAvailable;
  final bool isForced;
  final String updateUrl;
}
