const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const ParseServer = require("parse-server").ParseServer;
const ParseDashboard = require("parse-dashboard");
const RedisCacheAdapter = require("parse-server").RedisCacheAdapter;
let multer = require("multer");
let forms = multer();

// setup email
const { ApiPayloadConverter } = require("parse-server-api-mail-adapter");
const Mailgun = require("mailgun.js");
const formData = require("form-data");

const mailgun = new Mailgun(formData);
const mailgunClient = mailgun.client({
   username: "api",
   key: process.env.MAILGUN_API_KEY,
});


const app = express();

const dashboardURL = process.env.DASHBOARD_URL;

const api = new ParseServer({
   serverURL: process.env.SERVER_URL,
   publicServerURL: process.env.SERVER_URL,
   databaseURI: process.env.PARSE_POSTGRESQL_URI || "",
   cloud: "./cloud/main.js",
   appId: process.env.PARSE_APP_ID || "",
   appName: process.env.APP_NAME || "",
   fileKey: process.env.PARSE_FILE_KEY || "",
   masterKey: process.env.PARSE_MASTER_KEY || "",
   clientKey: process.env.PARSE_CLIENT_KEY || "",
   restAPIKey: process.env.PARSE_REST_API_KEY || "",
   javascriptKey: process.env.PARSE_JAVASCRIPT_KEY || "",
   filesAdapter: {
      module: "@parse/s3-files-adapter",
      options: {
            bucket: process.env.AWS_S3_BUCKET || "my-bucket",
            region: process.env.AWS_S3_REGION || "ap-southeast-3",
            bucketPrefix: process.env.PARSE_BUCKET_PREFIX || "staging/",
            directAccess: true,
      },
   },
   cacheAdapter: new RedisCacheAdapter({
      url: process.env.REDIS_URL || "redis://redis-master:6379",
   }),
   logLevel: "VERBOSE",
   emailAdapter: {
      module: "parse-server-api-mail-adapter",
      options: {
            sender: "no-reply@example.com",
            templates: {
               passwordResetEmail: {
                  subjectPath:
                        "./email/reset-password/password_reset_email_subject.txt",
                  textPath: "./email/reset-password/password_reset_email.txt",
                  htmlPath: "./email/reset-password/password_reset_email.html",
               },
               verificationEmail: {
                  subjectPath:
                        "./email/account-verification/account_verification_subject.txt",
                  textPath: "./email/account-verification/account_verification.txt",
                  htmlPath: "./email/account-verification/account_verification.html",
               },
            },
            apiCallback: async ({ payload, locale }) => {
               const mailgunPayload = ApiPayloadConverter.mailgun(payload);
               await mailgunClient.messages.create(
                  process.env.MAILGUN_DOMAIN,
                  mailgunPayload
               );
            },
      },
   },
});

const dashboard = new ParseDashboard(
   {
      apps: [
            {
               serverURL: process.env.SERVER_URL,
               graphQLServerURL: process.env.GRAPHQL_URL || "",
               appId: process.env.PARSE_APP_ID || "",
               masterKey: process.env.PARSE_MASTER_KEY || "",
               appName: process.env.APP_NAME || "",
            },
      ],
      trustProxy: 1,
      users: [
            {
               user: process.env.PARSE_DASHBOARD_USERNAME || "",
               pass: process.env.PARSE_DASHBOARD_PASSWORD || "",
            },
      ],
      useEncryptedPasswords: false,
   },
   { allowInsecureHTTP: false, cookieSessionSecret: "***" }
);

app.use(bodyParser.json());
app.use(forms.array());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());

app.use("/parse", api);
app.use("/dashboard", dashboard);

app.get("/health_check", (req, res) => {
   res.status(200).send("Ok");
});

const port = process.env.APP_PORT || "1337";

app.listen(port, function() {
    console.log('parse-server running on port ' + port + '.');
});
