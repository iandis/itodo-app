import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

import 'gql_auth.dart';

abstract class GQLClient {
  factory GQLClient({
    required String baseUrl,
    required GQLAuth auth,
  }) = GQLClientImpl;

  String get baseUrl;
  GQLAuth get auth;

  Future<QueryResult> query(QueryOptions options);
  Future<QueryResult> mutate(MutationOptions options);
}

class GQLClientImpl implements GQLClient {
  GQLClientImpl({
    required this.baseUrl,
    required this.auth,
  }) {
    initClient();
  }

  @override
  final String baseUrl;
  @override
  final GQLAuth auth;

  @protected
  late final GraphQLClient graphQLClient;

  @protected
  void initClient() {
    final HttpLink httpLink = HttpLink(baseUrl);
    final AuthLink authLink = AuthLink(getToken: auth.getToken);

    final Link link = authLink.concat(httpLink);

    graphQLClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }

  @override
  Future<QueryResult> mutate(MutationOptions options) {
    return graphQLClient.mutate(options);
  }

  @override
  Future<QueryResult> query(QueryOptions options) {
    return graphQLClient.query(options);
  }
}
