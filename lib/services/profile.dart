import 'package:axon/PODO/City.dart';
import 'package:axon/PODO/Customer.dart';
import 'package:axon/PODO/Region.dart';
import 'package:fly_networking/GraphQB/graph_qb.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'CityRegionService.dart';

class ProfileService {
  final Fly _fly = GetIt.instance<Fly<dynamic>>();
  Customer custumer;
  List<Region> regions = [];
  List<City> cities = [];
  City city;
  Region region;
  final CityRegionService _cityRegionService =
      GetIt.instance<CityRegionService>();

  /// called from completeprofile;
  Future<void> setCeties() async {
    //  regions = r;
    cities = await _cityRegionService.getCities();
    print("caties areee");
    print(cities);
  }

  void setRegions(String selectedcity) {
    regions = city.regions;
  }

  void setCitie(String selectedCity) {
    city = cities.firstWhere((element) => element.name == selectedCity);
  }

  void setRegion(String selectedreg) {
    region = regions.firstWhere((element) => element.name == selectedreg);
  }

  Future<Customer> getCustomer() async {
    print("hereeee the custimer");
    if (custumer != null) {
      return custumer;
    }
    Node custumerCurrent = Node(name: "myCustomer ", cols: [
      'id',
      "name",
      "email",
      "phone",
      'status',
      'birthdate',
      Node(name: 'region', cols: [
        'id',
        'name_ar',
        'name',
        Node(name: 'city', cols: [
          'id',
          'name',
          'name_ar',
        ])
      ]),
      Node(name: 'city', cols: [
        'id',
        'name_ar',
        'name',
      ])
      //'city',
      //'region'
      //'photo'
    ]);
    print("try to get result");
    dynamic results = await _fly
        .query([custumerCurrent], parsers: {'myCustomer': Customer.empty()});
    print("hereeee the custimer22222222222");

    custumer = results['myCustomer'];
    print(custumer);
    return custumer;
  }

  Future<Customer> completeCustomerProfile(
      String name, String email, DateTime birthday, String c, String r) async {
    await setCeties();
    setCitie(c);
    setRegions(c);
    setRegion(r);
    print("hereeee the edit custimer11111");
    print(region.name);
    print(city.name);
    //print(birthday.toIso8601String());
    //print(region);
    Node custumerCurrent = Node(name: 'updateCustomer', args: {
      'id': custumer.id,
      "name": name,
      "email": email,
      "input": {
        'city': {'connect': city.id},
        'region': {'connect': region.id}
      },
      "birthdate": '${DateFormat("yyy-MM-dd").format(birthday)}',
      'status': "_COMPLETED"
    }, cols: [
      'id',

      "name",
      "email",
      "phone",
      'status',
      'birthdate',
      Node(name: 'region', cols: [
        'id',
        'name_ar',
        'name',
        Node(name: 'city', cols: [
          'id',
          'name',
          'name_ar',
        ]),
      ]),
      Node(name: 'city', cols: [
        'id',
        'name_ar',
        'name',
      ])
      //'city',
      //'photo'
    ]);
    print("fly . mutation");
    var results = await _fly.mutation([custumerCurrent],
        parsers: {"updateCustomer": Customer.empty()});

    print("hereeee the custimer22222222222");

    custumer = results["updateCustomer"];
    print(custumer);
    return custumer;
  }

  Future<Customer> editCustomerProfile(
      String name, String email, DateTime birthday, String c, String r) async {
    print(c);
    print(r);
    await setCeties();
    setCitie(c);
    setRegions(c);
    setRegion(r);
    print("hereeee the edit custimer");
    print(region.name);
    print(city.name);

    //print(email);
    //print(birthday.toIso8601String());
    // print(region);
    Node custumerCurrent = Node(name: 'updateCustomer', args: {
      'id': custumer.id,
      "name": name,
      "email": email,
      "input": {
        'city': {'connect': city.id},
        'region': {'connect': region.id},
      },
      //  "local": region,
      "birthdate": '${DateFormat("yyy-MM-dd").format(birthday)}'
      // 'status': "_COMPLETED"
    }, cols: [
      'id',

      "name",
      "email",
      "phone",
      'status',
      'birthdate',
      Node(name: 'region', cols: [
        'id',
        'name_ar',
        'name',
        Node(name: 'city', cols: ['id', 'name', 'name_ar'])
      ]),
      Node(name: 'city', cols: [
        'id',
        'name_ar',
        'name',
      ]),
      //'city',
      //'photo'
    ]);
    print("fly . mutation");
    var results = await _fly.mutation([custumerCurrent],
        parsers: {"updateCustomer": Customer.empty()});

    print("hereeee the custimer22222222222");

    custumer = results["updateCustomer"];
    print(custumer);
    return custumer;
  }
}
