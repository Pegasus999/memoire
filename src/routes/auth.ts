import { Router } from "express";
import { signinController } from "../controllers/authController";

const router = Router();

router.post("/signin", signinController);

module.exports = router;
