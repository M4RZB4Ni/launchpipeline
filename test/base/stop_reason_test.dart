import 'package:launchpipeline/launchpipeline.dart';
import 'package:test/test.dart';

void stopReasonTests() {
  group('StopReason', () {
    group('NoCredentials', () {
      test('should create NoCredentials instance', () {
        // Act
        const stopReason = NoCredentials();

        // Assert
        expect(stopReason, isA<StopReason>());
        expect(stopReason, isA<NoCredentials>());
      });

      test('should be const', () {
        // Act
        const stopReason1 = NoCredentials();
        const stopReason2 = NoCredentials();

        // Assert
        expect(identical(stopReason1, stopReason2), isTrue);
      });
    });

    group('NotSignedUp', () {
      test('should create NotSignedUp instance', () {
        // Act
        const stopReason = NotSignedUp();

        // Assert
        expect(stopReason, isA<StopReason>());
        expect(stopReason, isA<NotSignedUp>());
      });

      test('should be const', () {
        // Act
        const stopReason1 = NotSignedUp();
        const stopReason2 = NotSignedUp();

        // Assert
        expect(identical(stopReason1, stopReason2), isTrue);
      });
    });

    group('ForcedUpdate', () {
      test('should create ForcedUpdate with updateUrl', () {
        // Arrange
        const updateUrl = 'https://example.com/update';

        // Act
        const stopReason = ForcedUpdate(updateUrl);

        // Assert
        expect(stopReason, isA<StopReason>());
        expect(stopReason, isA<ForcedUpdate>());
        expect(stopReason.updateUrl, equals(updateUrl));
      });

      test('should handle different update URLs', () {
        // Act & Assert
        expect(const ForcedUpdate('https://app.com/update').updateUrl, equals('https://app.com/update'));
        expect(const ForcedUpdate('https://store.com/download').updateUrl, equals('https://store.com/download'));
        expect(const ForcedUpdate('').updateUrl, equals(''));
      });
    });

    group('OptionalUpdate', () {
      test('should create OptionalUpdate with updateUrl', () {
        // Arrange
        const updateUrl = 'https://example.com/update';

        // Act
        const stopReason = OptionalUpdate(updateUrl);

        // Assert
        expect(stopReason, isA<StopReason>());
        expect(stopReason, isA<OptionalUpdate>());
        expect(stopReason.updateUrl, equals(updateUrl));
      });

      test('should handle different update URLs', () {
        // Act & Assert
        expect(const OptionalUpdate('https://app.com/update').updateUrl, equals('https://app.com/update'));
        expect(const OptionalUpdate('https://store.com/download').updateUrl, equals('https://store.com/download'));
        expect(const OptionalUpdate('').updateUrl, equals(''));
      });
    });

    group('NoInternet', () {
      test('should create NoInternet instance', () {
        // Act
        const stopReason = NoInternet();

        // Assert
        expect(stopReason, isA<StopReason>());
        expect(stopReason, isA<NoInternet>());
      });

      test('should be const', () {
        // Act
        const stopReason1 = NoInternet();
        const stopReason2 = NoInternet();

        // Assert
        expect(identical(stopReason1, stopReason2), isTrue);
      });
    });

    group('UnknownReason', () {
      test('should create UnknownReason instance', () {
        // Act
        const stopReason = UnknownReason();

        // Assert
        expect(stopReason, isA<StopReason>());
        expect(stopReason, isA<UnknownReason>());
      });

      test('should be const', () {
        // Act
        const stopReason1 = UnknownReason();
        const stopReason2 = UnknownReason();

        // Assert
        expect(identical(stopReason1, stopReason2), isTrue);
      });
    });

    group('IllegitimateDevice', () {
      test('should create IllegitimateDevice instance', () {
        // Act
        const stopReason = IllegitimateDevice();

        // Assert
        expect(stopReason, isA<StopReason>());
        expect(stopReason, isA<IllegitimateDevice>());
      });

      test('should be const', () {
        // Act
        const stopReason1 = IllegitimateDevice();
        const stopReason2 = IllegitimateDevice();

        // Assert
        expect(identical(stopReason1, stopReason2), isTrue);
      });
    });
  });
}
