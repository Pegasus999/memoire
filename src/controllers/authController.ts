import { PrismaClient, User } from "@prisma/client";
import { Request, Response } from "express";
let db = new PrismaClient();

export const signinController = async (req: Request, res: Response) => {
  try {
    let { username, password } = req.body;
    console.log(username);
    let user: User | null = await db.user.findFirst({
      where: { username, password },
      include: { zone: { select: { name: true, id: true } } },
    });
    user ? res.status(200).json(user) : res.status(400).send("Oopsie");
  } catch (err) {
    console.log(err);
    res.status(400).send(err);
  }
};
