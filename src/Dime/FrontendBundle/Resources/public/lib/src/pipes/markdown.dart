import 'package:angular/angular.dart';
import 'package:markdown/markdown.dart' as markdown;

@Pipe('markdown')
class MarkdownPipe implements PipeTransform {
  String transform(String input) => markdown.markdownToHtml(input);
}
