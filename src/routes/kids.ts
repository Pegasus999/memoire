import { Router } from "express";
import {
  addKids,
  getKids,
  getMine,
  getZoneRelated,
  resub,
} from "../controllers/kidsController";
const multer = require("multer");

const upload = multer();
const router = Router();

router.get("/getAll", getKids);

router.post("/getMine", getMine);

router.post("/getZoneRelated", getZoneRelated);

router.put("/resub", resub);

router.post("/addKid", upload.single("file"), addKids);

module.exports = router;
