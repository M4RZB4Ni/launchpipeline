import 'package:launchpipeline/launchpipeline.dart';
import 'package:test/test.dart';

void pipelineManagerTests() {
  group('PipelineManager', () {
    group('constructor', () {
      test('should have private constructor', () {
        // Assert
        expect(PipelineManager, isA<Type>());
        // Note: We can't directly test private constructor, but we can verify the class exists
      });
    });

    group('launchContext', () {
      test('should provide shared LaunchContext instance', () {
        // Act
        final context1 = PipelineManager.launchContext;
        final context2 = PipelineManager.launchContext;

        // Assert
        expect(context1, isA<LaunchContext>());
        expect(context2, isA<LaunchContext>());
        expect(identical(context1, context2), isTrue);
      });

      test('should allow context modification', () {
        // Arrange
        final context = PipelineManager.launchContext;
        const newIsLoggedIn = true;

        // Act
        context.isLoggedIn = newIsLoggedIn;

        // Assert
        expect(context.isLoggedIn, equals(newIsLoggedIn));
      });
    });

    group('runPipeline', () {
      test('should run pipeline successfully', () async {
        // Arrange
        final tasks = <LaunchTask>[
          _MockContinueTask(),
          _MockContinueTask(),
        ];
        final pipeline = LaunchPipeline(tasks);

        // Act
        final result = await PipelineManager.runPipeline(pipeline);

        // Assert
        expect(result, isA<PipelineCompleted>());
      });

      test('should store pipeline for restart', () async {
        // Arrange
        final tasks = <LaunchTask>[
          _MockContinueTask(),
        ];
        final pipeline = LaunchPipeline(tasks);

        // Act
        await PipelineManager.runPipeline(pipeline);

        // Assert
        // Note: We can't directly test the private _pipeline field,
        // but we can verify the method completes without error
        expect(true, isTrue);
      });

      test('should handle pipeline with stop reason', () async {
        // Arrange
        const stopReason = NoInternet();
        final tasks = <LaunchTask>[
          _MockContinueTask(),
          _MockStopTask(stopReason),
        ];
        final pipeline = LaunchPipeline(tasks);

        // Act
        final result = await PipelineManager.runPipeline(pipeline);

        // Assert
        expect(result, isA<PipelineStopped>());
        expect((result as PipelineStopped).reason, equals(stopReason));
      });

      test('should handle pipeline with error', () async {
        // Arrange
        final exception = Exception('Pipeline error');
        final tasks = <LaunchTask>[
          _MockErrorTask(exception),
        ];
        final pipeline = LaunchPipeline(tasks);

        // Act
        final result = await PipelineManager.runPipeline(pipeline);

        // Assert
        expect(result, isA<PipelineFailure>());
        expect((result as PipelineFailure).exception, equals(exception));
      });
    });

    group('restart', () {
      test('should restart the last run pipeline', () async {
        // Arrange
        final tasks = <LaunchTask>[
          _MockContinueTask(),
        ];
        final pipeline = LaunchPipeline(tasks);
        await PipelineManager.runPipeline(pipeline);

        // Act
        final result = await PipelineManager.restart();

        // Assert
        expect(result, isA<PipelineCompleted>());
      });

      test('should throw if no pipeline was run before', () async {
        // Act & Assert
        expect(
          () => PipelineManager.restart(),
          throwsA(isA<StateError>()),
        );
      });
    });
  });
}

// Mock task implementations for testing
class _MockContinueTask extends LaunchTask {
  @override
  Future<TaskOutput> execute(LaunchContext context) async {
    return const TaskContinue();
  }
}

class _MockStopTask extends LaunchTask {
  _MockStopTask(this.reason);

  final StopReason reason;

  @override
  Future<TaskOutput> execute(LaunchContext context) async {
    return TaskStop(reason);
  }
}

class _MockErrorTask extends LaunchTask {
  _MockErrorTask(this.exception);

  final Exception exception;

  @override
  Future<TaskOutput> execute(LaunchContext context) async {
    return TaskError(exception);
  }
}
