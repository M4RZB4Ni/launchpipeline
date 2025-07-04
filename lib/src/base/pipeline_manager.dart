import 'package:launchpipeline/src/base/base_index.dart';

class PipelineManager {
  PipelineManager._();

  static final LaunchContext launchContext = LaunchContext();

  static late LaunchPipeline _pipeline;

  static Future<PipelineOutput> runPipeline(LaunchPipeline pipeline) {
    _pipeline = pipeline;
    return pipeline.run(launchContext);
  }

  static Future restart() async {
    runPipeline(_pipeline);
  }
}
