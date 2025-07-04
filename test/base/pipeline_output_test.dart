import 'package:launchpipeline/launchpipeline.dart';
import 'package:test/test.dart';

void pipelineOutputTests() {
  group('PipelineOutput', () {
    group('PipelineCompleted', () {
      test('should create PipelineCompleted instance', () {
        // Act
        final pipelineOutput = PipelineCompleted();

        // Assert
        expect(pipelineOutput, isA<PipelineOutput>());
        expect(pipelineOutput, isA<PipelineCompleted>());
      });
    });

    group('PipelineStopped', () {
      test('should create PipelineStopped with reason', () {
        // Arrange
        const reason = NoInternet();

        // Act
        const pipelineOutput = PipelineStopped(reason);

        // Assert
        expect(pipelineOutput, isA<PipelineOutput>());
        expect(pipelineOutput, isA<PipelineStopped>());
        expect(pipelineOutput.reason, equals(reason));
      });

      test('should handle different stop reasons', () {
        // Arrange
        const noCredentials = NoCredentials();
        const forcedUpdate = ForcedUpdate('https://example.com/update');
        const illegitimateDevice = IllegitimateDevice();

        // Act & Assert
        expect(const PipelineStopped(noCredentials).reason, equals(noCredentials));
        expect(const PipelineStopped(forcedUpdate).reason, equals(forcedUpdate));
        expect(const PipelineStopped(illegitimateDevice).reason, equals(illegitimateDevice));
      });
    });

    group('PipelineFailure', () {
      test('should create PipelineFailure with exception', () {
        // Arrange
        final exception = Exception('Pipeline failed');

        // Act
        final pipelineOutput = PipelineFailure(exception);

        // Assert
        expect(pipelineOutput, isA<PipelineOutput>());
        expect(pipelineOutput, isA<PipelineFailure>());
        expect(pipelineOutput.exception, equals(exception));
      });

      test('should handle different exception types', () {
        // Arrange
        final runtimeException = Exception('Runtime error');
        final argumentException = Exception('Invalid argument');

        // Act & Assert
        expect(PipelineFailure(runtimeException).exception, equals(runtimeException));
        expect(PipelineFailure(argumentException).exception, equals(argumentException));
      });
    });
  });
}
