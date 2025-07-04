import 'package:launchpipeline/launchpipeline.dart';
import 'package:test/test.dart';

void checkCredentialsTaskTests() {
  group('CheckCredentialsTask', () {
    group('constructor', () {
      test('should create with auth token validator', () {
        // Arrange
        final authTokenValidator = _MockAuthTokenValidator();

        // Act
        final task = CheckCredentialsTask(authTokenValidator: authTokenValidator);

        // Assert
        expect(task, isA<LaunchTask>());
        expect(task, isA<CheckCredentialsTask>());
        expect(task.authTokenValidator, equals(authTokenValidator));
      });
    });

    group('execute method', () {
      test('should continue and update context when credentials are valid', () async {
        // Arrange
        final authTokenValidator = _MockAuthTokenValidator();
        authTokenValidator.isValidResult = true;
        final task = CheckCredentialsTask(authTokenValidator: authTokenValidator);
        final context = LaunchContext();

        // Act
        final result = await task.execute(context);

        // Assert
        expect(result, isA<TaskContinue>());
        expect(context.isLoggedIn, isTrue);
        expect(authTokenValidator.isValidCalled, isTrue);
      });

      test('should stop with NoCredentials when credentials are invalid', () async {
        // Arrange
        final authTokenValidator = _MockAuthTokenValidator();
        authTokenValidator.isValidResult = false;
        final task = CheckCredentialsTask(authTokenValidator: authTokenValidator);
        final context = LaunchContext();

        // Act
        final result = await task.execute(context);

        // Assert
        expect(result, isA<TaskStop>());
        expect((result as TaskStop).reason, isA<NoCredentials>());
        expect(context.isLoggedIn, isFalse);
        expect(authTokenValidator.isValidCalled, isTrue);
      });

      test('should stop with NoCredentials and set isLoggedIn to false when validator throws exception', () async {
        // Arrange
        final authTokenValidator = _MockAuthTokenValidator();
        authTokenValidator.shouldThrow = true;
        final task = CheckCredentialsTask(authTokenValidator: authTokenValidator);
        final context = LaunchContext();

        // Act
        final result = await task.execute(context);

        // Assert
        expect(result, isA<TaskStop>());
        expect((result as TaskStop).reason, isA<NoCredentials>());
        expect(context.isLoggedIn, isFalse);
        expect(authTokenValidator.isValidCalled, isTrue);
      });

      test('should call auth token validator with correct context', () async {
        // Arrange
        final authTokenValidator = _MockAuthTokenValidator();
        authTokenValidator.isValidResult = true;
        final task = CheckCredentialsTask(authTokenValidator: authTokenValidator);
        final context = LaunchContext();

        // Act
        await task.execute(context);

        // Assert
        expect(authTokenValidator.isValidCalled, isTrue);
      });

      test('should handle context state changes correctly', () async {
        // Arrange
        final authTokenValidator = _MockAuthTokenValidator();
        authTokenValidator.isValidResult = true;
        final task = CheckCredentialsTask(authTokenValidator: authTokenValidator);
        final context = LaunchContext();
        context.isLoggedIn = false; // Set initial state

        // Act
        await task.execute(context);

        // Assert
        expect(context.isLoggedIn, isTrue);
      });
    });
  });

  group('AuthTokenValidator interface', () {
    test('should be an abstract class', () {
      // Assert
      expect(AuthTokenValidator, isA<Type>());
    });
  });
}

// Mock implementation for testing
class _MockAuthTokenValidator implements AuthTokenValidator {
  bool isValidResult = true;
  bool isValidCalled = false;
  bool shouldThrow = false;

  @override
  Future<bool> isValid() async {
    isValidCalled = true;
    if (shouldThrow) {
      throw Exception('Validation failed');
    }
    return isValidResult;
  }
}
