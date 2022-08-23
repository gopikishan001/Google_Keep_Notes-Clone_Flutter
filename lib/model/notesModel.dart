class notes {
  int id;
  String noteString;
  bool pinned = false;
  bool deleted = false;
  int lastModifyD;
  int lastModifyM;
  int lastModifyY;

  notes(this.id, this.noteString, this.lastModifyD, this.lastModifyM,
      this.lastModifyY) {}
}
