import 'package:launchpipeline/launchpipeline.dart';
import 'package:test/test.dart';

void checkIllegitimateDeviceTaskTests() {
  group('CheckIlLegitimateDeviceTask', () {
    group('constructor', () {
      test('should create with device legitimate checker', () {
        // Arrange
        final deviceLegitimateChecker = _MockDeviceLegitimateChecker();

        // Act
        final task = CheckIlLegitimateDeviceTask(
          deviceLegitimateChecker: deviceLegitimateChecker,
        );

        // Assert
        expect(task, isA<LaunchTask>());
        expect(task, isA<CheckIlLegitimateDeviceTask>());
      });
    });

    group('execute method', () {
      test('should continue when device is legitimate', () async {
        // Arrange
        final deviceLegitimateChecker = _MockDeviceLegitimateChecker();
        deviceLegitimateChecker.isDeviceIllegitimateResult = false;
        final task = CheckIlLegitimateDeviceTask(
          deviceLegitimateChecker: deviceLegitimateChecker,
        );
        final context = LaunchContext();

        // Act
        final result = await task.execute(context);

        // Assert
        expect(result, isA<TaskContinue>());
        expect(deviceLegitimateChecker.isDeviceIllegitimateCalled, isTrue);
      });

      test('should stop with IllegitimateDevice when device is illegitimate', () async {
        // Arrange
        final deviceLegitimateChecker = _MockDeviceLegitimateChecker();
        deviceLegitimateChecker.isDeviceIllegitimateResult = true;
        final task = CheckIlLegitimateDeviceTask(
          deviceLegitimateChecker: deviceLegitimateChecker,
        );
        final context = LaunchContext();

        // Act
        final result = await task.execute(context);

        // Assert
        expect(result, isA<TaskStop>());
        expect((result as TaskStop).reason, isA<IllegitimateDevice>());
        expect(deviceLegitimateChecker.isDeviceIllegitimateCalled, isTrue);
      });

      test('should call device legitimate checker with correct context', () async {
        // Arrange
        final deviceLegitimateChecker = _MockDeviceLegitimateChecker();
        deviceLegitimateChecker.isDeviceIllegitimateResult = false;
        final task = CheckIlLegitimateDeviceTask(
          deviceLegitimateChecker: deviceLegitimateChecker,
        );
        final context = LaunchContext();

        // Act
        await task.execute(context);

        // Assert
        expect(deviceLegitimateChecker.isDeviceIllegitimateCalled, isTrue);
      });
    });
  });

  group('DeviceLegitimateChecker interface', () {
    test('should be an abstract interface class', () {
      // Assert
      expect(DeviceLegitimateChecker, isA<Type>());
    });
  });
}

// Mock implementation for testing
class _MockDeviceLegitimateChecker implements DeviceLegitimateChecker {
  bool isDeviceIllegitimateResult = false;
  bool isDeviceIllegitimateCalled = false;

  @override
  Future<bool> isDeviceIllegitimate() async {
    isDeviceIllegitimateCalled = true;
    return isDeviceIllegitimateResult;
  }
}
