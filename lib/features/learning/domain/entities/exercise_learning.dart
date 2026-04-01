import 'exercise.dart';

class ExerciseType {
  static const String multipleChoice = 'multiple_choice';
  static const String audioChoice = 'audio_choice';
  static const String memory = 'memory';
  static const String sentenceOrder = 'sentence_order';
  static const String fillBlank = 'fill_blank';
  static const String writing = 'writing';
  static const String dictation = 'dictation';
  static const String translation = 'translation';
  static const String grammar = 'grammar';
}

enum LearningStage {
  recognition,
  association,
  comprehension,
  production,
  grammar,
}

const List<LearningStage> learningStageProgression = <LearningStage>[
  LearningStage.recognition,
  LearningStage.association,
  LearningStage.comprehension,
  LearningStage.production,
  LearningStage.grammar,
];

class LearningSummary {
  const LearningSummary({
    required this.stageLabel,
    required this.levelLabel,
    required this.stageBreakdownParts,
  });

  final String stageLabel;
  final String levelLabel;
  final List<String> stageBreakdownParts;
}

LearningStage learningStageForType(String type) {
  return switch (type) {
    ExerciseType.multipleChoice ||
    ExerciseType.audioChoice => LearningStage.recognition,
    ExerciseType.memory => LearningStage.association,
    ExerciseType.translation => LearningStage.comprehension,
    ExerciseType.writing || ExerciseType.dictation => LearningStage.production,
    ExerciseType.sentenceOrder ||
    ExerciseType.fillBlank ||
    ExerciseType.grammar => LearningStage.grammar,
    _ => LearningStage.comprehension,
  };
}

int recommendedLevelForType(String type) {
  return switch (learningStageForType(type)) {
    LearningStage.recognition => 1,
    LearningStage.association => 2,
    LearningStage.comprehension => 2,
    LearningStage.grammar => 3,
    LearningStage.production => 4,
  };
}

int stageOrder(LearningStage stage) {
  return switch (stage) {
    LearningStage.recognition => 1,
    LearningStage.association => 2,
    LearningStage.comprehension => 3,
    LearningStage.production => 4,
    LearningStage.grammar => 5,
  };
}

String learningStageLabel(String type) {
  return switch (learningStageForType(type)) {
    LearningStage.recognition => 'Reconnaissance',
    LearningStage.association => 'Association',
    LearningStage.comprehension => 'Compréhension',
    LearningStage.production => 'Production',
    LearningStage.grammar => 'Logique grammaticale',
  };
}

String learningStageDisplayLabel(LearningStage stage) {
  return switch (stage) {
    LearningStage.recognition => 'Reconnaissance',
    LearningStage.association => 'Association',
    LearningStage.comprehension => 'Compréhension',
    LearningStage.production => 'Production',
    LearningStage.grammar => 'Grammaire',
  };
}

List<String> learningStageBreakdownParts(List<ExerciseEntity> exercises) {
  if (exercises.isEmpty) {
    return <String>['0 exercice'];
  }

  final int count = exercises.length;
  return <String>[count == 1 ? '1 exercice' : '$count exercices'];
}

String learningLevelLabel(List<ExerciseEntity> exercises) {
  final List<int> levels =
      exercises
          .map((ExerciseEntity e) => recommendedLevelForType(e.type))
          .toSet()
          .toList()
        ..sort();

  if (levels.isEmpty) {
    return 'Niveau 1';
  }
  if (levels.first == levels.last) {
    return 'Niveau ${levels.first}';
  }
  return 'Niveaux ${levels.first}-${levels.last}';
}

LearningSummary summarizeExercisesForLearning(List<ExerciseEntity> exercises) {
  final List<ExerciseEntity> orderedExercises = orderExercisesForLearning(
    exercises,
  );

  final String stageLabel = orderedExercises.isEmpty
      ? learningStageDisplayLabel(LearningStage.recognition)
      : learningStageLabel(orderedExercises.first.type);

  return LearningSummary(
    stageLabel: stageLabel,
    levelLabel: learningLevelLabel(orderedExercises),
    stageBreakdownParts: learningStageBreakdownParts(orderedExercises),
  );
}

List<ExerciseEntity> orderExercisesForLearning(
  List<ExerciseEntity> exercises, {
  String? focusType,
}) {
  final List<ExerciseEntity> ordered = List<ExerciseEntity>.from(exercises);

  ordered.sort((ExerciseEntity a, ExerciseEntity b) {
    final int aFocus = focusType != null && a.type == focusType ? 0 : 1;
    final int bFocus = focusType != null && b.type == focusType ? 0 : 1;
    if (aFocus != bFocus) {
      return aFocus - bFocus;
    }

    final int stageCompare = stageOrder(
      learningStageForType(a.type),
    ).compareTo(stageOrder(learningStageForType(b.type)));
    if (stageCompare != 0) {
      return stageCompare;
    }

    return a.difficulty.compareTo(b.difficulty);
  });

  return ordered;
}
