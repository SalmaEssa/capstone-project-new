abstract class OfferDetailsEvent {}

class OfferDetailsRequested extends OfferDetailsEvent {
  String id;
  OfferDetailsRequested(this.id);
}

class OfferpProviderBranchesRequested extends OfferDetailsEvent {
  String id;
  OfferpProviderBranchesRequested(this.id);
}
