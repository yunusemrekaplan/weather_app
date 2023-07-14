class City {
  late String name;
  late String date;
  late String day;
  late String icon;
  late String description;
  late String status;
  late String degree;
  late String min;
  late String max;
  late String night;
  late String humidity;

  City({required this.name});

  void fromJson(Map json) {
    date = json['date'] ?? "Error";
    day = json['day'] ?? "Error";
    icon = json['icon'] ?? "Error";
    description = json['description'] ?? "Error";
    status = json['status'] ?? "Error";
    degree = json['degree'] ?? "Error";
    min = json['min'] ?? "Error";
    max = json['max'] ?? "Error";
    night = json['night'] ?? "Error";
    humidity = json['humidity'] ?? "Error";
  }
}