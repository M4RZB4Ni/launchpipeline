// Represents why a pipeline stopped.
sealed class StopReason {
  const StopReason();
}

class NoCredentials extends StopReason {}

class NotSignedUp extends StopReason {}

class ForcedUpdate extends StopReason {
  const ForcedUpdate(this.updateUrl);

  final String updateUrl;
}

class OptionalUpdate extends StopReason {
  const OptionalUpdate(this.updateUrl);

  final String updateUrl;
}

class NoInternet extends StopReason {}

class UnknownReason extends StopReason {}

class IllegitimateDevice extends StopReason {}
