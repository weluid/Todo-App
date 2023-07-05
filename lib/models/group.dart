

class Group {
  String id;
  String groupName;

  Group({
    required this.id,
    required this.groupName,
  });

  @override
  String toString() {
    return 'Group{id: $id, groupName: $groupName}';
  }
}
