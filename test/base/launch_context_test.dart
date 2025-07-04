import 'package:launchpipeline/launchpipeline.dart';
import 'package:test/test.dart';

void launchContextTests() {
  group('LaunchContext', () {
    test('should create with default values', () {
      // Arrange
      const expectedIsLoggedIn = false;
      const expectedIsUpdateAvailable = false;
      const expectedIsForcedUpdate = false;
      const expectedUpdateUrl = '';

      // Act
      final context = LaunchContext();

      // Assert
      expect(context.isLoggedIn, equals(expectedIsLoggedIn));
      expect(context.isUpdateAvailable, equals(expectedIsUpdateAvailable));
      expect(context.isForcedUpdate, equals(expectedIsForcedUpdate));
      expect(context.updateUrl, equals(expectedUpdateUrl));
    });

    test('should create with custom values', () {
      // Arrange
      const expectedIsLoggedIn = true;
      const expectedIsUpdateAvailable = true;
      const expectedIsForcedUpdate = true;
      const expectedUpdateUrl = 'https://example.com/update';

      // Act
      final context = LaunchContext(
        isLoggedIn: expectedIsLoggedIn,
        isUpdateAvailable: expectedIsUpdateAvailable,
        isForcedUpdate: expectedIsForcedUpdate,
        updateUrl: expectedUpdateUrl,
      );

      // Assert
      expect(context.isLoggedIn, equals(expectedIsLoggedIn));
      expect(context.isUpdateAvailable, equals(expectedIsUpdateAvailable));
      expect(context.isForcedUpdate, equals(expectedIsForcedUpdate));
      expect(context.updateUrl, equals(expectedUpdateUrl));
    });

    test('should allow property modification', () {
      // Arrange
      final context = LaunchContext();
      const newIsLoggedIn = true;
      const newIsUpdateAvailable = true;
      const newIsForcedUpdate = true;
      const newUpdateUrl = 'https://example.com/update';

      // Act
      context.isLoggedIn = newIsLoggedIn;
      context.isUpdateAvailable = newIsUpdateAvailable;
      context.isForcedUpdate = newIsForcedUpdate;
      context.updateUrl = newUpdateUrl;

      // Assert
      expect(context.isLoggedIn, equals(newIsLoggedIn));
      expect(context.isUpdateAvailable, equals(newIsUpdateAvailable));
      expect(context.isForcedUpdate, equals(newIsForcedUpdate));
      expect(context.updateUrl, equals(newUpdateUrl));
    });
  });
}
