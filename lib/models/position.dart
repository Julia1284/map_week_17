import 'package:objectbox/objectbox.dart';

@Entity()
class Position {
  @Id()
  int id;

  double latitude;
  double longitude;
  Position({this.id = 0, required this.latitude, required this.longitude});
}
