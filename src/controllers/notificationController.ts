import { PrismaClient, Notification } from "@prisma/client";
import { Request, Response } from "express";

const db = new PrismaClient();

export const getNotif = async (req: Request, res: Response) => {
  try {
    const result: Notification[] | null = await db.notification.findMany();
    console.log(result);
    result.length
      ? res.status(200).json(result)
      : res.status(400).json("No notifications Found");
  } catch (err) {
    res.status(400).send(err);
  }
};

export const postNotif = async (req: Request, res: Response) => {
  try {
    let { title, content, date } = req.body;
    const result: Notification | null = await db.notification.create({
      data: { title, content, date },
    });
    result
      ? res.status(200).json({ result, message: "notification made" })
      : res.status(400).send("Couldn't make a notification try again");
  } catch (err) {
    console.log(err);
    res.status(400).send(err);
  }
};
