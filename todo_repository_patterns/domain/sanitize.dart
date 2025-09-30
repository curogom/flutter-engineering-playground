class ValidatorUseCases {
  static String text(String text) {
    return text.trim();
  }

  static String email(String email) {
    return email.trim().toLowerCase();
  }

  static String password(String password) {
    return password.trim();
  }

  static String slugify(String input) {
    // 소문자로 변환하고 영숫자가 아닌 문자를 하이픈으로 교체
    final nonAlphanumeric = RegExp(r'[^a-z0-9\s-]');
    final normalized = input.toLowerCase().replaceAll(nonAlphanumeric, '-');

    // 공백과 하이픈을 제거하고, 여러 개의 연속된 하이픈을 교체
    final trimmed = normalized.trim().replaceAll(RegExp(r'-{2,}'), '-');

    // 필요에 따라 나머지 공백을 하이픈으로 변환
    final hyphenatedSpaces = trimmed.replaceAll(' ', '-');

    return hyphenatedSpaces;
  }
}
