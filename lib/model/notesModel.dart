class notesModel {
  int id;
  String noteString;
  int pinned;
  int deleted;
  int lastModifyD;
  int lastModifyM;
  int lastModifyY;

  // notesModel(
  //     {id,
  //     noteString,
  //     pinned,
  //     deleted,
  //     lastModifyD,
  //     lastModifyM,
  //     lastModifyY}) {
  //   this.id = id;
  //   this.noteString = noteString;
  //   this.pinned = pinned;
  //   this.deleted = deleted;
  //   this.lastModifyD = lastModifyD;
  //   this.lastModifyM = lastModifyM;
  //   this.lastModifyY = lastModifyY;
  // }

  notesModel({
    this.id = 4004,
    this.noteString = "noteString",
    this.pinned = 0,
    this.deleted = 0,
    this.lastModifyD = 0,
    this.lastModifyM = 0,
    this.lastModifyY = 0,
  });
}
