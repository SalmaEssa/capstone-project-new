import 'package:axon/PODO/City.dart';
import 'package:axon/PODO/Customer.dart';
import 'package:axon/PODO/Membership.dart';
import 'package:axon/PODO/Offer.dart';
import 'package:axon/PODO/ProviderType.dart';
import 'package:axon/bloc/search/search_event.dart';
import 'package:axon/bloc/search/search_state.dart';
import 'package:axon/resources/strings.dart';
import 'package:axon/services/CityRegionService.dart';
import 'package:axon/services/MemberShip.dart';
import 'package:axon/services/Offer.dart';
import 'package:axon/services/Provider.dart';
import 'package:axon/services/profile.dart';

import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:axon/bloc/bloc.dart';

class SearchBloc extends BLoC<SearchEvent> {
  final PublishSubject searchSubject = PublishSubject<SearchState>();
  final ProfileService _profileService = GetIt.instance<ProfileService>();
  final OfferService _offerService = GetIt.instance<OfferService>();
    final ProviderService _providerService = GetIt.instance<ProviderService>();
  final MemberShipService _memberShipService =
      GetIt.instance<MemberShipService>();
  List<City> cities;
  String regionIdFilter;
  String memebershipFilter;
  @override
  void dispatch(SearchEvent event) async {
    if (event is SearchByProviderNameOfOffer) {
      _getSearchByOfferNameAndProvider(event.query,event.categoryId);
    }
    if (event is FilterScreenLanch) {
      getProfileAndMemberShips();
    }
    if (event is LaunchMainSearchScreen) {
     _getProviderTypes();
    }

    if (event is FilterOfferByRegionAndMemberShip) {
      _getFilterOfferByRegionAndMemberShip(event.regionId, event.membership);
    }
    if(event is GetFilterWithCategory){
      _getOffersFilterByCategories(event.categoryId);
    }
  }

 void _getOffersFilterByCategories(query) async {
    List<Offer> offers =
        await _offerService.getOffersByProviderType(query);
    searchSubject.add(OffersAre(offers));
  }


Future<void> _getProviderTypes() async {
    List<ProviderType> _providerTypes =
        await _providerService.getAllProviderTypes();
    searchSubject.sink.add(ProviderTypesCategoriesAre(_providerTypes));
    String catId= _offerService.getOfferFiltersByCtegory();
    if(catId!=null){
         searchSubject.sink.add(UpdateSelectedCategoryFromDiscovery(catId));
      _getOffersFilterByCategories(catId);
      _offerService.setOfferFiltersByCtegory(null);
      
    }
    if(catId==null){
      searchSubject.sink.add(InitialCategoryView());
    }
  }
  void getProfileAndMemberShips() async {
    //Needs to replace null with current customer instance
    Customer myProfile = null;

    List<Membership> memberships = await _memberShipService.getMemberShip();

    searchSubject.add(
        MyDataAre(myProfile, memberships, regionIdFilter, memebershipFilter));
  }

  void _getSearchByOfferNameAndProvider(query,categoryId) async {
    List<Offer> offers =
        await _offerService.getSearchOffersByNameProviderAndNameOffer(query,categoryId);
    searchSubject.add(OffersAre(offers));
  }

  void _getFilterOfferByRegionAndMemberShip(regionId, membership) async {
    List<Offer> offers = await _offerService.getOffersByRegionsAndMembership(
        regionId: regionId, membership: membership);

    regionIdFilter = regionId;
    memebershipFilter = membership;
    if (membership == null) {
      memebershipFilter = AppStrings.noMemberships;
    }
   searchSubject.sink.add(UpdateSelectedCategoryFromDiscovery(CodeStrings.all));
    searchSubject.add(OffersAre(offers));
  }

  void dispose() {
    searchSubject.close();
  }
}
