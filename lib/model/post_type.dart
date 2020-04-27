/// Post types
enum PostTypes {
  videos,
  faq,
  slider,
  faqCategories,
  detailStats,
  protocol
}

class PostType {
  final PostTypes postTypes;

  PostType(this.postTypes);

  String getRequestType() {
    switch (postTypes) {
      case PostTypes.slider:
        return '/slider';
      case PostTypes.faqCategories:
        return '/appfaqs';
      case PostTypes.faq:
        return '/faqs';
      case PostTypes.videos:
        return '/videos';
      case PostTypes.detailStats:
        return '/detailstats';
      case PostTypes.protocol:
        return '/protocol';
      default:
        return '';
    }
  }
}
