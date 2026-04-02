class ParticleExampleEntity {
  const ParticleExampleEntity({
    required this.korean,
    required this.translation,
  });

  final String korean;
  final String translation;
}

class ParticleInfoEntity {
  const ParticleInfoEntity({
    required this.name,
    required this.forms,
    required this.description,
    required this.examples,
  });

  final String name;
  final Map<String, String> forms;
  final String description;
  final List<ParticleExampleEntity> examples;
}
