class Post{
  Map postsJson;

  Post(this.postsJson);

  int get id => postsJson['id'];
  String get title => postsJson['title'];
  String get body => postsJson['body'];
}