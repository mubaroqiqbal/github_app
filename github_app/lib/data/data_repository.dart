import 'package:flutter/cupertino.dart';
import 'package:github/github.dart';

class DataRepository {

  static DataRepository _dataRepository;

  var github = GitHub();

  DataRepository();

  static DataRepository getRepository() {
    if (_dataRepository != null) {
      return _dataRepository;
    } else {
      _dataRepository = DataRepository();
      return _dataRepository;
    }
  }

  Future<List<Repository>> getRepositories(String query, int page) async {
    try {
      final response = await github.search.repositories(query, pages: page).handleError((errors){
        return null;
      });

      return response.toList();
    } on RateLimitHit {
      return null;
    } on GitHubError{
      return null;
    }
  }

  Future<List<User>> getUsers(String query, int page) async {
    try {

      final response = await github.search.users(query, pages: page).handleError((errors){
        return github.handleStatusCode(errors);
      });

      if(response!=null){
        return response.toList();
      }else{
        return null;
      }
    } on RateLimitHit {
      return null;
    } on GitHubError{
      return null;
    }
  }

  Future<List<Issue>> getIssues(String query, int page) async {
    try {
      final response = github.search.issues(query, pages: page).handleError((errors){
        return null;
      });

      return response.toList();
    } on RateLimitHit {
      return null;
    } on GitHubError{
      return null;
    }
  }

  Future<List<Repository>> getRepositoriesIndex(String query, int page) async {
    try {
      final response = await github.search.repositories(query).handleError((errors){
        return null;
      });

      return response.toList();
    } on RateLimitHit {
      return null;
    } on GitHubError{
      return null;
    }
  }

  Future<List<User>> getUsersIndex(String query, int page) async {
    try {

      final response = await github.search.users(query).handleError((errors){
        return github.handleStatusCode(errors);
      });

      if(response!=null){
        return response.toList();
      }else{
        return null;
      }
    } on RateLimitHit {
      return null;
    } on GitHubError{
      return null;
    }
  }

  Future<List<Issue>> getIssuesIndex(String query, int page) async {
    try {
      final response = github.search.issues(query).handleError((errors){
        return null;
      });

      return response.toList();
    } on RateLimitHit {
      return null;
    } on GitHubError{
      return null;
    }
  }
}
