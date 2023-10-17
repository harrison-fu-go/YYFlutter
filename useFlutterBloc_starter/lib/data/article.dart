///
///
/// Copyright (c) 2022 Razeware LLC
/// Permission is hereby granted, free of charge, to any person
/// obtaining a copy of this software and associated documentation
/// files (the "Software"), to deal in the Software without
/// restriction, including without limitation the rights to use,
/// copy, modify, merge, publish, distribute, sublicense, and/or
/// sell copies of the Software, and to permit persons to whom
/// the Software is furnished to do so, subject to the following
/// conditions:

/// The above copyright notice and this permission notice shall be
/// included in all copies or substantial portions of the Software.

/// Notwithstanding the foregoing, you may not use, copy, modify,
/// merge, publish, distribute, sublicense, create a derivative work,
/// and/or sell copies of the Software in any work that is designed,
/// intended, or marketed for pedagogical or instructional purposes
/// related to programming, coding, application development, or
/// information technology. Permission for such use, copying,
/// modification, merger, publication, distribution, sublicensing,
/// creation of derivative works, or sale is expressly withheld.

/// This project and source code may use libraries or frameworks
/// that are released under various Open-Source licenses. Use of
/// those libraries and frameworks are governed by their own
/// individual licenses.

/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
/// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
/// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
/// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
/// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
/// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
/// DEALINGS IN THE SOFTWARE.
///
///

// ignore_for_file: non_constant_identifier_names

class Article {
  late final String id;
  late final String? type;
  late final Attributes? attributes;
  late final Links? links;

  Article.fromJson(dynamic json)
      : id = json['id'],
        type = json['type'],
        attributes = Attributes.fromJson(json['attributes']),
        links = Links.fromJson(json['links']);
}

class Attributes {
  late final String? uri;
  late final String? name;
  late final String? description;
  late final String? released_at;
  late final bool? free;
  late final String? difficulty;
  late final String? content_type;
  late final int duration;
  late final double? popularity;
  late final String? technology_triple_string;
  late final String? contributor_string;
  late final String? ordinal;
  late final bool? professional;
  late final String? description_plain_text;
  late final int? video_identifier;
  late final int? parent_name;
  late final bool? accessible;
  late final String? card_artwork_url;

  Attributes.fromJson(Map json)
      : uri = json['uri'],
        name = json['name'],
        description = json['description'],
        released_at = json['released_at'],
        free = json['free'],
        difficulty = json['difficulty'],
        content_type = json['content_type'],
        duration = json['duration'],
        popularity = json['popularity'],
        technology_triple_string = json['technology_triple_string'],
        contributor_string = json['contributor_string'],
        ordinal = json['ordinal'],
        professional = json['professional'],
        description_plain_text = json['description_plain_text'],
        video_identifier = json['video_identifier'],
        parent_name = json['parent_name'],
        accessible = json['accessible'],
        card_artwork_url = json['card_artwork_url'];
}

class Links {
  late final String? self;

  Links.fromJson(Map json) : self = json['self'];
}
