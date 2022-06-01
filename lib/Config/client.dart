import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
class Config {
  static final HttpLink httpLink = HttpLink(
    'https://saved-turtle-14.hasura.app/v1/graphql',
    defaultHeaders: {"x-hasura-admin-secret":"4DJ2Q3xV4NdEySh3c0JF63n50VGcSSDe89mPQYsUt3Kz8ifxDKOT3296Da6br7P4"}
  );

  static ValueNotifier<GraphQLClient> initailizeClient() {
    ValueNotifier<GraphQLClient> client =
    ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: HiveStore()),
        link: httpLink,
      ),
    );
    return client;
  }
}