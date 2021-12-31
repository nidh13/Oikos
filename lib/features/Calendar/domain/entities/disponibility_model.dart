class Disponibility {
  String id;
  String dateStart;
  String dateEnd;
  String title;
  String description;
  String dispotype;
  String userId;
  bool allDay;

  Disponibility(
      {this.id,
        this.dateStart,
        this.dateEnd,
        this.title,
        this.description,
        this.dispotype,
        this.userId,
        this.allDay});

  Disponibility.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateStart = json['dateStart'];
    dateEnd = json['dateEnd'];
    title = json['title'];
    description = json['description'];
    dispotype = json['dispotype'];
    userId = json['userId'];
    allDay = json['allDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateStart'] = this.dateStart;
    data['dateEnd'] = this.dateEnd;
    data['title'] = this.title;
    data['description'] = this.description;
    data['dispotype'] = this.dispotype;
    data['isAllDay'] = this.allDay;
    return data;
  }
}
