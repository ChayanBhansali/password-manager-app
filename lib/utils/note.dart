class Note {

  int? _uid;
  String? _platform;
  String? _username ;
  String? _password ;
  String? _time;

  Note(this._platform, this._password, this._time, this._username);

  Note.withId(this._uid, this._platform, this._password, this._time, this._username);

  int? get uid => _uid;

  String? get platform => _platform;

  String? get username => _username;

  String? get time => _time;

  String? get password => _password;

  set platform(String? newPlatform) {

      this._platform = newPlatform;

  }

  set username(String? newUsername) {

      this._username = newUsername;

  }

  set time(String? newTime) {

      this._time = newTime;

  }

  set password(String? newPassword) {
    this._password = newPassword;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (uid != null) {
      map['uid'] = _uid;
    }
    map['platform'] = _platform;
    map['username'] = _username;
    map['time'] = _time;
    map['password'] = _password;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._uid = map['uid'];
    this._platform = map['platform'];
    this._username = map['username'];
    this._time = map['time'];
    this._password = map['password'];
  }
}