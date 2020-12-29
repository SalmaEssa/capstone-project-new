import 'package:axon/PODO/Branch.dart';
import 'package:axon/PODO/Offer.dart';
import 'package:axon/bloc/bloc.dart';
import 'package:axon/bloc/offer_details/bloc.dart';
import 'package:axon/services/Offer.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class OfferDetailsBloc extends BLoC<OfferDetailsEvent> {
  final PublishSubject<OfferDetailsState> offerDetailsStateSubject =
      PublishSubject();

  final OfferService _offerService = GetIt.instance<OfferService>();

  @override
  void dispatch(OfferDetailsEvent event) async {
    if (event is OfferDetailsRequested) {
      _getOffer(event);
    }
    if (event is OfferpProviderBranchesRequested) {
      _getOfferProviderBranches(event);
    }
  }

  Future<void> _getOffer(OfferDetailsRequested event) async {
    final Offer offer = await _offerService.getOffer(event.id);

    offerDetailsStateSubject.sink.add(OfferIs(offer));
  }

  Future<void> _getOfferProviderBranches(
      OfferpProviderBranchesRequested event) async {
    final List<Branch> branches =
        await _offerService.getProviderBranches(event.id);

    offerDetailsStateSubject.sink.add(OfferProviderBranchesAre(branches));
  }

  void dispose() {
    offerDetailsStateSubject.close();
  }
}
