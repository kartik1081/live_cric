const String matchListEp = "/matches/v1/live";
const String teamListEp = "/teams/v1/international";
const String teamScheduleEp = "/teams/v1/2/schedule";
const String teamPlayersEp = "/teams/v1/2/players";
const String teamNewsEp = "/news/v1/team/1";
const String playerInfoEp = "/stats/v1/player";

String getMatchScorecardEp(int matchId) => "/mcenter/v1/$matchId/scard";
String getMatchInfoEp(int matchId) => "/mcenter/v1/$matchId";
String getCommentryEp(int matchId) => "/mcenter/v1/$matchId/comm";
String getImageEp(int imageId) => "/img/v1/i1/c$imageId/i.jpg";
