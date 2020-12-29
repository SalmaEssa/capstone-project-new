
import 'package:axon/PODO/Membership.dart';
import 'package:axon/resources/strings.dart';
import 'package:get_it/get_it.dart';
import 'package:fly_networking/fly.dart';
import 'package:fly_networking/GraphQB/graph_qb.dart';

class   MemberShipService {
  Fly _fly;
    MemberShipService() {
    _fly = GetIt.instance<Fly<dynamic>>();
  }

  Future<List<Membership>> getMemberShip() async {
    Node node = Node(name: 'memberships',
       cols: [
      CodeStrings.descriptionColumn,
      CodeStrings.idColumn,
      CodeStrings.titleColumn,
    ]);
    Map results =
        await _fly.query([node], parsers: {'memberships': Membership.empty()});
   
    List<Membership> memberships = castDynamicToOffer(results['memberships']);
  
    return memberships;
  }

  List<Membership> castDynamicToOffer(List<dynamic> objs) {
    return objs
        .map((memberShip) => Membership.empty()
          ..id = memberShip.id
          ..title = memberShip.title
          ..description = memberShip.description)
        .toList();
  }
}

 

 

