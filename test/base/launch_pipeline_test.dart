import 'package:launchpipeline/launchpipeline.dart';
import 'package:test/test.dart';

void launchPipelineTests() {
  group('LaunchPipeline', () {
    group('constructor', () {
      test('should create with tasks', () {
        // Arrange
        final tasks = <LaunchTask>[
          _MockContinueTask(),
          _MockContinueTask(),
        ];

        // Act
        final pipeline = LaunchPipeline(tasks);

        // Assert
        expect(pipeline.tasks, equals(tasks));
        expect(pipeline.tasks.length, equals(2));
      });

      test('should create with empty tasks', () {
        // Arrange
        final tasks = <LaunchTask>[];

        // Act
        final pipeline = LaunchPipeline(tasks);

        // Assert
        expect(pipeline.tasks, equals(tasks));
        expect(pipeline.tasks.length, equals(0));
      });
    });

    group('run method', () {
      test('should complete successfully with all continue tasks', () async {
        // Arrange
        final tasks = <LaunchTask>[
          _MockContinueTask(),
          _MockContinueTask(),
          _MockContinueTask(),
        ];
        final pipeline = LaunchPipeline(tasks);
        final context = LaunchContext();

        // Act
        final result = await pipeline.run(context);

        // Assert
        expect(result, isA<PipelineCompleted>());
      });

      test('should stop when task returns TaskStop', () async {
        // Arrange
        const stopReason = NoInternet();
        final tasks = <LaunchTask>[
          _MockContinueTask(),
          _MockStopTask(stopReason),
          _MockContinueTask(), // This should not execute
        ];
        final pipeline = LaunchPipeline(tasks);
        final context = LaunchContext();

        // Act
        final result = await pipeline.run(context);

        // Assert
        expect(result, isA<PipelineStopped>());
        expect((result as PipelineStopped).reason, equals(stopReason));
      });

      test('should fail when task returns TaskError', () async {
        // Arrange
        final exception = Exception('Task failed');
        final tasks = <LaunchTask>[
          _MockContinueTask(),
          _MockErrorTask(exception),
          _MockContinueTask(), // This should not execute
        ];
        final pipeline = LaunchPipeline(tasks);
        final context = LaunchContext();

        // Act
        final result = await pipeline.run(context);

        // Assert
        expect(result, isA<PipelineFailure>());
        expect((result as PipelineFailure).exception, equals(exception));
      });

      test('should jump to specified task index', () async {
        // Arrange
        final tasks = <LaunchTask>[
          _MockContinueTask(),
          _MockJumpTask(0), // Jump back to first task
          _MockContinueTask(), // This should not execute
        ];
        final pipeline = LaunchPipeline(tasks);
        final context = LaunchContext();

        // Act
        final result = await pipeline.run(context);

        // Assert
        expect(result, isA<PipelineCompleted>());
      });

      test('should handle empty task list', () async {
        // Arrange
        final tasks = <LaunchTask>[];
        final pipeline = LaunchPipeline(tasks);
        final context = LaunchContext();

        // Act
        final result = await pipeline.run(context);

        // Assert
        expect(result, isA<PipelineCompleted>());
      });

      test('should pass context to all tasks', () async {
        // Arrange
        final context = LaunchContext();
        final task = _MockContextAwareTask();
        final pipeline = LaunchPipeline([task]);

        // Act
        await pipeline.run(context);

        // Assert
        expect(task.receivedContext, equals(context));
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

class _MockJumpTask extends LaunchTask {
  _MockJumpTask(this.index);

  final int index;

  @override
  Future<TaskOutput> execute(LaunchContext context) async {
    return TaskJumpTo(index);
  }
}

class _MockContextAwareTask extends LaunchTask {
  LaunchContext? receivedContext;

  @override
  Future<TaskOutput> execute(LaunchContext context) async {
    receivedContext = context;
    return const TaskContinue();
  }
}
