//Find a way to find a park give a name and an address should return a unique id

import 'package:uuid/uuid.dart';

String searchParc() {
  return const Uuid().v1();
}
