const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { onRequest } = require("firebase-functions/v2/https");

const admin = require("firebase-admin");

admin.initializeApp();

exports.sendTopicNotificationOnDocCreate = onDocumentCreated(
  "Stream Links/{docId}",
  async (event) => {
    const docId = event.params.docId;

    try {
      const response = await fetch(
        "https://cricbuzz-cricket.p.rapidapi.com/mcenter/v1/" + docId,
        {
          method: "GET",
          headers: {
            "x-rapidapi-host": "cricbuzz-cricket.p.rapidapi.com",
            "x-rapidapi-key":
              "c89783400cmsh40a6a97cc3e0dd4p11104bjsnd09af3840a52",
          },
        },
      );
      if (!response.ok) {
        console.error("API request failed with status:", response.status);
        return;
      }

      const result = await response.json();
      const title =
        result.matchdesc ||
        "" +
          " " +
          `${result.team1?.teamsname || "Team1"} vs ${
            result.team2?.teamsname || "Team2"
          }`;
      const body = result.shortstatus || "Watch Live match now.";
      const topic = "live_cric";
      const message = {
        topic,
        data: { title, body, docId },
        android: { priority: "high" },
      };
      await admin.messaging().send(message);
      console.log("Notification sent for docId:", docId, "title:", title);
    } catch (error) {
      console.error("Error in sendTopicNotificationOnDocCreate:", error);
    }
  },
);

exports.sendNotificationToTopic = onRequest(async (req, res) => {
  try {
    const { title, body } = req.body;

    if (!title || !body) {
      return res.status(400).send("Missing required fields");
    }

    const topic = "live_cric";

    const message = {
      topic,
      data: {
        title,
        body,
      },
      android: {
        priority: "high",
      },
    };
    const response = await admin.messaging().send(message);

    return res.status(200).json({
      success: true,
      messageId: response,
    });
  } catch (e) {
    console.error(e);
    return res.status(500).json({ error: e.message });
  }
});
