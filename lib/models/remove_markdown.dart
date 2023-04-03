String removeMarkdownSyntax(String markdownText) {
  RegExp exp = RegExp(
      r'(\*\*|__)(.*?)\1|(\*|_)(.*?)\3|(`{1,3})(.*?)\5|!\[.*?\]\(.*?\)|\[.*?\]\(.*?\)',
      multiLine: true,
      caseSensitive: true);
  return markdownText.replaceAll(exp, '').trim();
}
