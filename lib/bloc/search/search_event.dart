abstract class SearchEvent {}

class SearchByNameOfOffer extends SearchEvent{
String query;
SearchByNameOfOffer(this.query);}
class SearchByProviderNameOfOffer extends SearchEvent{
String query;
String categoryId;
SearchByProviderNameOfOffer(this.query,this.categoryId);}

class FilterScreenLanch extends SearchEvent{}

class FilterOfferByRegionAndMemberShip extends SearchEvent{
String regionId;
String membership;
FilterOfferByRegionAndMemberShip(this.regionId,this.membership);}
class LaunchMainSearchScreen extends SearchEvent {}

class GetFilterWithCategory extends SearchEvent{
String categoryId;

GetFilterWithCategory(this.categoryId,);}