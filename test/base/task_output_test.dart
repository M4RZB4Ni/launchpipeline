import 'package:launchpipeline/launchpipeline.dart';
import 'package:test/test.dart';

void taskOutputTests() {
  group('TaskOutput', () {
    group('TaskContinue', () {
      test('should create TaskContinue instance', () {
        // Act
        const taskOutput = TaskContinue();

        // Assert
        expect(taskOutput, isA<TaskOutput>());
        expect(taskOutput, isA<TaskContinue>());
      });

      test('should be const', () {
        // Act
        const taskOutput1 = TaskContinue();
        const taskOutput2 = TaskContinue();

        // Assert
        expect(identical(taskOutput1, taskOutput2), isTrue);
      });
    });

    group('TaskStop', () {
      test('should create TaskStop with reason', () {
        // Arrange
        const reason = NoInternet();

        // Act
        const taskOutput = TaskStop(reason);

        // Assert
        expect(taskOutput, isA<TaskOutput>());
        expect(taskOutput, isA<TaskStop>());
        expect(taskOutput.reason, equals(reason));
      });

      test('should handle different stop reasons', () {
        // Arrange
        const noCredentials = NoCredentials();
        const forcedUpdate = ForcedUpdate('https://example.com/update');
        const illegitimateDevice = IllegitimateDevice();

        // Act & Assert
        expect(const TaskStop(noCredentials).reason, equals(noCredentials));
        expect(const TaskStop(forcedUpdate).reason, equals(forcedUpdate));
        expect(const TaskStop(illegitimateDevice).reason, equals(illegitimateDevice));
      });
    });

    group('TaskError', () {
      test('should create TaskError with exception', () {
        // Arrange
        final exception = Exception('Test error');

        // Act
        final taskOutput = TaskError(exception);

        // Assert
        expect(taskOutput, isA<TaskOutput>());
        expect(taskOutput, isA<TaskError>());
        expect(taskOutput.exception, equals(exception));
      });

      test('should handle different exception types', () {
        // Arrange
        final runtimeException = Exception('Runtime error');
        final argumentException = Exception('Invalid argument');

        // Act & Assert
        expect(TaskError(runtimeException).exception, equals(runtimeException));
        expect(TaskError(argumentException).exception, equals(argumentException));
      });
    });

    group('TaskJumpTo', () {
      test('should create TaskJumpTo with index', () {
        // Arrange
        const jumpIndex = 5;

        // Act
        const taskOutput = TaskJumpTo(jumpIndex);

        // Assert
        expect(taskOutput, isA<TaskOutput>());
        expect(taskOutput, isA<TaskJumpTo>());
        expect(taskOutput.index, equals(jumpIndex));
      });

      test('should handle different indices', () {
        // Act & Assert
        expect(const TaskJumpTo(0).index, equals(0));
        expect(const TaskJumpTo(10).index, equals(10));
        expect(const TaskJumpTo(-1).index, equals(-1));
      });
    });
  });
}
