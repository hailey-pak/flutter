import 'dart:convert';

class Document {
  final Map<String, Object?> _json;

  Document() : _json = jsonDecode(documentJson);

  (String, {DateTime modified}) getMetadata() {
    var title = "My Document";
    var now = DateTime.now();

    return (title, modified: now);
  }

  (String, {DateTime modified}) getMetadata2() {
    if (_json.containsKey('metadata')) {
      var metadataJson = _json['metadata'];
      if (metadataJson is Map) {
        var title = metadataJson['title'] as String;
        var localModified = DateTime.parse(metadataJson['modified'] as String);
        return (title, modified: localModified);
      }
    }
    throw const FormatException('Unexpected JSON');
  }

  (String, {DateTime modified}) getMetadata3() {
    if (_json
        case {
          'metadata': {
            'title': String title,
            'modified': String localModified,
          }
        }) {
      return (title, modified: DateTime.parse(localModified));
    } else {
      throw const FormatException('Unexpected JSON');
    }
  }

  List<Block> getBlocks() {
    if (_json case {'blocks': List blocksJson}) {
      return <Block>[for (var blockJson in blocksJson) Block.fromJson(blockJson)];
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
}

sealed class Block {
  Block();

  factory Block.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'type': 'h1', 'text': String text } => HeaderBlock(text),
      {'type': 'p', 'text': String text } => ParagraphBlock(text),
      {'type': 'checkbox', 'text': String text, 'checked': bool checked} => CheckboxBlock(text, checked),
      _ => throw const FormatException('Unexpected JSON format'),
    };
  }
}


class HeaderBlock extends Block {
  final String text;
  HeaderBlock(this.text);
}

class ParagraphBlock extends Block {
  final String text;
  ParagraphBlock(this.text);
}

class CheckboxBlock extends Block {
  final String text;
  final bool isChecked;
  CheckboxBlock(this.text, this.isChecked);
}


const documentJson = ''' {
    "metadata" : {
      "title": "My document",
      "modified" : "2023-05-10"
    },
    "blocks" : [
      {
        "type" : "h1",
        "text" : "Chapter 1"
      },
      {
        "type": "p",
        "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
      },
      {
        "type": "checkbox",
        "checked": true,
        "text": "Learn Dart 3"
      }
    ]
  }
  ''';

