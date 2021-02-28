part of 'home_cubit.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoadedRepositories extends HomeState {

  final List<Repository> responseRepositories;

  const HomeLoadedRepositories(this.responseRepositories);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeLoadedRepositories && o.responseRepositories == responseRepositories;
  }

  @override
  int get hashCode => responseRepositories.hashCode;
}

class HomeLoadedUsers extends HomeState {

  final List<User> responseUsers;

  const HomeLoadedUsers(this.responseUsers);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeLoadedUsers && o.responseUsers == responseUsers;
  }

  @override
  int get hashCode => responseUsers.hashCode;
}

class HomeLoadedIssues extends HomeState {
  final List<Issue> responseIssue;

  const HomeLoadedIssues(this.responseIssue);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeLoadedIssues && o.responseIssue == responseIssue;
  }

  @override
  int get hashCode => responseIssue.hashCode;
}

class HomeLoadedRepositoriesIndex extends HomeState {

  List<Repository> responseRepositories;

  HomeLoadedRepositoriesIndex(List<Repository> responseRepositories){
    this.responseRepositories=new List<Repository>();
    this.responseRepositories.addAll(responseRepositories);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeLoadedRepositoriesIndex && o.responseRepositories == responseRepositories;
  }

  @override
  int get hashCode => responseRepositories.hashCode;
}

class HomeLoadedUsersIndex extends HomeState {

  List<User> responseUsers;

  HomeLoadedUsersIndex(List<User> responseUsers){
    this.responseUsers=new List<User>();
    this.responseUsers.addAll(responseUsers);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeLoadedUsersIndex && o.responseUsers == responseUsers;
  }

  @override
  int get hashCode => responseUsers.hashCode;
}

class HomeLoadedIssuesIndex extends HomeState {
  List<Issue> responseIssue;

  HomeLoadedIssuesIndex(List<Issue> responseIssue){
    this.responseIssue=new List<Issue>();
    this.responseIssue.addAll(responseIssue);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeLoadedIssuesIndex && o.responseIssue == responseIssue;
  }

  @override
  int get hashCode => responseIssue.hashCode;
}

class HomeError extends HomeState {

  final String message;
  const HomeError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class HomeEmptyData extends HomeState {

  final String message;
  const HomeEmptyData(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeEmptyData && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}