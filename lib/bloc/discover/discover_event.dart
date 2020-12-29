abstract class DiscoverEvent {}

class HotDealsRequested extends DiscoverEvent {}

class DynamicSectionRequested extends DiscoverEvent {
  int sectionIndex;
  DynamicSectionRequested(this.sectionIndex);
}

class ProviderTypesRequested extends DiscoverEvent {}
class GetFilterProviderType extends DiscoverEvent {
String categoryId;
GetFilterProviderType(this.categoryId);
}