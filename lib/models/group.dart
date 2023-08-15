class Group {
  int id;
  String groupName;

  Group({
    required this.id,
    required this.groupName,
  });

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
