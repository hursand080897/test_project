import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:sport/values/models.dart';

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
            'WOUT OF ORDER Man Utd fans left FUMING after what Wout Weghorst did in Anfield tunnel before Liverpool clash and want striker SACKED',
        description:
            'WOUT WEGHORST has sparked fury among Manchester United fans after touching the Liverpool badge ahead of kick-off.It is tradition for Liverpool players to touch the This is Anfield sign above the tunnel exit ahead of kick-off.Most Liverpool players perform the ritual before every game but it is unusual for away players to do the same. It is particularly strange for a player from a rival club to pay tribute in such a manner, which is why United fans are raging with Weghorst. One supporter claimed the strikers attitude meant United had "lost the game before it even started".Another fan fumed: "Sack him - NOW!!"',
        image: 'assets/images/1.webp'));
    futbolNews.add(ModelFutbol(
        id: 2,
        name:
            'SCOT IT ALL England hoping to convince Newcastle star Elliott Anderson to switch international allegiance back from rivals Scotland',
        description:
            'ENGLAND hope to convince Newcastle whizkid Elliot Anderson to switch from Scotland.Anderson, 20, was born in Whitley Bay in North Tyneside but has one cap for Scotland at Under-21 level.But he previously represented the country of his birth at Under-19 level.And now England would like him to play for them again for the Under-21s.Should he be persuaded, Anderson would not be allowed to play for the Young Lions until the 2025 Euros qualifying campaign.For England, that does not start until September, after they have competed in this summers finals in Georgia and Romania.',
        image: 'assets/images/2.webp'));
    futbolNews.add(ModelFutbol(
        id: 3,
        name:
            'PIECE OF REISS Arsenal star Reiss Nelson wanted by Brighton and Nice on free transfers with winger at ‘crossroads’ as deal runs down',
        description:
            "ARSENAL forward Reiss Nelson is reportedly attracting interest from Brighton and Nice. The Gunners star, 23, scored a sensational stoppage-time winner for Mikel Arteta's men on Saturday as they dramatically clinched a 3-2 win over Bournemouth. Nelson's crucial moment ensured Arsenal retain their five-point lead at the top of the Premier League table with 12 games remaining. Yet despite a potentially season-defining moment, his contract is continuing to run down at the Emirates.If Nelson does not pen a new deal, he will become a free agent in the summer.",
        image: 'assets/images/3.webp'));
    futbolNews.add(ModelFutbol(
        id: 4,
        name:
            'AUSTRALIAN footballer Jackson Irvine was left stunned when he was recognised by Manchester United and Brazil star Casemiro.',
        description:
            "And while Irvine failed to take home any gongs, he might well have been the night's biggest winner.The 30-year-old, who appeared in all four of Australia's World Cup games last year, arrived suited and booted at the ceremony as a member of FIFPRO's Global Player Council.Manchester United star Casemiro was there after being nominated for the World 11, an award voted by other players on football's best performers.Irvine and Casemiro can be seen posing for a photo together.",
        image: 'assets/images/4.webp'));
    futbolNews.add(ModelFutbol(
        id: 5,
        name:
            'LUKE AND LEARN Man Utd star Luke Shaw issues grovelling apology for ‘unacceptable’ Liverpool loss and hints at reason for defeat',
        description:
            "LUKE SHAW issued a grovelling apology to Manchester United fans following the 7-0 defeat to Liverpool. The defender was one of the worst performers at Anfield with Gary Neville labelling him appalling. Shaw twice gave the ball away in the build-up to Liverpool's second goal and he had a torrid afternoon up against Mo Salah.After the match he admitted he felt embarrassed and criticised himself and his team-mates for the lack of personality and mentality on show.He told MUTV post-match: “Out there on the pitch, I felt embarrassed for us players, for the fans who were supporting us and who were watching at home.",
        image: 'assets/images/5.webp'));
    futbolNews.add(ModelFutbol(
        id: 6,
        name:
            'TO THE MAX Newcastle star Allan Saint-Maximin wanted by AC Milan in summer transfer with chiefs ‘on the move’ for winger',
        description:
            "NEWCASTLE star Allan Saint-Maximin is reportedly a transfer target for AC Milan. The Serie A giants are considering a move for Saint-Maximin if they lose Rafael Leao in the summer. According to TuttoMercatoWeb, Milan are already on the move looking for Leao's replacement. The Portuguese forward wants to stay in Milan, but there has been no progress in negotiations for a new contract. With the 23-year-old's deal expiring in 2024, Milan could be forced into a sale - boosting Chelsea's transfer hopes.",
        image: 'assets/images/6.webp'));
    futbolNews.add(ModelFutbol(
        id: 7,
        name:
            'UNITED FRONT Three ways Man Utd could line up with Harry Kane including new formation as they line up blockbuster summer transfer',
        description:
            "MANCHESTER UNITED reckon they can sign Harry Kane this summer, if Tottenham miss out on the top four. Red Devils chiefs believe that Spurs will lower their £100million asking price if they fail to reach the Champions League. Kane, who will turn 30 in July, has less than 18 months remaining on his contract in North London. And with United having made contact with Kane's camp via a third party, they believe they can prise the England skipper from his boyhood club this summer. Manchester United were humiliated 7-0 by arch-rivals Liverpool on Sunday.",
        image: 'assets/images/7.webp'));
    futbolNews.add(ModelFutbol(
        id: 8,
        name:
            'JOR DE FORCE Arsenal fans spot Jorginho on sidelines in new footage against Bournemouth ‘doing something he didn’t do at Chelsea’',
        description:
            "With late victories against Manchester United and Aston Villa still fresh in the memory, Reiss Nelson did his best to top both moments with a stunning winner deep into injury time. This is despite Arsenal conceding the second fastest goal in Premier League history. Although Jorginho didn't manage to make it on to the pitch, the midfielder did still made his presence felt. Footage has emerged of the 31-year-old attempting to orchestrate his team-mates from the touchline.",
        image: 'assets/images/8.webp'));
    futbolNews.add(ModelFutbol(
        id: 9,
        name:
            'BRU SERIOUS? Bruno Fernandes’ antics in Liverpool thrashing ‘look set to end Man Utd captaincy dream with team-mates fuming at him’',
        description:
            "BRUNO FERNANDES faces missing out on becoming Manchester United's permanent captain following his behaviour at Anfield on Sunday.The Portuguese playmaker, 28, has deputised for club skipper Harry Maguire due to the England international spending most of the season on the bench. And with Maguire, 30, expected to leave in the summer, a new Man Utd captain is set to be appointed. However, The Mail are reporting that Fernandes' antics during their 7-0 loss to Liverpool have left many unsure about the merit in giving him the armband. Fernandes repeatedly threw his arms up at his team-mates as Erik ten Hag's men capitulated on Merseyside.He failed to acknowledge the away support at full-time, before Raphael Varane urged the rest of the team to head over to the Man Utd corner of the ground.",
        image: 'assets/images/9.webp'));
    futbolNews.add(ModelFutbol(
        id: 10,
        name:
            'EDEN FOR THE EXIT Eden Hazard to hold talks with Real Madrid over transfer exit with ex-Chelsea star set to leave after nightmare spell',
        description:
            "EDEN HAZARD is set to hold talks with Real Madrid chiefs over his exit after his nightmare spell at the club. The Belgian arrived at the Bernabeu in 2019 from Chelsea in a deal up to £150m. But his dream move unravelled in spectacular fashion and Hazard has been dogged by regular injury issues, inconsistency and question marks hanging over his fitness. It appears the 32-year-old's unhappy time at the club may be coming to a close as he prepares to sit down with club bosses to discuss his future. Hazard's contract runs until the summer of 2024 but a premature exit could be on the cards.",
        image: 'assets/images/10.webp'));
    emit(state.copyWith(listFutbol: futbolNews));
  }
}
