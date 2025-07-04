// Represents why a pipeline stopped.
sealed class StopReason {
  const StopReason();
}

class NoCredentials extends StopReason {
  const NoCredentials();
}

class NotSignedUp extends StopReason {
  const NotSignedUp();
}

class ForcedUpdate extends StopReason {
  const ForcedUpdate(this.updateUrl);

  final String updateUrl;
}

class OptionalUpdate extends StopReason {
  const OptionalUpdate(this.updateUrl);

  final String updateUrl;
}

class NoInternet extends StopReason {
  const NoInternet();
}

class UnknownReason extends StopReason {
  const UnknownReason();
}

class IllegitimateDevice extends StopReason {
  const IllegitimateDevice();
}
