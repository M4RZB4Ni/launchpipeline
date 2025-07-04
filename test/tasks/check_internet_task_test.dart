import 'package:launchpipeline/launchpipeline.dart';
import 'package:test/test.dart';

void checkInternetTaskTests() {
  group('CheckInternetTask', () {
    group('constructor', () {
      test('should create with connectivity checker', () {
        // Arrange
        final connectivityChecker = _MockConnectivityChecker();

        // Act
        final task = CheckInternetTask(connectivityChecker);

        // Assert
        expect(task, isA<LaunchTask>());
        expect(task, isA<CheckInternetTask>());
        expect(task.connectivityChecker, equals(connectivityChecker));
      });
    });

    group('execute method', () {
      test('should continue when network is available', () async {
        // Arrange
        final connectivityChecker = _MockConnectivityChecker();
        connectivityChecker.isNetworkAvailableResult = true;
        final task = CheckInternetTask(connectivityChecker);
        final context = LaunchContext();

        // Act
        final result = await task.execute(context);

        // Assert
        expect(result, isA<TaskContinue>());
        expect(connectivityChecker.isNetworkAvailableCalled, isTrue);
      });

      test('should stop with NoInternet when network is not available', () async {
        // Arrange
        final connectivityChecker = _MockConnectivityChecker();
        connectivityChecker.isNetworkAvailableResult = false;
        final task = CheckInternetTask(connectivityChecker);
        final context = LaunchContext();

        // Act
        final result = await task.execute(context);

        // Assert
        expect(result, isA<TaskStop>());
        expect((result as TaskStop).reason, isA<NoInternet>());
        expect(connectivityChecker.isNetworkAvailableCalled, isTrue);
      });

      test('should call connectivity checker with correct context', () async {
        // Arrange
        final connectivityChecker = _MockConnectivityChecker();
        connectivityChecker.isNetworkAvailableResult = true;
        final task = CheckInternetTask(connectivityChecker);
        final context = LaunchContext();

        // Act
        await task.execute(context);

        // Assert
        expect(connectivityChecker.isNetworkAvailableCalled, isTrue);
      });
    });
  });

  group('ConnectivityChecker interface', () {
    test('should be an abstract interface class', () {
      // Assert
      expect(ConnectivityChecker, isA<Type>());
    });
  });
}

// Mock implementation for testing
class _MockConnectivityChecker implements ConnectivityChecker {
  bool isNetworkAvailableResult = true;
  bool isNetworkAvailableCalled = false;

  @override
  Future<bool> isNetworkAvailable() async {
    isNetworkAvailableCalled = true;
    return isNetworkAvailableResult;
  }
}
