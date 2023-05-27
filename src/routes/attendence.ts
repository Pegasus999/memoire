import { Router } from "express";
import {
  getAbsentKids,
  resetKid,
  updatePosition,
} from "../controllers/attendenceController";

const router = Router();

router.get("/getAll", getAbsentKids);

router.put("/updatePosition", updatePosition);

router.put("/restAll", resetKid);

module.exports = router;
