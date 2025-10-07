import 'dart:convert';

class ResponseData {
  static final String liveMatches = jsonEncode({
    "typeMatches": [
      {
        "matchType": "International",
        "seriesMatches": [
          {
            "seriesAdWrapper": {
              "seriesId": 9629,
              "seriesName": "West Indies tour of India, 2025",
              "matches": [
                {
                  "matchInfo": {
                    "matchId": 117359,
                    "seriesId": 9629,
                    "seriesName": "West Indies tour of India, 2025",
                    "matchDesc": "1st Test",
                    "matchFormat": "TEST",
                    "startDate": "1759377600000",
                    "endDate": "1759748400000",
                    "state": "Complete",
                    "status": "India won by an innings and 140 runs",
                    "team1": {
                      "teamId": 10,
                      "teamName": "West Indies",
                      "teamSName": "WI",
                      "imageId": 172124,
                    },
                    "team2": {
                      "teamId": 2,
                      "teamName": "India",
                      "teamSName": "IND",
                      "imageId": 719031,
                    },
                    "venueInfo": {
                      "id": 50,
                      "ground": "Narendra Modi Stadium",
                      "city": "Ahmedabad",
                      "timezone": "+05:30",
                      "latitude": "23.091785",
                      "longitude": "72.597465",
                    },
                    "currBatTeamId": 2,
                    "seriesStartDt": "1759363200000",
                    "seriesEndDt": "1760572800000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Complete",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 162,
                        "wickets": 10,
                        "overs": 44.1,
                      },
                      "inngs2": {
                        "inningsId": 3,
                        "runs": 146,
                        "wickets": 10,
                        "overs": 45.1,
                      },
                    },
                    "team2Score": {
                      "inngs1": {
                        "inningsId": 2,
                        "runs": 448,
                        "wickets": 5,
                        "overs": 127.6,
                        "isDeclared": true,
                      },
                    },
                  },
                },
              ],
            },
          },
          {
            "seriesAdWrapper": {
              "seriesId": 10201,
              "seriesName": "Australia tour of New Zealand, 2025",
              "matches": [
                {
                  "matchInfo": {
                    "matchId": 122528,
                    "seriesId": 10201,
                    "seriesName": "Australia tour of New Zealand, 2025",
                    "matchDesc": "3rd T20I",
                    "matchFormat": "T20",
                    "startDate": "1759558500000",
                    "endDate": "1759571100000",
                    "state": "In Progress",
                    "status": "Australia need 23 runs in 26 balls",
                    "team1": {
                      "teamId": 13,
                      "teamName": "New Zealand",
                      "teamSName": "NZ",
                      "imageId": 767661,
                    },
                    "team2": {
                      "teamId": 4,
                      "teamName": "Australia",
                      "teamSName": "AUS",
                      "imageId": 172117,
                    },
                    "venueInfo": {
                      "id": 393,
                      "ground": "Bay Oval",
                      "city": "Mount Maunganui",
                      "timezone": "+13:00",
                      "latitude": "-37.670300",
                      "longitude": "176.212006",
                    },
                    "currBatTeamId": 4,
                    "seriesStartDt": "1759276800000",
                    "seriesEndDt": "1759708800000",
                    "isTimeAnnounced": true,
                    "stateTitle": "In Progress",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 156,
                        "wickets": 9,
                        "overs": 19.6,
                      },
                    },
                    "team2Score": {
                      "inngs1": {
                        "inningsId": 2,
                        "runs": 134,
                        "wickets": 7,
                        "overs": 15.4,
                      },
                    },
                  },
                },
              ],
            },
          },
          {
            "seriesAdWrapper": {
              "seriesId": 10944,
              "seriesName": "ICC Mens T20 World Cup Africa Regional Final 2025",
              "matches": [
                {
                  "matchInfo": {
                    "matchId": 134903,
                    "seriesId": 10944,
                    "seriesName":
                        "ICC Mens T20 World Cup Africa Regional Final 2025",
                    "matchDesc": "7th Place Play-off",
                    "matchFormat": "T20",
                    "startDate": "1759563000000",
                    "endDate": "1759575600000",
                    "state": "In Progress",
                    "status": "Botswana need 126 runs",
                    "team1": {
                      "teamId": 553,
                      "teamName": "Malawi",
                      "teamSName": "MWI",
                      "imageId": 172605,
                    },
                    "team2": {
                      "teamId": 529,
                      "teamName": "Botswana",
                      "teamSName": "BW",
                      "imageId": 172579,
                    },
                    "venueInfo": {
                      "id": 762,
                      "ground": "Takashinga Sports Club",
                      "city": "Harare",
                      "timezone": "+02:00",
                      "latitude": "-17.88849",
                      "longitude": "30.99021",
                    },
                    "currBatTeamId": 529,
                    "seriesStartDt": "1758844800000",
                    "seriesEndDt": "1759708800000",
                    "isTimeAnnounced": true,
                    "stateTitle": "In Progress",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 151,
                        "wickets": 5,
                        "overs": 19.6,
                      },
                    },
                    "team2Score": {
                      "inngs1": {"inningsId": 2, "runs": 26, "overs": 3.6},
                    },
                  },
                },
                {
                  "matchInfo": {
                    "matchId": 134892,
                    "seriesId": 10944,
                    "seriesName":
                        "ICC Mens T20 World Cup Africa Regional Final 2025",
                    "matchDesc": "3rd Place Play-off",
                    "matchFormat": "T20",
                    "startDate": "1759563000000",
                    "endDate": "1759575600000",
                    "state": "In Progress",
                    "status": "Tanzania need 101 runs in 66 balls",
                    "team1": {
                      "teamId": 14,
                      "teamName": "Kenya",
                      "teamSName": "KEN",
                      "imageId": 172129,
                    },
                    "team2": {
                      "teamId": 535,
                      "teamName": "Tanzania",
                      "teamSName": "TAN",
                      "imageId": 172586,
                    },
                    "venueInfo": {
                      "id": 69,
                      "ground": "Harare Sports Club",
                      "city": "Harare",
                      "timezone": "+02:00",
                      "latitude": "-17.814114",
                      "longitude": "31.050962",
                    },
                    "currBatTeamId": 535,
                    "seriesStartDt": "1758844800000",
                    "seriesEndDt": "1759708800000",
                    "isTimeAnnounced": true,
                    "stateTitle": "In Progress",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 142,
                        "wickets": 7,
                        "overs": 19.6,
                      },
                    },
                    "team2Score": {
                      "inngs1": {
                        "inningsId": 2,
                        "runs": 42,
                        "wickets": 4,
                        "overs": 8.6,
                      },
                    },
                  },
                },
              ],
            },
          },
          {
            "ad": {
              "name": "native_matches",
              "layout": "native_large",
              "position": 3,
            },
          },
        ],
      },
      {
        "matchType": "Domestic",
        "seriesMatches": [
          {
            "seriesAdWrapper": {
              "seriesId": 10823,
              "seriesName": "Sheffield Shield 2025-26",
              "matches": [
                {
                  "matchInfo": {
                    "matchId": 133209,
                    "seriesId": 10823,
                    "seriesName": "Sheffield Shield 2025-26",
                    "matchDesc": "2nd Match",
                    "matchFormat": "TEST",
                    "startDate": "1759537800000",
                    "endDate": "1759822200000",
                    "state": "Stumps",
                    "status": "Day 1: Stumps",
                    "team1": {
                      "teamId": 158,
                      "teamName": "South Australia",
                      "teamSName": "SAUS",
                      "imageId": 172225,
                    },
                    "team2": {
                      "teamId": 52,
                      "teamName": "Victoria",
                      "teamSName": "VIC",
                      "imageId": 172153,
                    },
                    "venueInfo": {
                      "id": 40,
                      "ground": "Adelaide Oval",
                      "city": "Adelaide",
                      "timezone": "+10:30",
                      "latitude": "-34.915516",
                      "longitude": "138.596115",
                    },
                    "currBatTeamId": 158,
                    "seriesStartDt": "1759536000000",
                    "seriesEndDt": "1774915200000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Stumps",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 270,
                        "wickets": 3,
                        "overs": 93.6,
                      },
                    },
                  },
                },
                {
                  "matchInfo": {
                    "matchId": 133220,
                    "seriesId": 10823,
                    "seriesName": "Sheffield Shield 2025-26",
                    "matchDesc": "3rd Match",
                    "matchFormat": "TEST",
                    "startDate": "1759545000000",
                    "endDate": "1759829400000",
                    "state": "Stumps",
                    "status": "Day 1: Stumps",
                    "team1": {
                      "teamId": 104,
                      "teamName": "New South Wales",
                      "teamSName": "NSW",
                      "imageId": 172196,
                    },
                    "team2": {
                      "teamId": 87,
                      "teamName": "Western Australia",
                      "teamSName": "WA",
                      "imageId": 172180,
                    },
                    "venueInfo": {
                      "id": 38,
                      "ground": "W.A.C.A. Ground",
                      "city": "Perth",
                      "timezone": "+08:00",
                      "latitude": "-31.959806",
                      "longitude": "115.879585",
                    },
                    "currBatTeamId": 104,
                    "seriesStartDt": "1759536000000",
                    "seriesEndDt": "1774915200000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Stumps",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 35,
                        "wickets": 3,
                        "overs": 25.1,
                      },
                    },
                  },
                },
                {
                  "matchInfo": {
                    "matchId": 133198,
                    "seriesId": 10823,
                    "seriesName": "Sheffield Shield 2025-26",
                    "matchDesc": "1st Match",
                    "matchFormat": "TEST",
                    "startDate": "1759536000000",
                    "endDate": "1759820400000",
                    "state": "Stumps",
                    "status": "Day 1: Stumps",
                    "team1": {
                      "teamId": 166,
                      "teamName": "Tasmania",
                      "teamSName": "TAS",
                      "imageId": 172235,
                    },
                    "team2": {
                      "teamId": 164,
                      "teamName": "Queensland",
                      "teamSName": "QL",
                      "imageId": 172233,
                    },
                    "venueInfo": {
                      "id": 300,
                      "ground": "Allan Border Field",
                      "city": "Brisbane",
                      "timezone": "+10:00",
                      "latitude": "-27.435145",
                      "longitude": "153.046143",
                    },
                    "currBatTeamId": 166,
                    "seriesStartDt": "1759536000000",
                    "seriesEndDt": "1774915200000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Stumps",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 299,
                        "wickets": 6,
                        "overs": 91.6,
                      },
                    },
                  },
                },
              ],
            },
          },
          {
            "seriesAdWrapper": {
              "seriesId": 10300,
              "seriesName": "Irani Cup 2025",
              "matches": [
                {
                  "matchInfo": {
                    "matchId": 123650,
                    "seriesId": 10300,
                    "seriesName": "Irani Cup 2025",
                    "matchDesc": "Irani Cup",
                    "matchFormat": "TEST",
                    "startDate": "1759291200000",
                    "endDate": "1759662000000",
                    "state": "Innings Break",
                    "status":
                        "Day 4: Innings Break - Vidarbha lead by 360 runs",
                    "team1": {
                      "teamId": 248,
                      "teamName": "Vidarbha",
                      "teamSName": "VID",
                      "imageId": 172301,
                    },
                    "team2": {
                      "teamId": 82,
                      "teamName": "Rest of India",
                      "teamSName": "ROI",
                      "imageId": 172176,
                    },
                    "venueInfo": {
                      "id": 228,
                      "ground": "Vidarbha Cricket Association Stadium",
                      "city": "Nagpur",
                      "timezone": "+05:30",
                      "latitude": "21.013566",
                      "longitude": "79.039576",
                    },
                    "currBatTeamId": 248,
                    "seriesStartDt": "1759276800000",
                    "seriesEndDt": "1759795200000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Ings Break",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 342,
                        "wickets": 10,
                        "overs": 101.4,
                      },
                      "inngs2": {
                        "inningsId": 3,
                        "runs": 232,
                        "wickets": 10,
                        "overs": 94.1,
                      },
                    },
                    "team2Score": {
                      "inngs1": {
                        "inningsId": 2,
                        "runs": 214,
                        "wickets": 10,
                        "overs": 69.5,
                      },
                    },
                  },
                },
              ],
            },
          },
          {
            "seriesAdWrapper": {
              "seriesId": 10878,
              "seriesName": "CSA Four-Day Series Division One 2025-26",
              "matches": [
                {
                  "matchInfo": {
                    "matchId": 133886,
                    "seriesId": 10878,
                    "seriesName": "CSA Four-Day Series Division One 2025-26",
                    "matchDesc": "6th Match",
                    "matchFormat": "TEST",
                    "startDate": "1759388400000",
                    "endDate": "1759672800000",
                    "state": "Stumps",
                    "status":
                        "Day 2: Stumps - KwaZulu-Natal Inland trail by 32 runs",
                    "team1": {
                      "teamId": 155,
                      "teamName": "Warriors",
                      "teamSName": "WAR",
                      "imageId": 172222,
                    },
                    "team2": {
                      "teamId": 1766,
                      "teamName": "KwaZulu-Natal Inland",
                      "teamSName": "KZNIN",
                      "imageId": 349611,
                    },
                    "venueInfo": {
                      "id": 206,
                      "ground": "City Oval",
                      "city": "Pietermaritzburg",
                      "timezone": "+02:00",
                      "latitude": "-29.551181",
                      "longitude": "30.407238",
                    },
                    "currBatTeamId": 1766,
                    "seriesStartDt": "1758758400000",
                    "seriesEndDt": "1771891200000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Stumps",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 140,
                        "wickets": 10,
                        "overs": 48.6,
                      },
                    },
                    "team2Score": {
                      "inngs1": {
                        "inningsId": 2,
                        "runs": 108,
                        "wickets": 6,
                        "overs": 41.6,
                      },
                    },
                  },
                },
                {
                  "matchInfo": {
                    "matchId": 133875,
                    "seriesId": 10878,
                    "seriesName": "CSA Four-Day Series Division One 2025-26",
                    "matchDesc": "4th Match",
                    "matchFormat": "TEST",
                    "startDate": "1759392000000",
                    "endDate": "1759676400000",
                    "state": "Stumps",
                    "status": "Day 2: Stumps - Boland lead by 9 runs",
                    "team1": {
                      "teamId": 1759,
                      "teamName": "Boland",
                      "teamSName": "BOL",
                      "imageId": 349610,
                    },
                    "team2": {
                      "teamId": 90,
                      "teamName": "Dolphins",
                      "teamSName": "DOL",
                      "imageId": 172183,
                    },
                    "venueInfo": {
                      "id": 207,
                      "ground": "Boland Park",
                      "city": "Paarl",
                      "timezone": "+02:00",
                      "latitude": "-33.730900",
                      "longitude": "18.970760",
                    },
                    "currBatTeamId": 1759,
                    "seriesStartDt": "1758758400000",
                    "seriesEndDt": "1771891200000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Stumps",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 156,
                        "wickets": 10,
                        "overs": 45.2,
                      },
                      "inngs2": {
                        "inningsId": 3,
                        "runs": 199,
                        "wickets": 1,
                        "overs": 47.6,
                      },
                    },
                    "team2Score": {
                      "inngs1": {
                        "inningsId": 2,
                        "runs": 346,
                        "wickets": 10,
                        "overs": 91.2,
                      },
                    },
                  },
                },
                {
                  "matchInfo": {
                    "matchId": 133897,
                    "seriesId": 10878,
                    "seriesName": "CSA Four-Day Series Division One 2025-26",
                    "matchDesc": "7th Match",
                    "matchFormat": "TEST",
                    "startDate": "1759392000000",
                    "endDate": "1759676400000",
                    "state": "Stumps",
                    "status": "Day 2: Stumps - Titans trail by 338 runs",
                    "team1": {
                      "teamId": 922,
                      "teamName": "North West",
                      "teamSName": "NWEST",
                      "imageId": 248439,
                    },
                    "team2": {
                      "teamId": 89,
                      "teamName": "Titans",
                      "teamSName": "TIT",
                      "imageId": 172182,
                    },
                    "venueInfo": {
                      "id": 102,
                      "ground": "Senwes Park",
                      "city": "Potchefstroom",
                      "timezone": "+02:00",
                      "latitude": "-26.695565",
                      "longitude": "27.100691",
                    },
                    "currBatTeamId": 89,
                    "seriesStartDt": "1758758400000",
                    "seriesEndDt": "1771891200000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Stumps",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 491,
                        "wickets": 8,
                        "overs": 133.6,
                        "isDeclared": true,
                      },
                    },
                    "team2Score": {
                      "inngs1": {
                        "inningsId": 2,
                        "runs": 153,
                        "wickets": 4,
                        "overs": 44.6,
                      },
                    },
                  },
                },
                {
                  "matchInfo": {
                    "matchId": 133880,
                    "seriesId": 10878,
                    "seriesName": "CSA Four-Day Series Division One 2025-26",
                    "matchDesc": "5th Match",
                    "matchFormat": "TEST",
                    "startDate": "1759392000000",
                    "endDate": "1759676400000",
                    "state": "Stumps",
                    "status": "Day 2: Stumps - Lions lead by 200 runs",
                    "team1": {
                      "teamId": 917,
                      "teamName": "Western Province",
                      "teamSName": "WPR",
                      "imageId": 248460,
                    },
                    "team2": {
                      "teamId": 157,
                      "teamName": "Lions",
                      "teamSName": "LIONS",
                      "imageId": 172224,
                    },
                    "venueInfo": {
                      "id": 52,
                      "ground": "Newlands",
                      "city": "Cape Town",
                      "timezone": "+02:00",
                      "latitude": "-33.979629",
                      "longitude": "18.459466",
                    },
                    "currBatTeamId": 157,
                    "seriesStartDt": "1758758400000",
                    "seriesEndDt": "1771891200000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Stumps",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 193,
                        "wickets": 10,
                        "overs": 44.6,
                      },
                    },
                    "team2Score": {
                      "inngs1": {
                        "inningsId": 2,
                        "runs": 393,
                        "wickets": 6,
                        "overs": 141.6,
                      },
                    },
                  },
                },
              ],
            },
          },
          {
            "seriesAdWrapper": {
              "seriesId": 10911,
              "seriesName": "CSA Four-Day Series Division Two 2025-26",
              "matches": [
                {
                  "matchInfo": {
                    "matchId": 134491,
                    "seriesId": 10911,
                    "seriesName": "CSA Four-Day Series Division Two 2025-26",
                    "matchDesc": "4th Match",
                    "matchFormat": "TEST",
                    "startDate": "1759392000000",
                    "endDate": "1759676400000",
                    "state": "Stumps",
                    "status": "Day 2: Stumps - Limpopo trail by 428 runs",
                    "team1": {
                      "teamId": 1768,
                      "teamName": "South Western Districts",
                      "teamSName": "SWD",
                      "imageId": 349609,
                    },
                    "team2": {
                      "teamId": 912,
                      "teamName": "Limpopo",
                      "teamSName": "LIMPO",
                      "imageId": 248430,
                    },
                    "venueInfo": {
                      "id": 772,
                      "ground": "Polokwane Cricket Club",
                      "city": "Polokwane",
                      "timezone": "+02:00",
                      "latitude": "-23.912260",
                      "longitude": "29.453550",
                    },
                    "currBatTeamId": 912,
                    "seriesStartDt": "1758758400000",
                    "seriesEndDt": "1770854400000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Stumps",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 490,
                        "wickets": 10,
                        "overs": 156.6,
                      },
                    },
                    "team2Score": {
                      "inngs1": {
                        "inningsId": 2,
                        "runs": 62,
                        "wickets": 2,
                        "overs": 23.6,
                      },
                    },
                  },
                },
                {
                  "matchInfo": {
                    "matchId": 134485,
                    "seriesId": 10911,
                    "seriesName": "CSA Four-Day Series Division Two 2025-26",
                    "matchDesc": "3rd Match",
                    "matchFormat": "TEST",
                    "startDate": "1759392000000",
                    "endDate": "1759676400000",
                    "state": "Stumps",
                    "status": "Day 2: Stumps - Northern Cape trail by 272 runs",
                    "team1": {
                      "teamId": 903,
                      "teamName": "Mpumalanga Rhinos",
                      "teamSName": "MPR",
                      "imageId": 248434,
                    },
                    "team2": {
                      "teamId": 923,
                      "teamName": "Northern Cape",
                      "teamSName": "NCAPE",
                      "imageId": 248438,
                    },
                    "venueInfo": {
                      "id": 148,
                      "ground": "Diamond Oval",
                      "city": "Kimberley",
                      "timezone": "+02:00",
                      "latitude": "-28.742487",
                      "longitude": "24.742101",
                    },
                    "currBatTeamId": 923,
                    "seriesStartDt": "1758758400000",
                    "seriesEndDt": "1770854400000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Stumps",
                  },
                  "matchScore": {
                    "team1Score": {
                      "inngs1": {
                        "inningsId": 1,
                        "runs": 463,
                        "wickets": 10,
                        "overs": 118.5,
                      },
                    },
                    "team2Score": {
                      "inngs1": {
                        "inningsId": 2,
                        "runs": 191,
                        "wickets": 7,
                        "overs": 68.6,
                      },
                    },
                  },
                },
              ],
            },
          },
        ],
      },
      {
        "matchType": "Women",
        "seriesMatches": [
          {
            "seriesAdWrapper": {
              "seriesId": 10009,
              "seriesName": "ICC Womens World Cup 2025",
              "matches": [
                {
                  "matchInfo": {
                    "matchId": 121477,
                    "seriesId": 10009,
                    "seriesName": "ICC Womens World Cup 2025",
                    "matchDesc": "5th Match",
                    "matchFormat": "ODI",
                    "startDate": "1759570200000",
                    "endDate": "1759599000000",
                    "state": "Delay",
                    "status": "Toss delayed due to rain",
                    "team1": {
                      "teamId": 258,
                      "teamName": "Sri Lanka Women",
                      "teamSName": "SLW",
                      "imageId": 172311,
                    },
                    "team2": {
                      "teamId": 100,
                      "teamName": "Australia Women",
                      "teamSName": "AUSW",
                      "imageId": 172192,
                    },
                    "venueInfo": {
                      "id": 15,
                      "ground": "R.Premadasa Stadium",
                      "city": "Colombo",
                      "timezone": "+05:30",
                      "latitude": "6.939966",
                      "longitude": "79.872222",
                    },
                    "isTournament": true,
                    "seriesStartDt": "1759190400000",
                    "seriesEndDt": "1762214400000",
                    "isTimeAnnounced": true,
                    "stateTitle": "Delay",
                  },
                },
              ],
            },
          },
        ],
      },
    ],
    "filters": {
      "matchType": ["International", "League", "Domestic", "Women"],
    },
    "appIndex": {
      "seoTitle": "Live Cricket Score - Scorecard and Match Results",
      "webURL": "www.cricbuzz.com/live-cricket-scores/",
    },
    "responseLastUpdated": "1759572208",
  });
}
