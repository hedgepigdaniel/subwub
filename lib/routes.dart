enum Routes {
  home("/"),
  welcome("/welcome"),
  search("/search"),
  userAccounts("/users"),
  addUserAccount("/users/add");

  const Routes(this.path);

  final String path;
}
