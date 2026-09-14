// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _pronunciationMeta = const VerificationMeta(
    'pronunciation',
  );
  @override
  late final GeneratedColumn<String> pronunciation = GeneratedColumn<String>(
    'pronunciation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _meaningMeta = const VerificationMeta(
    'meaning',
  );
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
    'meaning',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _italianTranslationMeta =
      const VerificationMeta('italianTranslation');
  @override
  late final GeneratedColumn<String> italianTranslation =
      GeneratedColumn<String>(
        'italian_translation',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _examplesJsonMeta = const VerificationMeta(
    'examplesJson',
  );
  @override
  late final GeneratedColumn<String> examplesJson = GeneratedColumn<String>(
    'examples_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _synonymsJsonMeta = const VerificationMeta(
    'synonymsJson',
  );
  @override
  late final GeneratedColumn<String> synonymsJson = GeneratedColumn<String>(
    'synonyms_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _antonymsJsonMeta = const VerificationMeta(
    'antonymsJson',
  );
  @override
  late final GeneratedColumn<String> antonymsJson = GeneratedColumn<String>(
    'antonyms_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _favoriteMeta = const VerificationMeta(
    'favorite',
  );
  @override
  late final GeneratedColumn<bool> favorite = GeneratedColumn<bool>(
    'favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<WordStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('newWord'),
      ).withConverter<WordStatus>($WordsTable.$converterstatus);
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepIndexMeta = const VerificationMeta(
    'stepIndex',
  );
  @override
  late final GeneratedColumn<int> stepIndex = GeneratedColumn<int>(
    'step_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _wrongCountMeta = const VerificationMeta(
    'wrongCount',
  );
  @override
  late final GeneratedColumn<int> wrongCount = GeneratedColumn<int>(
    'wrong_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta(
    'lastReviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt =
      GeneratedColumn<DateTime>(
        'last_reviewed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextReviewAtMeta = const VerificationMeta(
    'nextReviewAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextReviewAt = GeneratedColumn<DateTime>(
    'next_review_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    word,
    pronunciation,
    partOfSpeech,
    meaning,
    translation,
    italianTranslation,
    examplesJson,
    synonymsJson,
    antonymsJson,
    notes,
    favorite,
    status,
    difficulty,
    stepIndex,
    reviewCount,
    correctCount,
    wrongCount,
    lastReviewedAt,
    nextReviewAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<Word> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('pronunciation')) {
      context.handle(
        _pronunciationMeta,
        pronunciation.isAcceptableOrUnknown(
          data['pronunciation']!,
          _pronunciationMeta,
        ),
      );
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    }
    if (data.containsKey('meaning')) {
      context.handle(
        _meaningMeta,
        meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta),
      );
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    }
    if (data.containsKey('italian_translation')) {
      context.handle(
        _italianTranslationMeta,
        italianTranslation.isAcceptableOrUnknown(
          data['italian_translation']!,
          _italianTranslationMeta,
        ),
      );
    }
    if (data.containsKey('examples_json')) {
      context.handle(
        _examplesJsonMeta,
        examplesJson.isAcceptableOrUnknown(
          data['examples_json']!,
          _examplesJsonMeta,
        ),
      );
    }
    if (data.containsKey('synonyms_json')) {
      context.handle(
        _synonymsJsonMeta,
        synonymsJson.isAcceptableOrUnknown(
          data['synonyms_json']!,
          _synonymsJsonMeta,
        ),
      );
    }
    if (data.containsKey('antonyms_json')) {
      context.handle(
        _antonymsJsonMeta,
        antonymsJson.isAcceptableOrUnknown(
          data['antonyms_json']!,
          _antonymsJsonMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('favorite')) {
      context.handle(
        _favoriteMeta,
        favorite.isAcceptableOrUnknown(data['favorite']!, _favoriteMeta),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('step_index')) {
      context.handle(
        _stepIndexMeta,
        stepIndex.isAcceptableOrUnknown(data['step_index']!, _stepIndexMeta),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('wrong_count')) {
      context.handle(
        _wrongCountMeta,
        wrongCount.isAcceptableOrUnknown(data['wrong_count']!, _wrongCountMeta),
      );
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
        _lastReviewedAtMeta,
        lastReviewedAt.isAcceptableOrUnknown(
          data['last_reviewed_at']!,
          _lastReviewedAtMeta,
        ),
      );
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
        _nextReviewAtMeta,
        nextReviewAt.isAcceptableOrUnknown(
          data['next_review_at']!,
          _nextReviewAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Word map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Word(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      word: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      pronunciation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pronunciation'],
      ),
      partOfSpeech: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_of_speech'],
      ),
      meaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meaning'],
      ),
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      ),
      italianTranslation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}italian_translation'],
      ),
      examplesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}examples_json'],
      ),
      synonymsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}synonyms_json'],
      ),
      antonymsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}antonyms_json'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      favorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}favorite'],
      )!,
      status: $WordsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty'],
      ),
      stepIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_index'],
      )!,
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      wrongCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_count'],
      )!,
      lastReviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed_at'],
      ),
      nextReviewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_review_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WordStatus, String, String> $converterstatus =
      const EnumNameConverter<WordStatus>(WordStatus.values);
}

class Word extends DataClass implements Insertable<Word> {
  final int id;

  /// The English word or phrase.
  ///
  /// Enforced unique case-sensitively here. Case-insensitive duplicate
  /// checks (so "Efficient" is flagged against existing "efficient") are
  /// done at the repository layer with a `LOWER(word) = LOWER(?)` query,
  /// since Drift's table DSL has no first-class `COLLATE NOCASE` modifier.
  final String word;
  final String? pronunciation;
  final String? partOfSpeech;
  final String? meaning;

  /// Vietnamese translation.
  final String? translation;

  /// Italian translation.
  final String? italianTranslation;

  /// JSON-encoded `List<String>`. Encoded/decoded in the repository layer;
  /// a separate table isn't worth it since examples/synonyms/antonyms are
  /// always displayed as a whole, never queried individually.
  final String? examplesJson;
  final String? synonymsJson;
  final String? antonymsJson;
  final String? notes;
  final bool favorite;
  final WordStatus status;

  /// User's own subjective difficulty rating (1-5). Independent from the
  /// automatically-detected "weak word" concept, which is based on
  /// wrongCount/reviewCount instead.
  final int? difficulty;

  /// Position on the fixed interval ladder used by `SimpleIntervalScheduler`
  /// (Phase 7). 0 = just reset/never reviewed.
  final int stepIndex;
  final int reviewCount;
  final int correctCount;
  final int wrongCount;
  final DateTime? lastReviewedAt;

  /// Null until the word has been scheduled for the first time (i.e. still
  /// `newWord` and never reviewed).
  final DateTime? nextReviewAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Word({
    required this.id,
    required this.word,
    this.pronunciation,
    this.partOfSpeech,
    this.meaning,
    this.translation,
    this.italianTranslation,
    this.examplesJson,
    this.synonymsJson,
    this.antonymsJson,
    this.notes,
    required this.favorite,
    required this.status,
    this.difficulty,
    required this.stepIndex,
    required this.reviewCount,
    required this.correctCount,
    required this.wrongCount,
    this.lastReviewedAt,
    this.nextReviewAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    if (!nullToAbsent || pronunciation != null) {
      map['pronunciation'] = Variable<String>(pronunciation);
    }
    if (!nullToAbsent || partOfSpeech != null) {
      map['part_of_speech'] = Variable<String>(partOfSpeech);
    }
    if (!nullToAbsent || meaning != null) {
      map['meaning'] = Variable<String>(meaning);
    }
    if (!nullToAbsent || translation != null) {
      map['translation'] = Variable<String>(translation);
    }
    if (!nullToAbsent || italianTranslation != null) {
      map['italian_translation'] = Variable<String>(italianTranslation);
    }
    if (!nullToAbsent || examplesJson != null) {
      map['examples_json'] = Variable<String>(examplesJson);
    }
    if (!nullToAbsent || synonymsJson != null) {
      map['synonyms_json'] = Variable<String>(synonymsJson);
    }
    if (!nullToAbsent || antonymsJson != null) {
      map['antonyms_json'] = Variable<String>(antonymsJson);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['favorite'] = Variable<bool>(favorite);
    {
      map['status'] = Variable<String>(
        $WordsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<int>(difficulty);
    }
    map['step_index'] = Variable<int>(stepIndex);
    map['review_count'] = Variable<int>(reviewCount);
    map['correct_count'] = Variable<int>(correctCount);
    map['wrong_count'] = Variable<int>(wrongCount);
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    if (!nullToAbsent || nextReviewAt != null) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      word: Value(word),
      pronunciation: pronunciation == null && nullToAbsent
          ? const Value.absent()
          : Value(pronunciation),
      partOfSpeech: partOfSpeech == null && nullToAbsent
          ? const Value.absent()
          : Value(partOfSpeech),
      meaning: meaning == null && nullToAbsent
          ? const Value.absent()
          : Value(meaning),
      translation: translation == null && nullToAbsent
          ? const Value.absent()
          : Value(translation),
      italianTranslation: italianTranslation == null && nullToAbsent
          ? const Value.absent()
          : Value(italianTranslation),
      examplesJson: examplesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(examplesJson),
      synonymsJson: synonymsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(synonymsJson),
      antonymsJson: antonymsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(antonymsJson),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      favorite: Value(favorite),
      status: Value(status),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      stepIndex: Value(stepIndex),
      reviewCount: Value(reviewCount),
      correctCount: Value(correctCount),
      wrongCount: Value(wrongCount),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAt),
      nextReviewAt: nextReviewAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextReviewAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Word.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Word(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      pronunciation: serializer.fromJson<String?>(json['pronunciation']),
      partOfSpeech: serializer.fromJson<String?>(json['partOfSpeech']),
      meaning: serializer.fromJson<String?>(json['meaning']),
      translation: serializer.fromJson<String?>(json['translation']),
      italianTranslation: serializer.fromJson<String?>(
        json['italianTranslation'],
      ),
      examplesJson: serializer.fromJson<String?>(json['examplesJson']),
      synonymsJson: serializer.fromJson<String?>(json['synonymsJson']),
      antonymsJson: serializer.fromJson<String?>(json['antonymsJson']),
      notes: serializer.fromJson<String?>(json['notes']),
      favorite: serializer.fromJson<bool>(json['favorite']),
      status: $WordsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      difficulty: serializer.fromJson<int?>(json['difficulty']),
      stepIndex: serializer.fromJson<int>(json['stepIndex']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      wrongCount: serializer.fromJson<int>(json['wrongCount']),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
      nextReviewAt: serializer.fromJson<DateTime?>(json['nextReviewAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'pronunciation': serializer.toJson<String?>(pronunciation),
      'partOfSpeech': serializer.toJson<String?>(partOfSpeech),
      'meaning': serializer.toJson<String?>(meaning),
      'translation': serializer.toJson<String?>(translation),
      'italianTranslation': serializer.toJson<String?>(italianTranslation),
      'examplesJson': serializer.toJson<String?>(examplesJson),
      'synonymsJson': serializer.toJson<String?>(synonymsJson),
      'antonymsJson': serializer.toJson<String?>(antonymsJson),
      'notes': serializer.toJson<String?>(notes),
      'favorite': serializer.toJson<bool>(favorite),
      'status': serializer.toJson<String>(
        $WordsTable.$converterstatus.toJson(status),
      ),
      'difficulty': serializer.toJson<int?>(difficulty),
      'stepIndex': serializer.toJson<int>(stepIndex),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'correctCount': serializer.toJson<int>(correctCount),
      'wrongCount': serializer.toJson<int>(wrongCount),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
      'nextReviewAt': serializer.toJson<DateTime?>(nextReviewAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Word copyWith({
    int? id,
    String? word,
    Value<String?> pronunciation = const Value.absent(),
    Value<String?> partOfSpeech = const Value.absent(),
    Value<String?> meaning = const Value.absent(),
    Value<String?> translation = const Value.absent(),
    Value<String?> italianTranslation = const Value.absent(),
    Value<String?> examplesJson = const Value.absent(),
    Value<String?> synonymsJson = const Value.absent(),
    Value<String?> antonymsJson = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? favorite,
    WordStatus? status,
    Value<int?> difficulty = const Value.absent(),
    int? stepIndex,
    int? reviewCount,
    int? correctCount,
    int? wrongCount,
    Value<DateTime?> lastReviewedAt = const Value.absent(),
    Value<DateTime?> nextReviewAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Word(
    id: id ?? this.id,
    word: word ?? this.word,
    pronunciation: pronunciation.present
        ? pronunciation.value
        : this.pronunciation,
    partOfSpeech: partOfSpeech.present ? partOfSpeech.value : this.partOfSpeech,
    meaning: meaning.present ? meaning.value : this.meaning,
    translation: translation.present ? translation.value : this.translation,
    italianTranslation: italianTranslation.present
        ? italianTranslation.value
        : this.italianTranslation,
    examplesJson: examplesJson.present ? examplesJson.value : this.examplesJson,
    synonymsJson: synonymsJson.present ? synonymsJson.value : this.synonymsJson,
    antonymsJson: antonymsJson.present ? antonymsJson.value : this.antonymsJson,
    notes: notes.present ? notes.value : this.notes,
    favorite: favorite ?? this.favorite,
    status: status ?? this.status,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
    stepIndex: stepIndex ?? this.stepIndex,
    reviewCount: reviewCount ?? this.reviewCount,
    correctCount: correctCount ?? this.correctCount,
    wrongCount: wrongCount ?? this.wrongCount,
    lastReviewedAt: lastReviewedAt.present
        ? lastReviewedAt.value
        : this.lastReviewedAt,
    nextReviewAt: nextReviewAt.present ? nextReviewAt.value : this.nextReviewAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Word copyWithCompanion(WordsCompanion data) {
    return Word(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      pronunciation: data.pronunciation.present
          ? data.pronunciation.value
          : this.pronunciation,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      translation: data.translation.present
          ? data.translation.value
          : this.translation,
      italianTranslation: data.italianTranslation.present
          ? data.italianTranslation.value
          : this.italianTranslation,
      examplesJson: data.examplesJson.present
          ? data.examplesJson.value
          : this.examplesJson,
      synonymsJson: data.synonymsJson.present
          ? data.synonymsJson.value
          : this.synonymsJson,
      antonymsJson: data.antonymsJson.present
          ? data.antonymsJson.value
          : this.antonymsJson,
      notes: data.notes.present ? data.notes.value : this.notes,
      favorite: data.favorite.present ? data.favorite.value : this.favorite,
      status: data.status.present ? data.status.value : this.status,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      stepIndex: data.stepIndex.present ? data.stepIndex.value : this.stepIndex,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      wrongCount: data.wrongCount.present
          ? data.wrongCount.value
          : this.wrongCount,
      lastReviewedAt: data.lastReviewedAt.present
          ? data.lastReviewedAt.value
          : this.lastReviewedAt,
      nextReviewAt: data.nextReviewAt.present
          ? data.nextReviewAt.value
          : this.nextReviewAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('meaning: $meaning, ')
          ..write('translation: $translation, ')
          ..write('italianTranslation: $italianTranslation, ')
          ..write('examplesJson: $examplesJson, ')
          ..write('synonymsJson: $synonymsJson, ')
          ..write('antonymsJson: $antonymsJson, ')
          ..write('notes: $notes, ')
          ..write('favorite: $favorite, ')
          ..write('status: $status, ')
          ..write('difficulty: $difficulty, ')
          ..write('stepIndex: $stepIndex, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    word,
    pronunciation,
    partOfSpeech,
    meaning,
    translation,
    italianTranslation,
    examplesJson,
    synonymsJson,
    antonymsJson,
    notes,
    favorite,
    status,
    difficulty,
    stepIndex,
    reviewCount,
    correctCount,
    wrongCount,
    lastReviewedAt,
    nextReviewAt,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Word &&
          other.id == this.id &&
          other.word == this.word &&
          other.pronunciation == this.pronunciation &&
          other.partOfSpeech == this.partOfSpeech &&
          other.meaning == this.meaning &&
          other.translation == this.translation &&
          other.italianTranslation == this.italianTranslation &&
          other.examplesJson == this.examplesJson &&
          other.synonymsJson == this.synonymsJson &&
          other.antonymsJson == this.antonymsJson &&
          other.notes == this.notes &&
          other.favorite == this.favorite &&
          other.status == this.status &&
          other.difficulty == this.difficulty &&
          other.stepIndex == this.stepIndex &&
          other.reviewCount == this.reviewCount &&
          other.correctCount == this.correctCount &&
          other.wrongCount == this.wrongCount &&
          other.lastReviewedAt == this.lastReviewedAt &&
          other.nextReviewAt == this.nextReviewAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<int> id;
  final Value<String> word;
  final Value<String?> pronunciation;
  final Value<String?> partOfSpeech;
  final Value<String?> meaning;
  final Value<String?> translation;
  final Value<String?> italianTranslation;
  final Value<String?> examplesJson;
  final Value<String?> synonymsJson;
  final Value<String?> antonymsJson;
  final Value<String?> notes;
  final Value<bool> favorite;
  final Value<WordStatus> status;
  final Value<int?> difficulty;
  final Value<int> stepIndex;
  final Value<int> reviewCount;
  final Value<int> correctCount;
  final Value<int> wrongCount;
  final Value<DateTime?> lastReviewedAt;
  final Value<DateTime?> nextReviewAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.pronunciation = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.meaning = const Value.absent(),
    this.translation = const Value.absent(),
    this.italianTranslation = const Value.absent(),
    this.examplesJson = const Value.absent(),
    this.synonymsJson = const Value.absent(),
    this.antonymsJson = const Value.absent(),
    this.notes = const Value.absent(),
    this.favorite = const Value.absent(),
    this.status = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.stepIndex = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WordsCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    this.pronunciation = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.meaning = const Value.absent(),
    this.translation = const Value.absent(),
    this.italianTranslation = const Value.absent(),
    this.examplesJson = const Value.absent(),
    this.synonymsJson = const Value.absent(),
    this.antonymsJson = const Value.absent(),
    this.notes = const Value.absent(),
    this.favorite = const Value.absent(),
    this.status = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.stepIndex = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : word = Value(word);
  static Insertable<Word> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? pronunciation,
    Expression<String>? partOfSpeech,
    Expression<String>? meaning,
    Expression<String>? translation,
    Expression<String>? italianTranslation,
    Expression<String>? examplesJson,
    Expression<String>? synonymsJson,
    Expression<String>? antonymsJson,
    Expression<String>? notes,
    Expression<bool>? favorite,
    Expression<String>? status,
    Expression<int>? difficulty,
    Expression<int>? stepIndex,
    Expression<int>? reviewCount,
    Expression<int>? correctCount,
    Expression<int>? wrongCount,
    Expression<DateTime>? lastReviewedAt,
    Expression<DateTime>? nextReviewAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (pronunciation != null) 'pronunciation': pronunciation,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (meaning != null) 'meaning': meaning,
      if (translation != null) 'translation': translation,
      if (italianTranslation != null) 'italian_translation': italianTranslation,
      if (examplesJson != null) 'examples_json': examplesJson,
      if (synonymsJson != null) 'synonyms_json': synonymsJson,
      if (antonymsJson != null) 'antonyms_json': antonymsJson,
      if (notes != null) 'notes': notes,
      if (favorite != null) 'favorite': favorite,
      if (status != null) 'status': status,
      if (difficulty != null) 'difficulty': difficulty,
      if (stepIndex != null) 'step_index': stepIndex,
      if (reviewCount != null) 'review_count': reviewCount,
      if (correctCount != null) 'correct_count': correctCount,
      if (wrongCount != null) 'wrong_count': wrongCount,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WordsCompanion copyWith({
    Value<int>? id,
    Value<String>? word,
    Value<String?>? pronunciation,
    Value<String?>? partOfSpeech,
    Value<String?>? meaning,
    Value<String?>? translation,
    Value<String?>? italianTranslation,
    Value<String?>? examplesJson,
    Value<String?>? synonymsJson,
    Value<String?>? antonymsJson,
    Value<String?>? notes,
    Value<bool>? favorite,
    Value<WordStatus>? status,
    Value<int?>? difficulty,
    Value<int>? stepIndex,
    Value<int>? reviewCount,
    Value<int>? correctCount,
    Value<int>? wrongCount,
    Value<DateTime?>? lastReviewedAt,
    Value<DateTime?>? nextReviewAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      pronunciation: pronunciation ?? this.pronunciation,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      meaning: meaning ?? this.meaning,
      translation: translation ?? this.translation,
      italianTranslation: italianTranslation ?? this.italianTranslation,
      examplesJson: examplesJson ?? this.examplesJson,
      synonymsJson: synonymsJson ?? this.synonymsJson,
      antonymsJson: antonymsJson ?? this.antonymsJson,
      notes: notes ?? this.notes,
      favorite: favorite ?? this.favorite,
      status: status ?? this.status,
      difficulty: difficulty ?? this.difficulty,
      stepIndex: stepIndex ?? this.stepIndex,
      reviewCount: reviewCount ?? this.reviewCount,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (pronunciation.present) {
      map['pronunciation'] = Variable<String>(pronunciation.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (italianTranslation.present) {
      map['italian_translation'] = Variable<String>(italianTranslation.value);
    }
    if (examplesJson.present) {
      map['examples_json'] = Variable<String>(examplesJson.value);
    }
    if (synonymsJson.present) {
      map['synonyms_json'] = Variable<String>(synonymsJson.value);
    }
    if (antonymsJson.present) {
      map['antonyms_json'] = Variable<String>(antonymsJson.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (favorite.present) {
      map['favorite'] = Variable<bool>(favorite.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $WordsTable.$converterstatus.toSql(status.value),
      );
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (stepIndex.present) {
      map['step_index'] = Variable<int>(stepIndex.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (wrongCount.present) {
      map['wrong_count'] = Variable<int>(wrongCount.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('pronunciation: $pronunciation, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('meaning: $meaning, ')
          ..write('translation: $translation, ')
          ..write('italianTranslation: $italianTranslation, ')
          ..write('examplesJson: $examplesJson, ')
          ..write('synonymsJson: $synonymsJson, ')
          ..write('antonymsJson: $antonymsJson, ')
          ..write('notes: $notes, ')
          ..write('favorite: $favorite, ')
          ..write('status: $status, ')
          ..write('difficulty: $difficulty, ')
          ..write('stepIndex: $stepIndex, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, color, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;

  /// Enforced unique case-sensitively; case-insensitive duplicate checks
  /// (e.g. "IT" vs "it") are done at the repository layer, same reasoning
  /// as `Words.word`.
  final String name;

  /// Optional hex color (e.g. "#3D5AFE") so the UI can color-code tag
  /// groups (level / topic / part-of-speech).
  final String? color;
  final DateTime createdAt;
  const Tag({
    required this.id,
    required this.name,
    this.color,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      createdAt: Value(createdAt),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String?>(json['color']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String?>(color),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Tag copyWith({
    int? id,
    String? name,
    Value<String?> color = const Value.absent(),
    DateTime? createdAt,
  }) => Tag(
    id: id ?? this.id,
    name: name ?? this.name,
    color: color.present ? color.value : this.color,
    createdAt: createdAt ?? this.createdAt,
  );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, color, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.name == this.name &&
          other.color == this.color &&
          other.createdAt == this.createdAt);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> color;
  final Value<DateTime> createdAt;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? color,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TagsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? color,
    Value<DateTime>? createdAt,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WordTagsTable extends WordTags with TableInfo<$WordTagsTable, WordTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int> wordId = GeneratedColumn<int>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [wordId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wordId, tagId};
  @override
  WordTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordTag(
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $WordTagsTable createAlias(String alias) {
    return $WordTagsTable(attachedDatabase, alias);
  }
}

class WordTag extends DataClass implements Insertable<WordTag> {
  final int wordId;
  final int tagId;
  const WordTag({required this.wordId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_id'] = Variable<int>(wordId);
    map['tag_id'] = Variable<int>(tagId);
    return map;
  }

  WordTagsCompanion toCompanion(bool nullToAbsent) {
    return WordTagsCompanion(wordId: Value(wordId), tagId: Value(tagId));
  }

  factory WordTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordTag(
      wordId: serializer.fromJson<int>(json['wordId']),
      tagId: serializer.fromJson<int>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wordId': serializer.toJson<int>(wordId),
      'tagId': serializer.toJson<int>(tagId),
    };
  }

  WordTag copyWith({int? wordId, int? tagId}) =>
      WordTag(wordId: wordId ?? this.wordId, tagId: tagId ?? this.tagId);
  WordTag copyWithCompanion(WordTagsCompanion data) {
    return WordTag(
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordTag(')
          ..write('wordId: $wordId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(wordId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordTag &&
          other.wordId == this.wordId &&
          other.tagId == this.tagId);
}

class WordTagsCompanion extends UpdateCompanion<WordTag> {
  final Value<int> wordId;
  final Value<int> tagId;
  final Value<int> rowid;
  const WordTagsCompanion({
    this.wordId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordTagsCompanion.insert({
    required int wordId,
    required int tagId,
    this.rowid = const Value.absent(),
  }) : wordId = Value(wordId),
       tagId = Value(tagId);
  static Insertable<WordTag> custom({
    Expression<int>? wordId,
    Expression<int>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wordId != null) 'word_id': wordId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordTagsCompanion copyWith({
    Value<int>? wordId,
    Value<int>? tagId,
    Value<int>? rowid,
  }) {
    return WordTagsCompanion(
      wordId: wordId ?? this.wordId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordTagsCompanion(')
          ..write('wordId: $wordId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewSessionsTable extends ReviewSessions
    with TableInfo<$ReviewSessionsTable, ReviewSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _finishedAtMeta = const VerificationMeta(
    'finishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
    'finished_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReviewSourceType, String>
  sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<ReviewSourceType>($ReviewSessionsTable.$convertersourceType);
  static const VerificationMeta _sourceTagIdsJsonMeta = const VerificationMeta(
    'sourceTagIdsJson',
  );
  @override
  late final GeneratedColumn<String> sourceTagIdsJson = GeneratedColumn<String>(
    'source_tag_ids_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalWordsMeta = const VerificationMeta(
    'totalWords',
  );
  @override
  late final GeneratedColumn<int> totalWords = GeneratedColumn<int>(
    'total_words',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _wrongCountMeta = const VerificationMeta(
    'wrongCount',
  );
  @override
  late final GeneratedColumn<int> wrongCount = GeneratedColumn<int>(
    'wrong_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    finishedAt,
    sourceType,
    sourceTagIdsJson,
    totalWords,
    correctCount,
    wrongCount,
    durationSeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('finished_at')) {
      context.handle(
        _finishedAtMeta,
        finishedAt.isAcceptableOrUnknown(data['finished_at']!, _finishedAtMeta),
      );
    }
    if (data.containsKey('source_tag_ids_json')) {
      context.handle(
        _sourceTagIdsJsonMeta,
        sourceTagIdsJson.isAcceptableOrUnknown(
          data['source_tag_ids_json']!,
          _sourceTagIdsJsonMeta,
        ),
      );
    }
    if (data.containsKey('total_words')) {
      context.handle(
        _totalWordsMeta,
        totalWords.isAcceptableOrUnknown(data['total_words']!, _totalWordsMeta),
      );
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('wrong_count')) {
      context.handle(
        _wrongCountMeta,
        wrongCount.isAcceptableOrUnknown(data['wrong_count']!, _wrongCountMeta),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      finishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_at'],
      ),
      sourceType: $ReviewSessionsTable.$convertersourceType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source_type'],
        )!,
      ),
      sourceTagIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_tag_ids_json'],
      ),
      totalWords: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_words'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      wrongCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_count'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
    );
  }

  @override
  $ReviewSessionsTable createAlias(String alias) {
    return $ReviewSessionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReviewSourceType, String, String>
  $convertersourceType = const EnumNameConverter<ReviewSourceType>(
    ReviewSourceType.values,
  );
}

class ReviewSession extends DataClass implements Insertable<ReviewSession> {
  final int id;
  final DateTime startedAt;

  /// Null while the session is still in progress.
  final DateTime? finishedAt;
  final ReviewSourceType sourceType;

  /// JSON-encoded `List<int>` of tag ids, only set when
  /// `sourceType == ReviewSourceType.tag`.
  final String? sourceTagIdsJson;
  final int totalWords;
  final int correctCount;
  final int wrongCount;

  /// Filled in when the session finishes.
  final int? durationSeconds;
  const ReviewSession({
    required this.id,
    required this.startedAt,
    this.finishedAt,
    required this.sourceType,
    this.sourceTagIdsJson,
    required this.totalWords,
    required this.correctCount,
    required this.wrongCount,
    this.durationSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    {
      map['source_type'] = Variable<String>(
        $ReviewSessionsTable.$convertersourceType.toSql(sourceType),
      );
    }
    if (!nullToAbsent || sourceTagIdsJson != null) {
      map['source_tag_ids_json'] = Variable<String>(sourceTagIdsJson);
    }
    map['total_words'] = Variable<int>(totalWords);
    map['correct_count'] = Variable<int>(correctCount);
    map['wrong_count'] = Variable<int>(wrongCount);
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    return map;
  }

  ReviewSessionsCompanion toCompanion(bool nullToAbsent) {
    return ReviewSessionsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
      sourceType: Value(sourceType),
      sourceTagIdsJson: sourceTagIdsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceTagIdsJson),
      totalWords: Value(totalWords),
      correctCount: Value(correctCount),
      wrongCount: Value(wrongCount),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
    );
  }

  factory ReviewSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewSession(
      id: serializer.fromJson<int>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
      sourceType: $ReviewSessionsTable.$convertersourceType.fromJson(
        serializer.fromJson<String>(json['sourceType']),
      ),
      sourceTagIdsJson: serializer.fromJson<String?>(json['sourceTagIdsJson']),
      totalWords: serializer.fromJson<int>(json['totalWords']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      wrongCount: serializer.fromJson<int>(json['wrongCount']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
      'sourceType': serializer.toJson<String>(
        $ReviewSessionsTable.$convertersourceType.toJson(sourceType),
      ),
      'sourceTagIdsJson': serializer.toJson<String?>(sourceTagIdsJson),
      'totalWords': serializer.toJson<int>(totalWords),
      'correctCount': serializer.toJson<int>(correctCount),
      'wrongCount': serializer.toJson<int>(wrongCount),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
    };
  }

  ReviewSession copyWith({
    int? id,
    DateTime? startedAt,
    Value<DateTime?> finishedAt = const Value.absent(),
    ReviewSourceType? sourceType,
    Value<String?> sourceTagIdsJson = const Value.absent(),
    int? totalWords,
    int? correctCount,
    int? wrongCount,
    Value<int?> durationSeconds = const Value.absent(),
  }) => ReviewSession(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
    sourceType: sourceType ?? this.sourceType,
    sourceTagIdsJson: sourceTagIdsJson.present
        ? sourceTagIdsJson.value
        : this.sourceTagIdsJson,
    totalWords: totalWords ?? this.totalWords,
    correctCount: correctCount ?? this.correctCount,
    wrongCount: wrongCount ?? this.wrongCount,
    durationSeconds: durationSeconds.present
        ? durationSeconds.value
        : this.durationSeconds,
  );
  ReviewSession copyWithCompanion(ReviewSessionsCompanion data) {
    return ReviewSession(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      finishedAt: data.finishedAt.present
          ? data.finishedAt.value
          : this.finishedAt,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      sourceTagIdsJson: data.sourceTagIdsJson.present
          ? data.sourceTagIdsJson.value
          : this.sourceTagIdsJson,
      totalWords: data.totalWords.present
          ? data.totalWords.value
          : this.totalWords,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      wrongCount: data.wrongCount.present
          ? data.wrongCount.value
          : this.wrongCount,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewSession(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceTagIdsJson: $sourceTagIdsJson, ')
          ..write('totalWords: $totalWords, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('durationSeconds: $durationSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    finishedAt,
    sourceType,
    sourceTagIdsJson,
    totalWords,
    correctCount,
    wrongCount,
    durationSeconds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewSession &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.finishedAt == this.finishedAt &&
          other.sourceType == this.sourceType &&
          other.sourceTagIdsJson == this.sourceTagIdsJson &&
          other.totalWords == this.totalWords &&
          other.correctCount == this.correctCount &&
          other.wrongCount == this.wrongCount &&
          other.durationSeconds == this.durationSeconds);
}

class ReviewSessionsCompanion extends UpdateCompanion<ReviewSession> {
  final Value<int> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> finishedAt;
  final Value<ReviewSourceType> sourceType;
  final Value<String?> sourceTagIdsJson;
  final Value<int> totalWords;
  final Value<int> correctCount;
  final Value<int> wrongCount;
  final Value<int?> durationSeconds;
  const ReviewSessionsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceTagIdsJson = const Value.absent(),
    this.totalWords = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.durationSeconds = const Value.absent(),
  });
  ReviewSessionsCompanion.insert({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    required ReviewSourceType sourceType,
    this.sourceTagIdsJson = const Value.absent(),
    this.totalWords = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.durationSeconds = const Value.absent(),
  }) : sourceType = Value(sourceType);
  static Insertable<ReviewSession> custom({
    Expression<int>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? finishedAt,
    Expression<String>? sourceType,
    Expression<String>? sourceTagIdsJson,
    Expression<int>? totalWords,
    Expression<int>? correctCount,
    Expression<int>? wrongCount,
    Expression<int>? durationSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceTagIdsJson != null) 'source_tag_ids_json': sourceTagIdsJson,
      if (totalWords != null) 'total_words': totalWords,
      if (correctCount != null) 'correct_count': correctCount,
      if (wrongCount != null) 'wrong_count': wrongCount,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
    });
  }

  ReviewSessionsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? finishedAt,
    Value<ReviewSourceType>? sourceType,
    Value<String?>? sourceTagIdsJson,
    Value<int>? totalWords,
    Value<int>? correctCount,
    Value<int>? wrongCount,
    Value<int?>? durationSeconds,
  }) {
    return ReviewSessionsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      sourceType: sourceType ?? this.sourceType,
      sourceTagIdsJson: sourceTagIdsJson ?? this.sourceTagIdsJson,
      totalWords: totalWords ?? this.totalWords,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
      durationSeconds: durationSeconds ?? this.durationSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(
        $ReviewSessionsTable.$convertersourceType.toSql(sourceType.value),
      );
    }
    if (sourceTagIdsJson.present) {
      map['source_tag_ids_json'] = Variable<String>(sourceTagIdsJson.value);
    }
    if (totalWords.present) {
      map['total_words'] = Variable<int>(totalWords.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (wrongCount.present) {
      map['wrong_count'] = Variable<int>(wrongCount.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewSessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceTagIdsJson: $sourceTagIdsJson, ')
          ..write('totalWords: $totalWords, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('durationSeconds: $durationSeconds')
          ..write(')'))
        .toString();
  }
}

class $ReviewHistoryTable extends ReviewHistory
    with TableInfo<$ReviewHistoryTable, ReviewHistoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<int> wordId = GeneratedColumn<int>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reviewSessionIdMeta = const VerificationMeta(
    'reviewSessionId',
  );
  @override
  late final GeneratedColumn<int> reviewSessionId = GeneratedColumn<int>(
    'review_session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES review_sessions (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReviewQuestionType, String>
  questionType =
      GeneratedColumn<String>(
        'question_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ReviewQuestionType>(
        $ReviewHistoryTable.$converterquestionType,
      );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_correct" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReviewRating, String> rating =
      GeneratedColumn<String>(
        'rating',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ReviewRating>($ReviewHistoryTable.$converterrating);
  static const VerificationMeta _previousStepIndexMeta = const VerificationMeta(
    'previousStepIndex',
  );
  @override
  late final GeneratedColumn<int> previousStepIndex = GeneratedColumn<int>(
    'previous_step_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _newStepIndexMeta = const VerificationMeta(
    'newStepIndex',
  );
  @override
  late final GeneratedColumn<int> newStepIndex = GeneratedColumn<int>(
    'new_step_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
    'reviewed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wordId,
    reviewSessionId,
    questionType,
    isCorrect,
    rating,
    previousStepIndex,
    newStepIndex,
    reviewedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewHistoryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('review_session_id')) {
      context.handle(
        _reviewSessionIdMeta,
        reviewSessionId.isAcceptableOrUnknown(
          data['review_session_id']!,
          _reviewSessionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reviewSessionIdMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('previous_step_index')) {
      context.handle(
        _previousStepIndexMeta,
        previousStepIndex.isAcceptableOrUnknown(
          data['previous_step_index']!,
          _previousStepIndexMeta,
        ),
      );
    }
    if (data.containsKey('new_step_index')) {
      context.handle(
        _newStepIndexMeta,
        newStepIndex.isAcceptableOrUnknown(
          data['new_step_index']!,
          _newStepIndexMeta,
        ),
      );
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewHistoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewHistoryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_id'],
      )!,
      reviewSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_session_id'],
      )!,
      questionType: $ReviewHistoryTable.$converterquestionType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}question_type'],
        )!,
      ),
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
      rating: $ReviewHistoryTable.$converterrating.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rating'],
        )!,
      ),
      previousStepIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}previous_step_index'],
      ),
      newStepIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}new_step_index'],
      ),
      reviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reviewed_at'],
      )!,
    );
  }

  @override
  $ReviewHistoryTable createAlias(String alias) {
    return $ReviewHistoryTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReviewQuestionType, String, String>
  $converterquestionType = const EnumNameConverter<ReviewQuestionType>(
    ReviewQuestionType.values,
  );
  static JsonTypeConverter2<ReviewRating, String, String> $converterrating =
      const EnumNameConverter<ReviewRating>(ReviewRating.values);
}

class ReviewHistoryEntry extends DataClass
    implements Insertable<ReviewHistoryEntry> {
  final int id;
  final int wordId;

  /// Every review — even a single "Review this word" from the Word Detail
  /// screen — happens inside a session (a 1-word session in that case),
  /// so this is intentionally non-nullable.
  final int reviewSessionId;
  final ReviewQuestionType questionType;
  final bool isCorrect;
  final ReviewRating rating;

  /// Audit trail of the scheduler's decision, cheap to keep and useful for
  /// debugging "why did nextReviewAt change like that".
  final int? previousStepIndex;
  final int? newStepIndex;
  final DateTime reviewedAt;
  const ReviewHistoryEntry({
    required this.id,
    required this.wordId,
    required this.reviewSessionId,
    required this.questionType,
    required this.isCorrect,
    required this.rating,
    this.previousStepIndex,
    this.newStepIndex,
    required this.reviewedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word_id'] = Variable<int>(wordId);
    map['review_session_id'] = Variable<int>(reviewSessionId);
    {
      map['question_type'] = Variable<String>(
        $ReviewHistoryTable.$converterquestionType.toSql(questionType),
      );
    }
    map['is_correct'] = Variable<bool>(isCorrect);
    {
      map['rating'] = Variable<String>(
        $ReviewHistoryTable.$converterrating.toSql(rating),
      );
    }
    if (!nullToAbsent || previousStepIndex != null) {
      map['previous_step_index'] = Variable<int>(previousStepIndex);
    }
    if (!nullToAbsent || newStepIndex != null) {
      map['new_step_index'] = Variable<int>(newStepIndex);
    }
    map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    return map;
  }

  ReviewHistoryCompanion toCompanion(bool nullToAbsent) {
    return ReviewHistoryCompanion(
      id: Value(id),
      wordId: Value(wordId),
      reviewSessionId: Value(reviewSessionId),
      questionType: Value(questionType),
      isCorrect: Value(isCorrect),
      rating: Value(rating),
      previousStepIndex: previousStepIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(previousStepIndex),
      newStepIndex: newStepIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(newStepIndex),
      reviewedAt: Value(reviewedAt),
    );
  }

  factory ReviewHistoryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewHistoryEntry(
      id: serializer.fromJson<int>(json['id']),
      wordId: serializer.fromJson<int>(json['wordId']),
      reviewSessionId: serializer.fromJson<int>(json['reviewSessionId']),
      questionType: $ReviewHistoryTable.$converterquestionType.fromJson(
        serializer.fromJson<String>(json['questionType']),
      ),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
      rating: $ReviewHistoryTable.$converterrating.fromJson(
        serializer.fromJson<String>(json['rating']),
      ),
      previousStepIndex: serializer.fromJson<int?>(json['previousStepIndex']),
      newStepIndex: serializer.fromJson<int?>(json['newStepIndex']),
      reviewedAt: serializer.fromJson<DateTime>(json['reviewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wordId': serializer.toJson<int>(wordId),
      'reviewSessionId': serializer.toJson<int>(reviewSessionId),
      'questionType': serializer.toJson<String>(
        $ReviewHistoryTable.$converterquestionType.toJson(questionType),
      ),
      'isCorrect': serializer.toJson<bool>(isCorrect),
      'rating': serializer.toJson<String>(
        $ReviewHistoryTable.$converterrating.toJson(rating),
      ),
      'previousStepIndex': serializer.toJson<int?>(previousStepIndex),
      'newStepIndex': serializer.toJson<int?>(newStepIndex),
      'reviewedAt': serializer.toJson<DateTime>(reviewedAt),
    };
  }

  ReviewHistoryEntry copyWith({
    int? id,
    int? wordId,
    int? reviewSessionId,
    ReviewQuestionType? questionType,
    bool? isCorrect,
    ReviewRating? rating,
    Value<int?> previousStepIndex = const Value.absent(),
    Value<int?> newStepIndex = const Value.absent(),
    DateTime? reviewedAt,
  }) => ReviewHistoryEntry(
    id: id ?? this.id,
    wordId: wordId ?? this.wordId,
    reviewSessionId: reviewSessionId ?? this.reviewSessionId,
    questionType: questionType ?? this.questionType,
    isCorrect: isCorrect ?? this.isCorrect,
    rating: rating ?? this.rating,
    previousStepIndex: previousStepIndex.present
        ? previousStepIndex.value
        : this.previousStepIndex,
    newStepIndex: newStepIndex.present ? newStepIndex.value : this.newStepIndex,
    reviewedAt: reviewedAt ?? this.reviewedAt,
  );
  ReviewHistoryEntry copyWithCompanion(ReviewHistoryCompanion data) {
    return ReviewHistoryEntry(
      id: data.id.present ? data.id.value : this.id,
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      reviewSessionId: data.reviewSessionId.present
          ? data.reviewSessionId.value
          : this.reviewSessionId,
      questionType: data.questionType.present
          ? data.questionType.value
          : this.questionType,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      rating: data.rating.present ? data.rating.value : this.rating,
      previousStepIndex: data.previousStepIndex.present
          ? data.previousStepIndex.value
          : this.previousStepIndex,
      newStepIndex: data.newStepIndex.present
          ? data.newStepIndex.value
          : this.newStepIndex,
      reviewedAt: data.reviewedAt.present
          ? data.reviewedAt.value
          : this.reviewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewHistoryEntry(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('reviewSessionId: $reviewSessionId, ')
          ..write('questionType: $questionType, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('rating: $rating, ')
          ..write('previousStepIndex: $previousStepIndex, ')
          ..write('newStepIndex: $newStepIndex, ')
          ..write('reviewedAt: $reviewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    wordId,
    reviewSessionId,
    questionType,
    isCorrect,
    rating,
    previousStepIndex,
    newStepIndex,
    reviewedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewHistoryEntry &&
          other.id == this.id &&
          other.wordId == this.wordId &&
          other.reviewSessionId == this.reviewSessionId &&
          other.questionType == this.questionType &&
          other.isCorrect == this.isCorrect &&
          other.rating == this.rating &&
          other.previousStepIndex == this.previousStepIndex &&
          other.newStepIndex == this.newStepIndex &&
          other.reviewedAt == this.reviewedAt);
}

class ReviewHistoryCompanion extends UpdateCompanion<ReviewHistoryEntry> {
  final Value<int> id;
  final Value<int> wordId;
  final Value<int> reviewSessionId;
  final Value<ReviewQuestionType> questionType;
  final Value<bool> isCorrect;
  final Value<ReviewRating> rating;
  final Value<int?> previousStepIndex;
  final Value<int?> newStepIndex;
  final Value<DateTime> reviewedAt;
  const ReviewHistoryCompanion({
    this.id = const Value.absent(),
    this.wordId = const Value.absent(),
    this.reviewSessionId = const Value.absent(),
    this.questionType = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.rating = const Value.absent(),
    this.previousStepIndex = const Value.absent(),
    this.newStepIndex = const Value.absent(),
    this.reviewedAt = const Value.absent(),
  });
  ReviewHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int wordId,
    required int reviewSessionId,
    required ReviewQuestionType questionType,
    required bool isCorrect,
    required ReviewRating rating,
    this.previousStepIndex = const Value.absent(),
    this.newStepIndex = const Value.absent(),
    this.reviewedAt = const Value.absent(),
  }) : wordId = Value(wordId),
       reviewSessionId = Value(reviewSessionId),
       questionType = Value(questionType),
       isCorrect = Value(isCorrect),
       rating = Value(rating);
  static Insertable<ReviewHistoryEntry> custom({
    Expression<int>? id,
    Expression<int>? wordId,
    Expression<int>? reviewSessionId,
    Expression<String>? questionType,
    Expression<bool>? isCorrect,
    Expression<String>? rating,
    Expression<int>? previousStepIndex,
    Expression<int>? newStepIndex,
    Expression<DateTime>? reviewedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wordId != null) 'word_id': wordId,
      if (reviewSessionId != null) 'review_session_id': reviewSessionId,
      if (questionType != null) 'question_type': questionType,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (rating != null) 'rating': rating,
      if (previousStepIndex != null) 'previous_step_index': previousStepIndex,
      if (newStepIndex != null) 'new_step_index': newStepIndex,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
    });
  }

  ReviewHistoryCompanion copyWith({
    Value<int>? id,
    Value<int>? wordId,
    Value<int>? reviewSessionId,
    Value<ReviewQuestionType>? questionType,
    Value<bool>? isCorrect,
    Value<ReviewRating>? rating,
    Value<int?>? previousStepIndex,
    Value<int?>? newStepIndex,
    Value<DateTime>? reviewedAt,
  }) {
    return ReviewHistoryCompanion(
      id: id ?? this.id,
      wordId: wordId ?? this.wordId,
      reviewSessionId: reviewSessionId ?? this.reviewSessionId,
      questionType: questionType ?? this.questionType,
      isCorrect: isCorrect ?? this.isCorrect,
      rating: rating ?? this.rating,
      previousStepIndex: previousStepIndex ?? this.previousStepIndex,
      newStepIndex: newStepIndex ?? this.newStepIndex,
      reviewedAt: reviewedAt ?? this.reviewedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<int>(wordId.value);
    }
    if (reviewSessionId.present) {
      map['review_session_id'] = Variable<int>(reviewSessionId.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<String>(
        $ReviewHistoryTable.$converterquestionType.toSql(questionType.value),
      );
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (rating.present) {
      map['rating'] = Variable<String>(
        $ReviewHistoryTable.$converterrating.toSql(rating.value),
      );
    }
    if (previousStepIndex.present) {
      map['previous_step_index'] = Variable<int>(previousStepIndex.value);
    }
    if (newStepIndex.present) {
      map['new_step_index'] = Variable<int>(newStepIndex.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewHistoryCompanion(')
          ..write('id: $id, ')
          ..write('wordId: $wordId, ')
          ..write('reviewSessionId: $reviewSessionId, ')
          ..write('questionType: $questionType, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('rating: $rating, ')
          ..write('previousStepIndex: $previousStepIndex, ')
          ..write('newStepIndex: $newStepIndex, ')
          ..write('reviewedAt: $reviewedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WordsTable words = $WordsTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $WordTagsTable wordTags = $WordTagsTable(this);
  late final $ReviewSessionsTable reviewSessions = $ReviewSessionsTable(this);
  late final $ReviewHistoryTable reviewHistory = $ReviewHistoryTable(this);
  late final Index wordsNextReviewAt = Index(
    'words_next_review_at',
    'CREATE INDEX words_next_review_at ON words (next_review_at)',
  );
  late final Index wordsStatus = Index(
    'words_status',
    'CREATE INDEX words_status ON words (status)',
  );
  late final Index wordTagsTagId = Index(
    'word_tags_tag_id',
    'CREATE INDEX word_tags_tag_id ON word_tags (tag_id)',
  );
  late final Index reviewHistoryWordId = Index(
    'review_history_word_id',
    'CREATE INDEX review_history_word_id ON review_history (word_id)',
  );
  late final Index reviewHistoryReviewedAt = Index(
    'review_history_reviewed_at',
    'CREATE INDEX review_history_reviewed_at ON review_history (reviewed_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    words,
    tags,
    wordTags,
    reviewSessions,
    reviewHistory,
    wordsNextReviewAt,
    wordsStatus,
    wordTagsTagId,
    reviewHistoryWordId,
    reviewHistoryReviewedAt,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'words',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('word_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('word_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'words',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('review_history', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'review_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('review_history', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$WordsTableCreateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      required String word,
      Value<String?> pronunciation,
      Value<String?> partOfSpeech,
      Value<String?> meaning,
      Value<String?> translation,
      Value<String?> italianTranslation,
      Value<String?> examplesJson,
      Value<String?> synonymsJson,
      Value<String?> antonymsJson,
      Value<String?> notes,
      Value<bool> favorite,
      Value<WordStatus> status,
      Value<int?> difficulty,
      Value<int> stepIndex,
      Value<int> reviewCount,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<DateTime?> lastReviewedAt,
      Value<DateTime?> nextReviewAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$WordsTableUpdateCompanionBuilder =
    WordsCompanion Function({
      Value<int> id,
      Value<String> word,
      Value<String?> pronunciation,
      Value<String?> partOfSpeech,
      Value<String?> meaning,
      Value<String?> translation,
      Value<String?> italianTranslation,
      Value<String?> examplesJson,
      Value<String?> synonymsJson,
      Value<String?> antonymsJson,
      Value<String?> notes,
      Value<bool> favorite,
      Value<WordStatus> status,
      Value<int?> difficulty,
      Value<int> stepIndex,
      Value<int> reviewCount,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<DateTime?> lastReviewedAt,
      Value<DateTime?> nextReviewAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$WordsTableReferences
    extends BaseReferences<_$AppDatabase, $WordsTable, Word> {
  $$WordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WordTagsTable, List<WordTag>> _wordTagsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.wordTags,
    aliasName: 'words__id__word_tags__word_id',
  );

  $$WordTagsTableProcessedTableManager get wordTagsRefs {
    final manager = $$WordTagsTableTableManager(
      $_db,
      $_db.wordTags,
    ).filter((f) => f.wordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReviewHistoryTable, List<ReviewHistoryEntry>>
  _reviewHistoryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewHistory,
    aliasName: 'words__id__review_history__word_id',
  );

  $$ReviewHistoryTableProcessedTableManager get reviewHistoryRefs {
    final manager = $$ReviewHistoryTableTableManager(
      $_db,
      $_db.reviewHistory,
    ).filter((f) => f.wordId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewHistoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WordsTableFilterComposer extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get italianTranslation => $composableBuilder(
    column: $table.italianTranslation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examplesJson => $composableBuilder(
    column: $table.examplesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get synonymsJson => $composableBuilder(
    column: $table.synonymsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get antonymsJson => $composableBuilder(
    column: $table.antonymsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get favorite => $composableBuilder(
    column: $table.favorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<WordStatus, WordStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepIndex => $composableBuilder(
    column: $table.stepIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordTagsRefs(
    Expression<bool> Function($$WordTagsTableFilterComposer f) f,
  ) {
    final $$WordTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordTags,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordTagsTableFilterComposer(
            $db: $db,
            $table: $db.wordTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reviewHistoryRefs(
    Expression<bool> Function($$ReviewHistoryTableFilterComposer f) f,
  ) {
    final $$ReviewHistoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewHistory,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewHistoryTableFilterComposer(
            $db: $db,
            $table: $db.reviewHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meaning => $composableBuilder(
    column: $table.meaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get italianTranslation => $composableBuilder(
    column: $table.italianTranslation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examplesJson => $composableBuilder(
    column: $table.examplesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get synonymsJson => $composableBuilder(
    column: $table.synonymsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get antonymsJson => $composableBuilder(
    column: $table.antonymsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get favorite => $composableBuilder(
    column: $table.favorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepIndex => $composableBuilder(
    column: $table.stepIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get pronunciation => $composableBuilder(
    column: $table.pronunciation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get italianTranslation => $composableBuilder(
    column: $table.italianTranslation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get examplesJson => $composableBuilder(
    column: $table.examplesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get synonymsJson => $composableBuilder(
    column: $table.synonymsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get antonymsJson => $composableBuilder(
    column: $table.antonymsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get favorite =>
      $composableBuilder(column: $table.favorite, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WordStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stepIndex =>
      $composableBuilder(column: $table.stepIndex, builder: (column) => column);

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> wordTagsRefs<T extends Object>(
    Expression<T> Function($$WordTagsTableAnnotationComposer a) f,
  ) {
    final $$WordTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordTags,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.wordTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reviewHistoryRefs<T extends Object>(
    Expression<T> Function($$ReviewHistoryTableAnnotationComposer a) f,
  ) {
    final $$ReviewHistoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewHistory,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewHistoryTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordsTable,
          Word,
          $$WordsTableFilterComposer,
          $$WordsTableOrderingComposer,
          $$WordsTableAnnotationComposer,
          $$WordsTableCreateCompanionBuilder,
          $$WordsTableUpdateCompanionBuilder,
          (Word, $$WordsTableReferences),
          Word,
          PrefetchHooks Function({bool wordTagsRefs, bool reviewHistoryRefs})
        > {
  $$WordsTableTableManager(_$AppDatabase db, $WordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> word = const Value.absent(),
                Value<String?> pronunciation = const Value.absent(),
                Value<String?> partOfSpeech = const Value.absent(),
                Value<String?> meaning = const Value.absent(),
                Value<String?> translation = const Value.absent(),
                Value<String?> italianTranslation = const Value.absent(),
                Value<String?> examplesJson = const Value.absent(),
                Value<String?> synonymsJson = const Value.absent(),
                Value<String?> antonymsJson = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> favorite = const Value.absent(),
                Value<WordStatus> status = const Value.absent(),
                Value<int?> difficulty = const Value.absent(),
                Value<int> stepIndex = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<DateTime?> nextReviewAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                word: word,
                pronunciation: pronunciation,
                partOfSpeech: partOfSpeech,
                meaning: meaning,
                translation: translation,
                italianTranslation: italianTranslation,
                examplesJson: examplesJson,
                synonymsJson: synonymsJson,
                antonymsJson: antonymsJson,
                notes: notes,
                favorite: favorite,
                status: status,
                difficulty: difficulty,
                stepIndex: stepIndex,
                reviewCount: reviewCount,
                correctCount: correctCount,
                wrongCount: wrongCount,
                lastReviewedAt: lastReviewedAt,
                nextReviewAt: nextReviewAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String word,
                Value<String?> pronunciation = const Value.absent(),
                Value<String?> partOfSpeech = const Value.absent(),
                Value<String?> meaning = const Value.absent(),
                Value<String?> translation = const Value.absent(),
                Value<String?> italianTranslation = const Value.absent(),
                Value<String?> examplesJson = const Value.absent(),
                Value<String?> synonymsJson = const Value.absent(),
                Value<String?> antonymsJson = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> favorite = const Value.absent(),
                Value<WordStatus> status = const Value.absent(),
                Value<int?> difficulty = const Value.absent(),
                Value<int> stepIndex = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<DateTime?> nextReviewAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WordsCompanion.insert(
                id: id,
                word: word,
                pronunciation: pronunciation,
                partOfSpeech: partOfSpeech,
                meaning: meaning,
                translation: translation,
                italianTranslation: italianTranslation,
                examplesJson: examplesJson,
                synonymsJson: synonymsJson,
                antonymsJson: antonymsJson,
                notes: notes,
                favorite: favorite,
                status: status,
                difficulty: difficulty,
                stepIndex: stepIndex,
                reviewCount: reviewCount,
                correctCount: correctCount,
                wrongCount: wrongCount,
                lastReviewedAt: lastReviewedAt,
                nextReviewAt: nextReviewAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WordsTable, Word>(table),
                  $$WordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({wordTagsRefs = false, reviewHistoryRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wordTagsRefs) db.wordTags,
                    if (reviewHistoryRefs) db.reviewHistory,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (wordTagsRefs)
                        await $_getPrefetchedData<Word, $WordsTable, WordTag>(
                          currentTable: table,
                          referencedTable: $$WordsTableReferences
                              ._wordTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WordsTableReferences(
                                db,
                                table,
                                p0,
                              ).wordTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wordId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reviewHistoryRefs)
                        await $_getPrefetchedData<
                          Word,
                          $WordsTable,
                          ReviewHistoryEntry
                        >(
                          currentTable: table,
                          referencedTable: $$WordsTableReferences
                              ._reviewHistoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WordsTableReferences(
                                db,
                                table,
                                p0,
                              ).reviewHistoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wordId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordsTable,
      Word,
      $$WordsTableFilterComposer,
      $$WordsTableOrderingComposer,
      $$WordsTableAnnotationComposer,
      $$WordsTableCreateCompanionBuilder,
      $$WordsTableUpdateCompanionBuilder,
      (Word, $$WordsTableReferences),
      Word,
      PrefetchHooks Function({bool wordTagsRefs, bool reviewHistoryRefs})
    >;
typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> color,
      Value<DateTime> createdAt,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> color,
      Value<DateTime> createdAt,
    });

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WordTagsTable, List<WordTag>> _wordTagsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.wordTags,
    aliasName: 'tags__id__word_tags__tag_id',
  );

  $$WordTagsTableProcessedTableManager get wordTagsRefs {
    final manager = $$WordTagsTableTableManager(
      $_db,
      $_db.wordTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordTagsRefs(
    Expression<bool> Function($$WordTagsTableFilterComposer f) f,
  ) {
    final $$WordTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordTagsTableFilterComposer(
            $db: $db,
            $table: $db.wordTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> wordTagsRefs<T extends Object>(
    Expression<T> Function($$WordTagsTableAnnotationComposer a) f,
  ) {
    final $$WordTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.wordTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({bool wordTagsRefs})
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                name: name,
                color: color,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TagsCompanion.insert(
                id: id,
                name: name,
                color: color,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TagsTable, Tag>(table),
                  $$TagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (wordTagsRefs) db.wordTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wordTagsRefs)
                    await $_getPrefetchedData<Tag, $TagsTable, WordTag>(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences._wordTagsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$TagsTableReferences(db, table, p0).wordTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tagId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({bool wordTagsRefs})
    >;
typedef $$WordTagsTableCreateCompanionBuilder =
    WordTagsCompanion Function({
      required int wordId,
      required int tagId,
      Value<int> rowid,
    });
typedef $$WordTagsTableUpdateCompanionBuilder =
    WordTagsCompanion Function({
      Value<int> wordId,
      Value<int> tagId,
      Value<int> rowid,
    });

final class $$WordTagsTableReferences
    extends BaseReferences<_$AppDatabase, $WordTagsTable, WordTag> {
  $$WordTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WordsTable _wordIdTable(_$AppDatabase db) =>
      db.words.createAlias('word_tags__word_id__words__id');

  $$WordsTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<int>('word_id')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias('word_tags__tag_id__tags__id');

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<int>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordTagsTableFilterComposer
    extends Composer<_$AppDatabase, $WordTagsTable> {
  $$WordTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WordsTableFilterComposer get wordId {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordTagsTable> {
  $$WordTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WordsTableOrderingComposer get wordId {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordTagsTable> {
  $$WordTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WordsTableAnnotationComposer get wordId {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordTagsTable,
          WordTag,
          $$WordTagsTableFilterComposer,
          $$WordTagsTableOrderingComposer,
          $$WordTagsTableAnnotationComposer,
          $$WordTagsTableCreateCompanionBuilder,
          $$WordTagsTableUpdateCompanionBuilder,
          (WordTag, $$WordTagsTableReferences),
          WordTag,
          PrefetchHooks Function({bool wordId, bool tagId})
        > {
  $$WordTagsTableTableManager(_$AppDatabase db, $WordTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> wordId = const Value.absent(),
                Value<int> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  WordTagsCompanion(wordId: wordId, tagId: tagId, rowid: rowid),
          createCompanionCallback:
              ({
                required int wordId,
                required int tagId,
                Value<int> rowid = const Value.absent(),
              }) => WordTagsCompanion.insert(
                wordId: wordId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WordTagsTable, WordTag>(table),
                  $$WordTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.wordId,
                                referencedTable: $$WordTagsTableReferences
                                    ._wordIdTable(db),
                                referencedColumn: $$WordTagsTableReferences
                                    ._wordIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (tagId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagId,
                                referencedTable: $$WordTagsTableReferences
                                    ._tagIdTable(db),
                                referencedColumn: $$WordTagsTableReferences
                                    ._tagIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WordTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordTagsTable,
      WordTag,
      $$WordTagsTableFilterComposer,
      $$WordTagsTableOrderingComposer,
      $$WordTagsTableAnnotationComposer,
      $$WordTagsTableCreateCompanionBuilder,
      $$WordTagsTableUpdateCompanionBuilder,
      (WordTag, $$WordTagsTableReferences),
      WordTag,
      PrefetchHooks Function({bool wordId, bool tagId})
    >;
typedef $$ReviewSessionsTableCreateCompanionBuilder =
    ReviewSessionsCompanion Function({
      Value<int> id,
      Value<DateTime> startedAt,
      Value<DateTime?> finishedAt,
      required ReviewSourceType sourceType,
      Value<String?> sourceTagIdsJson,
      Value<int> totalWords,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<int?> durationSeconds,
    });
typedef $$ReviewSessionsTableUpdateCompanionBuilder =
    ReviewSessionsCompanion Function({
      Value<int> id,
      Value<DateTime> startedAt,
      Value<DateTime?> finishedAt,
      Value<ReviewSourceType> sourceType,
      Value<String?> sourceTagIdsJson,
      Value<int> totalWords,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<int?> durationSeconds,
    });

final class $$ReviewSessionsTableReferences
    extends BaseReferences<_$AppDatabase, $ReviewSessionsTable, ReviewSession> {
  $$ReviewSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ReviewHistoryTable, List<ReviewHistoryEntry>>
  _reviewHistoryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewHistory,
    aliasName: 'review_sessions__id__review_history__review_session_id',
  );

  $$ReviewHistoryTableProcessedTableManager get reviewHistoryRefs {
    final manager = $$ReviewHistoryTableTableManager(
      $_db,
      $_db.reviewHistory,
    ).filter((f) => f.reviewSessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewHistoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReviewSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewSessionsTable> {
  $$ReviewSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReviewSourceType, ReviewSourceType, String>
  get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get sourceTagIdsJson => $composableBuilder(
    column: $table.sourceTagIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalWords => $composableBuilder(
    column: $table.totalWords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> reviewHistoryRefs(
    Expression<bool> Function($$ReviewHistoryTableFilterComposer f) f,
  ) {
    final $$ReviewHistoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewHistory,
      getReferencedColumn: (t) => t.reviewSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewHistoryTableFilterComposer(
            $db: $db,
            $table: $db.reviewHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReviewSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewSessionsTable> {
  $$ReviewSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceTagIdsJson => $composableBuilder(
    column: $table.sourceTagIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalWords => $composableBuilder(
    column: $table.totalWords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReviewSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewSessionsTable> {
  $$ReviewSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ReviewSourceType, String> get sourceType =>
      $composableBuilder(
        column: $table.sourceType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get sourceTagIdsJson => $composableBuilder(
    column: $table.sourceTagIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalWords => $composableBuilder(
    column: $table.totalWords,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  Expression<T> reviewHistoryRefs<T extends Object>(
    Expression<T> Function($$ReviewHistoryTableAnnotationComposer a) f,
  ) {
    final $$ReviewHistoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewHistory,
      getReferencedColumn: (t) => t.reviewSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewHistoryTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReviewSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewSessionsTable,
          ReviewSession,
          $$ReviewSessionsTableFilterComposer,
          $$ReviewSessionsTableOrderingComposer,
          $$ReviewSessionsTableAnnotationComposer,
          $$ReviewSessionsTableCreateCompanionBuilder,
          $$ReviewSessionsTableUpdateCompanionBuilder,
          (ReviewSession, $$ReviewSessionsTableReferences),
          ReviewSession,
          PrefetchHooks Function({bool reviewHistoryRefs})
        > {
  $$ReviewSessionsTableTableManager(
    _$AppDatabase db,
    $ReviewSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<ReviewSourceType> sourceType = const Value.absent(),
                Value<String?> sourceTagIdsJson = const Value.absent(),
                Value<int> totalWords = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
              }) => ReviewSessionsCompanion(
                id: id,
                startedAt: startedAt,
                finishedAt: finishedAt,
                sourceType: sourceType,
                sourceTagIdsJson: sourceTagIdsJson,
                totalWords: totalWords,
                correctCount: correctCount,
                wrongCount: wrongCount,
                durationSeconds: durationSeconds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                required ReviewSourceType sourceType,
                Value<String?> sourceTagIdsJson = const Value.absent(),
                Value<int> totalWords = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
              }) => ReviewSessionsCompanion.insert(
                id: id,
                startedAt: startedAt,
                finishedAt: finishedAt,
                sourceType: sourceType,
                sourceTagIdsJson: sourceTagIdsJson,
                totalWords: totalWords,
                correctCount: correctCount,
                wrongCount: wrongCount,
                durationSeconds: durationSeconds,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReviewSessionsTable, ReviewSession>(table),
                  $$ReviewSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reviewHistoryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reviewHistoryRefs) db.reviewHistory,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reviewHistoryRefs)
                    await $_getPrefetchedData<
                      ReviewSession,
                      $ReviewSessionsTable,
                      ReviewHistoryEntry
                    >(
                      currentTable: table,
                      referencedTable: $$ReviewSessionsTableReferences
                          ._reviewHistoryRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ReviewSessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).reviewHistoryRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.reviewSessionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ReviewSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewSessionsTable,
      ReviewSession,
      $$ReviewSessionsTableFilterComposer,
      $$ReviewSessionsTableOrderingComposer,
      $$ReviewSessionsTableAnnotationComposer,
      $$ReviewSessionsTableCreateCompanionBuilder,
      $$ReviewSessionsTableUpdateCompanionBuilder,
      (ReviewSession, $$ReviewSessionsTableReferences),
      ReviewSession,
      PrefetchHooks Function({bool reviewHistoryRefs})
    >;
typedef $$ReviewHistoryTableCreateCompanionBuilder =
    ReviewHistoryCompanion Function({
      Value<int> id,
      required int wordId,
      required int reviewSessionId,
      required ReviewQuestionType questionType,
      required bool isCorrect,
      required ReviewRating rating,
      Value<int?> previousStepIndex,
      Value<int?> newStepIndex,
      Value<DateTime> reviewedAt,
    });
typedef $$ReviewHistoryTableUpdateCompanionBuilder =
    ReviewHistoryCompanion Function({
      Value<int> id,
      Value<int> wordId,
      Value<int> reviewSessionId,
      Value<ReviewQuestionType> questionType,
      Value<bool> isCorrect,
      Value<ReviewRating> rating,
      Value<int?> previousStepIndex,
      Value<int?> newStepIndex,
      Value<DateTime> reviewedAt,
    });

final class $$ReviewHistoryTableReferences
    extends
        BaseReferences<_$AppDatabase, $ReviewHistoryTable, ReviewHistoryEntry> {
  $$ReviewHistoryTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WordsTable _wordIdTable(_$AppDatabase db) =>
      db.words.createAlias('review_history__word_id__words__id');

  $$WordsTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<int>('word_id')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ReviewSessionsTable _reviewSessionIdTable(_$AppDatabase db) => db
      .reviewSessions
      .createAlias('review_history__review_session_id__review_sessions__id');

  $$ReviewSessionsTableProcessedTableManager get reviewSessionId {
    final $_column = $_itemColumn<int>('review_session_id')!;

    final manager = $$ReviewSessionsTableTableManager(
      $_db,
      $_db.reviewSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reviewSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewHistoryTable> {
  $$ReviewHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReviewQuestionType, ReviewQuestionType, String>
  get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReviewRating, ReviewRating, String>
  get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get previousStepIndex => $composableBuilder(
    column: $table.previousStepIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get newStepIndex => $composableBuilder(
    column: $table.newStepIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WordsTableFilterComposer get wordId {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReviewSessionsTableFilterComposer get reviewSessionId {
    final $$ReviewSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reviewSessionId,
      referencedTable: $db.reviewSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewSessionsTableFilterComposer(
            $db: $db,
            $table: $db.reviewSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewHistoryTable> {
  $$ReviewHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get previousStepIndex => $composableBuilder(
    column: $table.previousStepIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get newStepIndex => $composableBuilder(
    column: $table.newStepIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WordsTableOrderingComposer get wordId {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReviewSessionsTableOrderingComposer get reviewSessionId {
    final $$ReviewSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reviewSessionId,
      referencedTable: $db.reviewSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.reviewSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewHistoryTable> {
  $$ReviewHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReviewQuestionType, String>
  get questionType => $composableBuilder(
    column: $table.questionType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReviewRating, String> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get previousStepIndex => $composableBuilder(
    column: $table.previousStepIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get newStepIndex => $composableBuilder(
    column: $table.newStepIndex,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );

  $$WordsTableAnnotationComposer get wordId {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReviewSessionsTableAnnotationComposer get reviewSessionId {
    final $$ReviewSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reviewSessionId,
      referencedTable: $db.reviewSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewHistoryTable,
          ReviewHistoryEntry,
          $$ReviewHistoryTableFilterComposer,
          $$ReviewHistoryTableOrderingComposer,
          $$ReviewHistoryTableAnnotationComposer,
          $$ReviewHistoryTableCreateCompanionBuilder,
          $$ReviewHistoryTableUpdateCompanionBuilder,
          (ReviewHistoryEntry, $$ReviewHistoryTableReferences),
          ReviewHistoryEntry,
          PrefetchHooks Function({bool wordId, bool reviewSessionId})
        > {
  $$ReviewHistoryTableTableManager(_$AppDatabase db, $ReviewHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> wordId = const Value.absent(),
                Value<int> reviewSessionId = const Value.absent(),
                Value<ReviewQuestionType> questionType = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<ReviewRating> rating = const Value.absent(),
                Value<int?> previousStepIndex = const Value.absent(),
                Value<int?> newStepIndex = const Value.absent(),
                Value<DateTime> reviewedAt = const Value.absent(),
              }) => ReviewHistoryCompanion(
                id: id,
                wordId: wordId,
                reviewSessionId: reviewSessionId,
                questionType: questionType,
                isCorrect: isCorrect,
                rating: rating,
                previousStepIndex: previousStepIndex,
                newStepIndex: newStepIndex,
                reviewedAt: reviewedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int wordId,
                required int reviewSessionId,
                required ReviewQuestionType questionType,
                required bool isCorrect,
                required ReviewRating rating,
                Value<int?> previousStepIndex = const Value.absent(),
                Value<int?> newStepIndex = const Value.absent(),
                Value<DateTime> reviewedAt = const Value.absent(),
              }) => ReviewHistoryCompanion.insert(
                id: id,
                wordId: wordId,
                reviewSessionId: reviewSessionId,
                questionType: questionType,
                isCorrect: isCorrect,
                rating: rating,
                previousStepIndex: previousStepIndex,
                newStepIndex: newStepIndex,
                reviewedAt: reviewedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReviewHistoryTable, ReviewHistoryEntry>(table),
                  $$ReviewHistoryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordId = false, reviewSessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (wordId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.wordId,
                                referencedTable: $$ReviewHistoryTableReferences
                                    ._wordIdTable(db),
                                referencedColumn: $$ReviewHistoryTableReferences
                                    ._wordIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (reviewSessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.reviewSessionId,
                                referencedTable: $$ReviewHistoryTableReferences
                                    ._reviewSessionIdTable(db),
                                referencedColumn: $$ReviewHistoryTableReferences
                                    ._reviewSessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReviewHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewHistoryTable,
      ReviewHistoryEntry,
      $$ReviewHistoryTableFilterComposer,
      $$ReviewHistoryTableOrderingComposer,
      $$ReviewHistoryTableAnnotationComposer,
      $$ReviewHistoryTableCreateCompanionBuilder,
      $$ReviewHistoryTableUpdateCompanionBuilder,
      (ReviewHistoryEntry, $$ReviewHistoryTableReferences),
      ReviewHistoryEntry,
      PrefetchHooks Function({bool wordId, bool reviewSessionId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$WordTagsTableTableManager get wordTags =>
      $$WordTagsTableTableManager(_db, _db.wordTags);
  $$ReviewSessionsTableTableManager get reviewSessions =>
      $$ReviewSessionsTableTableManager(_db, _db.reviewSessions);
  $$ReviewHistoryTableTableManager get reviewHistory =>
      $$ReviewHistoryTableTableManager(_db, _db.reviewHistory);
}
