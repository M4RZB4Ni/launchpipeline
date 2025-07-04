// Represents a single piece of work to be done during app launch.
import 'package:launchpipeline/src/base/base_index.dart';

abstract class LaunchTask {
  /// Perform the work for this task. The result is a [TaskOutput],
  /// which dictates how the pipeline will proceed.
  Future<TaskOutput> execute(LaunchContext context);
}

typedef LaunchTasks = List<LaunchTask>;
