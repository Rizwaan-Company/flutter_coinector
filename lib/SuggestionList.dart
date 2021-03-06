import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'AddPlaceTagSearchDelegate.dart';
import 'SearchDemoSearchDelegate.dart';
import 'SuggestionMatch.dart';

class SuggestionList extends StatelessWidget {
  const SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  String addSeparator(String input) {
    return input != null && input.isNotEmpty ? " - " + input : "";
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext ctx) {
    final ThemeData theme = Theme.of(ctx);
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final SuggestionMatch match =
            SuggestionMatch.parseString(suggestions[i], i);
        final String searchMatch = capitalize(match.searchMatch);
        final String state = addSeparator(match.state);
        final String continent = addSeparator(match.continent);
        return ListTile(
          leading: query.isEmpty
              ? match.fileName.isEmpty
                  ? !isRealSuggestion(searchMatch, ctx)
                      ? null
                      : const Icon(Icons.history)
                  : const Icon(Icons.location_searching)
              : null,
          title: RichText(
            text: TextSpan(
              text: (isRealSuggestion(searchMatch, ctx))
                  ? searchMatch.isNotEmpty
                      ? searchMatch.substring(0, query.trim().length)
                      : searchMatch
                  : searchMatch,
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: (isRealSuggestion(searchMatch, ctx))
                      ? searchMatch.isNotEmpty
                          ? searchMatch.substring(query.trim().length)
                          : ''
                      : '',
                  style: theme.textTheme.subhead,
                ),
                TextSpan(
                  text: state,
                  style: theme.textTheme.subhead
                      .copyWith(color: Colors.white.withOpacity(0.5)),
                ),
                TextSpan(
                  text: continent,
                  style: theme.textTheme.subhead
                      .copyWith(color: Colors.white.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          onTap: () {
            if (isRealSuggestion(searchMatch, context)) {
              onSelected(match.input);
            }
          },
        );
      },
    );
  }

  bool isRealSuggestion(String suggestion, ctx) {
    return SearchDemoSearchDelegate.TRY_ANOTHER_WORD != suggestion &&
        FlutterI18n.translate(ctx, "you_can_scroll") != suggestion &&
        AddPlaceTagSearchDelegate.COINECTOR_SUPPORTS_MANY_LANGUAGES !=
            suggestion;
  }
}
