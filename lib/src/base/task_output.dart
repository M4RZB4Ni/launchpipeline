// Represents possible task outputs.
import 'package:launchpipeline/src/base/base_index.dart';

sealed class TaskOutput {
  const TaskOutput();
}

class TaskContinue extends TaskOutput {
  const TaskContinue();
}

class TaskStop extends TaskOutput {
  const TaskStop(this.reason);

  final StopReason reason;
}

class TaskError extends TaskOutput {
  const TaskError(this.exception);

  final Exception exception;
}

class TaskJumpTo extends TaskOutput {
  const TaskJumpTo(this.index);

  final int index;
}
