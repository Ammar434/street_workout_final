import '../geolocalisation/geolocalisation.dart';

class ChallengeServices {
  Geolocalisation geolocalisation = Geolocalisation();

  Future<String> checkDistanceBetweenUserAndPark(List userFavoriteParcs) async {
    for (String parcId in userFavoriteParcs) {
      bool isNearAPark = await geolocalisation.checkDistanceBetwweenUserAndPark(parcId);

      if (isNearAPark) {
        return parcId;
      }
    }
    return "f0750590-1d7a-11ed-b17e-f382a8462615";
    // return "";
  }
}
