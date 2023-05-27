import { Request, Response } from "express";
const express = require("express");

const app = express();

app.use(express.json());

app.get("/", (req: Request, res: Response) => {
  res.json("GAY").status(200);
});

const port = 5000;
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});

// Auth routes
const auth = require("./routes/auth");
app.use("/api/auth", auth);
// Kids routes
const kids = require("./routes/kids");
app.use("/api/kids", kids);
// Employees routes
const users = require("./routes/users");
app.use("/api/user", users);
// Notifcation routes
const notif = require("./routes/notifications");
app.use("/api/notif", notif);
// Attendence routes
const attendence = require("./routes/attendence");
app.use("/api/attendence", attendence);
