import 'package:axon/PODO/Branch.dart';
import 'package:axon/PODO/Offer.dart';

abstract class OfferDetailsState {}

class OfferIs extends OfferDetailsState {
  Offer offer;
  OfferIs(this.offer);
}

class OfferProviderBranchesAre extends OfferDetailsState {
  List<Branch> branches;
  OfferProviderBranchesAre(this.branches);
}
