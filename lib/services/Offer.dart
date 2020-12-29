import 'package:axon/PODO/Branch.dart';
import 'package:axon/PODO/Customer.dart';
import 'package:axon/PODO/DynamicSection.dart';
import 'package:axon/PODO/HotDeal.dart';
import 'package:axon/PODO/Offer.dart';
import 'package:axon/resources/strings.dart';
import 'package:fly_networking/GraphQB/graph_qb.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';

class OfferService {
  Fly _fly;
  String providerTypeUpdatedId;
  OfferService() {
    _fly = GetIt.instance<Fly<dynamic>>();
  }

  setOfferFiltersByCtegory(categoryid) {
    providerTypeUpdatedId = categoryid;
  }

  String getOfferFiltersByCtegory() {
    return providerTypeUpdatedId;
  }

  Future<List<Offer>> getOffersByRegionsAndMembership(
      {String regionId, String membership}) async {
    List<dynamic> cols = [
      CodeStrings.idColumn,
      CodeStrings.imageLinkColumn,
      CodeStrings.nameColumn,
      CodeStrings.priceColumn,
      CodeStrings.axonPriceColumn,
      CodeStrings.hotdealColumn,
      Node(
        name: CodeStrings.providerColumn,
        cols: [
          CodeStrings.idColumn,
          CodeStrings.nameColumn,
          CodeStrings.logoLinkColumn,
          Node(
            name: CodeStrings.providerTypeColumn,
            cols: [CodeStrings.nameColumn],
          )
        ],
      ),
      Node(
        name: CodeStrings.membershipsColumn,
        cols: [
          CodeStrings.idColumn,
          CodeStrings.titleColumn,
        ],
      ),
    ];
    Map<String, dynamic> argm = {
      "where": {"column": "_REGION_ID", "value": regionId},
      "orderBy": {"field": "_CREATED_AT", "order": "_DESC"}
    };

    if (membership != CodeStrings.all) {
      argm["hasMemberships"] = {
        "column": "_TITLE",
        "operator": "_EQ",
        "value": membership,
      };
    }

    Node node = Node(name: CodeStrings.offersList, args: argm, cols: cols);
    Map results =
        await _fly.query([node], parsers: {CodeStrings.offersList: Offer()});

    List<Offer> offersList = results[CodeStrings.offersList];

    return offersList;
  }

  Future<List<Offer>> getSearchOffersByNameProviderAndNameOffer(
      String value, String categoryId) async {
    List<String> newvalue;
    if ((value == null) && categoryId == null) {
      return getAllOffers();
    }
    if (value.contains(" ")) {
      String str1 = '%' + value.split(" ")[0] + '%';
      String str2 = '%' + value.split(" ")[1] + '%';
      newvalue = [str1, str2];

      List<Offer> totalOffers = [];
      if (categoryId != null) {
        List<Offer> listOfferByProviderName =
            await getOffersByNameProvider(newvalue);
        listOfferByProviderName.forEach((element) {
          totalOffers.add(element);
        });
      }

      List<Offer> listOfferByOfferName =
          await getOffersByName(newvalue, categoryId);
      listOfferByOfferName.forEach((element) {
        totalOffers.add(element);
      });

      return totalOffers;
    }
    List<Offer> totalOffers = [];
    if (categoryId != null) {
      List<Offer> listOfferByProviderName =
          await getOffersByNameProvider("%" + value + "%");

      listOfferByProviderName.forEach((element) {
        totalOffers.add(element);
      });
    }
    List<Offer> listOfferByOfferName =
        await getOffersByName("%" + value + "%", categoryId);
    listOfferByOfferName.forEach((element) {
      totalOffers.add(element);
    });

    return totalOffers;
  }

  Future<List<Offer>> getAllOffers() async {
    Node node = Node(name: CodeStrings.offersList, cols: [
      CodeStrings.idColumn,
      CodeStrings.imageLinkColumn,
      CodeStrings.nameColumn,
      CodeStrings.priceColumn,
      CodeStrings.axonPriceColumn,
      CodeStrings.hotdealColumn,
      Node(
        name: CodeStrings.providerColumn,
        cols: [
          CodeStrings.idColumn,
          CodeStrings.nameColumn,
          CodeStrings.logoLinkColumn,
          Node(
            name: CodeStrings.providerTypeColumn,
            cols: [CodeStrings.nameColumn],
          )
        ],
      ),
      Node(
        name: CodeStrings.membershipsColumn,
        cols: [
          CodeStrings.idColumn,
          CodeStrings.titleColumn,
        ],
      ),
    ]);
    Map results =
        await _fly.query([node], parsers: {CodeStrings.offersList: Offer()});

    List<Offer> offersList = results[CodeStrings.offersList];

    return offersList;
  }

  Future<List<Offer>> getOffersByNameProvider(value) async {
    Node node = Node(name: CodeStrings.offersList, args: {
      "hasProvider": {
        "column": "_NAME",
        "operator": "_LIKE",
        "value": value,
      },
    }, cols: [
      CodeStrings.idColumn,
      CodeStrings.imageLinkColumn,
      CodeStrings.nameColumn,
      CodeStrings.priceColumn,
      CodeStrings.axonPriceColumn,
      CodeStrings.hotdealColumn,
      Node(
        name: CodeStrings.providerColumn,
        cols: [
          CodeStrings.idColumn,
          CodeStrings.nameColumn,
          CodeStrings.logoLinkColumn,
          Node(
            name: CodeStrings.providerTypeColumn,
            cols: [CodeStrings.nameColumn],
          )
        ],
      ),
      Node(
        name: CodeStrings.membershipsColumn,
        cols: [
          CodeStrings.idColumn,
          CodeStrings.titleColumn,
        ],
      ),
    ]);
    Map results =
        await _fly.query([node], parsers: {CodeStrings.offersList: Offer()});

    List<Offer> offersList = results[CodeStrings.offersList];

    return offersList;
  }

  Future<List<Offer>> getOffersByName(value, categoryId) async {
    if (categoryId == null) {
      Node node = Node(name: CodeStrings.offersList, args: {
        "where": {
          "column": "_NAME",
          "operator": "_LIKE",
          "value": value,
        },
      }, cols: [
        CodeStrings.idColumn,
        CodeStrings.imageLinkColumn,
        CodeStrings.nameColumn,
        CodeStrings.priceColumn,
        CodeStrings.axonPriceColumn,
        CodeStrings.hotdealColumn,
        Node(
          name: CodeStrings.providerColumn,
          cols: [
            CodeStrings.idColumn,
            CodeStrings.nameColumn,
            CodeStrings.logoLinkColumn,
            Node(
              name: CodeStrings.providerTypeColumn,
              cols: [CodeStrings.nameColumn],
            )
          ],
        ),
        Node(
          name: CodeStrings.membershipsColumn,
          cols: [
            CodeStrings.idColumn,
            CodeStrings.titleColumn,
          ],
        ),
      ]);
      Map results =
          await _fly.query([node], parsers: {CodeStrings.offersList: Offer()});

      List<Offer> offersList = results[CodeStrings.offersList];

      return offersList;
    }

    Node node = Node(name: CodeStrings.offersList, args: {
      "where": {
        "column": "_NAME",
        "operator": "_LIKE",
        "value": value,
      },
      "hasProvider": {
        "column": "_PROVIDER_TYPE_ID",
        "operator": "_EQ",
        "value": categoryId,
      },
    }, cols: [
      CodeStrings.idColumn,
      CodeStrings.imageLinkColumn,
      CodeStrings.nameColumn,
      CodeStrings.priceColumn,
      CodeStrings.axonPriceColumn,
      CodeStrings.hotdealColumn,
      Node(
        name: CodeStrings.providerColumn,
        cols: [
          CodeStrings.idColumn,
          CodeStrings.nameColumn,
          CodeStrings.logoLinkColumn,
          Node(
            name: CodeStrings.providerTypeColumn,
            cols: [CodeStrings.nameColumn],
          )
        ],
      ),
      Node(
        name: CodeStrings.membershipsColumn,
        cols: [
          CodeStrings.idColumn,
          CodeStrings.titleColumn,
        ],
      ),
    ]);
    Map results =
        await _fly.query([node], parsers: {CodeStrings.offersList: Offer()});

    List<Offer> offersList = results[CodeStrings.offersList];

    return offersList;
  }

  Future<List<HotDeal>> getHotDeals() async {
    Node hotDealsNode = Node(
      name: CodeStrings.hotDealsNodeName,
      cols: [
        CodeStrings.idColumn,
        CodeStrings.photoColumn,
        Node(
          name: CodeStrings.offerColumn,
          cols: [
            CodeStrings.idColumn,
            CodeStrings.nameColumn,
            CodeStrings.descriptionColumn,
            CodeStrings.priceColumn,
            CodeStrings.dueDateColumn,
            CodeStrings.hotdealColumn,
            Node(
              name: CodeStrings.regionColumn,
              cols: [
                CodeStrings.idColumn,
                CodeStrings.nameColumn,
              ],
            )
          ],
        )
      ],
    );

    Map result = await _fly
        .query([hotDealsNode], parsers: {hotDealsNode.name: HotDeal()});

    return result[hotDealsNode.name];
  }

  Future<Offer> getOffer(String id) async {
    Node offersNode = Node(
      name: CodeStrings.offerNode,
      args: {CodeStrings.idColumn: id},
      cols: [
        CodeStrings.idColumn,
        CodeStrings.imageLinkColumn,
        CodeStrings.nameColumn,
        CodeStrings.descriptionColumn,
        CodeStrings.dueDateColumn,
        CodeStrings.priceColumn,
        CodeStrings.axonPriceColumn,
        CodeStrings.hotdealColumn,
        Node(
          name: CodeStrings.branchesColumn,
          cols: [CodeStrings.idColumn],
        ),
        Node(
          name: CodeStrings.providerColumn,
          cols: [
            CodeStrings.idColumn,
            CodeStrings.nameColumn,
            CodeStrings.logoLinkColumn,
            Node(
              name: CodeStrings.providerTypeColumn,
              cols: [CodeStrings.nameColumn],
            )
          ],
        ),
        Node(
          name: CodeStrings.membershipsColumn,
          cols: [
            CodeStrings.idColumn,
            CodeStrings.titleColumn,
            CodeStrings.isPayedColumn,
          ],
        ),
      ],
    );

    Map result =
        await _fly.query([offersNode], parsers: {offersNode.name: Offer()});

    return result[offersNode.name];
  }

  Future<DynamicSection> getDynamicSection(int sectionIndex) async {
    final Node _offerNode = Node(
      name: CodeStrings.offersColumn,
      cols: [
        CodeStrings.idColumn,
        CodeStrings.imageLinkColumn,
        CodeStrings.nameColumn,
        CodeStrings.priceColumn,
        CodeStrings.axonPriceColumn,
        CodeStrings.hotdealColumn,
        Node(
          name: CodeStrings.providerColumn,
          cols: [
            CodeStrings.idColumn,
            CodeStrings.nameColumn,
            CodeStrings.logoLinkColumn,
            Node(
              name: CodeStrings.providerTypeColumn,
              cols: [CodeStrings.nameColumn],
            )
          ],
        ),
        Node(
          name: CodeStrings.membershipsColumn,
          cols: [
            CodeStrings.idColumn,
            CodeStrings.titleColumn,
          ],
        ),
      ],
    );

    final Node _dynamicSectionsNode = Node(
      name: CodeStrings.dynamicSectionsNodeName,
      cols: [
        CodeStrings.idColumn,
        CodeStrings.nameColumn,
        _offerNode,
      ],
    );

    Map result = await _fly.query([_dynamicSectionsNode],
        parsers: {_dynamicSectionsNode.name: DynamicSection.empty()});
    return result[_dynamicSectionsNode.name][sectionIndex - 1];
  }

  Future<List<Branch>> getProviderBranches(String offerId) async {
    Node offersNode = Node(
      name: CodeStrings.offerNode,
      args: {CodeStrings.idColumn: offerId},
      cols: [
        CodeStrings.idColumn,
        Node(
          name: CodeStrings.branchesColumn,
          cols: [
            CodeStrings.idColumn,
            CodeStrings.nameColumn,
            CodeStrings.manulaAdressColumn,
            CodeStrings.googleLocationColumn,
          ],
        ),
      ],
    );

    Map result =
        await _fly.query([offersNode], parsers: {offersNode.name: Offer()});

    return (result[offersNode.name] as Offer).branches;
  }

  Future<List<Offer>> getOffersByProviderType(value) async {
    Node node = Node(name: CodeStrings.offersList, args: {
      "hasProvider": {
        "column": "_PROVIDER_TYPE_ID",
        "operator": "_EQ",
        "value": value,
      },
    }, cols: [
      CodeStrings.idColumn,
      CodeStrings.imageLinkColumn,
      CodeStrings.nameColumn,
      CodeStrings.priceColumn,
      CodeStrings.axonPriceColumn,
      CodeStrings.hotdealColumn,
      Node(
        name: CodeStrings.providerColumn,
        cols: [
          CodeStrings.idColumn,
          CodeStrings.nameColumn,
          CodeStrings.logoLinkColumn,
          Node(
            name: CodeStrings.providerTypeColumn,
            cols: [CodeStrings.nameColumn],
          )
        ],
      ),
      Node(
        name: CodeStrings.membershipsColumn,
        cols: [
          CodeStrings.idColumn,
          CodeStrings.titleColumn,
        ],
      ),
    ]);
    Map results =
        await _fly.query([node], parsers: {CodeStrings.offersList: Offer()});

    List<Offer> offersList = results[CodeStrings.offersList];

    return offersList;
  }
}
