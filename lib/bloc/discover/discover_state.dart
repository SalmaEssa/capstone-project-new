import 'package:axon/PODO/DynamicSection.dart';
import 'package:axon/PODO/HotDeal.dart';
import 'package:axon/PODO/ProviderType.dart';

abstract class DiscoverState {}

class HotDealsAre extends DiscoverState {
  List<HotDeal> hotDeals;
  HotDealsAre(this.hotDeals);
}

class HorizontalDynamicSectionIs extends DiscoverState {
  DynamicSection dynamicSection;
  HorizontalDynamicSectionIs(this.dynamicSection);
}

class VerticalDynamicSectionIs extends DiscoverState {
  DynamicSection dynamicSection;
  VerticalDynamicSectionIs(this.dynamicSection);
}

class ProviderTypesAre extends DiscoverState {
  List<ProviderType> providerTypers;
  ProviderTypesAre(this.providerTypers);
}
