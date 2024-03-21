class MacrosEntity {
  int calories;
  int proteins;
  int fat;
  int carbs;

  MacrosEntity({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.proteins,
  });

  Map<String, Object?> toDocument() {
    return {
      "calories": calories,
      "carbs": carbs,
      "fat": fat,
      "proteins": proteins,
    };
  }

  static MacrosEntity fromDocument(Map<String, dynamic> doc) {
    return MacrosEntity(
      calories: doc['calories'],
      carbs: doc['carbs'],
      fat: doc['fat'],
      proteins: doc['proteins'],
    );
  }
}
