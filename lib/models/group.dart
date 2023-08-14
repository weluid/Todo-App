class Group {
  int id;
  String groupName;

  Group({
    required this.id,
    required this.groupName,
  });

  Group copy({
    int? id,
    String? groupName,
  }) =>
      Group(id: id ?? this.id, groupName: groupName ?? this.groupName);

  @override
  String toString() {
    return 'Group{id: $id, groupName: $groupName}';
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'groupName': groupName,
    };
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      groupName: json['groupName'],
    );
  }
}
