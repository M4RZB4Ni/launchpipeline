# 🚀 LaunchPipeline

A lightweight and extensible Dart package for managing sequential app startup tasks in Flutter.  
Easily organize and control your launch flow using composable, testable tasks — such as checking internet connectivity, validating credentials, enforcing app updates, and more.

---

## ✨ Features

- 🧩 Modular task system (plug in custom startup logic)
- 🔁 Flow control: continue, stop, jump, or error
- 📦 Shared `LaunchContext` for inter-task communication
- ✅ Fully testable via injected interfaces
- 🔧 Clean separation of concerns with sealed classes

---

## 🛠️ Installation

Add `launchpipeline` to your `pubspec.yaml`:

```yaml
dependencies:
  launchpipeline:
    git:
      url: git@github.com:M4RZB4Ni/launchpipeline.git
      ref: latest_version
```

---

## 🚦 Getting Started

### 1. Define Your Tasks

```dart
final pipeline = LaunchPipeline([
  SetupConfigurationTask(),
  CheckInternetTask(MyConnectivityChecker()),
  CheckUpdateTask(updateInfoProvider: MyUpdateInfoProvider()),
  CheckIlLegitimateDeviceTask(deviceLegitimateChecker: MyDeviceChecker()),
  CheckCredentialsTask(authTokenValidator: MyAuthValidator()),
]);
```

### 2. Run the Pipeline

```dart
final result = await PipelineManager.runPipeline(pipeline);

switch (result) {
  case PipelineCompleted():
    // Navigate to the main screen
    break;
  case PipelineStopped(reason: final reason):
    // Handle stop case (e.g., no internet, forced update, etc.)
    break;
  case PipelineFailure(exception: final e):
    // Handle unexpected errors
    break;
}
```

---

## 🧱 Core Concepts

### 🔄 `LaunchTask`

An abstract class representing a unit of work. Each task defines its own logic via `execute()`:

```dart
abstract class LaunchTask {
  Future<TaskOutput> execute(LaunchContext context);
}
```

### 🧠 `LaunchContext`

A shared mutable context passed between tasks, used to store intermediate state like login status or update flags.

```dart
class LaunchContext {
  bool isLoggedIn;
  bool isUpdateAvailable;
  bool isForcedUpdate;
  String updateUrl;
}
```

### 🎯 `TaskOutput`

Each task returns one of the following:

- `TaskContinue()` → proceed to next task
- `TaskStop(reason)` → halt pipeline with a known reason
- `TaskJumpTo(index)` → jump to another task
- `TaskError(exception)` → signal an error and fail the pipeline

### 🧾 `PipelineOutput`

Final result of the pipeline:

- `PipelineCompleted()` → all tasks ran successfully
- `PipelineStopped(reason)` → pipeline stopped with a specific reason
- `PipelineFailure(exception)` → failed due to error

---

## ✅ Built-in Tasks

| Task                         | Description                                  |
|-----------------------------|----------------------------------------------|
| `SetupConfigurationTask`    | Placeholder for initial setup                |
| `CheckInternetTask`         | Stops if no internet connection              |
| `CheckUpdateTask`           | Checks for optional/forced updates           |
| `CheckIlLegitimateDeviceTask` | Stops if device is invalid (e.g., rooted)  |
| `CheckCredentialsTask`      | Stops if user is not authenticated           |

Each task uses dependency injection, making testing and customization easy.

---

## 🧪 Example: Creating a Custom Task

```dart
class LogAppOpenTask extends LaunchTask {
  @override
  Future<TaskOutput> execute(LaunchContext context) async {
    await logAnalyticsEvent("app_open");
    return TaskContinue();
  }
}
```

## ❤️ Contribution

Made with passion by Hamid Marzbani, please feel free to email me in case of any questions or contributions.
