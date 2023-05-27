import { PrismaClient, Kid } from "@prisma/client";
import { Request, Response } from "express";
let db = new PrismaClient();

export const updatePosition = async (req: Request, res: Response) => {
  try {
    const { position, kid_id } = req.body;

    // Get the current date
    const now = new Date();
    // Check if it's morning or evening
    const isMorning = now.getHours() < 12;
    let dataLoad = null;
    if (isMorning) {
      dataLoad = {
        position,
        morningPresent: true,
      };
    } else {
      dataLoad = { position, eveningPresent: true };
    }

    const kid: Kid | null = await db.kid.update({
      data: dataLoad,
      where: { id: kid_id },
    });
    console.log(kid);
    res.status(200).json({ kid });
  } catch (err) {
    console.log(err);
    res.status(400).send(err);
  }
};

export const getAbsentKids = async (req: Request, res: Response) => {
  try {
    const now = new Date();

    // Check if it's morning or evening
    const isMorning = now.getHours() < 12;

    let dataLoad = null;

    if (isMorning) {
      dataLoad = {
        morningPresent: false,
      };
    } else {
      dataLoad = { eveningPresent: false };
    }

    const absentKids = await db.kid.findMany({
      where: dataLoad,
      include: {
        User: {
          select: {
            phone: true,
            adress: true,
            zone: { select: { name: true } },
          },
        },
      },
    });
    res.json(absentKids);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Unable to get absent kids" });
  }
};

export const resetKid = async (req: Request, res: Response) => {
  try {
    const { zone } = req.body;
    const kids = await db.kid.updateMany({
      data: { morningPresent: false, eveningPresent: false },
      where: { zone: { name: zone } },
    });
    res.status(200).send("rested");
  } catch (error) {
    console.log(error);
    res.status(400).send(error);
  }
};
