import { Router } from "express";
import {
  addDriver,
  addParent,
  addWorker,
  getEmployees,
  getParents,
  getZones,
} from "../controllers/usersController";
const multer = require("multer");
const router = Router();

const upload = multer();
router.get("/getEmployees", getEmployees);

router.get("/getParents", getParents);

router.post("/addWorker", upload.single("file"), addWorker);

router.post("/addParent", upload.single("file"), addParent);

router.post("/addDriver", upload.single("file"), addDriver);

router.get("/getZones", getZones);

module.exports = router;
