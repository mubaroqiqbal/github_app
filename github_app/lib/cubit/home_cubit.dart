import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:github_app/data/data_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final DataRepository _dataRepository;
  static int dataLength=0;

  HomeCubit(this._dataRepository) : super(HomeInitial());

  Future<void> getRepositories(String query, int page) async {
    try {
      if(page==1){
        emit(HomeLoading());
      }
      final data = await _dataRepository.getRepositories(query, page).catchError((errors){
        emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
      });

      if(page==1&&data.length<=0){
        emit(HomeEmptyData("Data Tidak Ditemukan"));
      }else{
        emit(HomeLoadedRepositories(data));
      }
    } on SocketException {
      emit(HomeError("Please Check Your Internet Or Try Again Later"));
    } on Exception catch(e){
      emit(HomeError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> getUsers(String query, int page) async {
    try {
      if(page==1){
        emit(HomeLoading());
      }
      final data = await _dataRepository.getUsers(query, page).catchError((errors){
        emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
      });

      if(page==1&&data.length<=0){
        emit(HomeEmptyData("Data Tidak Ditemukan"));
      }else{
        emit(HomeLoadedUsers(data));
      }
    } on GitHubError{
      emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
    } on SocketException {
      emit(HomeError("Please Check Your Internet Or Try Again Later"));
    } on Exception catch(e){
      emit(HomeError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> getIssues(String query, int page) async {
    try {
      if(page==1){
        emit(HomeLoading());
      }
      final data = await _dataRepository.getIssues(query, page).catchError((errors){
        emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
      });

      if(page==1&&data.length<=0){
        emit(HomeEmptyData("Data Tidak Ditemukan"));
      }else{
        emit(HomeLoadedIssues(data));
      }
      
    } on GitHubError{
      emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
    } on SocketException {
      emit(HomeError("Please Check Your Internet Or Try Again Later"));
    } on Exception catch(e){
      emit(HomeError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> getRepositoriesIndex(String query, int page) async {
    try {
      if(page==1){
        emit(HomeLoading());

        final data = await _dataRepository.getRepositoriesIndex(query, page).catchError((errors){
          emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
        });

        if(page==1&&data.length<=0){
          emit(HomeEmptyData("Data Tidak Ditemukan"));
        }else{
          dataLength=(data.length/30).ceil();
          emit(HomeLoadedRepositoriesIndex(data));
        }
      } else{
        emit(HomeLoading());

        final data = await _dataRepository.getRepositories(query, page).catchError((errors){
          emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
        });

        if(page==1&&data.length<=0){
          emit(HomeEmptyData("Data Tidak Ditemukan"));
        }else{
          emit(HomeLoadedRepositoriesIndex(data));
        }
      }
    } on SocketException {
      emit(HomeError("Please Check Your Internet Or Try Again Later"));
    } on Exception catch(e){
      emit(HomeError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> getUsersIndex(String query, int page) async {
    try {
      if(page==1){
        emit(HomeLoading());

        final data = await _dataRepository.getUsersIndex(query, page).catchError((errors){
          emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
        });

        if(page==1&&data.length<=0){
          emit(HomeEmptyData("Data Tidak Ditemukan"));
        }else{
          dataLength=(data.length/30).ceil();
          emit(HomeLoadedUsersIndex(data));
        }
      } else{
        emit(HomeLoading());

        final data = await _dataRepository.getUsers(query, page).catchError((errors){
          emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
        });

        if(page==1&&data.length<=0){
          emit(HomeEmptyData("Data Tidak Ditemukan"));
        }else{
          emit(HomeLoadedUsersIndex(data));
        }
      }
    } on GitHubError{
      emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
    } on SocketException {
      emit(HomeError("Please Check Your Internet Or Try Again Later"));
    } on Exception catch(e){
      emit(HomeError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> getIssuesIndex(String query, int page) async {
    try {
      if(page==1){
        emit(HomeLoading());

        final data = await _dataRepository.getIssuesIndex(query, page).catchError((errors){
          emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
        });

        if(page==1&&data.length<=0){
          emit(HomeEmptyData("Data Tidak Ditemukan"));
        }else{
          dataLength=(data.length/30).ceil();
          emit(HomeLoadedIssuesIndex(data));
        }
      } else{
        emit(HomeLoading());

        final data = await _dataRepository.getIssues(query, page).catchError((errors){
          emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
        });

        if(page==1&&data.length<=0){
          emit(HomeEmptyData("Data Tidak Ditemukan"));
        }else{
          emit(HomeLoadedIssuesIndex(data));
        }
      }

    } on GitHubError{
      emit(HomeError("Terjadi kesalahan, silahkan coba beberapa saat lagi"));
    } on SocketException {
      emit(HomeError("Please Check Your Internet Or Try Again Later"));
    } on Exception catch(e){
      emit(HomeError(e.toString().replaceFirst("Exception: ", "")));
    }
  }

  Future<void> finish() async{
    emit(HomeInitial());
  }

}