// Represents how the pipeline ended.
import 'package:launchpipeline/src/base/base_index.dart';

sealed class PipelineOutput {
  const PipelineOutput();
}

class PipelineCompleted extends PipelineOutput {
  PipelineCompleted();
}

class PipelineStopped extends PipelineOutput {
  const PipelineStopped(this.reason);

  final StopReason reason;
}

class PipelineFailure extends PipelineOutput {
  const PipelineFailure(this.exception);

  final Exception exception;
}
