enum Routes {
  home("/"),
  search("/search"),
  userAccounts("/users"),
  addUserAccount("/users/add");

  const Routes(this.path);

  final String path;
}
