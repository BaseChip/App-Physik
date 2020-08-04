import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:physik_lp_app_rewrite/core/util/shared_prefrences/shared_prefs_slider.dart';
import 'package:physik_lp_app_rewrite/features/notes/presentation/pages/markdown_editor/advanced_editor.dart';
import 'package:physik_lp_app_rewrite/features/notes/presentation/pages/note_viewer.dart';
import 'package:physik_lp_app_rewrite/features/notes/presentation/pages/notes_list_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/appinfo.dart';
import 'core/platform/networkinfo.dart';
import 'core/ui/pages/settings/settings_page.dart';
import 'core/util/input_converter.dart';
import 'core/util/shared_prefrences/shared_prefs_auth.dart';
import 'core/util/shared_prefrences/shared_prefs_rendering_engine.dart';
import 'core/util/shared_prefrences/shared_prefs_theme.dart';
import 'features/content/data/datasources/content_api.dart';
import 'features/content/data/repositories/content_repository_impl.dart';
import 'features/content/domain/repositories/content_repository.dart';
import 'features/content/domain/usecases/get_all_articels.dart';
import 'features/content/domain/usecases/get_all_topics.dart';
import 'features/content/domain/usecases/get_articel.dart';
import 'features/content/presentation/bloc/content_bloc.dart';
import 'features/login/data/datasources/user_api.dart';
import 'features/login/data/repositories/login_repository_impl.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/usecases/create_user.dart';
import 'features/login/domain/usecases/delete_user.dart';
import 'features/login/domain/usecases/login.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/notes/data/datasources/note_api.dart';
import 'features/notes/data/repositories/note_repository_impl.dart';
import 'features/notes/domain/repositories/note_repository.dart';
import 'features/notes/domain/usecases/add_note.dart';
import 'features/notes/domain/usecases/change_note.dart';
import 'features/notes/domain/usecases/delete_note.dart';
import 'features/notes/domain/usecases/get_all_notes.dart';
import 'features/notes/domain/usecases/get_note.dart';
import 'features/notes/presentation/bloc/notes_bloc.dart';
import 'features/plot/data/datasources/Plot_api.dart';
import 'features/plot/data/repositories/plot_repository_impl.dart';
import 'features/plot/domain/repositories/plot_repository.dart';
import 'features/plot/domain/usecases/get_beugungsmuster_plot.dart';
import 'features/plot/presentation/bloc/beugungsmuster_plot_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  initFeatures();
  //! Core
  initCore();
  //! External services
  // http client
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  // packageInfo
  final _packageinfo = await PackageInfo.fromPlatform();
  sl.registerLazySingleton(() => _packageinfo);
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

void initCore() {
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<AppInfo>(() => AppInfoImpl(sl()));
}

//! FEATURES INITS
void initFeatures() {
  //! Content
  initContent();
  //! Plot
  initFeaturePlot();
  //! Settings Page
  initFeatureSettingsPage();
  //! Login
  initLogin();
  //! Notizen
  initNotes();
  //! Slider
  initSlider();
}

void initContent() {
  // Bloc
  sl.registerFactory(() =>
      ContentBloc(getAllArticels: sl(), getAllTopics: sl(), getArticel: sl()));
  // Repository
  sl.registerLazySingleton<ContentRepository>(
      () => ContentRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  // Use Cases
  sl.registerLazySingleton(() => GetAllTopics(sl()));
  sl.registerLazySingleton(() => GetAllArticels(repository: sl()));
  sl.registerLazySingleton(() => GetArticel(repository: sl()));
  // Data sources
  sl.registerLazySingleton<ContentApi>(() => ContentApiImpl(client: sl()));
}

void initFeatureSettingsPage() {
  sl.registerLazySingleton(() => SettingsPage(
        appInfo: sl(),
      ));
  sl.registerLazySingleton(() => SharedPrefsTheme(prefs: sl()));
  sl.registerLazySingleton(() => SharedPrefsRenderingEngine(prefs: sl()));
}

void initFeaturePlot() {
  // Bloc
  sl.registerFactory(
    () => BeugungsmusterPlotBloc(
      plot: sl(),
      inputConverter: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetBeugungsmusterPlot(sl()));
  //Repository
  sl.registerLazySingleton<PlotRepository>(
      () => PlotRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  // Data sources
  sl.registerLazySingleton<PlotApi>(() => PlotApiImpl(client: sl()));
}

Future<void> initLogin() {
  // Bloc
  sl.registerFactory(
      () => LoginBloc(login: sl(), createUser: sl(), deleteUser: sl()));
  // Repository
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  // Use Cases
  sl.registerLazySingleton(() => Login(repository: sl()));
  sl.registerLazySingleton(() => CreateUser(repository: sl()));
  sl.registerLazySingleton(() => DeleteUser(repository: sl()));
  // Data sources
  sl.registerLazySingleton<UserApi>(() => UserApiImpl(client: sl()));
  //Shared Prefs
  sl.registerLazySingleton(() => SharedPrefsAuth(prefs: sl()));
}

Future<void> initNotes() {
  // Bloc
  sl.registerFactory(() => NotesBloc(
      addNote: sl(),
      changeNote: sl(),
      deleteNote: sl(),
      getAllNotes: sl(),
      getNote: sl()));
  // Repository
  sl.registerLazySingleton<NoteRepository>(
      () => NoteRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  // Use Cases
  sl.registerLazySingleton(() => AddNote(repository: sl()));
  sl.registerLazySingleton(() => ChangeNote(repository: sl()));
  sl.registerLazySingleton(() => DeleteNote(repository: sl()));
  sl.registerLazySingleton(() => GetAllNotes(repository: sl()));
  sl.registerLazySingleton(() => GetNote(repository: sl()));
  // Data sources
  sl.registerLazySingleton<NoteApi>(() => NoteApiImpl(client: sl()));
  // Pages
  sl.registerLazySingleton(() => AdvancedMarkDownEditor());
}

void initSlider() {
  sl.registerLazySingleton(() => SharedPrefsSlider(prefs: sl()));
}
