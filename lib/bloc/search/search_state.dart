

import 'package:axon/PODO/Customer.dart';
import 'package:axon/PODO/Membership.dart';
import 'package:axon/PODO/Offer.dart';
import 'package:axon/PODO/ProviderType.dart';

abstract class SearchState {}



class OffersAre extends SearchState {
  List<Offer> offers;

  OffersAre(this.offers);
}

class InitialCategoryView extends SearchState {
  
}
class MyDataAre extends SearchState {
  Customer mydata;
List<Membership> memberShips;
String regionIdFilter;
String membershipFilter;
  MyDataAre(this.mydata,this.memberShips,this.regionIdFilter,this.membershipFilter);
}

class ProviderTypesCategoriesAre extends SearchState {
  List<ProviderType> providerTypers;
  ProviderTypesCategoriesAre(this.providerTypers);
}
class UpdateSelectedCategoryFromDiscovery extends SearchState {
  String providerTyperId;
  UpdateSelectedCategoryFromDiscovery(this.providerTyperId);
}