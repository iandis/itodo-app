import 'package:network/network.dart';

class TodoDeleteRequest extends GQLExecutor<bool> {
  const TodoDeleteRequest(GQLClient client)
      : super(
          client: client,
          parser: const _TodoDeleteParser(),
        );
}

class _TodoDeleteParser extends GQLParser<bool> {
  const _TodoDeleteParser();

  @override
  String get document => r'''
    mutation todoDelete($id: String!) {
      todoDelete(todoDeleteInput: { id: $id }) {
        success
      }
    }
  ''';

  @override
  GQLType get type => GQLType.mutation;

  @override
  bool parse(Map<String, dynamic> json) {
    final Map<String, dynamic> result =
        json['todoDelete'] as Map<String, dynamic>;

    final bool success = result['success'] as bool;
    return success;
  }
}
