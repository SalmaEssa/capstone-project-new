import 'package:axon/PODO/City.dart';
import 'package:get_it/get_it.dart';
import 'package:fly_networking/fly.dart';
import 'package:fly_networking/GraphQB/graph_qb.dart';

class CityRegionService {
  List<City> cities;
  Fly _fly;
  CityRegionService() {
    _fly = GetIt.instance<Fly<dynamic>>();
  }

  List cityCols = [
    'id',
    'name',
    Node(name: 'regions', cols: [
      "id",
      "name",
    ])
  ];

  Future<List<City>> getCities() async {
    if (cities != null) return cities;
    Node nodeCities = Node(name: "Cities", cols: cityCols);
    Map results =
        await _fly.query([nodeCities], parsers: {'Cities': City.empty()});

    cities = castDynamicToCity(results['Cities']);
    // cities.forEach((city) {
    //   print(city.name);
    // });

    return cities;
  }

  List<City> castDynamicToCity(List<dynamic> objs) {
    return objs
        .map((city) => City.empty()
          ..id = city.id
          ..name = city.name
          ..regions = city.regions)
        .toList();
  }
}
