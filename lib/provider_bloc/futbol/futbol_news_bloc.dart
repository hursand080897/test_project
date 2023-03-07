import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:project/values/models.dart';

part 'futbol_news_event.dart';
part 'futbol_news_state.dart';

class FutbolNewsBloc extends Bloc<FutbolNewsEvent, FutbolNewsState> {
  FutbolNewsBloc() : super(FutbolNewsState()) {
    on<FutbolNewsEvent>(_incFetch);
  }
  _incFetch(FutbolNewsEvent event, Emitter<FutbolNewsState> emit) async {
    List<ModelFutbol> futbolNews = [];
    futbolNews.add(ModelFutbol(
        id: 1,
        name:
            '1. Спортивный директор «Оренбурга» рассказал о сроках возвращения Габриэля Флорентина',
        description: 'description',
        image: 'assets/images/1.webp'));
    futbolNews.add(ModelFutbol(
        id: 2,
        name:
            '2. Уникального российского футболиста притесняют в Европе. Из-за «неправильной» национальности?',
        description: 'description',
        image: 'assets/images/2.webp'));
    futbolNews.add(ModelFutbol(
        id: 3,
        name:
            '3. Гилерме заявил, что у него нет мыслей о завершении карьеры в сборной России',
        description: 'description',
        image: 'assets/images/3.webp'));
    futbolNews.add(ModelFutbol(
        id: 4,
        name:
            '4. Экс-игрок «Спартака» Пуцко рассказал, что Каррера в Хабаровске вручил ему медаль за чемпионство',
        description: 'description',
        image: 'assets/images/4.webp'));
    futbolNews.add(ModelFutbol(
        id: 5,
        name:
            '5. Фомин заявил, что свое ближайшее будущее связывает с «Динамо»',
        description: 'description',
        image: 'assets/images/5.webp'));
    futbolNews.add(ModelFutbol(
        id: 6,
        name:
            '6. Модрич в 37 лет получил вызов в сборную Хорватии на матчи отбора Евро-2024',
        description: 'description',
        image: 'assets/images/6.webp'));
    futbolNews.add(ModelFutbol(
        id: 7,
        name:
            '7. «У нас была неудачная серия с «Крыльями Советов» в Кубке, но вчера мы взяли свое» — Нгамале',
        description: 'description',
        image: 'assets/images/7.webp'));
    futbolNews.add(ModelFutbol(
        id: 8,
        name: '8. «Бердыев вернет Джорджевича на прежний уровень» — агент',
        description: 'description',
        image: 'assets/images/8.webp'));
    futbolNews.add(ModelFutbol(
        id: 9,
        name:
            '9. Спортивный директор «Оренбурга» рассказал, как клубу предлагали взять Дзюбу',
        description: 'description',
        image: 'assets/images/9.webp'));
    futbolNews.add(ModelFutbol(
        id: 10,
        name:
            '10. Гленн Бейл заявил, что не думает о получении российского гражданства',
        description: 'description',
        image: 'assets/images/10.webp'));
    emit(state.copyWith(listFutbol: futbolNews));
  }
}
