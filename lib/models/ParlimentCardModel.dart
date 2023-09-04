class ParlimentCard {
  String Name;
  String id;
  String imgURL;
  String state;
  bool male;

  // Constructor
  ParlimentCard({required this.Name,required this.id,required this.imgURL,required this.male,required this.state});

  // toMap for Sembast storage - sembast stores data as JSON strings
  Map<String, dynamic> toMap() {
    return {
      'name': Name,
      'id':id,
      'imgURL':imgURL,
      'state':state,
      'male':male
    };
  }

  // From map, for sembast storage
  static ParlimentCard fromMap(Map<String, dynamic> map) {
    return ParlimentCard(
      Name: map['name'],
      id: map['id'],
      imgURL: map['imgURL'],
      male: map['male'],
      state:map['state'],
    );
  }
}