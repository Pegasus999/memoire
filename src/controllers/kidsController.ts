import { PrismaClient, Kid } from "@prisma/client";
import { Request, Response } from "express";
import { Storage } from "@google-cloud/storage";
import path from "path";

const db = new PrismaClient();

const baseUrl = "https://storage.googleapis.com/daycare-pictures/";
const gc = new Storage({
  keyFilename: path.join(__dirname, "../config/mykey.json"),
  projectId: "hip-courier-366911",
});

export const getKids = async (req: Request, res: Response) => {
  try {
    const result: Kid[] | null = await db.kid.findMany({
      include: {
        User: {
          select: {
            adress: true,
            phone: true,
            zone: { select: { name: true } },
          },
        },
      },
    });
    result.length
      ? res.status(200).json(result)
      : res.status(400).send("No Kids Found");
  } catch (err) {
    res.status(400).send(err);
  }
};

export const getMine = async (req: Request, res: Response) => {
  try {
    let { id } = req.body;
    const result: Kid[] | null = await db.kid.findMany({
      where: { userId: id },
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
    result.length
      ? res.status(200).json(result)
      : res.status(400).send("No Kids Found");
  } catch (err) {
    res.status(400).send(err);
  }
};

export const addKids = async (req: Request, res: Response) => {
  try {
    const { user, zone, name, lastname, gender, school } = req.body;
    let picture: string = "";
    if (req.file) {
      const contents = req.file.buffer;
      const newName = Date.now() + req.file.originalname;

      gc.bucket("daycare-pictures")
        .file(newName)
        .save(contents)
        .catch((err) => console.log(err));
      picture = baseUrl + newName;
    } else {
      picture =
        gender == "MALE" ? "assets/images/Boy.png" : "assets/images/Girl.png";
    }
    const today = new Date();
    const futureDate = new Date();
    futureDate.setDate(today.getDate() + 30);
    let subscription = futureDate;
    const result: Kid | null = await db.kid.create({
      data: {
        User: {
          connect: {
            id: user,
          },
        },
        gender,
        zone: {
          connectOrCreate: {
            where: { name: zone },
            create: { name: zone },
          },
        },
        subscription,
        name,
        lastname,
        picture,
        school,
        position: "HOME",
      },
    });
    console.log(result);
    result
      ? res.status(200).json(result)
      : res.status(400).send("An error occured");
  } catch (err) {
    console.log(err);
    res.status(400).send(err);
  }
};

export const getZoneRelated = async (req: Request, res: Response) => {
  try {
    let { zone } = req.body;
    const result: Kid[] | null = await db.kid.findMany({
      where: { zone: { name: zone } },
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

    result.length
      ? res.status(200).json(result)
      : res.status(400).send("No Kids Found");
  } catch (err) {
    res.status(400).send(err);
  }
};

export const resub = async (req: Request, res: Response) => {
  try {
    const { id } = req.body;
    const today = new Date();
    const futureDate = new Date();
    futureDate.setDate(today.getDate() + 30);
    let subscription = futureDate;

    await db.kid.update({ data: { subscription }, where: { id } });
    res.status(200).send("rested");
  } catch (error) {
    console.log(error);
    res.status(400).send(error);
  }
};
