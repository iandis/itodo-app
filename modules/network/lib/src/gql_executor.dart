import 'package:graphql/client.dart';
import 'package:meta/meta.dart';

import 'gql_client.dart';
import 'gql_parser.dart';
import 'gql_type.dart';

abstract class GQLExecutor<T> {
  const GQLExecutor({
    required GQLClient client,
    required GQLParser<T> parser,
  })  : _client = client,
        _parser = parser;

  final GQLClient _client;
  final GQLParser<T> _parser;

  FetchPolicy get _fetchPolicy => _parser.alwaysFetch
      ? FetchPolicy.networkOnly
      : FetchPolicy.cacheAndNetwork;

  @nonVirtual
  Future<T> execute(Map<String, dynamic> variables) async {
    final QueryResult result;

    if (_parser.type == GQLType.query) {
      final QueryOptions queryOptions = QueryOptions(
        document: gql(_parser.document),
        variables: variables,
        fetchPolicy: _fetchPolicy,
      );

      result = await _client.query(queryOptions);
    } else {
      final MutationOptions mutationOptions = MutationOptions(
        document: gql(_parser.document),
        variables: variables,
        fetchPolicy: _fetchPolicy,
      );

      result = await _client.mutate(mutationOptions);
    }

    if (result.hasException) {
      _parser.onError(result.exception!);
    }

    return _parser.parse(result.data!);
  }
}
