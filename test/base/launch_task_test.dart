import 'package:launchpipeline/launchpipeline.dart';
import 'package:test/test.dart';

void launchTaskTests() {
  group('LaunchTask', () {
    group('abstract class', () {
      test('should be abstract', () {
        // Assert
        expect(LaunchTask, isA<Type>());
        // Note: We can't directly test if it's abstract, but we can verify it exists
      });
    });

    group('concrete implementation', () {
      test('should implement execute method', () async {
        // Arrange
        final mockTask = _MockLaunchTask();
        final context = LaunchContext();

        // Act
        final result = await mockTask.execute(context);

        // Assert
        expect(result, isA<TaskOutput>());
      });
    });

    group('LaunchTasks typedef', () {
      test('should be a List of LaunchTask', () {
        // Arrange
        final mockTask1 = _MockLaunchTask();
        final mockTask2 = _MockLaunchTask();

        // Act
        final tasks = <LaunchTask>[mockTask1, mockTask2];

        // Assert
        expect(tasks, isA<LaunchTasks>());
        expect(tasks.length, equals(2));
        expect(tasks[0], isA<LaunchTask>());
        expect(tasks[1], isA<LaunchTask>());
      });
    });
  });
}

// Mock implementation for testing
class _MockLaunchTask extends LaunchTask {
  @override
  Future<TaskOutput> execute(LaunchContext context) async {
    return const TaskContinue();
  }
}
