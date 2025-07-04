import 'package:launchpipeline/src/base/base_index.dart';

class CheckIlLegitimateDeviceTask implements LaunchTask {
  CheckIlLegitimateDeviceTask({required DeviceLegitimateChecker deviceLegitimateChecker}) : _deviceLegitimateChecker = deviceLegitimateChecker;

  final DeviceLegitimateChecker _deviceLegitimateChecker;

  @override
  Future<TaskOutput> execute(LaunchContext context) async {
    final isIllegitimate = await _deviceLegitimateChecker.isDeviceIllegitimate();
    return isIllegitimate ? const TaskContinue() : const TaskStop(IllegitimateDevice());
  }
}

abstract interface class DeviceLegitimateChecker {
  Future<bool> isDeviceIllegitimate();
}
