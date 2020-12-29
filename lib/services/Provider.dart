import 'package:axon/PODO/ProviderType.dart';
import 'package:axon/resources/strings.dart';
import 'package:fly_networking/GraphQB/graph_qb.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';

class ProviderService {
  Fly _fly = GetIt.instance<Fly>();

  Future<List<ProviderType>> getAllProviderTypes() async {
    Node providerTypesNode = Node(
      name: CodeStrings.providerTypesNodeName,
      cols: [
        CodeStrings.idColumn,
        CodeStrings.nameColumn,
        CodeStrings.logoColumn,
      ],
    );

    Map result = await _fly.query([providerTypesNode],
        parsers: {providerTypesNode.name: ProviderType()});

    return result[providerTypesNode.name];
  }
}
