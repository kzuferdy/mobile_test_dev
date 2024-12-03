import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_test_dev/models/user.dart';
import 'package:mobile_test_dev/services/api_services.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;

  UserBloc({ApiService? apiService})
      : apiService = apiService ?? ApiService(),
        super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  void _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final users = await apiService.fetchUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
