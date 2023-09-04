class States {
  String Name;

  // Constructor
  States({required this.Name});

  // toMap for Sembast storage - sembast stores data as JSON strings
  Map<String, dynamic> toMap() {
    return {
      'name': Name,
    };
  }

  // From map, for sembast storage
  static States fromMap(Map<String, dynamic> map) {
    return States(
      Name: map['name'],
    );
  }
}