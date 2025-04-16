class WorkStatusState {
  final double backpackProgress;
  final double carProgress;
  final double homeProgress;
  final double gearProgress;
  final double checkProgress;
  final bool isBackpackComplete;
  final bool isCarComplete;
  final bool isHomeComplete;
  final bool isGearComplete;
  final bool isCheckComplete;
  final bool isQRVerified;

  WorkStatusState({
    required this.backpackProgress,
    required this.carProgress,
    required this.homeProgress,
    required this.gearProgress,
    required this.checkProgress,
    this.isBackpackComplete = false,
    this.isCarComplete = false,
    this.isHomeComplete = false,
    this.isGearComplete = false,
    this.isCheckComplete = false,
    this.isQRVerified = false,
  });

  WorkStatusState copyWith({
    double? backpackProgress,
    double? carProgress,
    double? homeProgress,
    double? gearProgress,
    double? checkProgress,
    bool? isBackpackComplete,
    bool? isCarComplete,
    bool? isHomeComplete,
    bool? isGearComplete,
    bool? isCheckComplete,
    bool? isQRVerified,
  }) {
    return WorkStatusState(
      backpackProgress: backpackProgress ?? this.backpackProgress,
      carProgress: carProgress ?? this.carProgress,
      homeProgress: homeProgress ?? this.homeProgress,
      gearProgress: gearProgress ?? this.gearProgress,
      checkProgress: checkProgress ?? this.checkProgress,
      isBackpackComplete: isBackpackComplete ?? this.isBackpackComplete,
      isCarComplete: isCarComplete ?? this.isCarComplete,
      isHomeComplete: isHomeComplete ?? this.isHomeComplete,
      isGearComplete: isGearComplete ?? this.isGearComplete,
      isCheckComplete: isCheckComplete ?? this.isCheckComplete,
      isQRVerified: isQRVerified ?? this.isQRVerified,
    );
  }
}
