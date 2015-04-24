library script_inliner;

import 'package:barback/barback.dart' show Asset, Transform, Transformer;
import 'dart:async' show Future;
import 'package:html5lib/parser.dart' show parse;
import 'package:code_transformers/assets.dart' show uriToAssetId;

/// Finds script tags that have data-pub-inline attributes, and inlines
/// the contents. The src attribute URL must be reachable by pub's build
/// system.
class ScriptInliningTransformer extends Transformer {
  ScriptInliningTransformer.asPlugin();

  String get allowedExtensions => ".html";

  Future apply(Transform transform) {
    var id = transform.primaryInput.id;
    return transform.primaryInput.readAsString().then((content) {
      var document = parse(content);

      // attribute selectors don't work yet, do it manually
      var processing = document.querySelectorAll('script').where((tag) {
        return tag.attributes['data-pub-inline'] != null &&
               tag.attributes['src'] != null;
      }).map((tag) {
        var src = tag.attributes['src'];
        var srcAssetId = uriToAssetId(id, src, transform.logger, tag.sourceSpan);

        return transform.readInputAsString(srcAssetId).then((source) {
          tag.text = source;
          tag.attributes.remove('src');
          tag.attributes['data-pub-inline'] = src;
        });
      });

      return Future.wait(processing).then((_) {
        transform.addOutput(new Asset.fromString(id, document.outerHtml));
      });
    });
  }
}