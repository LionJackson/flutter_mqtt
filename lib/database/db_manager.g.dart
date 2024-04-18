// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_manager.dart';

// ignore_for_file: type=lint
class $ContactsTable extends Contacts
    with TableInfo<$ContactsTable, ContactsEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nickNameMeta =
      const VerificationMeta('nickName');
  @override
  late final GeneratedColumn<String> nickName = GeneratedColumn<String>(
      'nick_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<DateTime> createTime = GeneratedColumn<DateTime>(
      'create_time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, userId, nickName, createTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<ContactsEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('nick_name')) {
      context.handle(_nickNameMeta,
          nickName.isAcceptableOrUnknown(data['nick_name']!, _nickNameMeta));
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ContactsEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactsEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      nickName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nick_name']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_time'])!,
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class ContactsEntity extends DataClass implements Insertable<ContactsEntity> {
  final String id;
  final String? userId;
  final String? nickName;
  final DateTime createTime;
  const ContactsEntity(
      {required this.id, this.userId, this.nickName, required this.createTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || nickName != null) {
      map['nick_name'] = Variable<String>(nickName);
    }
    map['create_time'] = Variable<DateTime>(createTime);
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      nickName: nickName == null && nullToAbsent
          ? const Value.absent()
          : Value(nickName),
      createTime: Value(createTime),
    );
  }

  factory ContactsEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactsEntity(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      nickName: serializer.fromJson<String?>(json['nickName']),
      createTime: serializer.fromJson<DateTime>(json['createTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'nickName': serializer.toJson<String?>(nickName),
      'createTime': serializer.toJson<DateTime>(createTime),
    };
  }

  ContactsEntity copyWith(
          {String? id,
          Value<String?> userId = const Value.absent(),
          Value<String?> nickName = const Value.absent(),
          DateTime? createTime}) =>
      ContactsEntity(
        id: id ?? this.id,
        userId: userId.present ? userId.value : this.userId,
        nickName: nickName.present ? nickName.value : this.nickName,
        createTime: createTime ?? this.createTime,
      );
  @override
  String toString() {
    return (StringBuffer('ContactsEntity(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('createTime: $createTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, nickName, createTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactsEntity &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.nickName == this.nickName &&
          other.createTime == this.createTime);
}

class ContactsCompanion extends UpdateCompanion<ContactsEntity> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<String?> nickName;
  final Value<DateTime> createTime;
  final Value<int> rowid;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.nickName = const Value.absent(),
    this.createTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.nickName = const Value.absent(),
    this.createTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<ContactsEntity> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? nickName,
    Expression<DateTime>? createTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (nickName != null) 'nick_name': nickName,
      if (createTime != null) 'create_time': createTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContactsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? userId,
      Value<String?>? nickName,
      Value<DateTime>? createTime,
      Value<int>? rowid}) {
    return ContactsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nickName: nickName ?? this.nickName,
      createTime: createTime ?? this.createTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (nickName.present) {
      map['nick_name'] = Variable<String>(nickName.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('createTime: $createTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessageTable extends Message
    with TableInfo<$MessageTable, MessageEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nickNameMeta =
      const VerificationMeta('nickName');
  @override
  late final GeneratedColumn<String> nickName = GeneratedColumn<String>(
      'nick_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<DateTime> createTime = GeneratedColumn<DateTime>(
      'create_time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, userId, nickName, createTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message';
  @override
  VerificationContext validateIntegrity(Insertable<MessageEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('nick_name')) {
      context.handle(_nickNameMeta,
          nickName.isAcceptableOrUnknown(data['nick_name']!, _nickNameMeta));
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MessageEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      nickName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nick_name']),
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_time'])!,
    );
  }

  @override
  $MessageTable createAlias(String alias) {
    return $MessageTable(attachedDatabase, alias);
  }
}

class MessageEntity extends DataClass implements Insertable<MessageEntity> {
  final String id;
  final String? userId;
  final String? nickName;
  final DateTime createTime;
  const MessageEntity(
      {required this.id, this.userId, this.nickName, required this.createTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || nickName != null) {
      map['nick_name'] = Variable<String>(nickName);
    }
    map['create_time'] = Variable<DateTime>(createTime);
    return map;
  }

  MessageCompanion toCompanion(bool nullToAbsent) {
    return MessageCompanion(
      id: Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      nickName: nickName == null && nullToAbsent
          ? const Value.absent()
          : Value(nickName),
      createTime: Value(createTime),
    );
  }

  factory MessageEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageEntity(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      nickName: serializer.fromJson<String?>(json['nickName']),
      createTime: serializer.fromJson<DateTime>(json['createTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'nickName': serializer.toJson<String?>(nickName),
      'createTime': serializer.toJson<DateTime>(createTime),
    };
  }

  MessageEntity copyWith(
          {String? id,
          Value<String?> userId = const Value.absent(),
          Value<String?> nickName = const Value.absent(),
          DateTime? createTime}) =>
      MessageEntity(
        id: id ?? this.id,
        userId: userId.present ? userId.value : this.userId,
        nickName: nickName.present ? nickName.value : this.nickName,
        createTime: createTime ?? this.createTime,
      );
  @override
  String toString() {
    return (StringBuffer('MessageEntity(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('createTime: $createTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, nickName, createTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageEntity &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.nickName == this.nickName &&
          other.createTime == this.createTime);
}

class MessageCompanion extends UpdateCompanion<MessageEntity> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<String?> nickName;
  final Value<DateTime> createTime;
  final Value<int> rowid;
  const MessageCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.nickName = const Value.absent(),
    this.createTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessageCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.nickName = const Value.absent(),
    this.createTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<MessageEntity> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? nickName,
    Expression<DateTime>? createTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (nickName != null) 'nick_name': nickName,
      if (createTime != null) 'create_time': createTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessageCompanion copyWith(
      {Value<String>? id,
      Value<String?>? userId,
      Value<String?>? nickName,
      Value<DateTime>? createTime,
      Value<int>? rowid}) {
    return MessageCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      nickName: nickName ?? this.nickName,
      createTime: createTime ?? this.createTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (nickName.present) {
      map['nick_name'] = Variable<String>(nickName.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('createTime: $createTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessageRowTable extends MessageRow
    with TableInfo<$MessageRowTable, MessageRowEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageRowTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: () => const Uuid().v4());
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<String> chatId = GeneratedColumn<String>(
      'chat_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nickNameMeta =
      const VerificationMeta('nickName');
  @override
  late final GeneratedColumn<String> nickName = GeneratedColumn<String>(
      'nick_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
      'data', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _topicMeta = const VerificationMeta('topic');
  @override
  late final GeneratedColumn<String> topic = GeneratedColumn<String>(
      'topic', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _messageIdMeta =
      const VerificationMeta('messageId');
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
      'message_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES message (id)'));
  static const VerificationMeta _createTimeMeta =
      const VerificationMeta('createTime');
  @override
  late final GeneratedColumn<DateTime> createTime = GeneratedColumn<DateTime>(
      'create_time', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _timeMillMeta =
      const VerificationMeta('timeMill');
  @override
  late final GeneratedColumn<DateTime> timeMill = GeneratedColumn<DateTime>(
      'time_mill', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        chatId,
        userId,
        nickName,
        data,
        topic,
        messageId,
        createTime,
        timeMill
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_row';
  @override
  VerificationContext validateIntegrity(Insertable<MessageRowEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('nick_name')) {
      context.handle(_nickNameMeta,
          nickName.isAcceptableOrUnknown(data['nick_name']!, _nickNameMeta));
    }
    if (data.containsKey('data')) {
      context.handle(
          _dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    }
    if (data.containsKey('topic')) {
      context.handle(
          _topicMeta, topic.isAcceptableOrUnknown(data['topic']!, _topicMeta));
    }
    if (data.containsKey('message_id')) {
      context.handle(_messageIdMeta,
          messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta));
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
          _createTimeMeta,
          createTime.isAcceptableOrUnknown(
              data['create_time']!, _createTimeMeta));
    }
    if (data.containsKey('time_mill')) {
      context.handle(_timeMillMeta,
          timeMill.isAcceptableOrUnknown(data['time_mill']!, _timeMillMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  MessageRowEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageRowEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}chat_id']),
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      nickName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nick_name']),
      data: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data']),
      topic: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}topic']),
      messageId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message_id'])!,
      createTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_time'])!,
      timeMill: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time_mill']),
    );
  }

  @override
  $MessageRowTable createAlias(String alias) {
    return $MessageRowTable(attachedDatabase, alias);
  }
}

class MessageRowEntity extends DataClass
    implements Insertable<MessageRowEntity> {
  final String id;
  final String? chatId;
  final String? userId;
  final String? nickName;
  final String? data;
  final String? topic;
  final String messageId;
  final DateTime createTime;
  final DateTime? timeMill;
  const MessageRowEntity(
      {required this.id,
      this.chatId,
      this.userId,
      this.nickName,
      this.data,
      this.topic,
      required this.messageId,
      required this.createTime,
      this.timeMill});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || chatId != null) {
      map['chat_id'] = Variable<String>(chatId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || nickName != null) {
      map['nick_name'] = Variable<String>(nickName);
    }
    if (!nullToAbsent || data != null) {
      map['data'] = Variable<String>(data);
    }
    if (!nullToAbsent || topic != null) {
      map['topic'] = Variable<String>(topic);
    }
    map['message_id'] = Variable<String>(messageId);
    map['create_time'] = Variable<DateTime>(createTime);
    if (!nullToAbsent || timeMill != null) {
      map['time_mill'] = Variable<DateTime>(timeMill);
    }
    return map;
  }

  MessageRowCompanion toCompanion(bool nullToAbsent) {
    return MessageRowCompanion(
      id: Value(id),
      chatId:
          chatId == null && nullToAbsent ? const Value.absent() : Value(chatId),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      nickName: nickName == null && nullToAbsent
          ? const Value.absent()
          : Value(nickName),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
      topic:
          topic == null && nullToAbsent ? const Value.absent() : Value(topic),
      messageId: Value(messageId),
      createTime: Value(createTime),
      timeMill: timeMill == null && nullToAbsent
          ? const Value.absent()
          : Value(timeMill),
    );
  }

  factory MessageRowEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageRowEntity(
      id: serializer.fromJson<String>(json['id']),
      chatId: serializer.fromJson<String?>(json['chatId']),
      userId: serializer.fromJson<String?>(json['userId']),
      nickName: serializer.fromJson<String?>(json['nickName']),
      data: serializer.fromJson<String?>(json['data']),
      topic: serializer.fromJson<String?>(json['topic']),
      messageId: serializer.fromJson<String>(json['messageId']),
      createTime: serializer.fromJson<DateTime>(json['createTime']),
      timeMill: serializer.fromJson<DateTime?>(json['timeMill']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'chatId': serializer.toJson<String?>(chatId),
      'userId': serializer.toJson<String?>(userId),
      'nickName': serializer.toJson<String?>(nickName),
      'data': serializer.toJson<String?>(data),
      'topic': serializer.toJson<String?>(topic),
      'messageId': serializer.toJson<String>(messageId),
      'createTime': serializer.toJson<DateTime>(createTime),
      'timeMill': serializer.toJson<DateTime?>(timeMill),
    };
  }

  MessageRowEntity copyWith(
          {String? id,
          Value<String?> chatId = const Value.absent(),
          Value<String?> userId = const Value.absent(),
          Value<String?> nickName = const Value.absent(),
          Value<String?> data = const Value.absent(),
          Value<String?> topic = const Value.absent(),
          String? messageId,
          DateTime? createTime,
          Value<DateTime?> timeMill = const Value.absent()}) =>
      MessageRowEntity(
        id: id ?? this.id,
        chatId: chatId.present ? chatId.value : this.chatId,
        userId: userId.present ? userId.value : this.userId,
        nickName: nickName.present ? nickName.value : this.nickName,
        data: data.present ? data.value : this.data,
        topic: topic.present ? topic.value : this.topic,
        messageId: messageId ?? this.messageId,
        createTime: createTime ?? this.createTime,
        timeMill: timeMill.present ? timeMill.value : this.timeMill,
      );
  @override
  String toString() {
    return (StringBuffer('MessageRowEntity(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('data: $data, ')
          ..write('topic: $topic, ')
          ..write('messageId: $messageId, ')
          ..write('createTime: $createTime, ')
          ..write('timeMill: $timeMill')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, chatId, userId, nickName, data, topic,
      messageId, createTime, timeMill);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageRowEntity &&
          other.id == this.id &&
          other.chatId == this.chatId &&
          other.userId == this.userId &&
          other.nickName == this.nickName &&
          other.data == this.data &&
          other.topic == this.topic &&
          other.messageId == this.messageId &&
          other.createTime == this.createTime &&
          other.timeMill == this.timeMill);
}

class MessageRowCompanion extends UpdateCompanion<MessageRowEntity> {
  final Value<String> id;
  final Value<String?> chatId;
  final Value<String?> userId;
  final Value<String?> nickName;
  final Value<String?> data;
  final Value<String?> topic;
  final Value<String> messageId;
  final Value<DateTime> createTime;
  final Value<DateTime?> timeMill;
  final Value<int> rowid;
  const MessageRowCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.userId = const Value.absent(),
    this.nickName = const Value.absent(),
    this.data = const Value.absent(),
    this.topic = const Value.absent(),
    this.messageId = const Value.absent(),
    this.createTime = const Value.absent(),
    this.timeMill = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessageRowCompanion.insert({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.userId = const Value.absent(),
    this.nickName = const Value.absent(),
    this.data = const Value.absent(),
    this.topic = const Value.absent(),
    required String messageId,
    this.createTime = const Value.absent(),
    this.timeMill = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : messageId = Value(messageId);
  static Insertable<MessageRowEntity> custom({
    Expression<String>? id,
    Expression<String>? chatId,
    Expression<String>? userId,
    Expression<String>? nickName,
    Expression<String>? data,
    Expression<String>? topic,
    Expression<String>? messageId,
    Expression<DateTime>? createTime,
    Expression<DateTime>? timeMill,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatId != null) 'chat_id': chatId,
      if (userId != null) 'user_id': userId,
      if (nickName != null) 'nick_name': nickName,
      if (data != null) 'data': data,
      if (topic != null) 'topic': topic,
      if (messageId != null) 'message_id': messageId,
      if (createTime != null) 'create_time': createTime,
      if (timeMill != null) 'time_mill': timeMill,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessageRowCompanion copyWith(
      {Value<String>? id,
      Value<String?>? chatId,
      Value<String?>? userId,
      Value<String?>? nickName,
      Value<String?>? data,
      Value<String?>? topic,
      Value<String>? messageId,
      Value<DateTime>? createTime,
      Value<DateTime?>? timeMill,
      Value<int>? rowid}) {
    return MessageRowCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      userId: userId ?? this.userId,
      nickName: nickName ?? this.nickName,
      data: data ?? this.data,
      topic: topic ?? this.topic,
      messageId: messageId ?? this.messageId,
      createTime: createTime ?? this.createTime,
      timeMill: timeMill ?? this.timeMill,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<String>(chatId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (nickName.present) {
      map['nick_name'] = Variable<String>(nickName.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (topic.present) {
      map['topic'] = Variable<String>(topic.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    if (timeMill.present) {
      map['time_mill'] = Variable<DateTime>(timeMill.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageRowCompanion(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('userId: $userId, ')
          ..write('nickName: $nickName, ')
          ..write('data: $data, ')
          ..write('topic: $topic, ')
          ..write('messageId: $messageId, ')
          ..write('createTime: $createTime, ')
          ..write('timeMill: $timeMill, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DBManager extends GeneratedDatabase {
  _$DBManager(QueryExecutor e) : super(e);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $MessageTable message = $MessageTable(this);
  late final $MessageRowTable messageRow = $MessageRowTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [contacts, message, messageRow];
}
