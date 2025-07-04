class LaunchContext {
  LaunchContext({
    this.isLoggedIn = false,
    this.isUpdateAvailable = false,
    this.isForcedUpdate = false,
    this.updateUrl = '',
  });

  bool isLoggedIn;

  bool isUpdateAvailable;
  bool isForcedUpdate;
  String updateUrl;
}
