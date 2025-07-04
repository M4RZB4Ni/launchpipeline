// Executes a sequence of LaunchTask objects.
import 'package:launchpipeline/src/base/base_index.dart';

class LaunchPipeline {
  LaunchPipeline(this.tasks);

  final List<LaunchTask> tasks;

  Future<PipelineOutput> run(LaunchContext context) async {
    var index = 0;

    while (index < tasks.length) {
      final output = await tasks[index].execute(context);
      switch (output) {
        case TaskContinue():
          index++;
          break;
        case TaskStop(reason: final reason):
          return PipelineStopped(reason);
        case TaskError(exception: final exception):
          return PipelineFailure(exception);
        case TaskJumpTo(index: final jumpIndex):
          index = jumpIndex;
          break;
      }
    }
    return PipelineCompleted();
  }
}
