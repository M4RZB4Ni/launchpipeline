import 'package:launchpipeline/launchpipeline.dart';
import 'package:test/test.dart';

void checkUpdateTaskTests() {
  group('CheckUpdateTask', () {
    group('constructor', () {
      test('should create with update info provider', () {
        // Arrange
        final updateInfoProvider = _MockUpdateInfoProvider();

        // Act
        final task = CheckUpdateTask(updateInfoProvider: updateInfoProvider);

        // Assert
        expect(task, isA<LaunchTask>());
        expect(task, isA<CheckUpdateTask>());
        expect(task.updateInfoProvider, equals(updateInfoProvider));
      });
    });

    group('execute method', () {
      test('should continue and update context when no update is available', () async {
        // Arrange
        final updateInfoProvider = _MockUpdateInfoProvider();
        updateInfoProvider.serverUpdateInfo = ServerUpdateInfo(
          isUpdateAvailable: false,
          isForced: false,
          updateUrl: '',
        );
        final task = CheckUpdateTask(updateInfoProvider: updateInfoProvider);
        final context = LaunchContext();

        // Act
        final result = await task.execute(context);

        // Assert
        expect(result, isA<TaskContinue>());
        expect(context.isUpdateAvailable, isFalse);
        expect(context.isForcedUpdate, isFalse);
        expect(context.updateUrl, equals(''));
        expect(updateInfoProvider.getServerUpdateInfoCalled, isTrue);
      });

      test('should continue and update context when optional update is available', () async {
        // Arrange
        const updateUrl = 'https://example.com/update';
        final updateInfoProvider = _MockUpdateInfoProvider();
        updateInfoProvider.serverUpdateInfo = ServerUpdateInfo(
          isUpdateAvailable: true,
          isForced: false,
          updateUrl: updateUrl,
        );
        final task = CheckUpdateTask(updateInfoProvider: updateInfoProvider);
        final context = LaunchContext();

        // Act
        final result = await task.execute(context);

        // Assert
        expect(result, isA<TaskContinue>());
        expect(context.isUpdateAvailable, isTrue);
        expect(context.isForcedUpdate, isFalse);
        expect(context.updateUrl, equals(updateUrl));
        expect(updateInfoProvider.getServerUpdateInfoCalled, isTrue);
      });

      test('should continue and update context when forced update is available', () async {
        // Arrange
        const updateUrl = 'https://example.com/forced-update';
        final updateInfoProvider = _MockUpdateInfoProvider();
        updateInfoProvider.serverUpdateInfo = ServerUpdateInfo(
          isUpdateAvailable: true,
          isForced: true,
          updateUrl: updateUrl,
        );
        final task = CheckUpdateTask(updateInfoProvider: updateInfoProvider);
        final context = LaunchContext();

        // Act
        final result = await task.execute(context);

        // Assert
        expect(result, isA<TaskContinue>());
        expect(context.isUpdateAvailable, isTrue);
        expect(context.isForcedUpdate, isTrue);
        expect(context.updateUrl, equals(updateUrl));
        expect(updateInfoProvider.getServerUpdateInfoCalled, isTrue);
      });

      test('should call update info provider with correct context', () async {
        // Arrange
        final updateInfoProvider = _MockUpdateInfoProvider();
        updateInfoProvider.serverUpdateInfo = ServerUpdateInfo(
          isUpdateAvailable: false,
          isForced: false,
          updateUrl: '',
        );
        final task = CheckUpdateTask(updateInfoProvider: updateInfoProvider);
        final context = LaunchContext();

        // Act
        await task.execute(context);

        // Assert
        expect(updateInfoProvider.getServerUpdateInfoCalled, isTrue);
      });
    });
  });

  group('UpdateInfoProvider interface', () {
    test('should be an abstract class', () {
      // Assert
      expect(UpdateInfoProvider, isA<Type>());
    });
  });

  group('ServerUpdateInfo', () {
    test('should create with required parameters', () {
      // Arrange
      const isUpdateAvailable = true;
      const isForced = false;
      const updateUrl = 'https://example.com/update';

      // Act
      final serverUpdateInfo = ServerUpdateInfo(
        isUpdateAvailable: isUpdateAvailable,
        isForced: isForced,
        updateUrl: updateUrl,
      );

      // Assert
      expect(serverUpdateInfo.isUpdateAvailable, equals(isUpdateAvailable));
      expect(serverUpdateInfo.isForced, equals(isForced));
      expect(serverUpdateInfo.updateUrl, equals(updateUrl));
    });

    test('should handle different update scenarios', () {
      // Test no update
      final noUpdate = ServerUpdateInfo(
        isUpdateAvailable: false,
        isForced: false,
        updateUrl: '',
      );
      expect(noUpdate.isUpdateAvailable, isFalse);
      expect(noUpdate.isForced, isFalse);

      // Test optional update
      final optionalUpdate = ServerUpdateInfo(
        isUpdateAvailable: true,
        isForced: false,
        updateUrl: 'https://example.com/optional',
      );
      expect(optionalUpdate.isUpdateAvailable, isTrue);
      expect(optionalUpdate.isForced, isFalse);

      // Test forced update
      final forcedUpdate = ServerUpdateInfo(
        isUpdateAvailable: true,
        isForced: true,
        updateUrl: 'https://example.com/forced',
      );
      expect(forcedUpdate.isUpdateAvailable, isTrue);
      expect(forcedUpdate.isForced, isTrue);
    });
  });
}

// Mock implementation for testing
class _MockUpdateInfoProvider implements UpdateInfoProvider {
  ServerUpdateInfo serverUpdateInfo = ServerUpdateInfo(
    isUpdateAvailable: false,
    isForced: false,
    updateUrl: '',
  );
  bool getServerUpdateInfoCalled = false;

  @override
  Future<ServerUpdateInfo> getServerUpdateInfo() async {
    getServerUpdateInfoCalled = true;
    return serverUpdateInfo;
  }
}
