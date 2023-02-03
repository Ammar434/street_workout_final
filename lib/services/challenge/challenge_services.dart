import 'package:street_workout_final/services/geolocalisation/geolocalisation.dart';

class ChallengeServices {
  Geolocalisation geolocalisation = Geolocalisation();

  Future<String> checkDistanceBetweenUserAndPark(List userFavoriteParcs) async {
    for (String parcId in userFavoriteParcs) {
      bool isNearAPark = await geolocalisation.checkDistanceBetwweenUserAndPark(parcId);

      if (isNearAPark) {
        return parcId;
      }
    }
    return "";
  }
}
