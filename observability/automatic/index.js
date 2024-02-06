const express = require("express");
const cors = require('cors')
require("@opentelemetry/api");

const app = express();

app.use(cors());

app.all("/", (req, res) => {
    res.json({ method: req.method, message: "Hello OnXP", ...req.body });
});

const port = process.env.APP_PORT || "3001";
app.listen(port, function() {
    console.log('server running on port ' + port + '.');
});
