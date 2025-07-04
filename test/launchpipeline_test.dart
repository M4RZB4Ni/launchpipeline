import 'package:test/test.dart';

import 'base/launch_context_test.dart';
import 'base/launch_pipeline_test.dart';
import 'base/launch_task_test.dart';
import 'base/pipeline_manager_test.dart';
import 'base/pipeline_output_test.dart';
import 'base/stop_reason_test.dart';
import 'base/task_output_test.dart';
import 'tasks/check_credentials_task_test.dart';
import 'tasks/check_illegitimate_device_task_test.dart';
import 'tasks/check_internet_task_test.dart';
import 'tasks/check_update_task_test.dart';

void main() {
  group('LaunchPipeline Package Tests', () {
    // Base classes tests
    group('Base Classes', () {
      launchContextTests();
      launchTaskTests();
      taskOutputTests();
      pipelineOutputTests();
      stopReasonTests();
      launchPipelineTests();
      pipelineManagerTests();
    });

    // Built-in tasks tests
    group('Built-in Tasks', () {
      checkInternetTaskTests();
      checkUpdateTaskTests();
      checkIllegitimateDeviceTaskTests();
      checkCredentialsTaskTests();
    });
  });
}
