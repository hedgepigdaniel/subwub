enum Routes {
  home("/"),
  search("/search"),
  userAccounts("/users"),
  addUserAccount("/users/add"),

  welcome("welcome");

  const Routes(this.path);

  final String path;
}
