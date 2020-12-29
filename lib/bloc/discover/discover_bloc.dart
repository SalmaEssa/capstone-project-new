import 'package:axon/PODO/DynamicSection.dart';
import 'package:axon/PODO/HotDeal.dart';
import 'package:axon/PODO/Offer.dart';
import 'package:axon/PODO/ProviderType.dart';
import 'package:axon/bloc/bloc.dart';
import 'package:axon/bloc/discover/bloc.dart';
import 'package:axon/services/Offer.dart';
import 'package:axon/services/Provider.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:axon/main_router.gr.dart';
import 'package:auto_route/auto_route.dart';
class DiscoverBloc extends BLoC<DiscoverEvent> {
  final PublishSubject<DiscoverState> discoverStateSubject = PublishSubject();

  final OfferService _offerService = GetIt.instance<OfferService>();
  final ProviderService _providerService = GetIt.instance<ProviderService>();

  @override
  void dispatch(DiscoverEvent event) async {
    if (event is HotDealsRequested) {
      _getHotDeals();
    }
    if (event is DynamicSectionRequested) {
      _getDynamicSection(event);
    } 
    if (event is ProviderTypesRequested) {
      _getProviderTypes();
    }
     if (event is GetFilterProviderType) {
      _getProviderTypesSearch(event.categoryId);
    }
  }

  Future<void> _getHotDeals() async {
    List<HotDeal> hotdeals = await _offerService.getHotDeals();
    discoverStateSubject.sink.add(HotDealsAre(hotdeals));
  }

  Future<void> _getDynamicSection(DynamicSectionRequested event) async {
    DynamicSection dynamicSections =
        await _offerService.getDynamicSection(event.sectionIndex);

    if (event.sectionIndex == 1)
      discoverStateSubject.sink
          .add(HorizontalDynamicSectionIs(dynamicSections));
    if (event.sectionIndex == 2)
      discoverStateSubject.sink.add(VerticalDynamicSectionIs(dynamicSections));
  }

  Future<void> _getProviderTypes() async {
    List<ProviderType> _providerTypes =
        await _providerService.getAllProviderTypes();
    discoverStateSubject.sink.add(ProviderTypesAre(_providerTypes));
  }
 Future<void> _getProviderTypesSearch(categoryId) async {
    await _offerService.setOfferFiltersByCtegory(categoryId);
     ExtendedNavigator.root.push(Routes.mainSearchScreen);
  }
  dispose() {
    discoverStateSubject.close();
  }
}
