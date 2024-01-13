import 'package:flutter/material.dart';

class HighlightText {
  List<TextSpan> highlight(
      {required String source,
      required String query,
      required TextStyle styleSource,
      required TextStyle styleQuery}) {
    if (query == null || query.isEmpty) {
      return [
        TextSpan(
          text: source,
          style: styleSource,
        )
      ];
    }

    var matches = <Match>[];
    for (final token in query.trim().toLowerCase().split(' ')) {
      matches.addAll(token.allMatches(source.toLowerCase()));
    }

    if (matches.isEmpty) {
      return [
        TextSpan(
          text: source,
          style: styleSource,
        )
      ];
    }
    matches.sort((a, b) => a.start.compareTo(b.start));

    int lastMatchEnd = 0;
    final List<TextSpan> children = [];
    for (final match in matches) {
      if (match.end <= lastMatchEnd) {
      } else if (match.start <= lastMatchEnd) {
        children.add(
          TextSpan(
            text: source.substring(lastMatchEnd, match.end),
            style: styleQuery,
          ),
        );
      } else if (match.start > lastMatchEnd) {
        children.add(
          TextSpan(
            text: source.substring(lastMatchEnd, match.start),
            style: styleSource,
          ),
        );

        children.add(
          TextSpan(
            text: source.substring(match.start, match.end),
            style: styleQuery,
          ),
        );
      }

      if (lastMatchEnd < match.end) {
        lastMatchEnd = match.end;
      }
    }

    if (lastMatchEnd < source.length) {
      children.add(
        TextSpan(
          text: source.substring(lastMatchEnd, source.length),
          style: styleSource,
        ),
      );
    }

    return children;
  }
}
