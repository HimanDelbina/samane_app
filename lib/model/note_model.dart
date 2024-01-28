
class Note {

  int? _id;
  String? _firstName;
  String? _lastName;

	Note(this._firstName, this._lastName);

	Note.withId(this._id, this._firstName, this._lastName);

	int get id => _id!;

	String get firstName => _firstName!;

	String get lastName => _lastName!;


	set firstName(String newfirstName) {
		if (newfirstName.length <= 255) {
			this._firstName = newfirstName;
		}
	}
	set lastName(String newlastName) {
		if (newlastName.length <= 255) {
			this._lastName = newlastName;
		}
	}

	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['firstName'] = _firstName;
		map['lastName'] = _lastName;

		return map;
	}

	// Extract a Note object from a Map object
	Note.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._firstName = map['firstName'];
		this._lastName = map['lastName'];
	}
}