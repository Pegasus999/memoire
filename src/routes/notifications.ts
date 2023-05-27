import { Router } from "express";
import { getNotif, postNotif } from "../controllers/notificationController";

const router = Router();

router.get("/getAll", getNotif);

router.post("/post", postNotif);

module.exports = router;
